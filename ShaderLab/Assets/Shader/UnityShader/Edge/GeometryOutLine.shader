// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "GeometryOutLine"{
     Properties{
         _MainTex("_MainTex",2d)="white"{}
         _OutLine("_OutLine",Range(0,1))=0.4
         _Z("_Z",Range(-5,5))=1
    }
     SubShader{
     pass{
         Cull Back
         Lighting On

         CGPROGRAM
         #pragma vertex vert
         #pragma fragment frag 
         #include "UnityCG.cginc"

        struct v2f{
            float2 uv:TEXCOORD0;
            float4 pos:POSITION;
        };

        sampler2D _MainTex;
         v2f vert(appdata_full v){
                v2f o;
                o.pos= UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;

                return o;
        }
         fixed4 frag(v2f i):COLOR
         {
            fixed3 col = tex2D(_MainTex, i.uv).rgb; 

            fixed4 fragColor;
            fragColor.rgb = col;
            fragColor.a = 1.0;

            return fragColor;
        }
        ENDCG
    }

    pass
    {
        Cull Front
        Lighting Off

        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag 
        #include "UnityCG.cginc"

        float _OutLine;
        float _Z;

        struct v2f{
            float2 uv:TEXCOORD0;
            float4 pos:POSITION;
        };

        ///z-bias
        v2f ZBiasMethod(appdata_full i,v2f o)
        {
            float4 viewPos=mul(UNITY_MATRIX_MV,i.vertex);
            viewPos.z+=_OutLine;

            o.pos = mul(UNITY_MATRIX_P, viewPos);
            return o;
        }

        ///法线扩张1
        v2f VertexNormalMethod0(appdata_full i,v2f o)
        {
            o.pos=UnityObjectToClipPos(i.vertex);

            float3 normal=mul((float3x3)UNITY_MATRIX_IT_MV,i.normal);
            float2 offset=TransformViewToProjection(normal.xy);

            o.pos.xy+=offset*o.pos.z*_OutLine;

            return o;
        }

        ///法线扩张2
        v2f VertexNormalMethod1(appdata_full i,v2f o)
        {
            float4 viewPos = mul(UNITY_MATRIX_MV, i.vertex);
            float3 normal = mul( (float3x3)UNITY_MATRIX_IT_MV, i.normal);
            normal.z=-_Z;

            viewPos=viewPos+float4(normalize(normal),0)*_OutLine;
            o.pos=mul(UNITY_MATRIX_P,viewPos);    
            return o;
        }

        v2f vert(appdata_full i){
            v2f o;
            // o=ZBiasMethod(i,o);
            // o=VertexNormalMethod0(i,o);
            o=VertexNormalMethod1(i,o);
            return o;
        }

        float4 frag(v2f i):COLOR
        {
            return float4(0,0,0,1);
        }
        ENDCG
    }
}
}
