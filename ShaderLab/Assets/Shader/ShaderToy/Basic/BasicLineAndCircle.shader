// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Shadertoy/BaseLineAndCircle" { 
    Properties{
		_Parameters ("Circle Parameters", Vector) = (0.5, 0.5, 10, 1) // Center: (x, y), Radius: z
		_Color ("Circle Color", Color) = (1, 1, 1, 1)
		_BackgroundColor ("Background Color", Color) = (0, 0, 0.5, 1)
		_LineWidth ("Line Width", float) = 5
        _Antialias ("Antialias Factor", float) = 3

		_LineColor ("Line Color", Color) = (1, 1, 1, 1)

    }

    CGINCLUDE    
    #include "UnityCG.cginc"   
    #pragma target 3.0      

    #define vec2 float2
    #define vec3 float3
    #define vec4 float4
    #define mat2 float2x2
    #define mat3 float3x3
    #define mat4 float4x4
    #define iGlobalTime _Time.y
    #define mod fmod
    #define mix lerp
    #define fract frac
    #define texture2D tex2D
    #define iResolution _ScreenParams
    #define gl_FragCoord ((_iParam.scrPos.xy/_iParam.scrPos.w) * _ScreenParams.xy)

    #define PI2 6.28318530718
    #define pi 3.14159265358979
    #define halfpi (pi * 0.5)
    #define oneoverpi (1.0 / pi)

    float4 _Parameters;
    float4 _Color;
    float4 _BackgroundColor;
    float _LineWidth;
    float _Antialias;
    float4 _LineColor;

    struct v2f {    
        float4 pos : SV_POSITION;    
        float4 scrPos : TEXCOORD0;   
    };              

    v2f vert(appdata_base v) {  
        v2f o;
        o.pos = UnityObjectToClipPos (v.vertex);
        o.scrPos = ComputeScreenPos(o.pos);
        return o;
    }  

    vec4 circle(vec2 pos,vec2 center,float radius,float3 color,float antialias)
    {
        float d=length(pos-center)-radius;
        float t=smoothstep(0,antialias,d);
        return vec4(color,1.0-t);
    }
    vec4 mline(vec2 pos,vec2 point1,vec2 point2,float width,float3 color,float antialias)
    {
        float k=(point2.y-point1.y)/(point2.x-point1.x);
        float b=point1.y-k*point1.x;
        float d=abs(pos.y-k*pos.x-b)/sqrt(k*k+1);
        float t=smoothstep(width/2.0,width/2.0+antialias,d);

        return vec4(color,1-t);
    }
    vec4 main(vec2 fragCoord);

    fixed4 frag(v2f _iParam) : COLOR { 
        vec2 fragCoord = gl_FragCoord;
        return main(gl_FragCoord);
    }  

    vec4 main(vec2 fragCoord) { 
        vec2 pos=fragCoord;  //屏幕长宽,pos.x ~ (0, iResolution.x), pos.y ~ (0, iResolution.y
        // vec2 pos=fragCoord.xy/isResolution.xy; //x(0,1) y(0,1)
        // vec2 pos=fragCoord/min(isResolution.x,isResolution.y) //如果x大于y y(0,1) x(0,分辨率)
		// vec2 pos =fragCoord.xy / iResolution.xy * 2. - 1.; // pos.x ~ (-1, 1), pos.y ~ (-1, 1)
        // vec2 pos = (2.0*fragCoord.xy-iResolution.xy)/min(iResolution.x,iResolution.y);	// If iResolution.x > iResolution.y, pos.x ~ (-1.xx, 1.xx), pos.y ~ (-1, 1)
        vec4 layer1=vec4(_BackgroundColor.rgb,1.0f);

        vec2 point1 = vec2(0.3, 0.8);
	    vec2 point2 = vec2(0.8, 0.2);

		vec4 layer2 = mline(pos, point1* iResolution.xy, point2* iResolution.xy, _LineWidth, _LineColor.rgb, _Antialias);
        vec4 layer3 =  circle(pos, point1 * iResolution.xy, _Parameters.z, _Color.rgb, _Parameters.w);
		vec4 layer4 =  circle(pos, point2 * iResolution.xy, _Parameters.z, _Color.rgb, _Parameters.w);

        vec4 fragColor=mix(layer1,layer2,layer2.a);
        fragColor=mix(fragColor,layer3,layer3.a);    
        fragColor = mix(fragColor, layer4, layer4.a);

        return fragColor;
    }

    ENDCG    

    SubShader {    
        Pass {    
            CGPROGRAM    

            #pragma vertex vert    
            #pragma fragment frag    
            #pragma fragmentoption ARB_precision_hint_fastest     

            ENDCG    
        }    
    }     
    FallBack Off    
}