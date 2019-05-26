shader "Custom/Sharpen"
{
    Properties
    {
        _MainTex("Base(RGB),Alpha",2D)="white"{}
        _TexSize("Texture Size",vector)=(256,256,0,0)
        _BlurOffset("Blur Offset",Range(0,10))=1
    }
    SubShader
    {
        LOD 200

        Tags
        {
            "Queue"="Transparent"
            "IgnoreProjector"="True"
            "RenderType"="Tranparent"
        }
        Pass
        {
            Lighting Off
            ZWrite Off
            Fog
            {
                Mode Off
            }
            Blend SrcAlpha OneMinusSrcAlpha

            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float4 _TexSize;
            float _BlurOffset;
            float4 _MainTex_ST;

            struct appdata_t
            {
                float4 vertex:POSITION;
                float2 uv:TEXCOORD;
                fixed4 color:COLOR;
            };
            struct v2f
            {
                float4 vertex:SV_POSITION;
                half2 uv:TEXCOORD;
                fixed4 color:COLOR;
            };

            v2f vert(appdata_t v)
            {
                v2f o;
                o.vertex=UnityObjectToClipPos(v.vertex);
                o.uv=v.uv;
                o.color=v.color;
                return o;
            };
            //滤波器
            float4 filter(float3x3 filter,sampler2D tex,float2 coord,float2 texSize)
            {
                float4 outCol=float4(0,0,0,0);
                for(int i=0;i<3;i++)
                {
                    for(int j=0;j<3;j++)
                    {
                        float2 newCoord=float2(coord.x+(i-1)*_BlurOffset,coord.y+(j-1)*_BlurOffset);
                        float2 newUV=float2(newCoord.x/texSize.x,newCoord.y/texSize.y);
                        outCol+=tex2D(tex,newUV)*filter[i][j];
                    }
                }
                return outCol;
            }
            fixed4 frag(v2f IN):COLOR
            {
                //拉普拉斯锐化
                float3x3 laplaceFilter = 
                {
                    -1, -1, -1,
                    -1,  9, -1,
                    -1, -1, -1,
                };
                float2 coord=float2(IN.uv.x*_TexSize.x,IN.uv.y*_TexSize.y);
                return filter(laplaceFilter,_MainTex,coord,_TexSize);
            }
            ENDCG
        }
    }
}