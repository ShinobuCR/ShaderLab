Shader "Noise/Perlin"
{
    Properties
    {
        _MainTex("_MainTex",2D)="white"{}
        _TexSize("_TexSize",vector)=(256,256,0,0)
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
            struct v2f
            {
                float4  pos : SV_POSITION;
                float2  uv : TEXCOORD0;
            };
            sampler2D _MainTex;
            float4 _MainTex_ST;
            
            v2f vert (appdata_base v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv =  TRANSFORM_TEX(v.texcoord,_MainTex);
                return o;
            }

            float4 _TexSize;
            //取随机向量
            float2 hash22(float2 p)
            {
                p=float2(dot(p,float2(127.1,311.7)),
                dot(p,float2(269.5,183.3)));
                //frac函数取小数部分
                return -1.0+2.0*frac(sin(p)*43758.5453123);
            }
            ///perlin噪声
            float perlin_noise(float2 p)
            {
                float2 pi=floor(p);
                float2 pf=p-pi;
                //s(t)=3t^2-2t^3;
                float2 w=pf*pf*(3-2*pf);
                ///插值计算与四个向量的点乘
                 return lerp(lerp(dot(hash22(pi + float2(0.0, 0.0)), pf - float2(0.0, 0.0)), 
                   dot(hash22(pi + float2(1.0, 0.0)), pf - float2(1.0, 0.0)), w.x), 
               lerp(dot(hash22(pi + float2(0.0, 1.0)), pf - float2(0.0, 1.0)), 
                   dot(hash22(pi + float2(1.0, 1.0)), pf - float2(1.0, 1.0)), w.x),
               w.y);
            }

            fixed4 frag(v2f IN):COLOR
            {
                float f=0.0;
                float2 uv=IN.uv;
                uv=uv*4;
                    ///加了下面的就是分形噪声,fbm公式 noise(p)+1/2*noise(2p)+1/4*noise(4p)
                    ///不加abs的时候，这种噪声可以用来模拟石头，山脉
                    ///加了abs后类似川流
                    ///更一步的改进加sin,可以用来模拟一些大理石材质
                    ///emmm,是挺像的
                    f=f+abs(perlin_noise(uv));
                    uv=uv*2;
                    f=f+0.5*abs(perlin_noise(uv));
                    uv=2*uv;
                    // uv=m*uv;
                    f=f+0.25*abs(perlin_noise(uv));
                    // uv=m*uv;
                    uv=uv*2;
                    f=f+0.125*abs(perlin_noise(uv));
                    uv=uv*2;
                    // uv=m*uv;
                    f=f+0.0625*abs(perlin_noise(uv));
                    f=sin(f+uv.x/32);
                //最简单的perlin噪声
                // float n_f=perlin_noise(uv*8.0);

                // return float4(n_f,n_f,n_f,1);
                //分形噪声
                return float4(f,f,f,1.0);
            }
            ENDCG
        }
    }
}