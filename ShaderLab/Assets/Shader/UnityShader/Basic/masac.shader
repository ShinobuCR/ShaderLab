Shader "Custom/Masac"
{
    Properties
    {
        _MainTex("MainTex",2D)="white"{}
        _TexSize("偏移",vector)=(256,256,0,0)
        _SquareWidth("SquareWidth",float)=0
    }
    SubShader
    {
        Tags{"Queue"="Transparent"}
        pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            vector _TexSize;
            sampler2D _MainTex;
            float _SquareWidth;
            float4 _MainTex_ST;

            struct v2f
            {
                fixed4 vertex:POSITION;
                fixed2 uv:TEXCOORD0;
            };

            v2f vert(appdata_base v)
            {
                v2f o;
                o.vertex=UnityObjectToClipPos(v.vertex);
                o.uv=TRANSFORM_TEX(v.texcoord,_MainTex);
                return o;
            }

            fixed4 frag(v2f IN):COLOR
            {
                //利用int，周围nxn方块都取同一个颜色
                float pixelX=int(IN.uv.x*_TexSize.x/_SquareWidth)*_SquareWidth;
                float pixelY=int(IN.uv.y*_TexSize.y/_SquareWidth)*_SquareWidth;
                float2 uv=float2(pixelX/_TexSize.x,pixelY/_TexSize.y);
                return tex2D(_MainTex,uv);
            }
            ENDCG
        }
    }
}