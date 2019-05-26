Shader "Custom/TemPlate" {
    Properties {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _LightMap("LightMap",2D)= "white" {}
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
            sampler2D _MainTex;
            sampler2D _LightMap;

            struct v2f {
                float4 pos : POSITION;
                float2 uv : TEXCOORD0;
            };
            
            v2f vert (appdata_img v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos (v.vertex);
                o.uv = v.texcoord;
                return o;
            };

            float4 frag (v2f i) : COLOR
            {
                fixed3 lightCol=tex2D(_LightMap,i.uv).rgb;
                fixed4 col=tex2D(_MainTex,i.uv);
                fixed3 rgb=col.rgb*lightCol;
                return fixed4(rgb.r,rgb.g,rgb.b,1);
            }
            ENDCG
        }
    }
}