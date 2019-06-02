// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/TemPlate" {
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 depth: TEXCOORD0;
            };
        
            v2f vert (appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.depth = o.vertex.zw ;
                return o;
            }
            fixed4 frag (v2f i) : SV_Target
            {
                float depth = i.depth.x/i.depth.y ;
                return EncodeFloatRGBA(depth) ;
            }
            ENDCG
        }
//            void  GetLightProjectMatrix(Camera camera)
//        {
//            Matrix4x4 worldToView = camera.worldToCameraMatrix;
//            Matrix4x4 projection  = GL.GetGPUProjectionMatrix(camera.projectionMatrix, false);
//            Matrix4x4 lightProjecionMatrix =  projection * worldToView;
//            Shader.SetGlobalMatrix ("_LightProjection", lightProjecionMatrix);
//        }
    }
}