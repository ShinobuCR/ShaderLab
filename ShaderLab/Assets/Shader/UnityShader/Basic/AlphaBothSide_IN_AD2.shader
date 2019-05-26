Shader "DHGames/DoubleSide"
{
	Properties
	{
		_MainTexFront ("TextureBack", 2D) = "white" {}
        _MainColorFront("Main Color",Color) = (1, 1, 1, 1)
        _StrengthFront("StrengthFront",float) = 1
        _MainTexBack ("TextureFront", 2D) = "white" {}
        _MainColorBack("Main Color",Color) = (1, 1, 1, 1)
        _StrengthBack("StrengthBack",float) = 1
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
            NAME "FRONT"
            Cull Back
            Blend SrcAlpha OneMinusSrcAlpha
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTexFront;
			float4 _MainTexFront_ST;
            fixed4 _MainColorFront;
            float _StrengthFront;    
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTexFront);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTexFront, i.uv);
				return col*_MainColorFront*_StrengthFront;
			}
			ENDCG
		}

        Pass
        {
            NAME "BACK"
            Cull Front
            Blend SrcAlpha OneMinusSrcAlpha
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTexBack;
            float4 _MainTexBack_ST;
            fixed4 _MainColorBack;
            float _StrengthBack;
            
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTexBack);
                return o;
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTexBack, i.uv);
                return col*_MainColorBack*_StrengthBack;
            }
            ENDCG
        }
	}
}
