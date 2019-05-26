// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "OutLineOnly"
{
    Properties
    {
        _Outline ("Outline", Range(0,1)) = 0.4
        _SilhouetteTex("_SilhouetteTex",2D)="white"{}
        _MainTex("_MainTex",2d)="white"{}
    }
    ///surface Angle Silhouette
    ///通过法线与视角向量的点乘判断是否靠近边缘
    SubShader
    {
        Pass
        {
            Tags{"RendertType"="Opaque"}
            LOD 200
        
            CGPROGRAM
            #include "UnityCG.cginc"
            #include "Lighting.cginc"  
            #include "AutoLight.cginc" 

            #pragma vertex vert
            #pragma fragment frag
            
            float _Outline;
            sampler2D _SilhouetteTex;
            sampler2D _MainTex;

            struct v2f
            {
                float4 pos:POSITION;
                float2 uv:TEXCOORD0;
                float3 worldNormal:TEXCOORD1;
                float3 worldLightDir:TEXCOORD2;
                float3 worldViewDir:TEXCOORD3;
            };

            v2f vert(appdata_full i)
            {
                v2f o;
                o.pos=UnityObjectToClipPos(i.vertex);
                o.uv=i.texcoord;
                o.worldNormal=UnityObjectToWorldNormal(i.normal);
                // o.worldNormal = mul(i.normal, (float3x3)unity_WorldToObject);
                // o.worldLigthDir=WorldSpaceLightDir(i.vertex);
                o.worldLightDir = mul((float3x3)unity_ObjectToWorld, ObjSpaceLightDir(i.vertex));
                o.worldViewDir = mul((float3x3)unity_ObjectToWorld, ObjSpaceViewDir(i.vertex));
                // RANSFER_VERTEX_TO_FRAGMENT(o); 
                return o;
            }

            fixed3 SilhouetteUseConstant(float3 normal,float3 viewDir)
            {
                float res=saturate(dot(normal,viewDir));
                res=res<_Outline?res/4:1;

                return fixed3(res,0.7,0.8);
            }

            fixed3 SilhouetteUseTexture(float3 normal,float3 viewDir)
            {
                float res=dot(normal,viewDir);
                res=res*0.5+0.5;

                return tex2D(_SilhouetteTex,float2(res,res)).rgb;
            }


            fixed4 frag(v2f i):COLOR
            {
                fixed3 worldNormal = normalize(i.worldNormal);
                fixed3 worldLigthDir = normalize(i.worldLightDir);
                fixed3 worldViewDir = normalize(i.worldViewDir);

                fixed4 col=tex2D(_MainTex,i.uv);

                fixed3 SilhouetteColor=SilhouetteUseConstant(worldNormal,worldViewDir);
                // fixed3 SilhouetteColor=SilhouetteUseTexture(worldNormal,worldViewDir);
                fixed4 fragColor;
                if(SilhouetteColor.r>0.5)
                    discard;
                fragColor.rgb=col.rgb*SilhouetteColor;
                fragColor.a=1;
                return fragColor;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}