///
Shader "Custom/Emboss"
{
    Properties
    {
        _MainTex("Base(RGB)",2D)="white"{}
        _Color("Color",Color)=(1, 1, 1, 1)
        _TexSize("Texture Size",vector)=(256,256,0,0)
    }
    SubShader
    {
        Tags{"Queue"="Transparent"}
        Pass
        {
            // Cull front
            // Blend SrcAlpha OneMinusSrcAlpha
			// ZWrite Off
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            fixed4 _Color;
            vector _TexSize;
            struct appdata_t
            {
                fixed4 vertex:POSITION;
                fixed2 uv:TEXCOORD0;
                fixed4 color:COLOR;
            };
            struct v2f
            {
                fixed4 vertex:SV_POSITION;
                fixed2 uv:TEXCOORD0;
                fixed4 color:COLOR;
            };

            v2f vert(appdata_t v)
            {
                v2f o;
                o.vertex=UnityObjectToClipPos(v.vertex);
                o.uv=v.uv;
                o.color=v.color;
                return o;
            }
            fixed4 frag(v2f o):COLOR
            {
                fixed2 newuv=fixed2(o.uv.x-1/_TexSize.x,o.uv.y-1/_TexSize.y);
                fixed4 leftUpcol=tex2D(_MainTex,newuv);
                fixed4 col=tex2D(_MainTex,o.uv);
                fixed4 colout=col-leftUpcol;
                float gray=dot(colout,fixed3(0.3,0.6,0.1));
                return fixed4(gray,gray,gray,1);
                
            }
            ENDCG
        }
        // Pass
        // {
        //     Cull back
        //     Blend SrcAlpha OneMinusSrcAlpha
		// 	ZWrite Off
        //     CGPROGRAM
        //     #pragma vertex vert
        //     #pragma fragment frag
        //     #include "UnityCG.cginc"

        //     sampler2D _MainTex;
        //     fixed4 _Color;

        //     struct appdata_t
        //     {
        //         fixed4 vertex:POSITION;
        //         fixed2 uv:TEXCOORD0;
        //         fixed4 color:COLOR;
        //     };
        //     struct v2f
        //     {
        //         fixed4 vertex:SV_POSITION;
        //         fixed2 uv:TEXCOORD0;
        //         fixed4 color:COLOR;
        //     };

        //     v2f vert(appdata_t v)
        //     {
        //         v2f o;
        //         o.vertex=UnityObjectToClipPos(v.vertex);
        //         o.uv=v.uv;
        //         o.color=v.color;
        //         return o;
        //     }
        //     fixed4 frag(v2f o):COLOR
        //     {
        //         o.uv.y=1-o.uv.y;
        //         o.uv.x=1-o.uv.x;
        //         fixed4 col=tex2D(_MainTex,o.uv);
        //         return col*_Color;
        //     }
        //     ENDCG
        // }
    }
}