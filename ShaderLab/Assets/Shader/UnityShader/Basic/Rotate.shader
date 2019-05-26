Shader "Custom/Rotate"
{
    Properties
    {
        _MainTex("Base(RGB)",2D)="white"{}
        _CloudTex ("Cloud", 2D) = "white" {}
        _speed("speed",float)=0.5
    }
        SubShader
        {
            LOD 200
            Tags
            {
                "Queue"="Transparent"
                "IgnoreProjector"="True"
                "RenderType"="Transparent"
            }
            Pass
            {
                Cull Back
                Zwrite On
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"

                sampler2D _MainTex;
                sampler2D _CloudTex;
                float4 _MainTex_ST;
                float _speed;

                struct appdata_t
                {
                    float4 vertex:POSITION;
                    float2 texcoord:TEXCOORD0;
                    float4 color:COLOR;
                };
                struct v2f
                {
                    float4 vertex:SV_POSITION;
                    float2 texcoord:TEXCOORD0;
                };
                v2f vert(appdata_t v)
                {
                    v2f o;
                    o.vertex=UnityObjectToClipPos(v.vertex);
                    o.texcoord=TRANSFORM_TEX(v.texcoord,_MainTex);
                    return o;    
                }
                fixed4 frag(v2f IN):SV_TARGET
                {
                    float u=IN.texcoord.x+-_speed*_Time;
                    float uv=float2(u,IN.texcoord.y);
                    fixed4 texcol=tex2D(_MainTex,uv);
                    
                    u = IN.texcoord.x + -0.2*_Time;
                    uv = float2(u, IN.texcoord.y);
                    half4 cloudtex = tex2D (_CloudTex, uv);
                    cloudtex = float4(1,1,1,0) * (cloudtex.x);
                    return lerp(texcol, cloudtex, 0.5f);
                }
                ENDCG
            }
        }
    }