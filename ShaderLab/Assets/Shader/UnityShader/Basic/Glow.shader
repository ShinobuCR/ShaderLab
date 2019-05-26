shader "Custom/Glow"
{
    Properties
    {
        _MainTex("Base(RGB),Alpha",2D)="white"{}
        _TexSize("Texture Size",vector)=(256,256,0,0)
        _BlurOffset("Blur Offset",Range(0,10))=1
		_LuminanceThreshold ("Luminance Threshold", Float) = 0.5
        _blend("blend",Range(0,1))=0.5

    }
    SubShader
    {
        LOD 200

        Tags
        {
            "Queue"="Transparent"
            "IgnoreProjector"="True"
            "RenderType"="Tranparent"
        }
        Pass
        {
            Lighting Off
            ZWrite Off

            // Offset -1,-1
            // Blend SrcAlpha OneMinusSrcAlpha

            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float4 _TexSize;
            float _BlurOffset;
            float4 _MainTex_ST;
            float _LuminanceThreshold;
            float _blend;

            struct appdata_t
            {
                float4 vertex:POSITION;
                float2 uv:TEXCOORD;
                fixed4 color:COLOR;
            };
            struct v2f
            {
                float4 vertex:SV_POSITION;
                half2 uv:TEXCOORD;
                fixed4 color:COLOR;
            };


            v2f vert(appdata_t v)
            {
                v2f o;
                o.vertex=UnityObjectToClipPos(v.vertex);
                o.uv=v.uv;
                o.color=v.color;
                return o;
            };
            fixed luminance(fixed4 color)
            {
                return color.r*0.2125+0.7154*color.g+0.0721*color.b;
            }
            //滤波器实现模糊效果(横竖都会模糊)
            float4 filter(float3x3 filter,sampler2D tex,float2 coord,float2 texSize)
            {
                float4 outCol=float4(0,0,0,0);
                for(int i=0;i<3;i++)
                {
                    for(int j=0;j<3;j++)
                    {
                        float2 newCoord=float2(coord.x+(i-1)*_BlurOffset,coord.y+(j-1)*_BlurOffset);
                        float2 newUV=float2(newCoord.x/texSize.x,newCoord.y/texSize.y);
                        outCol+=tex2D(tex,newUV)*filter[i][j];
                    }
                }
                return outCol;
            }


            fixed4 frag(v2f IN):COLOR
            {

                fixed4 origin=tex2D(_MainTex,IN.uv);
                //box模糊
                float3x3 boxFilter=
                {
                    1.0f/9, 1.0f/9, 1.0f/9, 
                    1.0f/9, 1.0f/9, 1.0f/9, 
                    1.0f/9, 1.0f/9, 1.0f/9, 
                };

                //高斯模糊
                float3x3 gaussFilter=
                {
                    1.0f/16,2.0f/16,1.0f/16,
                    2.0f/16,4.0f/16,2.0f/16,
                    1.0f/16,2.0f/16,1.0f/16,
                };
                //较量区域
                fixed4 ExtracBright=origin*clamp(luminance(origin)-_LuminanceThreshold,0.0,1.0);
                //模糊处理 
                float2 coord=float2(IN.uv.x*_TexSize.x,IN.uv.y*_TexSize.y);
                fixed4 blur=filter(gaussFilter,_MainTex,coord,_TexSize);
                //原图与较亮区域经过模糊的图混合
                return origin+blur;
            }
            ENDCG
        }
    }
}

// Shader "Custom/Glow"
// {
//     Properties
//     {
//         _MainTex("Base(RGB),Alpha",2D)="white"{}
//         _TexSize("Texture Size",vector)=(256,256,0,0)
//         _BlurOffset("Blur Offset",Range(0,10))=1
// 		_LuminanceThreshold ("Luminance Threshold", Float) = 0.5
//         _Bloom("Base(RGB)",2D)="black"{}
//     }
//     //------CGINCLUDE的写法--------
//     SubShader
//     {
//         CGINCLUDE

//         #include "UnityCG.cginc"
//         sampler2D _MainTex;
//         float4 _TexSize;
//         float _BlurOffset;
//         float4 _MainTex_ST;
//         float _LuminanceThreshold;
//         sampler2D _Bloom;
//         struct appdata_t
//         {
//             float4 vertex:POSITION;
//             float2 uv:TEXCOORD;
//             fixed4 color:COLOR;
//         };
//         ///第一个pass获得高光区域
//         struct v2f
//         {
//             float4 vertex:SV_POSITION;
//             half2 uv:TEXCOORD;
//             fixed4 color:COLOR;
//         };
//         v2f vert(appdata_t v)
//         {
//             v2f o;
//             o.vertex=UnityObjectToClipPos(v.vertex);
//             o.uv=v.uv;
//             o.color=v.color;
//             return o;
//         };
//         fixed luminance(fixed4 color)
//         {
//             return color.r*0.2125+0.7154*color.g+0.0721*color.b;
//         }
//         fixed4 fragExtractBright(v2f i) : SV_Target {
// 		    fixed4 c = tex2D(_MainTex, i.uv);
// 		    fixed val = clamp(luminance(c) - _LuminanceThreshold, 0.0, 1.0);	
// 		    return c * val;
// 		}



//         /// 第二个pass对高光区域进行模糊

//         struct v2fBlur
//         {
//             float4 vertex:SV_POSITION;
//             half2 uv:TEXCOORD;
//             fixed4 color:COLOR;
//         };

//         struct appdata_blur
//         {
//             float4 vertex:POSITION;
//             float2 uv:TEXCOORD;
//             fixed4 color:COLOR;
//         };

//         v2fBlur Blurvert(appdata_blur v)
//         {
//             v2fBlur o;
//             o.vertex=UnityObjectToClipPos(v.vertex);
//             o.uv=v.uv;
//             o.color=v.color;
//             return o;
//         };
//                             //滤波器实现模糊效果(横竖都会模糊)
//         float4 filter(float3x3 filter,sampler2D tex,float2 coord,float2 texSize)
//         {
//             float4 outCol=float4(0,0,0,0);
//             for(int i=0;i<3;i++)
//             {
//                 for(int j=0;j<3;j++)
//                 {
//                     float2 newCoord=float2(coord.x+(i-1)*_BlurOffset,coord.y+(j-1)*_BlurOffset);
//                     float2 newUV=float2(newCoord.x/texSize.x,newCoord.y/texSize.y);
//                     outCol+=tex2D(tex,newUV)*filter[i][j];
//                 }
//             }
//             return outCol;
//         }


//         fixed4 frag(v2f IN):COLOR
//         {

//             fixed4 origin=tex2D(_MainTex,IN.uv);
//             //box模糊
//             float3x3 boxFilter=
//             {
//                 1.0f/9, 1.0f/9, 1.0f/9, 
//                 1.0f/9, 1.0f/9, 1.0f/9, 
//                 1.0f/9, 1.0f/9, 1.0f/9, 
//             };

//             //高斯模糊
//             float3x3 gaussFilter=
//             {
//                 1.0f/16,2.0f/16,1.0f/16,
//                 2.0f/16,4.0f/16,2.0f/16,
//                 1.0f/16,2.0f/16,1.0f/16,
//             };
//             //模糊处理 
//             float2 coord=float2(IN.uv.x*_TexSize.x,IN.uv.y*_TexSize.y);
//             fixed4 blur=filter(gaussFilter,_MainTex,coord,_TexSize);
//             //原图与较亮区域经过模糊的图混合
//             return blur;
//         }


//         ///第三个pass对模糊后的图和原图进行混合
//         struct v2fBloom {
// 		    float4 pos : SV_POSITION; 
// 			half4 uv : TEXCOORD0;
// 		};
		
// 		v2fBloom vertBloom(appdata_img v) {
// 			v2fBloom o;
			
// 			o.pos = UnityObjectToClipPos (v.vertex);
// 			o.uv.xy = v.texcoord;		
// 			o.uv.zw = v.texcoord;
			
// 			// #if UNITY_UV_STARTS_AT_TOP			
// 			// if (_MainTex_TexelSize.y < 0.0)
// 			// 	o.uv.w = 1.0 - o.uv.w;
// 			// #endif
				        	
// 			return o; 
// 		}
		
// 		fixed4 fragBloom(v2fBloom i) : SV_Target {
// 			return tex2D(_MainTex, i.uv.xy) + tex2D(_Bloom, i.uv.zw);
// 		} 
		
// 		ENDCG

//         ZTest Always Cull Off ZWrite Off

//         Pass
//         {
//             CGPROGRAM
//             #pragma vertex vert
//             #pragma fragment fragExtractBright
            
//             ENDCG
//         }
//         Pass
//         {
//             CGPROGRAM
//             #pragma vertex Blurvert
//             #pragma fragment frag

//             ENDCG
//         }
//         Pass
//         {
//             CGPROGRAM
//             #pragma vertex vertBloom
// 			#pragma fragment fragBloom  
			
// 			ENDCG  
// 		}
// 	}
// 	FallBack Off
// }