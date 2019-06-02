// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Custom/Face" {
    Properties {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _LightMap("Light Map",2D) = "white" {}
        _lightColor("Light Color",Vector) = (1,1,1)
        
        _DiffuseColor("_DiffuseColor",Color) = (1,1,1)
        _Shiness("_Shiness",int) = 32
        specularStrength("specularStrength",float) = 1
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
            
            float3 _DiffuseColor;
            int _Shiness;
            float specularStrength;
           
            struct v2f
            {
                float4  pos : SV_POSITION;
                float4  uv : TEXCOORD0;
                float3 worldNormal : NORMAL;
                float3 viewDir : TEXCOORD1;
                float3 lightDir : TEXCOORD2;
            };
            
            v2f vert (appdata_full v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                //计算法线和视角向量
                o.worldNormal = mul(v.normal,(float3x3)unity_WorldToObject);
                // o.viewDir = normalize(_WorldSpaceCameraPos.xyz - mul(v.vertex, (float3x3)unity_WorldToObject).xyz);
                // o.viewDir = normalize(_WorldSpaceCameraPos.xyz);
                o.viewDir = ObjSpaceViewDir(v.vertex);

                // o.lightDir = normalize(_WorldSpaceLightPos0.xyz - mul(v.vertex, (float3x3)unity_WorldToObject).xyz);
                // o.lightDir = normalize(_WorldSpaceLightPos0.xyz);
                o.lightDir = ObjSpaceLightDir(v.vertex);
                
                float3 binormal=cross(v.normal,v.tangent);
                //用顶点的Tangent,Binormal,Normal组合成选择矩阵
                float3x3 rotation=float3x3(v.tangent.xyz,binormal,v.normal);
                o.lightDir = mul(rotation,o.lightDir);
                o.viewDir = mul(rotation,o.viewDir);

                //采样光照贴图和颜色贴图
                o.uv.xy = TRANSFORM_TEX(v.texcoord,_MainTex); 
                o.uv.zw = TRANSFORM_TEX(v.texcoord,_LightMap);
                return o;
            };

            fixed4 frag (v2f i) : COLOR
            {
                float3 mainColor = tex2D(_MainTex,i.uv.xy).rgb;
                
                //lightmap
                float3 normalTex = (tex2D(_LightMap, i.uv.zw).xyz);
                float3 normal =normalize(2 * normalTex - 1);
                float3 viewDir = i.viewDir;
                float3 lightDir = i.lightDir;

                //冯氏高光
                float reflectDir = reflect(-lightDir, normal);

                //bling-phone
                float3 halfwayDir = normalize(viewDir + lightDir);

                float spec = pow(max(dot(normal, halfwayDir), 0.0), _Shiness);

                // float spec = pow(max(dot(viewDir, reflectDir), 0.0), _Shiness);
                // spec = specularStrength * spec * _DiffuseColor;

                //漫反射
                
                float3 diffuse = float3(0,0,0);

                fixed4 fragColor;
                diffuse = 0.5 * dot(normal,lightDir) + 0.5;

                fragColor.rgb = ( diffuse + spec) * mainColor;


                fragColor.a = 1;
                return fragColor;
            }
            ENDCG
        }
    }
}