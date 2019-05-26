Shader "DynamicWeather"
{
    Properties
    {
        _BackTex("_BackTex",2D)="white"{}
        _Noise1("_Noise1",2D)="white"{}
        _Noise2("_Noise2",2D)="white"{}
        _Noise3("_Noise3",2D)="white"{}
        _Noise4("Noise4",2D)="white"{}
        _Speed("_Speed",Range(-3,10))=0.1
        _Speed_2("_Speed_2",Range(1,10))=2
        _Cloud("_Cloud",Color) = (0.5,0.5,0.5,1)
        _Emptiness("_Emptiness", Range(-0.3, 0.3)) = 0.2
        _Sharpness("_Sharpness", Range(-0.3, 0.5)) = 0.1
    }
    SubShader
    {
        Tags{"Queue"="Transparent"}
        ///渲染背景
        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _BackTex;
            float4 _BackTex_ST;
            struct v2f
            {
                float4 vertex:POSITION;
                float2 uv:TEXCOORD0;
            };

            v2f vert(appdata_base v)
            {
                v2f o;
                o.vertex=UnityObjectToClipPos(v.vertex);
                o.uv=TRANSFORM_TEX(v.texcoord,_BackTex);
                return o;
            }
            fixed4 frag(v2f IN):COLOR
            {
                return tex2D(_BackTex,IN.uv);
            }
            ENDCG
        }
        ///渲染云1层
        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct v2f
            {
                float4 vertex:POSITION;
                float4 uv0:TEXCOORD0;
                float4 uv1:TEXCOORD1;
            };
            float4 _Cloud;
            sampler2D _Noise1;
            sampler2D _Noise2;
            sampler2D _Noise3;
            sampler2D _Noise4;
            float4 _Noise1_ST;
            float4 _Noise2_ST;
            float4 _Noise3_ST;
            float4 _Noise4_ST;
            float _Speed;
            float _Emptiness;
            float _Sharpness;

            v2f vert(appdata_base v)
            {
                v2f o;
                o.vertex=UnityObjectToClipPos(v.vertex);
                o.uv0.xy=TRANSFORM_TEX(v.texcoord,_Noise1)+_Time.x*1.0*_Speed*half2(1,0);
                o.uv0.zw=TRANSFORM_TEX(v.texcoord,_Noise2)+_Time.x*1.5*_Speed*half2(0,1);
                o.uv1.xy=TRANSFORM_TEX(v.texcoord,_Noise3)+_Time.x*2.0*_Speed*half2(0,-1);
                o.uv1.zw=TRANSFORM_TEX(v.texcoord,_Noise4)+_Time.x*2.5*_Speed*half2(-1,0);
                return o;
            }
            fixed4 frag(v2f IN):COLOR
            {
                float y1=IN.uv0.xy.y;
                float y2=IN.uv1.xy.y;
                // if(y1<0.5)
                // {
                //     return fixed4(1,1,1,0);
                // } 
                // if(y2<0.3)
                // {
                //     return fixed4(1,1,1,0);
                // }
                float4 col;
                float4 no1=tex2D(_Noise1,IN.uv0.xy);
                float4 no2=tex2D(_Noise2,IN.uv0.zw);
                float4 no3=tex2D(_Noise3,IN.uv1.xy);
                float4 no4=tex2D(_Noise4,IN.uv1.zw);

                float4 f=0.5*no1+0.25*no2+0.125*no3+0.0625*no4;
                f = (clamp(f, _Emptiness, _Sharpness) -  _Emptiness)/(_Sharpness - _Emptiness);

                float4 ray=(0,0.2,0.4,0.6);
                float4 amount=dot(max(0,f-ray),float4(0.25,0.25,0.25,0.25));
                col.rgb=_Cloud.rgb*amount+2*(1-amount)*0.4;
                col.a=amount*1.5;
                return col;
            }
            ENDCG
        }
            ///渲染云2层
        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct v2f
            {
                float4 vertex:POSITION;
                float4 uv0:TEXCOORD0;
                float4 uv1:TEXCOORD1;
            };
            float4 _Cloud;
            sampler2D _Noise1;
            sampler2D _Noise2;
            sampler2D _Noise3;
            sampler2D _Noise4;
            float4 _Noise1_ST;
            float4 _Noise2_ST;
            float4 _Noise3_ST;
            float4 _Noise4_ST;
            float _Speed_2;
            float _Emptiness;
            float _Sharpness;

            v2f vert(appdata_base v)
            {
                v2f o;
                o.vertex=UnityObjectToClipPos(v.vertex);
                o.uv0.xy=TRANSFORM_TEX(v.texcoord,_Noise1)+_Time.x*1.0*_Speed_2*half2(1,0);
                o.uv0.zw=TRANSFORM_TEX(v.texcoord,_Noise2)+_Time.x*1.5*_Speed_2*half2(0,1);
                o.uv1.xy=TRANSFORM_TEX(v.texcoord,_Noise3)+_Time.x*2.0*_Speed_2*half2(0,-1);
                o.uv1.zw=TRANSFORM_TEX(v.texcoord,_Noise4)+_Time.x*2.5*_Speed_2*half2(-1,0);
                return o;
            }
            fixed4 frag(v2f IN):COLOR
            {
                float y1=IN.uv0.xy.y;
                float y2=IN.uv1.xy.y;

                float4 col;
                float4 no1=tex2D(_Noise1,IN.uv0.xy);
                float4 no2=tex2D(_Noise2,IN.uv0.zw);
                float4 no3=tex2D(_Noise3,IN.uv1.xy);
                float4 no4=tex2D(_Noise4,IN.uv1.zw);

                float4 f=0.5*no1+0.25*no2+0.125*no3+0.0625*no4;
                f = (clamp(f, _Emptiness, _Sharpness) -  _Emptiness)/(_Sharpness - _Emptiness);

                float4 ray=(0,0.2,0.4,0.6);
                float4 amount=dot(max(0,f-ray),float4(0.25,0.25,0.25,0.25));
                col.rgb=_Cloud.rgb*amount+2*(1-amount)*0.4;
                col.a=amount*1.5;
                return col;
            }
            ENDCG
        }
    }
}