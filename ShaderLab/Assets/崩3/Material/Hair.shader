Shader "Custom/Hair" {
    Properties {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _LightMap("LightMap",2D) = "white" {}
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
            struct v2f
            {
                float4  pos : SV_POSITION;
                float2  uv : TEXCOORD0;
            };
            
            v2f vert (appdata_img v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv =  v.texcoord;
                return o;
            };

            float4 frag (v2f i) : COLOR
            {
                float4 col = tex2D(_MainTex,i.uv);
                float4 light = tex2D(_LightMap,i.uv);
                return col*light;
            }
            ENDCG
        }
    }
}