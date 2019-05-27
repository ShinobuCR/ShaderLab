// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Custom/Body-1" {
    Properties {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _LightMap("Light Map",2D) = "white" {}
        _lightColor("Light Color",Vector) = (1,1,1)
        ambinetStrenth("ambinetStrenth",float) = 0.1
        _LightSpecColor("_LightSpecColor",vector) = (1,1,1)
        __SpecuMulti("_SpecuMulti",float) = 16

        _halmbert("halmbert",float) = 0.5
        FirstShadowMultiColor("FirstShadowMultiColor",range(0,0.2)) = 0.1
        SecondShadowMultiColor("SecondShadowMultiColor",range(0,0.2)) = 0.1
        _FirstShadow("_FirstShadow",range(0,0.2)) = 0.3
        _SecondShaow("_SecondShaow",range(0,0.1)) = 0.3
    }
    SubShader
    {
         Tags{"Queue"="Transparent"}
     
        pass
        {   
            Lighting On
            CGPROGRAM
// Upgrade NOTE: excluded shader from DX11; has structs without semantics (struct v2f members viewDir)
#pragma exclude_renderers d3d11
// Upgrade NOTE: excluded shader from DX11; has structs without semantics (struct v2f members viewDir)
            #pragma vertex vert
            #pragma fragment frag
           
            #include "UnityCG.cginc"
            #include "Lighting.cginc"


            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _LightMap;
            float4 _LightMap_ST;
            float3 _lightColor;
            float _LightSpecColor;
            float __SpecuMulti;
            float _halmbert;
            float FirstShadowMultiColor;
            float SecondShadowMultiColor;
            float _FirstShadow;
            float _SecondShaow;
           
            struct v2f
            {
                float4  pos : SV_POSITION;
                float4  uv : TEXCOORD0;
                float3 worldNormal : NORMAL;
                float3 viewDir : TEXCOORD1;
            };
            
            v2f vert (appdata_full v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                //计算法线和视角向量
                o.worldNormal = mul(v.normal,(float3x3)unity_WorldToObject);
                o.viewDir = normalize(_WorldSpaceCameraPos.xyz - mul(v.vertex, (float3x3)unity_WorldToObject).xyz);

                //采样光照贴图和颜色贴图
                o.uv.xy = TRANSFORM_TEX(v.texcoord,_MainTex); 
                o.uv.zw = TRANSFORM_TEX(v.texcoord,_LightMap);
                return o;
            };

            fixed4 frag (v2f i) : COLOR
            {
                //lightmap
                float4 lightCol = tex2D(_LightMap,i.uv.zw);
                float3 mainColor = tex2D(_MainTex,i.uv.xy).rgb;
                
                //高光
                float3 normal = normalize(i.worldNormal);

                float lightDir = normalize(_WorldSpaceLightPos0.xyz);
                float3 viewDir = i.viewDir;
                float3 halfwayDir = normalize(viewDir + lightDir);

                float shinPow = pow(max(dot(normal, halfwayDir), 0.0), 16.0);
                float3 spec = shinPow + lightCol.z > 1.0 ? __SpecuMulti * lightCol.x  * _LightSpecColor : 1;

                //漫反射
                float3 diffuse = float3(0,0,0);
                float diffuseMask = lightCol.y * mainColor.x;
                
                if (diffuseMask > 0.1)
                {
                    float firstMask = diffuseMask > 0.5 ? diffuseMask*1.2-0.1:diffuseMask*1.25-0.125;
                    bool isLight = (firstMask * _halmbert)*0.5 > _FirstShadow;
                    diffuse = isLight ? 1.0:FirstShadowMultiColor;
                }
                else
                {
                    bool isFirst = (diffuseMask + _halmbert)*0.5>_SecondShaow;
                    diffuse = isFirst ?  FirstShadowMultiColor : SecondShadowMultiColor;
                }
                fixed4 fragColor;
                fragColor.rgb = (diffuse + spec) * mainColor;
                fragColor.a = 1;
                return fragColor;
            }
            ENDCG
        }
    }
}