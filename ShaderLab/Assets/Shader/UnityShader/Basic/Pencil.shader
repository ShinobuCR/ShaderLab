Shader "Custom/Pencil"
{
    Properties
    {
        _MainTex("MainTex",2D)="white"{}
        _TexSize("_TexSize",vector)=(256,256,0,0)
        _BlurOffset("_BlurOffset",float)=0
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
            float _BlurOffset;
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
            ///滤波操作
            fixed4 Filter(sampler2D tex,float2 o,float3x3 filter,float2 texSize)
            {
                fixed4 output=(0,0,0,0);
                for(int i=0;i<3;i++)
                {
                    for(int j=0;j<3;j++)
                    {
                        float2 newCoord=float2(o.x+(i-1)*_BlurOffset,o.y+(j-1)*_BlurOffset);
                        float2 newUv=float2(newCoord.x/texSize.x,newCoord.y/texSize.y);
                        fixed4 col=tex2D(tex,newUv)*filter[i][j];
                        output+=col;
                    }
                }
                return output;
            }
            fixed4 frag(v2f o):COLOR
            {
                ///边缘处理核
                float3x3 pencilFilter = 
                {
                    -0.5, -1.0, 0.0,
                    -1.0,  0.0, 1.0,
                     0.0,  1.0, 0.5
                };
                float2 coord = float2(o.uv.x * _TexSize.x, o.uv.y * _TexSize.y);
                fixed4 filterCol=Filter(_MainTex,coord,pencilFilter,_TexSize);
                float gray = 0.3 * filterCol.x + 0.59 * filterCol.y + 0.11 * filterCol.z;
                gray = abs(gray);
                gray = 1.0 - gray;
                return float4(gray, gray, gray, 1);

            }
            ENDCG
        }
    }
}