Shader "Custom/Shader"
{
    Properties
    {
        _MainTex("MainTex",2D)="white"{}
        _BlowTex ("Blow Texture", 2D) = "black" {}
        _Param ("Parameter", Range(1, 3)) = 1
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

            float _Param;
            sampler2D _MainTex;
            sampler2D _BlowTex;
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
        // 调整亮度，让亮的地方更亮  公式: y = x * [(2-4k)*x + 4k-1]
        float4 hdr(fixed4 col,float gray,float k)
        {
            float b=4*k-1;
            float a=1-b;
            float y=gray*(a*gray+b);
            return y*col;
        }
        fixed4 frag(v2f IN):COLOR
        {
            fixed4 blurCol=tex2D(_BlowTex,IN.uv);
            float gray = 0.3 * blurCol.r + 0.59 * blurCol.g + 0.11 * blurCol.b;
            fixed4 col=tex2D(_MainTex,IN.uv);
            return hdr(col,gray,_Param);
        }
        ENDCG
    }
    }
}