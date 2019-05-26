Shader "Custom/WaterColor"
{
    Properties
    {
        _MainTex("MainTex",2D)="white"{}
        _NoiseTex("Noise Texture",2D)="black"{}
        _QuanBit("Quant Bit",Range(1,7))=2
        _WaterPower("Water Power",Range(5,50))=10
        _TexSize("Texture Size",Vector)=(256,256,0,0)
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

            sampler2D _NoiseTex;
            sampler2D _MainTex;

            float4 _TexSize;
            float4 _MainTex_ST;
            float _QuanBit;
            float _WaterPower;

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
            //对颜色的几个分量进行量化
            float4 quant(float4 col,float k)
            {
                col.r=int(col.r*255/k)*k/255;
                col.g=int(col.g*255/k)*k/255;
                col.b=int(col.b*255/k)*k/255;
                return col;
            }
            fixed4 frag(v2f IN):COLOR
            {
                //从噪声纹理中取随机数，对纹理坐标进行干扰，从而形成扩散的效果
                float4 noiseCol=_WaterPower*tex2D(_NoiseTex,IN.uv);
                float2 newUV=float2(IN.uv.x+noiseCol.x/_TexSize.x,IN.uv.y+noiseCol.y/_TexSize.y);
                float4 col=tex2D(_MainTex,newUV);
                // return col;
                return quant(col,_QuanBit);
            }
            ENDCG
        }
    }
}