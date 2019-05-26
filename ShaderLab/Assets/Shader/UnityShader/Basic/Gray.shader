Shader "Unlit/gray"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _isGray ("isGray",int) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile GRAY NO_GRAY
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                fixed4 color : COLOR;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
                fixed4 color : COLOR;
            };

            int _isGray=0;
            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                o.color = v.color;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // 采样
                fixed4 col = tex2D(_MainTex, i.uv);
                // 灰度

                //if分支
                if(_isGray==1)
                {
                   float gray = dot(col.rgb, float3(0.299, 0.587, 0.114));
                   col.rgb=float3(gray,gray,gray);
                }
                //step函数以可以减少一定的分支，但是这里好像不好用上
                // float stats=step(_isGray,0.5)
                // col=col+(1-stats)*
                
                
            //    #ifdef GRAY
            //        float gray = dot(col.rgb, float3(0.299, 0.587, 0.114));
            //        col.rgb=float3(gray,gray,gray);
            //    #endif
               
            //    #ifdef NO_GRAY
            //        col=col;
            //    #endif    
                
               return col;
            }
            ENDCG
        }
    }
    CustomEditor "GrayGUI"
}