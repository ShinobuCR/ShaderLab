// Upgrade NOTE: replaced tex2D unity_Lightmap with UNITY_SAMPLE_TEX2D

// Upgrade NOTE: replaced tex2D unity_Lightmap with UNITY_SAMPLE_TEX2D

// Upgrade NOTE: replaced tex2D unity_Lightmap with UNITY_SAMPLE_TEX2D

Shader "Custom/Body" {
    Properties {
        _MainTex ("_MainTex", 2D) = "white" {}
        _LightMap("_LightMap", 2D) = "white"{}
        _FirstShadowMultColor("_FirstShadowMultColor",Color) = (1,1,1,1)
        _SecondShadowMultColor("_SecondShadowMultColor",Color) = (1,1,1,1)
        _Shininess("_Shininess",float) = 16
        _LightArea("_LightArea",float) = 0.1
        _SecondShadow("_SecondShadow",float) = 0
        _SpecMulti("_SpecMulti",float) = 16
        _LightSpecColor("_LightSpecColor",Color) = (1,1,1,1)

        //描边
        _OutLine("_OutLine",Range(0,1))=0.4
        _Z("_Z",Range(-5,5))=1
        _OutColor("_OutColor",Color) = (1,1,1,1)
    }
    SubShader
    {
         Tags{"Queue"="Transparent"}
        pass
        {   

            Cull Back
            Lighting ON
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON

            #include "UnityCG.cginc"
            sampler2D _MainTex;
            float4 _MainTex_ST;

            sampler2D _LightMap;
            float4 _LightMap_ST;

            float4 _FirstShadowMultColor;
            float4 _SecondShadowMultColor;
            float _SecondShadow;
            float _LightArea;
            float _Shininess;
            float _SpecMulti;
            
            float4 _LightSpecColor;
           
            struct v2f
            {
                float4  pos : SV_POSITION;
                float2  uv : TEXCOORD0;
				float2 uvLM : TEXCOORD2;
                float2 uv2 : TEXCOORD1;
                float4 color : COLOR;
                float halfLamber:TEXCOORD3;
                float3 worldPos:TEXCOORD4;
                float3 worldNormal:TEXCOORD5;
            };
            
            v2f vert (appdata_full v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv =  TRANSFORM_TEX(v.texcoord,_MainTex);

                o.color = v.color;
                // o.uv2 =  TRANSFORM_TEX(v.texcoord,unity_LightmapST);
                
				o.uvLM = v.texcoord2.xy * unity_LightmapST.xy + unity_LightmapST.zw;


                float3 worldNormal = normalize(UnityObjectToWorldNormal(v.normal));
                float3 worldPos = mul(unity_ObjectToWorld, o.pos);
                float3 worldLightDir = normalize(UnityWorldSpaceLightDir(worldPos));
                //o.halfLamber = dot(worldNormal, worldLightDir)*0.5 + 0.5;
                o.halfLamber = dot(worldNormal, worldLightDir);

                o.worldPos = worldPos;
                o.worldNormal = worldNormal;
                return o;
            };

            float4 frag (v2f i) : COLOR
            {
                //利用阴影mask计算阴影
                float4 lightMapColor = tex2D(_LightMap,i.uvLM);

                fixed mask = lightMapColor.y * i.color.x;
                mask  = mask + saturate(i.halfLamber);
                mask  = mask *0.5 +(-_LightArea) + 1;
                int lightStep = step(1,mask);

                float4 mainCol = float4(1,1,1,1);
                mainCol.xyz = tex2D(_MainTex,i.uv).rgb;

                fixed3 firstShadow = mainCol.xyz * _FirstShadowMultColor.rgb;
                if(lightStep!=0)
                    firstShadow = mainCol.xyz;
                else
                    firstShadow = firstShadow ;

            
                fixed3 secondShadow = mainCol.xyz * _SecondShadowMultColor.rgb;
                fixed secMask = i.color.x * lightMapColor.y + saturate(i.halfLamber);
                secMask = secMask *0.5 + (-_SecondShadow)+1;
                lightStep = step(1, secMask);
                if(lightStep !=0)
                    secondShadow= mainCol.xyz;
                else
                    secondShadow= secondShadow;

                fixed sep = i.color.x * lightMapColor.y + 0.9;
                int sepMask = step(1,sep);

                fixed3 finalColor;
                if(sepMask != 0)
                    finalColor= firstShadow;
                else
                    finalColor= secondShadow;
                
                //高光信息和高光mask计算高光
                float3 viewDir = -i.worldPos + _WorldSpaceCameraPos.xyz;

                viewDir = normalize(viewDir);
                float3 halfView = viewDir + normalize(_WorldSpaceLightPos0.xyz);
                halfView = normalize(halfView);

                float shinPow = pow(max(dot(normalize(i.worldNormal.xyz), halfView), 0), _Shininess);
                
                float oneMinusSpec = 1 - lightMapColor.z;

                oneMinusSpec = oneMinusSpec - shinPow;
                int specMaslk = step(0,oneMinusSpec);
                fixed3 specColor = _SpecMulti * _LightSpecColor.xyz;
                specColor = lightMapColor.x * specColor;
                if(specMaslk!=0)
                    specColor = 0;
                else
                    specColor = specColor;

                float4 finalcol = (1,1,1,1);
                finalcol.rgb = finalColor + specColor * mainCol.rgb;
                return finalcol;
            }

            ENDCG
        }
    pass
    {
        Cull Front
        Lighting Off

        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag 
        #include "UnityCG.cginc"

        float _OutLine;
        float _Z;
        float4 _OutColor;

        struct v2f{
            float2 uv:TEXCOORD0;
            float4 pos:POSITION;
        };

        ///z-bias
        v2f ZBiasMethod(appdata_full i,v2f o)
        {
            float4 viewPos=mul(UNITY_MATRIX_MV,i.vertex);
            viewPos.z+=_OutLine;

            o.pos = mul(UNITY_MATRIX_P, viewPos);
            return o;
        }

        ///法线扩张1
        v2f VertexNormalMethod0(appdata_full i,v2f o)
        {
            o.pos=UnityObjectToClipPos(i.vertex);

            float3 normal=mul((float3x3)UNITY_MATRIX_IT_MV,i.normal);
            float2 offset=TransformViewToProjection(normal.xy);

            o.pos.xy+=offset*o.pos.z*_OutLine;

            return o;
        }

        ///法线扩张2
        v2f VertexNormalMethod1(appdata_full i,v2f o)
        {
            float4 viewPos = mul(UNITY_MATRIX_MV, i.vertex);
            float3 normal = mul( (float3x3)UNITY_MATRIX_IT_MV, i.normal);
            normal.z=-_Z;

            viewPos=viewPos+float4(normalize(normal),0)*_OutLine;
            o.pos=mul(UNITY_MATRIX_P,viewPos);    
            return o;
        }

        v2f vert(appdata_full i){
            v2f o;
            // o=ZBiasMethod(i,o);
            // o=VertexNormalMethod0(i,o);
            o=VertexNormalMethod1(i,o);
            return o;
        }

        float4 frag(v2f i):COLOR
        {
            return _OutColor;
        }
        ENDCG
    }
    }
}