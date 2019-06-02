// Upgrade NOTE: replaced tex2D unity_Lightmap with UNITY_SAMPLE_TEX2D

// Upgrade NOTE: replaced tex2D unity_Lightmap with UNITY_SAMPLE_TEX2D

// Upgrade NOTE: replaced tex2D unity_Lightmap with UNITY_SAMPLE_TEX2D

Shader "Custom/Body" {
    Properties {
        _MainTex ("_MainTex", 2D) = "white" {}
        _LightMap("_LightMap", 2D) = "white"{}
    }
    SubShader
    {
         Tags{"Queue"="Transparent"}
        pass
        {   
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
           
            struct v2f
            {
                float4  pos : SV_POSITION;
                float2  uv : TEXCOORD0;
				float2 uvLM : TEXCOORD2;
                float2 uv2 : TEXCOORD1;
            };
            
            v2f vert (appdata_full v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv =  TRANSFORM_TEX(v.texcoord,_MainTex);
                // o.uv2 =  TRANSFORM_TEX(v.texcoord,unity_LightmapST);
                
				o.uvLM = v.texcoord2.xy * unity_LightmapST.xy + unity_LightmapST.zw;

                return o;
            };

            float4 frag (v2f i) : COLOR
            {
                float4 col = tex2D(_MainTex,i.uv);
                UNITY_APPLY_FOG(i.fogCoord, col);
				UNITY_OPAQUE_ALPHA(col.a);
				fixed3 lm = DecodeLightmap (UNITY_SAMPLE_TEX2D(unity_Lightmap, i.uvLM));

                col.rgb = col.rgb * lm;
                return col;
            }
            ENDCG
        }
    }
}