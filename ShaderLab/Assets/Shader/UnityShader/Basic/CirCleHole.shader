﻿Shader "Custom/CircleHole"
{
    Properties
    {
        _MainTex("Base(RGB)",2D)="white"{}
        _Center("center",vector)=(0.5,0.5,0,0)
        _Radius("Radius",float)=0.5
        _Alpha("Alpha",float)=1.0
        _Fade("Fade Rate",float)=0.0
        _Interval("Interval",float)=0.0
    }
    SubShader
    {
        LOD 100
        Tags
        {
            "Queue"="Transparent"
            "IgnoreProjector"="True"
            "RenderType"="Transparent"
        }
        pass
        {
            Cull Off
            Lighting Off
            ZWrite Off
            Fog { Mode Off }
            Offset -1, -1
            ColorMask RGB
            //AlphaTest Greater .01
            Blend SrcAlpha OneMinusSrcAlpha
            ColorMaterial AmbientAndDiffuse

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            
            sampler2D _MainTex;
            float2 _Center;
            float _Radius;
            float _Alpha;
            float _Fade;
            float _Interval;


            struct v2f
            {
                float4 pos:POSITION;
                float2 uv:TEXCOORD3;
            };
            v2f vert(appdata_base v)
            {
                v2f o;
                o.pos=UnityObjectToClipPos(v.vertex);
                o.uv=v.texcoord;
                return o;
            }
            fixed4 frag(v2f i):COLOR
            {
                fixed4 texcol=tex2D(_MainTex,i.uv);
                float d=distance(i.uv,_Center.xy);

                float startTime=floor(_Time.y/_Interval)*_Interval;
                float passTime=_Time.y-startTime;
                float r=_Radius*clamp((1-5*passTime/_Interval),0,1);
                
                if(d<r*_Fade)
                {
                    texcol.a=0;
                }
                else if(d<r)
                texcol.a=_Alpha*(1-(r-d))/(r-r*_Fade);
                else
                    texcol.a=_Alpha;
                return texcol;
            }
        ENDCG

        }
    }
    Fallback "Diffuse"
}