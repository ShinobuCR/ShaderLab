//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Standard" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_MainTex ("Albedo", 2D) = "white" { }
_Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
_Glossiness ("Smoothness", Range(0, 1)) = 0.5
_GlossMapScale ("Smoothness Scale", Range(0, 1)) = 1
[Enum(Metallic Alpha,0,Albedo Alpha,1)] _SmoothnessTextureChannel ("Smoothness texture channel", Float) = 0
_Metallic ("Metallic", Range(0, 1)) = 0
_MetallicGlossMap ("Metallic", 2D) = "white" { }
[ToggleOff] _SpecularHighlights ("Specular Highlights", Float) = 1
[ToggleOff] _GlossyReflections ("Glossy Reflections", Float) = 1
_BumpScale ("Scale", Float) = 1
_BumpMap ("Normal Map", 2D) = "bump" { }
_Parallax ("Height Scale", Range(0.005, 0.08)) = 0.02
_ParallaxMap ("Height Map", 2D) = "black" { }
_OcclusionStrength ("Strength", Range(0, 1)) = 1
_OcclusionMap ("Occlusion", 2D) = "white" { }
_EmissionColor ("Color", Color) = (0,0,0,1)
_EmissionMap ("Emission", 2D) = "white" { }
_DetailMask ("Detail Mask", 2D) = "white" { }
_DetailAlbedoMap ("Detail Albedo x2", 2D) = "grey" { }
_DetailNormalMapScale ("Scale", Float) = 1
_DetailNormalMap ("Normal Map", 2D) = "bump" { }
[Enum(UV0,0,UV1,1)] _UVSec ("UV Set for secondary textures", Float) = 0
_Mode ("__mode", Float) = 0
_SrcBlend ("__src", Float) = 1
_DstBlend ("__dst", Float) = 0
_ZWrite ("__zw", Float) = 1
}
SubShader {
 LOD 300
 Tags { "PerformanceChecks" = "False" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 300
  Tags { "LIGHTMODE" = "FORWARDBASE" "PerformanceChecks" = "False" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ZClip Off
  ZWrite Off
  GpuProgramID 56268
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  normalWorld_4 = tmpvar_17;
  tmpvar_8.xyz = normalWorld_4;
  tmpvar_6.xyz = eyeVec_5;
  mediump vec4 ambientOrLightmapUV_18;
  ambientOrLightmapUV_18.w = 0.0;
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = normalWorld_4;
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, tmpvar_19);
  x_21.y = dot (unity_SHAg, tmpvar_19);
  x_21.z = dot (unity_SHAb, tmpvar_19);
  mediump vec3 x1_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = (normalWorld_4.xyzz * normalWorld_4.yzzx);
  x1_22.x = dot (unity_SHBr, tmpvar_23);
  x1_22.y = dot (unity_SHBg, tmpvar_23);
  x1_22.z = dot (unity_SHBb, tmpvar_23);
  res_20 = (x_21 + (x1_22 + (unity_SHC.xyz * 
    ((normalWorld_4.x * normalWorld_4.x) - (normalWorld_4.y * normalWorld_4.y))
  )));
  mediump vec3 tmpvar_24;
  tmpvar_24 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_24;
  ambientOrLightmapUV_18.xyz = max (vec3(0.0, 0.0, 0.0), tmpvar_24);
  tmpvar_7.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  mediump float x_25;
  x_25 = (1.0 - clamp (dot (normalWorld_4, 
    -(eyeVec_5)
  ), 0.0, 1.0));
  tmpvar_8.w = ((x_25 * x_25) * (x_25 * x_25));
  tmpvar_6.w = clamp ((_Glossiness + (1.0 - 
    (0.7790837 - (_Metallic * 0.7790837))
  )), 0.0, 1.0);
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = ambientOrLightmapUV_18;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump float rl_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_6;
  tmpvar_6 = _LightColor0.xyz;
  mediump float occ_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_7 = tmpvar_8;
  rl_1 = dot (xlv_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
  mediump float occlusion_9;
  occlusion_9 = ((1.0 - _OcclusionStrength) + (occ_7 * _OcclusionStrength));
  highp vec4 tmpvar_10;
  tmpvar_10 = unity_SpecCube0_HDR;
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - _Glossiness);
  mediump vec4 hdr_12;
  hdr_12 = tmpvar_10;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = xlv_TEXCOORD4.yzw;
  tmpvar_13.w = ((tmpvar_11 * (1.7 - 
    (0.7 * tmpvar_11)
  )) * 6.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = impl_low_textureCubeLodEXT (unity_SpecCube0, xlv_TEXCOORD4.yzw, tmpvar_13.w);
  mediump vec4 tmpvar_15;
  tmpvar_15 = tmpvar_14;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((rl_1 * rl_1) * (rl_1 * rl_1));
  tmpvar_16.y = tmpvar_11;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_NHxRoughness, tmpvar_16);
  mediump vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = (((
    (xlv_TEXCOORD2.xyz * occlusion_9)
   * tmpvar_4) + (
    (((hdr_12.x * (
      (hdr_12.w * (tmpvar_15.w - 1.0))
     + 1.0)) * tmpvar_15.xyz) * occlusion_9)
   * 
    mix (tmpvar_5, xlv_TEXCOORD1.www, xlv_TEXCOORD5.www)
  )) + ((tmpvar_4 + 
    ((tmpvar_17.w * 16.0) * tmpvar_5)
  ) * (tmpvar_6 * 
    clamp (dot (xlv_TEXCOORD5.xyz, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  )));
  mediump vec4 xlat_varoutput_19;
  xlat_varoutput_19.xyz = tmpvar_18.xyz;
  xlat_varoutput_19.w = 1.0;
  gl_FragData[0] = xlat_varoutput_19;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  mediump vec3 x1_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_21.x = dot (unity_SHBr, tmpvar_22);
  x1_21.y = dot (unity_SHBg, tmpvar_22);
  x1_21.z = dot (unity_SHBb, tmpvar_22);
  ambientOrLightmapUV_20.xyz = (x1_21 + (unity_SHC.xyz * (
    (normalWorld_19.x * normalWorld_19.x)
   - 
    (normalWorld_19.y * normalWorld_19.y)
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  mediump float tmpvar_6;
  tmpvar_6 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_4 = (tmpvar_3 * tmpvar_6);
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_9;
  tmpvar_9 = _LightColor0.xyz;
  mediump float occ_10;
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_10 = tmpvar_11;
  mediump float occlusion_12;
  occlusion_12 = ((1.0 - _OcclusionStrength) + (occ_10 * _OcclusionStrength));
  highp vec4 tmpvar_13;
  tmpvar_13 = unity_SpecCube0_HDR;
  mediump vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_7;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, tmpvar_14);
  x_15.y = dot (unity_SHAg, tmpvar_14);
  x_15.z = dot (unity_SHAb, tmpvar_14);
  mediump vec3 tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = (1.0 - _Glossiness);
  tmpvar_16 = (tmpvar_8 - (2.0 * (
    dot (tmpvar_7, tmpvar_8)
   * tmpvar_7)));
  mediump vec4 hdr_18;
  hdr_18 = tmpvar_13;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = tmpvar_16;
  tmpvar_19.w = ((tmpvar_17 * (1.7 - 
    (0.7 * tmpvar_17)
  )) * 6.0);
  lowp vec4 tmpvar_20;
  tmpvar_20 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_16, tmpvar_19.w);
  mediump vec4 tmpvar_21;
  tmpvar_21 = tmpvar_20;
  mediump vec3 viewDir_22;
  viewDir_22 = -(tmpvar_8);
  mediump float specularTerm_23;
  mediump vec3 tmpvar_24;
  mediump vec3 inVec_25;
  inVec_25 = (_WorldSpaceLightPos0.xyz + viewDir_22);
  tmpvar_24 = (inVec_25 * inversesqrt(max (0.001, 
    dot (inVec_25, inVec_25)
  )));
  mediump float tmpvar_26;
  tmpvar_26 = clamp (dot (tmpvar_7, tmpvar_24), 0.0, 1.0);
  mediump float tmpvar_27;
  tmpvar_27 = (tmpvar_17 * tmpvar_17);
  specularTerm_23 = ((tmpvar_27 / (
    (max (0.32, clamp (dot (_WorldSpaceLightPos0.xyz, tmpvar_24), 0.0, 1.0)) * (1.5 + tmpvar_27))
   * 
    (((tmpvar_26 * tmpvar_26) * ((tmpvar_27 * tmpvar_27) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (specularTerm_23, 0.0, 100.0);
  specularTerm_23 = tmpvar_28;
  mediump float x_29;
  x_29 = (1.0 - clamp (dot (tmpvar_7, viewDir_22), 0.0, 1.0));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (((
    ((tmpvar_4 + (tmpvar_28 * tmpvar_5)) * tmpvar_9)
   * 
    clamp (dot (tmpvar_7, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (max (((1.055 * 
      pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_15)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0)) * occlusion_12)
   * tmpvar_4)) + ((
    (1.0 - ((tmpvar_27 * tmpvar_17) * 0.28))
   * 
    (((hdr_18.x * (
      (hdr_18.w * (tmpvar_21.w - 1.0))
     + 1.0)) * tmpvar_21.xyz) * occlusion_12)
  ) * mix (tmpvar_5, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_6)), 0.0, 1.0)
  ), vec3(
    ((x_29 * x_29) * (x_29 * x_29))
  ))));
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = tmpvar_30;
  c_1.w = tmpvar_31.w;
  c_1.xyz = tmpvar_30;
  mediump vec4 xlat_varoutput_32;
  xlat_varoutput_32.xyz = c_1.xyz;
  xlat_varoutput_32.w = 1.0;
  gl_FragData[0] = xlat_varoutput_32;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  mediump vec3 x1_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_21.x = dot (unity_SHBr, tmpvar_22);
  x1_21.y = dot (unity_SHBg, tmpvar_22);
  x1_21.z = dot (unity_SHBb, tmpvar_22);
  ambientOrLightmapUV_20.xyz = (x1_21 + (unity_SHC.xyz * (
    (normalWorld_19.x * normalWorld_19.x)
   - 
    (normalWorld_19.y * normalWorld_19.y)
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  mediump float tmpvar_6;
  tmpvar_6 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_4 = (tmpvar_3 * tmpvar_6);
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_9;
  tmpvar_9 = _LightColor0.xyz;
  mediump float occ_10;
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_10 = tmpvar_11;
  mediump float occlusion_12;
  occlusion_12 = ((1.0 - _OcclusionStrength) + (occ_10 * _OcclusionStrength));
  highp vec4 tmpvar_13;
  tmpvar_13 = unity_SpecCube0_HDR;
  mediump vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_7;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, tmpvar_14);
  x_15.y = dot (unity_SHAg, tmpvar_14);
  x_15.z = dot (unity_SHAb, tmpvar_14);
  mediump vec3 tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = (1.0 - _Glossiness);
  tmpvar_16 = (tmpvar_8 - (2.0 * (
    dot (tmpvar_7, tmpvar_8)
   * tmpvar_7)));
  mediump vec4 hdr_18;
  hdr_18 = tmpvar_13;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = tmpvar_16;
  tmpvar_19.w = ((tmpvar_17 * (1.7 - 
    (0.7 * tmpvar_17)
  )) * 6.0);
  lowp vec4 tmpvar_20;
  tmpvar_20 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_16, tmpvar_19.w);
  mediump vec4 tmpvar_21;
  tmpvar_21 = tmpvar_20;
  mediump vec3 viewDir_22;
  viewDir_22 = -(tmpvar_8);
  mediump float specularTerm_23;
  mediump vec3 tmpvar_24;
  mediump vec3 inVec_25;
  inVec_25 = (_WorldSpaceLightPos0.xyz + viewDir_22);
  tmpvar_24 = (inVec_25 * inversesqrt(max (0.001, 
    dot (inVec_25, inVec_25)
  )));
  mediump float tmpvar_26;
  tmpvar_26 = clamp (dot (tmpvar_7, tmpvar_24), 0.0, 1.0);
  mediump float tmpvar_27;
  tmpvar_27 = (tmpvar_17 * tmpvar_17);
  specularTerm_23 = ((tmpvar_27 / (
    (max (0.32, clamp (dot (_WorldSpaceLightPos0.xyz, tmpvar_24), 0.0, 1.0)) * (1.5 + tmpvar_27))
   * 
    (((tmpvar_26 * tmpvar_26) * ((tmpvar_27 * tmpvar_27) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (specularTerm_23, 0.0, 100.0);
  specularTerm_23 = tmpvar_28;
  mediump float x_29;
  x_29 = (1.0 - clamp (dot (tmpvar_7, viewDir_22), 0.0, 1.0));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (((
    ((tmpvar_4 + (tmpvar_28 * tmpvar_5)) * tmpvar_9)
   * 
    clamp (dot (tmpvar_7, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (max (((1.055 * 
      pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_15)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0)) * occlusion_12)
   * tmpvar_4)) + ((
    (1.0 - ((tmpvar_27 * tmpvar_17) * 0.28))
   * 
    (((hdr_18.x * (
      (hdr_18.w * (tmpvar_21.w - 1.0))
     + 1.0)) * tmpvar_21.xyz) * occlusion_12)
  ) * mix (tmpvar_5, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_6)), 0.0, 1.0)
  ), vec3(
    ((x_29 * x_29) * (x_29 * x_29))
  ))));
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = tmpvar_30;
  c_1.w = tmpvar_31.w;
  c_1.xyz = tmpvar_30;
  mediump vec4 xlat_varoutput_32;
  xlat_varoutput_32.xyz = c_1.xyz;
  xlat_varoutput_32.w = 1.0;
  gl_FragData[0] = xlat_varoutput_32;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  normalWorld_4 = tmpvar_17;
  tmpvar_8.xyz = normalWorld_4;
  tmpvar_6.xyz = eyeVec_5;
  mediump vec4 ambientOrLightmapUV_18;
  ambientOrLightmapUV_18.w = 0.0;
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = normalWorld_4;
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, tmpvar_19);
  x_21.y = dot (unity_SHAg, tmpvar_19);
  x_21.z = dot (unity_SHAb, tmpvar_19);
  mediump vec3 x1_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = (normalWorld_4.xyzz * normalWorld_4.yzzx);
  x1_22.x = dot (unity_SHBr, tmpvar_23);
  x1_22.y = dot (unity_SHBg, tmpvar_23);
  x1_22.z = dot (unity_SHBb, tmpvar_23);
  res_20 = (x_21 + (x1_22 + (unity_SHC.xyz * 
    ((normalWorld_4.x * normalWorld_4.x) - (normalWorld_4.y * normalWorld_4.y))
  )));
  mediump vec3 tmpvar_24;
  tmpvar_24 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_24;
  ambientOrLightmapUV_18.xyz = max (vec3(0.0, 0.0, 0.0), tmpvar_24);
  tmpvar_7.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  mediump float x_25;
  x_25 = (1.0 - clamp (dot (normalWorld_4, 
    -(eyeVec_5)
  ), 0.0, 1.0));
  tmpvar_8.w = ((x_25 * x_25) * (x_25 * x_25));
  tmpvar_6.w = clamp ((_Glossiness + (1.0 - 
    (0.7790837 - (_Metallic * 0.7790837))
  )), 0.0, 1.0);
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = ambientOrLightmapUV_18;
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump float rl_1;
  mediump float realtimeShadowAttenuation_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  tmpvar_5 = (tmpvar_4 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_7;
  tmpvar_7 = _LightColor0.xyz;
  lowp float tmpvar_8;
  highp float lightShadowDataX_9;
  mediump float tmpvar_10;
  tmpvar_10 = _LightShadowData.x;
  lightShadowDataX_9 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD3.xy).x > xlv_TEXCOORD3.z)), lightShadowDataX_9);
  tmpvar_8 = tmpvar_11;
  realtimeShadowAttenuation_2 = tmpvar_8;
  mediump float occ_12;
  lowp float tmpvar_13;
  tmpvar_13 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_12 = tmpvar_13;
  rl_1 = dot (xlv_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
  mediump float occlusion_14;
  occlusion_14 = ((1.0 - _OcclusionStrength) + (occ_12 * _OcclusionStrength));
  highp vec4 tmpvar_15;
  tmpvar_15 = unity_SpecCube0_HDR;
  mediump float tmpvar_16;
  tmpvar_16 = (1.0 - _Glossiness);
  mediump vec4 hdr_17;
  hdr_17 = tmpvar_15;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = xlv_TEXCOORD4.yzw;
  tmpvar_18.w = ((tmpvar_16 * (1.7 - 
    (0.7 * tmpvar_16)
  )) * 6.0);
  lowp vec4 tmpvar_19;
  tmpvar_19 = impl_low_textureCubeLodEXT (unity_SpecCube0, xlv_TEXCOORD4.yzw, tmpvar_18.w);
  mediump vec4 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  mediump vec2 tmpvar_21;
  tmpvar_21.x = ((rl_1 * rl_1) * (rl_1 * rl_1));
  tmpvar_21.y = tmpvar_16;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (unity_NHxRoughness, tmpvar_21);
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = (((
    (xlv_TEXCOORD2.xyz * occlusion_14)
   * tmpvar_5) + (
    (((hdr_17.x * (
      (hdr_17.w * (tmpvar_20.w - 1.0))
     + 1.0)) * tmpvar_20.xyz) * occlusion_14)
   * 
    mix (tmpvar_6, xlv_TEXCOORD1.www, xlv_TEXCOORD5.www)
  )) + ((tmpvar_5 + 
    ((tmpvar_22.w * 16.0) * tmpvar_6)
  ) * (
    (tmpvar_7 * realtimeShadowAttenuation_2)
   * 
    clamp (dot (xlv_TEXCOORD5.xyz, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  )));
  mediump vec4 xlat_varoutput_24;
  xlat_varoutput_24.xyz = tmpvar_23.xyz;
  xlat_varoutput_24.w = 1.0;
  gl_FragData[0] = xlat_varoutput_24;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  mediump vec3 x1_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_21.x = dot (unity_SHBr, tmpvar_22);
  x1_21.y = dot (unity_SHBg, tmpvar_22);
  x1_21.z = dot (unity_SHBb, tmpvar_22);
  ambientOrLightmapUV_20.xyz = (x1_21 + (unity_SHC.xyz * (
    (normalWorld_19.x * normalWorld_19.x)
   - 
    (normalWorld_19.y * normalWorld_19.y)
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 c_1;
  lowp float atten_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  mediump float tmpvar_7;
  tmpvar_7 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_5 = (tmpvar_4 * tmpvar_7);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_10;
  tmpvar_10 = _LightColor0.xyz;
  mediump float realtimeShadowAttenuation_11;
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].z;
  v_12.y = unity_MatrixV[1].z;
  v_12.z = unity_MatrixV[2].z;
  v_12.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD8 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD8), v_12.xyz), sqrt(dot (tmpvar_13, tmpvar_13)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = xlv_TEXCOORD8;
  lowp float tmpvar_17;
  highp vec4 shadowCoord_18;
  shadowCoord_18 = (unity_WorldToShadow[0] * tmpvar_16);
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, shadowCoord_18.xy).x > shadowCoord_18.z)), lightShadowDataX_19);
  tmpvar_17 = tmpvar_21;
  realtimeShadowAttenuation_11 = tmpvar_17;
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((realtimeShadowAttenuation_11 + tmpvar_14), 0.0, 1.0);
  atten_2 = tmpvar_22;
  mediump float occ_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_23 = tmpvar_24;
  mediump float atten_25;
  atten_25 = atten_2;
  mediump float occlusion_26;
  occlusion_26 = ((1.0 - _OcclusionStrength) + (occ_23 * _OcclusionStrength));
  highp vec4 tmpvar_27;
  tmpvar_27 = unity_SpecCube0_HDR;
  mediump vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_8;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, tmpvar_28);
  x_29.y = dot (unity_SHAg, tmpvar_28);
  x_29.z = dot (unity_SHAb, tmpvar_28);
  mediump vec3 tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = (1.0 - _Glossiness);
  tmpvar_30 = (tmpvar_9 - (2.0 * (
    dot (tmpvar_8, tmpvar_9)
   * tmpvar_8)));
  mediump vec4 hdr_32;
  hdr_32 = tmpvar_27;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = ((tmpvar_31 * (1.7 - 
    (0.7 * tmpvar_31)
  )) * 6.0);
  lowp vec4 tmpvar_34;
  tmpvar_34 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_30, tmpvar_33.w);
  mediump vec4 tmpvar_35;
  tmpvar_35 = tmpvar_34;
  mediump vec3 viewDir_36;
  viewDir_36 = -(tmpvar_9);
  mediump float specularTerm_37;
  mediump vec3 tmpvar_38;
  mediump vec3 inVec_39;
  inVec_39 = (_WorldSpaceLightPos0.xyz + viewDir_36);
  tmpvar_38 = (inVec_39 * inversesqrt(max (0.001, 
    dot (inVec_39, inVec_39)
  )));
  mediump float tmpvar_40;
  tmpvar_40 = clamp (dot (tmpvar_8, tmpvar_38), 0.0, 1.0);
  mediump float tmpvar_41;
  tmpvar_41 = (tmpvar_31 * tmpvar_31);
  specularTerm_37 = ((tmpvar_41 / (
    (max (0.32, clamp (dot (_WorldSpaceLightPos0.xyz, tmpvar_38), 0.0, 1.0)) * (1.5 + tmpvar_41))
   * 
    (((tmpvar_40 * tmpvar_40) * ((tmpvar_41 * tmpvar_41) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_42;
  tmpvar_42 = clamp (specularTerm_37, 0.0, 100.0);
  specularTerm_37 = tmpvar_42;
  mediump float x_43;
  x_43 = (1.0 - clamp (dot (tmpvar_8, viewDir_36), 0.0, 1.0));
  mediump vec3 tmpvar_44;
  tmpvar_44 = (((
    ((tmpvar_5 + (tmpvar_42 * tmpvar_6)) * (tmpvar_10 * atten_25))
   * 
    clamp (dot (tmpvar_8, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (max (((1.055 * 
      pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_29)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0)) * occlusion_26)
   * tmpvar_5)) + ((
    (1.0 - ((tmpvar_41 * tmpvar_31) * 0.28))
   * 
    (((hdr_32.x * (
      (hdr_32.w * (tmpvar_35.w - 1.0))
     + 1.0)) * tmpvar_35.xyz) * occlusion_26)
  ) * mix (tmpvar_6, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_7)), 0.0, 1.0)
  ), vec3(
    ((x_43 * x_43) * (x_43 * x_43))
  ))));
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = tmpvar_44;
  c_1.w = tmpvar_45.w;
  c_1.xyz = tmpvar_44;
  mediump vec4 xlat_varoutput_46;
  xlat_varoutput_46.xyz = c_1.xyz;
  xlat_varoutput_46.w = 1.0;
  gl_FragData[0] = xlat_varoutput_46;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  mediump vec3 x1_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_21.x = dot (unity_SHBr, tmpvar_22);
  x1_21.y = dot (unity_SHBg, tmpvar_22);
  x1_21.z = dot (unity_SHBb, tmpvar_22);
  ambientOrLightmapUV_20.xyz = (x1_21 + (unity_SHC.xyz * (
    (normalWorld_19.x * normalWorld_19.x)
   - 
    (normalWorld_19.y * normalWorld_19.y)
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 c_1;
  lowp float atten_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  mediump float tmpvar_7;
  tmpvar_7 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_5 = (tmpvar_4 * tmpvar_7);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_10;
  tmpvar_10 = _LightColor0.xyz;
  mediump float realtimeShadowAttenuation_11;
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].z;
  v_12.y = unity_MatrixV[1].z;
  v_12.z = unity_MatrixV[2].z;
  v_12.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD8 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD8), v_12.xyz), sqrt(dot (tmpvar_13, tmpvar_13)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = xlv_TEXCOORD8;
  lowp float tmpvar_17;
  highp vec4 shadowCoord_18;
  shadowCoord_18 = (unity_WorldToShadow[0] * tmpvar_16);
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, shadowCoord_18.xy).x > shadowCoord_18.z)), lightShadowDataX_19);
  tmpvar_17 = tmpvar_21;
  realtimeShadowAttenuation_11 = tmpvar_17;
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((realtimeShadowAttenuation_11 + tmpvar_14), 0.0, 1.0);
  atten_2 = tmpvar_22;
  mediump float occ_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_23 = tmpvar_24;
  mediump float atten_25;
  atten_25 = atten_2;
  mediump float occlusion_26;
  occlusion_26 = ((1.0 - _OcclusionStrength) + (occ_23 * _OcclusionStrength));
  highp vec4 tmpvar_27;
  tmpvar_27 = unity_SpecCube0_HDR;
  mediump vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_8;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, tmpvar_28);
  x_29.y = dot (unity_SHAg, tmpvar_28);
  x_29.z = dot (unity_SHAb, tmpvar_28);
  mediump vec3 tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = (1.0 - _Glossiness);
  tmpvar_30 = (tmpvar_9 - (2.0 * (
    dot (tmpvar_8, tmpvar_9)
   * tmpvar_8)));
  mediump vec4 hdr_32;
  hdr_32 = tmpvar_27;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = ((tmpvar_31 * (1.7 - 
    (0.7 * tmpvar_31)
  )) * 6.0);
  lowp vec4 tmpvar_34;
  tmpvar_34 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_30, tmpvar_33.w);
  mediump vec4 tmpvar_35;
  tmpvar_35 = tmpvar_34;
  mediump vec3 viewDir_36;
  viewDir_36 = -(tmpvar_9);
  mediump float specularTerm_37;
  mediump vec3 tmpvar_38;
  mediump vec3 inVec_39;
  inVec_39 = (_WorldSpaceLightPos0.xyz + viewDir_36);
  tmpvar_38 = (inVec_39 * inversesqrt(max (0.001, 
    dot (inVec_39, inVec_39)
  )));
  mediump float tmpvar_40;
  tmpvar_40 = clamp (dot (tmpvar_8, tmpvar_38), 0.0, 1.0);
  mediump float tmpvar_41;
  tmpvar_41 = (tmpvar_31 * tmpvar_31);
  specularTerm_37 = ((tmpvar_41 / (
    (max (0.32, clamp (dot (_WorldSpaceLightPos0.xyz, tmpvar_38), 0.0, 1.0)) * (1.5 + tmpvar_41))
   * 
    (((tmpvar_40 * tmpvar_40) * ((tmpvar_41 * tmpvar_41) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_42;
  tmpvar_42 = clamp (specularTerm_37, 0.0, 100.0);
  specularTerm_37 = tmpvar_42;
  mediump float x_43;
  x_43 = (1.0 - clamp (dot (tmpvar_8, viewDir_36), 0.0, 1.0));
  mediump vec3 tmpvar_44;
  tmpvar_44 = (((
    ((tmpvar_5 + (tmpvar_42 * tmpvar_6)) * (tmpvar_10 * atten_25))
   * 
    clamp (dot (tmpvar_8, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (max (((1.055 * 
      pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_29)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0)) * occlusion_26)
   * tmpvar_5)) + ((
    (1.0 - ((tmpvar_41 * tmpvar_31) * 0.28))
   * 
    (((hdr_32.x * (
      (hdr_32.w * (tmpvar_35.w - 1.0))
     + 1.0)) * tmpvar_35.xyz) * occlusion_26)
  ) * mix (tmpvar_6, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_7)), 0.0, 1.0)
  ), vec3(
    ((x_43 * x_43) * (x_43 * x_43))
  ))));
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = tmpvar_44;
  c_1.w = tmpvar_45.w;
  c_1.xyz = tmpvar_44;
  mediump vec4 xlat_varoutput_46;
  xlat_varoutput_46.xyz = c_1.xyz;
  xlat_varoutput_46.w = 1.0;
  gl_FragData[0] = xlat_varoutput_46;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  normalWorld_4 = tmpvar_17;
  tmpvar_8.xyz = normalWorld_4;
  tmpvar_6.xyz = eyeVec_5;
  mediump vec4 ambientOrLightmapUV_18;
  ambientOrLightmapUV_18.w = 0.0;
  highp vec3 lightColor0_19;
  lightColor0_19 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_20;
  lightColor1_20 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_21;
  lightColor2_21 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_22;
  lightColor3_22 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_23;
  lightAttenSq_23 = unity_4LightAtten0;
  highp vec3 normal_24;
  normal_24 = normalWorld_4;
  highp vec3 col_25;
  highp vec4 ndotl_26;
  highp vec4 lengthSq_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_27 = (tmpvar_28 * tmpvar_28);
  lengthSq_27 = (lengthSq_27 + (tmpvar_29 * tmpvar_29));
  lengthSq_27 = (lengthSq_27 + (tmpvar_30 * tmpvar_30));
  highp vec4 tmpvar_31;
  tmpvar_31 = max (lengthSq_27, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_27 = tmpvar_31;
  ndotl_26 = (tmpvar_28 * normal_24.x);
  ndotl_26 = (ndotl_26 + (tmpvar_29 * normal_24.y));
  ndotl_26 = (ndotl_26 + (tmpvar_30 * normal_24.z));
  highp vec4 tmpvar_32;
  tmpvar_32 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_26 * inversesqrt(tmpvar_31)));
  ndotl_26 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_32 * (1.0/((1.0 + 
    (tmpvar_31 * lightAttenSq_23)
  ))));
  col_25 = (lightColor0_19 * tmpvar_33.x);
  col_25 = (col_25 + (lightColor1_20 * tmpvar_33.y));
  col_25 = (col_25 + (lightColor2_21 * tmpvar_33.z));
  col_25 = (col_25 + (lightColor3_22 * tmpvar_33.w));
  ambientOrLightmapUV_18.xyz = col_25;
  mediump vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = normalWorld_4;
  mediump vec3 res_35;
  mediump vec3 x_36;
  x_36.x = dot (unity_SHAr, tmpvar_34);
  x_36.y = dot (unity_SHAg, tmpvar_34);
  x_36.z = dot (unity_SHAb, tmpvar_34);
  mediump vec3 x1_37;
  mediump vec4 tmpvar_38;
  tmpvar_38 = (normalWorld_4.xyzz * normalWorld_4.yzzx);
  x1_37.x = dot (unity_SHBr, tmpvar_38);
  x1_37.y = dot (unity_SHBg, tmpvar_38);
  x1_37.z = dot (unity_SHBb, tmpvar_38);
  res_35 = (x_36 + (x1_37 + (unity_SHC.xyz * 
    ((normalWorld_4.x * normalWorld_4.x) - (normalWorld_4.y * normalWorld_4.y))
  )));
  mediump vec3 tmpvar_39;
  tmpvar_39 = max (((1.055 * 
    pow (max (res_35, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_35 = tmpvar_39;
  ambientOrLightmapUV_18.xyz = (ambientOrLightmapUV_18.xyz + max (vec3(0.0, 0.0, 0.0), tmpvar_39));
  tmpvar_7.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  mediump float x_40;
  x_40 = (1.0 - clamp (dot (normalWorld_4, 
    -(eyeVec_5)
  ), 0.0, 1.0));
  tmpvar_8.w = ((x_40 * x_40) * (x_40 * x_40));
  tmpvar_6.w = clamp ((_Glossiness + (1.0 - 
    (0.7790837 - (_Metallic * 0.7790837))
  )), 0.0, 1.0);
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = ambientOrLightmapUV_18;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump float rl_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_6;
  tmpvar_6 = _LightColor0.xyz;
  mediump float occ_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_7 = tmpvar_8;
  rl_1 = dot (xlv_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
  mediump float occlusion_9;
  occlusion_9 = ((1.0 - _OcclusionStrength) + (occ_7 * _OcclusionStrength));
  highp vec4 tmpvar_10;
  tmpvar_10 = unity_SpecCube0_HDR;
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - _Glossiness);
  mediump vec4 hdr_12;
  hdr_12 = tmpvar_10;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = xlv_TEXCOORD4.yzw;
  tmpvar_13.w = ((tmpvar_11 * (1.7 - 
    (0.7 * tmpvar_11)
  )) * 6.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = impl_low_textureCubeLodEXT (unity_SpecCube0, xlv_TEXCOORD4.yzw, tmpvar_13.w);
  mediump vec4 tmpvar_15;
  tmpvar_15 = tmpvar_14;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((rl_1 * rl_1) * (rl_1 * rl_1));
  tmpvar_16.y = tmpvar_11;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_NHxRoughness, tmpvar_16);
  mediump vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = (((
    (xlv_TEXCOORD2.xyz * occlusion_9)
   * tmpvar_4) + (
    (((hdr_12.x * (
      (hdr_12.w * (tmpvar_15.w - 1.0))
     + 1.0)) * tmpvar_15.xyz) * occlusion_9)
   * 
    mix (tmpvar_5, xlv_TEXCOORD1.www, xlv_TEXCOORD5.www)
  )) + ((tmpvar_4 + 
    ((tmpvar_17.w * 16.0) * tmpvar_5)
  ) * (tmpvar_6 * 
    clamp (dot (xlv_TEXCOORD5.xyz, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  )));
  mediump vec4 xlat_varoutput_19;
  xlat_varoutput_19.xyz = tmpvar_18.xyz;
  xlat_varoutput_19.w = 1.0;
  gl_FragData[0] = xlat_varoutput_19;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 normal_26;
  normal_26 = normalWorld_19;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (lengthSq_29, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_29 = tmpvar_33;
  ndotl_28 = (tmpvar_30 * normal_26.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * normal_26.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * normal_26.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(tmpvar_33)));
  ndotl_28 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (tmpvar_33 * lightAttenSq_25)
  ))));
  col_27 = (lightColor0_21 * tmpvar_35.x);
  col_27 = (col_27 + (lightColor1_22 * tmpvar_35.y));
  col_27 = (col_27 + (lightColor2_23 * tmpvar_35.z));
  col_27 = (col_27 + (lightColor3_24 * tmpvar_35.w));
  ambientOrLightmapUV_20.xyz = col_27;
  mediump vec3 x1_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_36.x = dot (unity_SHBr, tmpvar_37);
  x1_36.y = dot (unity_SHBg, tmpvar_37);
  x1_36.z = dot (unity_SHBb, tmpvar_37);
  ambientOrLightmapUV_20.xyz = ((ambientOrLightmapUV_20.xyz * (
    (ambientOrLightmapUV_20.xyz * ((ambientOrLightmapUV_20.xyz * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_36 + (unity_SHC.xyz * 
    ((normalWorld_19.x * normalWorld_19.x) - (normalWorld_19.y * normalWorld_19.y))
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  mediump float tmpvar_6;
  tmpvar_6 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_4 = (tmpvar_3 * tmpvar_6);
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_9;
  tmpvar_9 = _LightColor0.xyz;
  mediump float occ_10;
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_10 = tmpvar_11;
  mediump float occlusion_12;
  occlusion_12 = ((1.0 - _OcclusionStrength) + (occ_10 * _OcclusionStrength));
  highp vec4 tmpvar_13;
  tmpvar_13 = unity_SpecCube0_HDR;
  mediump vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_7;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, tmpvar_14);
  x_15.y = dot (unity_SHAg, tmpvar_14);
  x_15.z = dot (unity_SHAb, tmpvar_14);
  mediump vec3 tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = (1.0 - _Glossiness);
  tmpvar_16 = (tmpvar_8 - (2.0 * (
    dot (tmpvar_7, tmpvar_8)
   * tmpvar_7)));
  mediump vec4 hdr_18;
  hdr_18 = tmpvar_13;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = tmpvar_16;
  tmpvar_19.w = ((tmpvar_17 * (1.7 - 
    (0.7 * tmpvar_17)
  )) * 6.0);
  lowp vec4 tmpvar_20;
  tmpvar_20 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_16, tmpvar_19.w);
  mediump vec4 tmpvar_21;
  tmpvar_21 = tmpvar_20;
  mediump vec3 viewDir_22;
  viewDir_22 = -(tmpvar_8);
  mediump float specularTerm_23;
  mediump vec3 tmpvar_24;
  mediump vec3 inVec_25;
  inVec_25 = (_WorldSpaceLightPos0.xyz + viewDir_22);
  tmpvar_24 = (inVec_25 * inversesqrt(max (0.001, 
    dot (inVec_25, inVec_25)
  )));
  mediump float tmpvar_26;
  tmpvar_26 = clamp (dot (tmpvar_7, tmpvar_24), 0.0, 1.0);
  mediump float tmpvar_27;
  tmpvar_27 = (tmpvar_17 * tmpvar_17);
  specularTerm_23 = ((tmpvar_27 / (
    (max (0.32, clamp (dot (_WorldSpaceLightPos0.xyz, tmpvar_24), 0.0, 1.0)) * (1.5 + tmpvar_27))
   * 
    (((tmpvar_26 * tmpvar_26) * ((tmpvar_27 * tmpvar_27) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (specularTerm_23, 0.0, 100.0);
  specularTerm_23 = tmpvar_28;
  mediump float x_29;
  x_29 = (1.0 - clamp (dot (tmpvar_7, viewDir_22), 0.0, 1.0));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (((
    ((tmpvar_4 + (tmpvar_28 * tmpvar_5)) * tmpvar_9)
   * 
    clamp (dot (tmpvar_7, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (max (((1.055 * 
      pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_15)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0)) * occlusion_12)
   * tmpvar_4)) + ((
    (1.0 - ((tmpvar_27 * tmpvar_17) * 0.28))
   * 
    (((hdr_18.x * (
      (hdr_18.w * (tmpvar_21.w - 1.0))
     + 1.0)) * tmpvar_21.xyz) * occlusion_12)
  ) * mix (tmpvar_5, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_6)), 0.0, 1.0)
  ), vec3(
    ((x_29 * x_29) * (x_29 * x_29))
  ))));
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = tmpvar_30;
  c_1.w = tmpvar_31.w;
  c_1.xyz = tmpvar_30;
  mediump vec4 xlat_varoutput_32;
  xlat_varoutput_32.xyz = c_1.xyz;
  xlat_varoutput_32.w = 1.0;
  gl_FragData[0] = xlat_varoutput_32;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 normal_26;
  normal_26 = normalWorld_19;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (lengthSq_29, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_29 = tmpvar_33;
  ndotl_28 = (tmpvar_30 * normal_26.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * normal_26.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * normal_26.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(tmpvar_33)));
  ndotl_28 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (tmpvar_33 * lightAttenSq_25)
  ))));
  col_27 = (lightColor0_21 * tmpvar_35.x);
  col_27 = (col_27 + (lightColor1_22 * tmpvar_35.y));
  col_27 = (col_27 + (lightColor2_23 * tmpvar_35.z));
  col_27 = (col_27 + (lightColor3_24 * tmpvar_35.w));
  ambientOrLightmapUV_20.xyz = col_27;
  mediump vec3 x1_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_36.x = dot (unity_SHBr, tmpvar_37);
  x1_36.y = dot (unity_SHBg, tmpvar_37);
  x1_36.z = dot (unity_SHBb, tmpvar_37);
  ambientOrLightmapUV_20.xyz = ((ambientOrLightmapUV_20.xyz * (
    (ambientOrLightmapUV_20.xyz * ((ambientOrLightmapUV_20.xyz * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_36 + (unity_SHC.xyz * 
    ((normalWorld_19.x * normalWorld_19.x) - (normalWorld_19.y * normalWorld_19.y))
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  mediump float tmpvar_6;
  tmpvar_6 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_4 = (tmpvar_3 * tmpvar_6);
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_9;
  tmpvar_9 = _LightColor0.xyz;
  mediump float occ_10;
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_10 = tmpvar_11;
  mediump float occlusion_12;
  occlusion_12 = ((1.0 - _OcclusionStrength) + (occ_10 * _OcclusionStrength));
  highp vec4 tmpvar_13;
  tmpvar_13 = unity_SpecCube0_HDR;
  mediump vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_7;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, tmpvar_14);
  x_15.y = dot (unity_SHAg, tmpvar_14);
  x_15.z = dot (unity_SHAb, tmpvar_14);
  mediump vec3 tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = (1.0 - _Glossiness);
  tmpvar_16 = (tmpvar_8 - (2.0 * (
    dot (tmpvar_7, tmpvar_8)
   * tmpvar_7)));
  mediump vec4 hdr_18;
  hdr_18 = tmpvar_13;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = tmpvar_16;
  tmpvar_19.w = ((tmpvar_17 * (1.7 - 
    (0.7 * tmpvar_17)
  )) * 6.0);
  lowp vec4 tmpvar_20;
  tmpvar_20 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_16, tmpvar_19.w);
  mediump vec4 tmpvar_21;
  tmpvar_21 = tmpvar_20;
  mediump vec3 viewDir_22;
  viewDir_22 = -(tmpvar_8);
  mediump float specularTerm_23;
  mediump vec3 tmpvar_24;
  mediump vec3 inVec_25;
  inVec_25 = (_WorldSpaceLightPos0.xyz + viewDir_22);
  tmpvar_24 = (inVec_25 * inversesqrt(max (0.001, 
    dot (inVec_25, inVec_25)
  )));
  mediump float tmpvar_26;
  tmpvar_26 = clamp (dot (tmpvar_7, tmpvar_24), 0.0, 1.0);
  mediump float tmpvar_27;
  tmpvar_27 = (tmpvar_17 * tmpvar_17);
  specularTerm_23 = ((tmpvar_27 / (
    (max (0.32, clamp (dot (_WorldSpaceLightPos0.xyz, tmpvar_24), 0.0, 1.0)) * (1.5 + tmpvar_27))
   * 
    (((tmpvar_26 * tmpvar_26) * ((tmpvar_27 * tmpvar_27) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (specularTerm_23, 0.0, 100.0);
  specularTerm_23 = tmpvar_28;
  mediump float x_29;
  x_29 = (1.0 - clamp (dot (tmpvar_7, viewDir_22), 0.0, 1.0));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (((
    ((tmpvar_4 + (tmpvar_28 * tmpvar_5)) * tmpvar_9)
   * 
    clamp (dot (tmpvar_7, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (max (((1.055 * 
      pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_15)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0)) * occlusion_12)
   * tmpvar_4)) + ((
    (1.0 - ((tmpvar_27 * tmpvar_17) * 0.28))
   * 
    (((hdr_18.x * (
      (hdr_18.w * (tmpvar_21.w - 1.0))
     + 1.0)) * tmpvar_21.xyz) * occlusion_12)
  ) * mix (tmpvar_5, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_6)), 0.0, 1.0)
  ), vec3(
    ((x_29 * x_29) * (x_29 * x_29))
  ))));
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = tmpvar_30;
  c_1.w = tmpvar_31.w;
  c_1.xyz = tmpvar_30;
  mediump vec4 xlat_varoutput_32;
  xlat_varoutput_32.xyz = c_1.xyz;
  xlat_varoutput_32.w = 1.0;
  gl_FragData[0] = xlat_varoutput_32;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  normalWorld_4 = tmpvar_17;
  tmpvar_8.xyz = normalWorld_4;
  tmpvar_6.xyz = eyeVec_5;
  mediump vec4 ambientOrLightmapUV_18;
  ambientOrLightmapUV_18.w = 0.0;
  highp vec3 lightColor0_19;
  lightColor0_19 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_20;
  lightColor1_20 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_21;
  lightColor2_21 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_22;
  lightColor3_22 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_23;
  lightAttenSq_23 = unity_4LightAtten0;
  highp vec3 normal_24;
  normal_24 = normalWorld_4;
  highp vec3 col_25;
  highp vec4 ndotl_26;
  highp vec4 lengthSq_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_27 = (tmpvar_28 * tmpvar_28);
  lengthSq_27 = (lengthSq_27 + (tmpvar_29 * tmpvar_29));
  lengthSq_27 = (lengthSq_27 + (tmpvar_30 * tmpvar_30));
  highp vec4 tmpvar_31;
  tmpvar_31 = max (lengthSq_27, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_27 = tmpvar_31;
  ndotl_26 = (tmpvar_28 * normal_24.x);
  ndotl_26 = (ndotl_26 + (tmpvar_29 * normal_24.y));
  ndotl_26 = (ndotl_26 + (tmpvar_30 * normal_24.z));
  highp vec4 tmpvar_32;
  tmpvar_32 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_26 * inversesqrt(tmpvar_31)));
  ndotl_26 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_32 * (1.0/((1.0 + 
    (tmpvar_31 * lightAttenSq_23)
  ))));
  col_25 = (lightColor0_19 * tmpvar_33.x);
  col_25 = (col_25 + (lightColor1_20 * tmpvar_33.y));
  col_25 = (col_25 + (lightColor2_21 * tmpvar_33.z));
  col_25 = (col_25 + (lightColor3_22 * tmpvar_33.w));
  ambientOrLightmapUV_18.xyz = col_25;
  mediump vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = normalWorld_4;
  mediump vec3 res_35;
  mediump vec3 x_36;
  x_36.x = dot (unity_SHAr, tmpvar_34);
  x_36.y = dot (unity_SHAg, tmpvar_34);
  x_36.z = dot (unity_SHAb, tmpvar_34);
  mediump vec3 x1_37;
  mediump vec4 tmpvar_38;
  tmpvar_38 = (normalWorld_4.xyzz * normalWorld_4.yzzx);
  x1_37.x = dot (unity_SHBr, tmpvar_38);
  x1_37.y = dot (unity_SHBg, tmpvar_38);
  x1_37.z = dot (unity_SHBb, tmpvar_38);
  res_35 = (x_36 + (x1_37 + (unity_SHC.xyz * 
    ((normalWorld_4.x * normalWorld_4.x) - (normalWorld_4.y * normalWorld_4.y))
  )));
  mediump vec3 tmpvar_39;
  tmpvar_39 = max (((1.055 * 
    pow (max (res_35, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_35 = tmpvar_39;
  ambientOrLightmapUV_18.xyz = (ambientOrLightmapUV_18.xyz + max (vec3(0.0, 0.0, 0.0), tmpvar_39));
  tmpvar_7.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  mediump float x_40;
  x_40 = (1.0 - clamp (dot (normalWorld_4, 
    -(eyeVec_5)
  ), 0.0, 1.0));
  tmpvar_8.w = ((x_40 * x_40) * (x_40 * x_40));
  tmpvar_6.w = clamp ((_Glossiness + (1.0 - 
    (0.7790837 - (_Metallic * 0.7790837))
  )), 0.0, 1.0);
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = ambientOrLightmapUV_18;
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump float rl_1;
  mediump float realtimeShadowAttenuation_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  tmpvar_5 = (tmpvar_4 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_7;
  tmpvar_7 = _LightColor0.xyz;
  lowp float tmpvar_8;
  highp float lightShadowDataX_9;
  mediump float tmpvar_10;
  tmpvar_10 = _LightShadowData.x;
  lightShadowDataX_9 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD3.xy).x > xlv_TEXCOORD3.z)), lightShadowDataX_9);
  tmpvar_8 = tmpvar_11;
  realtimeShadowAttenuation_2 = tmpvar_8;
  mediump float occ_12;
  lowp float tmpvar_13;
  tmpvar_13 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_12 = tmpvar_13;
  rl_1 = dot (xlv_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
  mediump float occlusion_14;
  occlusion_14 = ((1.0 - _OcclusionStrength) + (occ_12 * _OcclusionStrength));
  highp vec4 tmpvar_15;
  tmpvar_15 = unity_SpecCube0_HDR;
  mediump float tmpvar_16;
  tmpvar_16 = (1.0 - _Glossiness);
  mediump vec4 hdr_17;
  hdr_17 = tmpvar_15;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = xlv_TEXCOORD4.yzw;
  tmpvar_18.w = ((tmpvar_16 * (1.7 - 
    (0.7 * tmpvar_16)
  )) * 6.0);
  lowp vec4 tmpvar_19;
  tmpvar_19 = impl_low_textureCubeLodEXT (unity_SpecCube0, xlv_TEXCOORD4.yzw, tmpvar_18.w);
  mediump vec4 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  mediump vec2 tmpvar_21;
  tmpvar_21.x = ((rl_1 * rl_1) * (rl_1 * rl_1));
  tmpvar_21.y = tmpvar_16;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (unity_NHxRoughness, tmpvar_21);
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = (((
    (xlv_TEXCOORD2.xyz * occlusion_14)
   * tmpvar_5) + (
    (((hdr_17.x * (
      (hdr_17.w * (tmpvar_20.w - 1.0))
     + 1.0)) * tmpvar_20.xyz) * occlusion_14)
   * 
    mix (tmpvar_6, xlv_TEXCOORD1.www, xlv_TEXCOORD5.www)
  )) + ((tmpvar_5 + 
    ((tmpvar_22.w * 16.0) * tmpvar_6)
  ) * (
    (tmpvar_7 * realtimeShadowAttenuation_2)
   * 
    clamp (dot (xlv_TEXCOORD5.xyz, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  )));
  mediump vec4 xlat_varoutput_24;
  xlat_varoutput_24.xyz = tmpvar_23.xyz;
  xlat_varoutput_24.w = 1.0;
  gl_FragData[0] = xlat_varoutput_24;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 normal_26;
  normal_26 = normalWorld_19;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (lengthSq_29, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_29 = tmpvar_33;
  ndotl_28 = (tmpvar_30 * normal_26.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * normal_26.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * normal_26.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(tmpvar_33)));
  ndotl_28 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (tmpvar_33 * lightAttenSq_25)
  ))));
  col_27 = (lightColor0_21 * tmpvar_35.x);
  col_27 = (col_27 + (lightColor1_22 * tmpvar_35.y));
  col_27 = (col_27 + (lightColor2_23 * tmpvar_35.z));
  col_27 = (col_27 + (lightColor3_24 * tmpvar_35.w));
  ambientOrLightmapUV_20.xyz = col_27;
  mediump vec3 x1_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_36.x = dot (unity_SHBr, tmpvar_37);
  x1_36.y = dot (unity_SHBg, tmpvar_37);
  x1_36.z = dot (unity_SHBb, tmpvar_37);
  ambientOrLightmapUV_20.xyz = ((ambientOrLightmapUV_20.xyz * (
    (ambientOrLightmapUV_20.xyz * ((ambientOrLightmapUV_20.xyz * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_36 + (unity_SHC.xyz * 
    ((normalWorld_19.x * normalWorld_19.x) - (normalWorld_19.y * normalWorld_19.y))
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 c_1;
  lowp float atten_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  mediump float tmpvar_7;
  tmpvar_7 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_5 = (tmpvar_4 * tmpvar_7);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_10;
  tmpvar_10 = _LightColor0.xyz;
  mediump float realtimeShadowAttenuation_11;
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].z;
  v_12.y = unity_MatrixV[1].z;
  v_12.z = unity_MatrixV[2].z;
  v_12.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD8 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD8), v_12.xyz), sqrt(dot (tmpvar_13, tmpvar_13)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = xlv_TEXCOORD8;
  lowp float tmpvar_17;
  highp vec4 shadowCoord_18;
  shadowCoord_18 = (unity_WorldToShadow[0] * tmpvar_16);
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, shadowCoord_18.xy).x > shadowCoord_18.z)), lightShadowDataX_19);
  tmpvar_17 = tmpvar_21;
  realtimeShadowAttenuation_11 = tmpvar_17;
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((realtimeShadowAttenuation_11 + tmpvar_14), 0.0, 1.0);
  atten_2 = tmpvar_22;
  mediump float occ_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_23 = tmpvar_24;
  mediump float atten_25;
  atten_25 = atten_2;
  mediump float occlusion_26;
  occlusion_26 = ((1.0 - _OcclusionStrength) + (occ_23 * _OcclusionStrength));
  highp vec4 tmpvar_27;
  tmpvar_27 = unity_SpecCube0_HDR;
  mediump vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_8;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, tmpvar_28);
  x_29.y = dot (unity_SHAg, tmpvar_28);
  x_29.z = dot (unity_SHAb, tmpvar_28);
  mediump vec3 tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = (1.0 - _Glossiness);
  tmpvar_30 = (tmpvar_9 - (2.0 * (
    dot (tmpvar_8, tmpvar_9)
   * tmpvar_8)));
  mediump vec4 hdr_32;
  hdr_32 = tmpvar_27;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = ((tmpvar_31 * (1.7 - 
    (0.7 * tmpvar_31)
  )) * 6.0);
  lowp vec4 tmpvar_34;
  tmpvar_34 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_30, tmpvar_33.w);
  mediump vec4 tmpvar_35;
  tmpvar_35 = tmpvar_34;
  mediump vec3 viewDir_36;
  viewDir_36 = -(tmpvar_9);
  mediump float specularTerm_37;
  mediump vec3 tmpvar_38;
  mediump vec3 inVec_39;
  inVec_39 = (_WorldSpaceLightPos0.xyz + viewDir_36);
  tmpvar_38 = (inVec_39 * inversesqrt(max (0.001, 
    dot (inVec_39, inVec_39)
  )));
  mediump float tmpvar_40;
  tmpvar_40 = clamp (dot (tmpvar_8, tmpvar_38), 0.0, 1.0);
  mediump float tmpvar_41;
  tmpvar_41 = (tmpvar_31 * tmpvar_31);
  specularTerm_37 = ((tmpvar_41 / (
    (max (0.32, clamp (dot (_WorldSpaceLightPos0.xyz, tmpvar_38), 0.0, 1.0)) * (1.5 + tmpvar_41))
   * 
    (((tmpvar_40 * tmpvar_40) * ((tmpvar_41 * tmpvar_41) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_42;
  tmpvar_42 = clamp (specularTerm_37, 0.0, 100.0);
  specularTerm_37 = tmpvar_42;
  mediump float x_43;
  x_43 = (1.0 - clamp (dot (tmpvar_8, viewDir_36), 0.0, 1.0));
  mediump vec3 tmpvar_44;
  tmpvar_44 = (((
    ((tmpvar_5 + (tmpvar_42 * tmpvar_6)) * (tmpvar_10 * atten_25))
   * 
    clamp (dot (tmpvar_8, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (max (((1.055 * 
      pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_29)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0)) * occlusion_26)
   * tmpvar_5)) + ((
    (1.0 - ((tmpvar_41 * tmpvar_31) * 0.28))
   * 
    (((hdr_32.x * (
      (hdr_32.w * (tmpvar_35.w - 1.0))
     + 1.0)) * tmpvar_35.xyz) * occlusion_26)
  ) * mix (tmpvar_6, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_7)), 0.0, 1.0)
  ), vec3(
    ((x_43 * x_43) * (x_43 * x_43))
  ))));
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = tmpvar_44;
  c_1.w = tmpvar_45.w;
  c_1.xyz = tmpvar_44;
  mediump vec4 xlat_varoutput_46;
  xlat_varoutput_46.xyz = c_1.xyz;
  xlat_varoutput_46.w = 1.0;
  gl_FragData[0] = xlat_varoutput_46;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 normal_26;
  normal_26 = normalWorld_19;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (lengthSq_29, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_29 = tmpvar_33;
  ndotl_28 = (tmpvar_30 * normal_26.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * normal_26.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * normal_26.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(tmpvar_33)));
  ndotl_28 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (tmpvar_33 * lightAttenSq_25)
  ))));
  col_27 = (lightColor0_21 * tmpvar_35.x);
  col_27 = (col_27 + (lightColor1_22 * tmpvar_35.y));
  col_27 = (col_27 + (lightColor2_23 * tmpvar_35.z));
  col_27 = (col_27 + (lightColor3_24 * tmpvar_35.w));
  ambientOrLightmapUV_20.xyz = col_27;
  mediump vec3 x1_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_36.x = dot (unity_SHBr, tmpvar_37);
  x1_36.y = dot (unity_SHBg, tmpvar_37);
  x1_36.z = dot (unity_SHBb, tmpvar_37);
  ambientOrLightmapUV_20.xyz = ((ambientOrLightmapUV_20.xyz * (
    (ambientOrLightmapUV_20.xyz * ((ambientOrLightmapUV_20.xyz * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_36 + (unity_SHC.xyz * 
    ((normalWorld_19.x * normalWorld_19.x) - (normalWorld_19.y * normalWorld_19.y))
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 c_1;
  lowp float atten_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  mediump float tmpvar_7;
  tmpvar_7 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_5 = (tmpvar_4 * tmpvar_7);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_10;
  tmpvar_10 = _LightColor0.xyz;
  mediump float realtimeShadowAttenuation_11;
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].z;
  v_12.y = unity_MatrixV[1].z;
  v_12.z = unity_MatrixV[2].z;
  v_12.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD8 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD8), v_12.xyz), sqrt(dot (tmpvar_13, tmpvar_13)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = xlv_TEXCOORD8;
  lowp float tmpvar_17;
  highp vec4 shadowCoord_18;
  shadowCoord_18 = (unity_WorldToShadow[0] * tmpvar_16);
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, shadowCoord_18.xy).x > shadowCoord_18.z)), lightShadowDataX_19);
  tmpvar_17 = tmpvar_21;
  realtimeShadowAttenuation_11 = tmpvar_17;
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((realtimeShadowAttenuation_11 + tmpvar_14), 0.0, 1.0);
  atten_2 = tmpvar_22;
  mediump float occ_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_23 = tmpvar_24;
  mediump float atten_25;
  atten_25 = atten_2;
  mediump float occlusion_26;
  occlusion_26 = ((1.0 - _OcclusionStrength) + (occ_23 * _OcclusionStrength));
  highp vec4 tmpvar_27;
  tmpvar_27 = unity_SpecCube0_HDR;
  mediump vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_8;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, tmpvar_28);
  x_29.y = dot (unity_SHAg, tmpvar_28);
  x_29.z = dot (unity_SHAb, tmpvar_28);
  mediump vec3 tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = (1.0 - _Glossiness);
  tmpvar_30 = (tmpvar_9 - (2.0 * (
    dot (tmpvar_8, tmpvar_9)
   * tmpvar_8)));
  mediump vec4 hdr_32;
  hdr_32 = tmpvar_27;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = ((tmpvar_31 * (1.7 - 
    (0.7 * tmpvar_31)
  )) * 6.0);
  lowp vec4 tmpvar_34;
  tmpvar_34 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_30, tmpvar_33.w);
  mediump vec4 tmpvar_35;
  tmpvar_35 = tmpvar_34;
  mediump vec3 viewDir_36;
  viewDir_36 = -(tmpvar_9);
  mediump float specularTerm_37;
  mediump vec3 tmpvar_38;
  mediump vec3 inVec_39;
  inVec_39 = (_WorldSpaceLightPos0.xyz + viewDir_36);
  tmpvar_38 = (inVec_39 * inversesqrt(max (0.001, 
    dot (inVec_39, inVec_39)
  )));
  mediump float tmpvar_40;
  tmpvar_40 = clamp (dot (tmpvar_8, tmpvar_38), 0.0, 1.0);
  mediump float tmpvar_41;
  tmpvar_41 = (tmpvar_31 * tmpvar_31);
  specularTerm_37 = ((tmpvar_41 / (
    (max (0.32, clamp (dot (_WorldSpaceLightPos0.xyz, tmpvar_38), 0.0, 1.0)) * (1.5 + tmpvar_41))
   * 
    (((tmpvar_40 * tmpvar_40) * ((tmpvar_41 * tmpvar_41) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_42;
  tmpvar_42 = clamp (specularTerm_37, 0.0, 100.0);
  specularTerm_37 = tmpvar_42;
  mediump float x_43;
  x_43 = (1.0 - clamp (dot (tmpvar_8, viewDir_36), 0.0, 1.0));
  mediump vec3 tmpvar_44;
  tmpvar_44 = (((
    ((tmpvar_5 + (tmpvar_42 * tmpvar_6)) * (tmpvar_10 * atten_25))
   * 
    clamp (dot (tmpvar_8, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (max (((1.055 * 
      pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_29)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0)) * occlusion_26)
   * tmpvar_5)) + ((
    (1.0 - ((tmpvar_41 * tmpvar_31) * 0.28))
   * 
    (((hdr_32.x * (
      (hdr_32.w * (tmpvar_35.w - 1.0))
     + 1.0)) * tmpvar_35.xyz) * occlusion_26)
  ) * mix (tmpvar_6, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_7)), 0.0, 1.0)
  ), vec3(
    ((x_43 * x_43) * (x_43 * x_43))
  ))));
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = tmpvar_44;
  c_1.w = tmpvar_45.w;
  c_1.xyz = tmpvar_44;
  mediump vec4 xlat_varoutput_46;
  xlat_varoutput_46.xyz = c_1.xyz;
  xlat_varoutput_46.w = 1.0;
  gl_FragData[0] = xlat_varoutput_46;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "_EMISSION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  normalWorld_4 = tmpvar_17;
  tmpvar_8.xyz = normalWorld_4;
  tmpvar_6.xyz = eyeVec_5;
  mediump vec4 ambientOrLightmapUV_18;
  ambientOrLightmapUV_18.w = 0.0;
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = normalWorld_4;
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, tmpvar_19);
  x_21.y = dot (unity_SHAg, tmpvar_19);
  x_21.z = dot (unity_SHAb, tmpvar_19);
  mediump vec3 x1_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = (normalWorld_4.xyzz * normalWorld_4.yzzx);
  x1_22.x = dot (unity_SHBr, tmpvar_23);
  x1_22.y = dot (unity_SHBg, tmpvar_23);
  x1_22.z = dot (unity_SHBb, tmpvar_23);
  res_20 = (x_21 + (x1_22 + (unity_SHC.xyz * 
    ((normalWorld_4.x * normalWorld_4.x) - (normalWorld_4.y * normalWorld_4.y))
  )));
  mediump vec3 tmpvar_24;
  tmpvar_24 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_24;
  ambientOrLightmapUV_18.xyz = max (vec3(0.0, 0.0, 0.0), tmpvar_24);
  tmpvar_7.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  mediump float x_25;
  x_25 = (1.0 - clamp (dot (normalWorld_4, 
    -(eyeVec_5)
  ), 0.0, 1.0));
  tmpvar_8.w = ((x_25 * x_25) * (x_25 * x_25));
  tmpvar_6.w = clamp ((_Glossiness + (1.0 - 
    (0.7790837 - (_Metallic * 0.7790837))
  )), 0.0, 1.0);
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = ambientOrLightmapUV_18;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 c_1;
  mediump float rl_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  tmpvar_5 = (tmpvar_4 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_7;
  tmpvar_7 = _LightColor0.xyz;
  mediump float occ_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_8 = tmpvar_9;
  rl_2 = dot (xlv_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
  mediump float occlusion_10;
  occlusion_10 = ((1.0 - _OcclusionStrength) + (occ_8 * _OcclusionStrength));
  highp vec4 tmpvar_11;
  tmpvar_11 = unity_SpecCube0_HDR;
  mediump float tmpvar_12;
  tmpvar_12 = (1.0 - _Glossiness);
  mediump vec4 hdr_13;
  hdr_13 = tmpvar_11;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = xlv_TEXCOORD4.yzw;
  tmpvar_14.w = ((tmpvar_12 * (1.7 - 
    (0.7 * tmpvar_12)
  )) * 6.0);
  lowp vec4 tmpvar_15;
  tmpvar_15 = impl_low_textureCubeLodEXT (unity_SpecCube0, xlv_TEXCOORD4.yzw, tmpvar_14.w);
  mediump vec4 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = ((rl_2 * rl_2) * (rl_2 * rl_2));
  tmpvar_17.y = tmpvar_12;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (unity_NHxRoughness, tmpvar_17);
  c_1 = (((
    (xlv_TEXCOORD2.xyz * occlusion_10)
   * tmpvar_5) + (
    (((hdr_13.x * (
      (hdr_13.w * (tmpvar_16.w - 1.0))
     + 1.0)) * tmpvar_16.xyz) * occlusion_10)
   * 
    mix (tmpvar_6, xlv_TEXCOORD1.www, xlv_TEXCOORD5.www)
  )) + ((tmpvar_5 + 
    ((tmpvar_18.w * 16.0) * tmpvar_6)
  ) * (tmpvar_7 * 
    clamp (dot (xlv_TEXCOORD5.xyz, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  c_1 = (c_1 + (tmpvar_19.xyz * _EmissionColor.xyz));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = c_1;
  mediump vec4 xlat_varoutput_21;
  xlat_varoutput_21.xyz = tmpvar_20.xyz;
  xlat_varoutput_21.w = 1.0;
  gl_FragData[0] = xlat_varoutput_21;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_EMISSION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  mediump vec3 x1_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_21.x = dot (unity_SHBr, tmpvar_22);
  x1_21.y = dot (unity_SHBg, tmpvar_22);
  x1_21.z = dot (unity_SHBb, tmpvar_22);
  ambientOrLightmapUV_20.xyz = (x1_21 + (unity_SHC.xyz * (
    (normalWorld_19.x * normalWorld_19.x)
   - 
    (normalWorld_19.y * normalWorld_19.y)
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  mediump float tmpvar_6;
  tmpvar_6 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_4 = (tmpvar_3 * tmpvar_6);
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_9;
  tmpvar_9 = _LightColor0.xyz;
  mediump float occ_10;
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_10 = tmpvar_11;
  mediump float occlusion_12;
  occlusion_12 = ((1.0 - _OcclusionStrength) + (occ_10 * _OcclusionStrength));
  highp vec4 tmpvar_13;
  tmpvar_13 = unity_SpecCube0_HDR;
  mediump vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_7;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, tmpvar_14);
  x_15.y = dot (unity_SHAg, tmpvar_14);
  x_15.z = dot (unity_SHAb, tmpvar_14);
  mediump vec3 tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = (1.0 - _Glossiness);
  tmpvar_16 = (tmpvar_8 - (2.0 * (
    dot (tmpvar_7, tmpvar_8)
   * tmpvar_7)));
  mediump vec4 hdr_18;
  hdr_18 = tmpvar_13;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = tmpvar_16;
  tmpvar_19.w = ((tmpvar_17 * (1.7 - 
    (0.7 * tmpvar_17)
  )) * 6.0);
  lowp vec4 tmpvar_20;
  tmpvar_20 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_16, tmpvar_19.w);
  mediump vec4 tmpvar_21;
  tmpvar_21 = tmpvar_20;
  mediump vec3 viewDir_22;
  viewDir_22 = -(tmpvar_8);
  mediump float specularTerm_23;
  mediump vec3 tmpvar_24;
  mediump vec3 inVec_25;
  inVec_25 = (_WorldSpaceLightPos0.xyz + viewDir_22);
  tmpvar_24 = (inVec_25 * inversesqrt(max (0.001, 
    dot (inVec_25, inVec_25)
  )));
  mediump float tmpvar_26;
  tmpvar_26 = clamp (dot (tmpvar_7, tmpvar_24), 0.0, 1.0);
  mediump float tmpvar_27;
  tmpvar_27 = (tmpvar_17 * tmpvar_17);
  specularTerm_23 = ((tmpvar_27 / (
    (max (0.32, clamp (dot (_WorldSpaceLightPos0.xyz, tmpvar_24), 0.0, 1.0)) * (1.5 + tmpvar_27))
   * 
    (((tmpvar_26 * tmpvar_26) * ((tmpvar_27 * tmpvar_27) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (specularTerm_23, 0.0, 100.0);
  specularTerm_23 = tmpvar_28;
  mediump float x_29;
  x_29 = (1.0 - clamp (dot (tmpvar_7, viewDir_22), 0.0, 1.0));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (((
    ((tmpvar_4 + (tmpvar_28 * tmpvar_5)) * tmpvar_9)
   * 
    clamp (dot (tmpvar_7, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (max (((1.055 * 
      pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_15)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0)) * occlusion_12)
   * tmpvar_4)) + ((
    (1.0 - ((tmpvar_27 * tmpvar_17) * 0.28))
   * 
    (((hdr_18.x * (
      (hdr_18.w * (tmpvar_21.w - 1.0))
     + 1.0)) * tmpvar_21.xyz) * occlusion_12)
  ) * mix (tmpvar_5, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_6)), 0.0, 1.0)
  ), vec3(
    ((x_29 * x_29) * (x_29 * x_29))
  ))));
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = tmpvar_30;
  c_1.w = tmpvar_31.w;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  c_1.xyz = (tmpvar_30 + (tmpvar_32.xyz * _EmissionColor.xyz));
  mediump vec4 xlat_varoutput_33;
  xlat_varoutput_33.xyz = c_1.xyz;
  xlat_varoutput_33.w = 1.0;
  gl_FragData[0] = xlat_varoutput_33;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_EMISSION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  mediump vec3 x1_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_21.x = dot (unity_SHBr, tmpvar_22);
  x1_21.y = dot (unity_SHBg, tmpvar_22);
  x1_21.z = dot (unity_SHBb, tmpvar_22);
  ambientOrLightmapUV_20.xyz = (x1_21 + (unity_SHC.xyz * (
    (normalWorld_19.x * normalWorld_19.x)
   - 
    (normalWorld_19.y * normalWorld_19.y)
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  mediump float tmpvar_6;
  tmpvar_6 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_4 = (tmpvar_3 * tmpvar_6);
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_9;
  tmpvar_9 = _LightColor0.xyz;
  mediump float occ_10;
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_10 = tmpvar_11;
  mediump float occlusion_12;
  occlusion_12 = ((1.0 - _OcclusionStrength) + (occ_10 * _OcclusionStrength));
  highp vec4 tmpvar_13;
  tmpvar_13 = unity_SpecCube0_HDR;
  mediump vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_7;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, tmpvar_14);
  x_15.y = dot (unity_SHAg, tmpvar_14);
  x_15.z = dot (unity_SHAb, tmpvar_14);
  mediump vec3 tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = (1.0 - _Glossiness);
  tmpvar_16 = (tmpvar_8 - (2.0 * (
    dot (tmpvar_7, tmpvar_8)
   * tmpvar_7)));
  mediump vec4 hdr_18;
  hdr_18 = tmpvar_13;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = tmpvar_16;
  tmpvar_19.w = ((tmpvar_17 * (1.7 - 
    (0.7 * tmpvar_17)
  )) * 6.0);
  lowp vec4 tmpvar_20;
  tmpvar_20 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_16, tmpvar_19.w);
  mediump vec4 tmpvar_21;
  tmpvar_21 = tmpvar_20;
  mediump vec3 viewDir_22;
  viewDir_22 = -(tmpvar_8);
  mediump float specularTerm_23;
  mediump vec3 tmpvar_24;
  mediump vec3 inVec_25;
  inVec_25 = (_WorldSpaceLightPos0.xyz + viewDir_22);
  tmpvar_24 = (inVec_25 * inversesqrt(max (0.001, 
    dot (inVec_25, inVec_25)
  )));
  mediump float tmpvar_26;
  tmpvar_26 = clamp (dot (tmpvar_7, tmpvar_24), 0.0, 1.0);
  mediump float tmpvar_27;
  tmpvar_27 = (tmpvar_17 * tmpvar_17);
  specularTerm_23 = ((tmpvar_27 / (
    (max (0.32, clamp (dot (_WorldSpaceLightPos0.xyz, tmpvar_24), 0.0, 1.0)) * (1.5 + tmpvar_27))
   * 
    (((tmpvar_26 * tmpvar_26) * ((tmpvar_27 * tmpvar_27) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (specularTerm_23, 0.0, 100.0);
  specularTerm_23 = tmpvar_28;
  mediump float x_29;
  x_29 = (1.0 - clamp (dot (tmpvar_7, viewDir_22), 0.0, 1.0));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (((
    ((tmpvar_4 + (tmpvar_28 * tmpvar_5)) * tmpvar_9)
   * 
    clamp (dot (tmpvar_7, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (max (((1.055 * 
      pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_15)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0)) * occlusion_12)
   * tmpvar_4)) + ((
    (1.0 - ((tmpvar_27 * tmpvar_17) * 0.28))
   * 
    (((hdr_18.x * (
      (hdr_18.w * (tmpvar_21.w - 1.0))
     + 1.0)) * tmpvar_21.xyz) * occlusion_12)
  ) * mix (tmpvar_5, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_6)), 0.0, 1.0)
  ), vec3(
    ((x_29 * x_29) * (x_29 * x_29))
  ))));
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = tmpvar_30;
  c_1.w = tmpvar_31.w;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  c_1.xyz = (tmpvar_30 + (tmpvar_32.xyz * _EmissionColor.xyz));
  mediump vec4 xlat_varoutput_33;
  xlat_varoutput_33.xyz = c_1.xyz;
  xlat_varoutput_33.w = 1.0;
  gl_FragData[0] = xlat_varoutput_33;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_EMISSION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  normalWorld_4 = tmpvar_17;
  tmpvar_8.xyz = normalWorld_4;
  tmpvar_6.xyz = eyeVec_5;
  mediump vec4 ambientOrLightmapUV_18;
  ambientOrLightmapUV_18.w = 0.0;
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = normalWorld_4;
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, tmpvar_19);
  x_21.y = dot (unity_SHAg, tmpvar_19);
  x_21.z = dot (unity_SHAb, tmpvar_19);
  mediump vec3 x1_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = (normalWorld_4.xyzz * normalWorld_4.yzzx);
  x1_22.x = dot (unity_SHBr, tmpvar_23);
  x1_22.y = dot (unity_SHBg, tmpvar_23);
  x1_22.z = dot (unity_SHBb, tmpvar_23);
  res_20 = (x_21 + (x1_22 + (unity_SHC.xyz * 
    ((normalWorld_4.x * normalWorld_4.x) - (normalWorld_4.y * normalWorld_4.y))
  )));
  mediump vec3 tmpvar_24;
  tmpvar_24 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_24;
  ambientOrLightmapUV_18.xyz = max (vec3(0.0, 0.0, 0.0), tmpvar_24);
  tmpvar_7.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  mediump float x_25;
  x_25 = (1.0 - clamp (dot (normalWorld_4, 
    -(eyeVec_5)
  ), 0.0, 1.0));
  tmpvar_8.w = ((x_25 * x_25) * (x_25 * x_25));
  tmpvar_6.w = clamp ((_Glossiness + (1.0 - 
    (0.7790837 - (_Metallic * 0.7790837))
  )), 0.0, 1.0);
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = ambientOrLightmapUV_18;
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 c_1;
  mediump float rl_2;
  mediump float realtimeShadowAttenuation_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_5;
  tmpvar_5 = (_Color.xyz * tmpvar_4.xyz);
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_5, vec3(_Metallic));
  tmpvar_6 = (tmpvar_5 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_8;
  tmpvar_8 = _LightColor0.xyz;
  lowp float tmpvar_9;
  highp float lightShadowDataX_10;
  mediump float tmpvar_11;
  tmpvar_11 = _LightShadowData.x;
  lightShadowDataX_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD3.xy).x > xlv_TEXCOORD3.z)), lightShadowDataX_10);
  tmpvar_9 = tmpvar_12;
  realtimeShadowAttenuation_3 = tmpvar_9;
  mediump float occ_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_13 = tmpvar_14;
  rl_2 = dot (xlv_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
  mediump float occlusion_15;
  occlusion_15 = ((1.0 - _OcclusionStrength) + (occ_13 * _OcclusionStrength));
  highp vec4 tmpvar_16;
  tmpvar_16 = unity_SpecCube0_HDR;
  mediump float tmpvar_17;
  tmpvar_17 = (1.0 - _Glossiness);
  mediump vec4 hdr_18;
  hdr_18 = tmpvar_16;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = xlv_TEXCOORD4.yzw;
  tmpvar_19.w = ((tmpvar_17 * (1.7 - 
    (0.7 * tmpvar_17)
  )) * 6.0);
  lowp vec4 tmpvar_20;
  tmpvar_20 = impl_low_textureCubeLodEXT (unity_SpecCube0, xlv_TEXCOORD4.yzw, tmpvar_19.w);
  mediump vec4 tmpvar_21;
  tmpvar_21 = tmpvar_20;
  mediump vec2 tmpvar_22;
  tmpvar_22.x = ((rl_2 * rl_2) * (rl_2 * rl_2));
  tmpvar_22.y = tmpvar_17;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (unity_NHxRoughness, tmpvar_22);
  c_1 = (((
    (xlv_TEXCOORD2.xyz * occlusion_15)
   * tmpvar_6) + (
    (((hdr_18.x * (
      (hdr_18.w * (tmpvar_21.w - 1.0))
     + 1.0)) * tmpvar_21.xyz) * occlusion_15)
   * 
    mix (tmpvar_7, xlv_TEXCOORD1.www, xlv_TEXCOORD5.www)
  )) + ((tmpvar_6 + 
    ((tmpvar_23.w * 16.0) * tmpvar_7)
  ) * (
    (tmpvar_8 * realtimeShadowAttenuation_3)
   * 
    clamp (dot (xlv_TEXCOORD5.xyz, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  c_1 = (c_1 + (tmpvar_24.xyz * _EmissionColor.xyz));
  mediump vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = c_1;
  mediump vec4 xlat_varoutput_26;
  xlat_varoutput_26.xyz = tmpvar_25.xyz;
  xlat_varoutput_26.w = 1.0;
  gl_FragData[0] = xlat_varoutput_26;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_EMISSION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  mediump vec3 x1_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_21.x = dot (unity_SHBr, tmpvar_22);
  x1_21.y = dot (unity_SHBg, tmpvar_22);
  x1_21.z = dot (unity_SHBb, tmpvar_22);
  ambientOrLightmapUV_20.xyz = (x1_21 + (unity_SHC.xyz * (
    (normalWorld_19.x * normalWorld_19.x)
   - 
    (normalWorld_19.y * normalWorld_19.y)
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 c_1;
  lowp float atten_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  mediump float tmpvar_7;
  tmpvar_7 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_5 = (tmpvar_4 * tmpvar_7);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_10;
  tmpvar_10 = _LightColor0.xyz;
  mediump float realtimeShadowAttenuation_11;
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].z;
  v_12.y = unity_MatrixV[1].z;
  v_12.z = unity_MatrixV[2].z;
  v_12.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD8 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD8), v_12.xyz), sqrt(dot (tmpvar_13, tmpvar_13)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = xlv_TEXCOORD8;
  lowp float tmpvar_17;
  highp vec4 shadowCoord_18;
  shadowCoord_18 = (unity_WorldToShadow[0] * tmpvar_16);
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, shadowCoord_18.xy).x > shadowCoord_18.z)), lightShadowDataX_19);
  tmpvar_17 = tmpvar_21;
  realtimeShadowAttenuation_11 = tmpvar_17;
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((realtimeShadowAttenuation_11 + tmpvar_14), 0.0, 1.0);
  atten_2 = tmpvar_22;
  mediump float occ_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_23 = tmpvar_24;
  mediump float atten_25;
  atten_25 = atten_2;
  mediump float occlusion_26;
  occlusion_26 = ((1.0 - _OcclusionStrength) + (occ_23 * _OcclusionStrength));
  highp vec4 tmpvar_27;
  tmpvar_27 = unity_SpecCube0_HDR;
  mediump vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_8;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, tmpvar_28);
  x_29.y = dot (unity_SHAg, tmpvar_28);
  x_29.z = dot (unity_SHAb, tmpvar_28);
  mediump vec3 tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = (1.0 - _Glossiness);
  tmpvar_30 = (tmpvar_9 - (2.0 * (
    dot (tmpvar_8, tmpvar_9)
   * tmpvar_8)));
  mediump vec4 hdr_32;
  hdr_32 = tmpvar_27;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = ((tmpvar_31 * (1.7 - 
    (0.7 * tmpvar_31)
  )) * 6.0);
  lowp vec4 tmpvar_34;
  tmpvar_34 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_30, tmpvar_33.w);
  mediump vec4 tmpvar_35;
  tmpvar_35 = tmpvar_34;
  mediump vec3 viewDir_36;
  viewDir_36 = -(tmpvar_9);
  mediump float specularTerm_37;
  mediump vec3 tmpvar_38;
  mediump vec3 inVec_39;
  inVec_39 = (_WorldSpaceLightPos0.xyz + viewDir_36);
  tmpvar_38 = (inVec_39 * inversesqrt(max (0.001, 
    dot (inVec_39, inVec_39)
  )));
  mediump float tmpvar_40;
  tmpvar_40 = clamp (dot (tmpvar_8, tmpvar_38), 0.0, 1.0);
  mediump float tmpvar_41;
  tmpvar_41 = (tmpvar_31 * tmpvar_31);
  specularTerm_37 = ((tmpvar_41 / (
    (max (0.32, clamp (dot (_WorldSpaceLightPos0.xyz, tmpvar_38), 0.0, 1.0)) * (1.5 + tmpvar_41))
   * 
    (((tmpvar_40 * tmpvar_40) * ((tmpvar_41 * tmpvar_41) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_42;
  tmpvar_42 = clamp (specularTerm_37, 0.0, 100.0);
  specularTerm_37 = tmpvar_42;
  mediump float x_43;
  x_43 = (1.0 - clamp (dot (tmpvar_8, viewDir_36), 0.0, 1.0));
  mediump vec3 tmpvar_44;
  tmpvar_44 = (((
    ((tmpvar_5 + (tmpvar_42 * tmpvar_6)) * (tmpvar_10 * atten_25))
   * 
    clamp (dot (tmpvar_8, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (max (((1.055 * 
      pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_29)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0)) * occlusion_26)
   * tmpvar_5)) + ((
    (1.0 - ((tmpvar_41 * tmpvar_31) * 0.28))
   * 
    (((hdr_32.x * (
      (hdr_32.w * (tmpvar_35.w - 1.0))
     + 1.0)) * tmpvar_35.xyz) * occlusion_26)
  ) * mix (tmpvar_6, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_7)), 0.0, 1.0)
  ), vec3(
    ((x_43 * x_43) * (x_43 * x_43))
  ))));
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = tmpvar_44;
  c_1.w = tmpvar_45.w;
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  c_1.xyz = (tmpvar_44 + (tmpvar_46.xyz * _EmissionColor.xyz));
  mediump vec4 xlat_varoutput_47;
  xlat_varoutput_47.xyz = c_1.xyz;
  xlat_varoutput_47.w = 1.0;
  gl_FragData[0] = xlat_varoutput_47;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_EMISSION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  mediump vec3 x1_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_21.x = dot (unity_SHBr, tmpvar_22);
  x1_21.y = dot (unity_SHBg, tmpvar_22);
  x1_21.z = dot (unity_SHBb, tmpvar_22);
  ambientOrLightmapUV_20.xyz = (x1_21 + (unity_SHC.xyz * (
    (normalWorld_19.x * normalWorld_19.x)
   - 
    (normalWorld_19.y * normalWorld_19.y)
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 c_1;
  lowp float atten_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  mediump float tmpvar_7;
  tmpvar_7 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_5 = (tmpvar_4 * tmpvar_7);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_10;
  tmpvar_10 = _LightColor0.xyz;
  mediump float realtimeShadowAttenuation_11;
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].z;
  v_12.y = unity_MatrixV[1].z;
  v_12.z = unity_MatrixV[2].z;
  v_12.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD8 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD8), v_12.xyz), sqrt(dot (tmpvar_13, tmpvar_13)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = xlv_TEXCOORD8;
  lowp float tmpvar_17;
  highp vec4 shadowCoord_18;
  shadowCoord_18 = (unity_WorldToShadow[0] * tmpvar_16);
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, shadowCoord_18.xy).x > shadowCoord_18.z)), lightShadowDataX_19);
  tmpvar_17 = tmpvar_21;
  realtimeShadowAttenuation_11 = tmpvar_17;
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((realtimeShadowAttenuation_11 + tmpvar_14), 0.0, 1.0);
  atten_2 = tmpvar_22;
  mediump float occ_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_23 = tmpvar_24;
  mediump float atten_25;
  atten_25 = atten_2;
  mediump float occlusion_26;
  occlusion_26 = ((1.0 - _OcclusionStrength) + (occ_23 * _OcclusionStrength));
  highp vec4 tmpvar_27;
  tmpvar_27 = unity_SpecCube0_HDR;
  mediump vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_8;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, tmpvar_28);
  x_29.y = dot (unity_SHAg, tmpvar_28);
  x_29.z = dot (unity_SHAb, tmpvar_28);
  mediump vec3 tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = (1.0 - _Glossiness);
  tmpvar_30 = (tmpvar_9 - (2.0 * (
    dot (tmpvar_8, tmpvar_9)
   * tmpvar_8)));
  mediump vec4 hdr_32;
  hdr_32 = tmpvar_27;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = ((tmpvar_31 * (1.7 - 
    (0.7 * tmpvar_31)
  )) * 6.0);
  lowp vec4 tmpvar_34;
  tmpvar_34 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_30, tmpvar_33.w);
  mediump vec4 tmpvar_35;
  tmpvar_35 = tmpvar_34;
  mediump vec3 viewDir_36;
  viewDir_36 = -(tmpvar_9);
  mediump float specularTerm_37;
  mediump vec3 tmpvar_38;
  mediump vec3 inVec_39;
  inVec_39 = (_WorldSpaceLightPos0.xyz + viewDir_36);
  tmpvar_38 = (inVec_39 * inversesqrt(max (0.001, 
    dot (inVec_39, inVec_39)
  )));
  mediump float tmpvar_40;
  tmpvar_40 = clamp (dot (tmpvar_8, tmpvar_38), 0.0, 1.0);
  mediump float tmpvar_41;
  tmpvar_41 = (tmpvar_31 * tmpvar_31);
  specularTerm_37 = ((tmpvar_41 / (
    (max (0.32, clamp (dot (_WorldSpaceLightPos0.xyz, tmpvar_38), 0.0, 1.0)) * (1.5 + tmpvar_41))
   * 
    (((tmpvar_40 * tmpvar_40) * ((tmpvar_41 * tmpvar_41) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_42;
  tmpvar_42 = clamp (specularTerm_37, 0.0, 100.0);
  specularTerm_37 = tmpvar_42;
  mediump float x_43;
  x_43 = (1.0 - clamp (dot (tmpvar_8, viewDir_36), 0.0, 1.0));
  mediump vec3 tmpvar_44;
  tmpvar_44 = (((
    ((tmpvar_5 + (tmpvar_42 * tmpvar_6)) * (tmpvar_10 * atten_25))
   * 
    clamp (dot (tmpvar_8, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (max (((1.055 * 
      pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_29)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0)) * occlusion_26)
   * tmpvar_5)) + ((
    (1.0 - ((tmpvar_41 * tmpvar_31) * 0.28))
   * 
    (((hdr_32.x * (
      (hdr_32.w * (tmpvar_35.w - 1.0))
     + 1.0)) * tmpvar_35.xyz) * occlusion_26)
  ) * mix (tmpvar_6, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_7)), 0.0, 1.0)
  ), vec3(
    ((x_43 * x_43) * (x_43 * x_43))
  ))));
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = tmpvar_44;
  c_1.w = tmpvar_45.w;
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  c_1.xyz = (tmpvar_44 + (tmpvar_46.xyz * _EmissionColor.xyz));
  mediump vec4 xlat_varoutput_47;
  xlat_varoutput_47.xyz = c_1.xyz;
  xlat_varoutput_47.w = 1.0;
  gl_FragData[0] = xlat_varoutput_47;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "_EMISSION" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  normalWorld_4 = tmpvar_17;
  tmpvar_8.xyz = normalWorld_4;
  tmpvar_6.xyz = eyeVec_5;
  mediump vec4 ambientOrLightmapUV_18;
  ambientOrLightmapUV_18.w = 0.0;
  highp vec3 lightColor0_19;
  lightColor0_19 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_20;
  lightColor1_20 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_21;
  lightColor2_21 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_22;
  lightColor3_22 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_23;
  lightAttenSq_23 = unity_4LightAtten0;
  highp vec3 normal_24;
  normal_24 = normalWorld_4;
  highp vec3 col_25;
  highp vec4 ndotl_26;
  highp vec4 lengthSq_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_27 = (tmpvar_28 * tmpvar_28);
  lengthSq_27 = (lengthSq_27 + (tmpvar_29 * tmpvar_29));
  lengthSq_27 = (lengthSq_27 + (tmpvar_30 * tmpvar_30));
  highp vec4 tmpvar_31;
  tmpvar_31 = max (lengthSq_27, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_27 = tmpvar_31;
  ndotl_26 = (tmpvar_28 * normal_24.x);
  ndotl_26 = (ndotl_26 + (tmpvar_29 * normal_24.y));
  ndotl_26 = (ndotl_26 + (tmpvar_30 * normal_24.z));
  highp vec4 tmpvar_32;
  tmpvar_32 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_26 * inversesqrt(tmpvar_31)));
  ndotl_26 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_32 * (1.0/((1.0 + 
    (tmpvar_31 * lightAttenSq_23)
  ))));
  col_25 = (lightColor0_19 * tmpvar_33.x);
  col_25 = (col_25 + (lightColor1_20 * tmpvar_33.y));
  col_25 = (col_25 + (lightColor2_21 * tmpvar_33.z));
  col_25 = (col_25 + (lightColor3_22 * tmpvar_33.w));
  ambientOrLightmapUV_18.xyz = col_25;
  mediump vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = normalWorld_4;
  mediump vec3 res_35;
  mediump vec3 x_36;
  x_36.x = dot (unity_SHAr, tmpvar_34);
  x_36.y = dot (unity_SHAg, tmpvar_34);
  x_36.z = dot (unity_SHAb, tmpvar_34);
  mediump vec3 x1_37;
  mediump vec4 tmpvar_38;
  tmpvar_38 = (normalWorld_4.xyzz * normalWorld_4.yzzx);
  x1_37.x = dot (unity_SHBr, tmpvar_38);
  x1_37.y = dot (unity_SHBg, tmpvar_38);
  x1_37.z = dot (unity_SHBb, tmpvar_38);
  res_35 = (x_36 + (x1_37 + (unity_SHC.xyz * 
    ((normalWorld_4.x * normalWorld_4.x) - (normalWorld_4.y * normalWorld_4.y))
  )));
  mediump vec3 tmpvar_39;
  tmpvar_39 = max (((1.055 * 
    pow (max (res_35, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_35 = tmpvar_39;
  ambientOrLightmapUV_18.xyz = (ambientOrLightmapUV_18.xyz + max (vec3(0.0, 0.0, 0.0), tmpvar_39));
  tmpvar_7.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  mediump float x_40;
  x_40 = (1.0 - clamp (dot (normalWorld_4, 
    -(eyeVec_5)
  ), 0.0, 1.0));
  tmpvar_8.w = ((x_40 * x_40) * (x_40 * x_40));
  tmpvar_6.w = clamp ((_Glossiness + (1.0 - 
    (0.7790837 - (_Metallic * 0.7790837))
  )), 0.0, 1.0);
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = ambientOrLightmapUV_18;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 c_1;
  mediump float rl_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  tmpvar_5 = (tmpvar_4 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_7;
  tmpvar_7 = _LightColor0.xyz;
  mediump float occ_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_8 = tmpvar_9;
  rl_2 = dot (xlv_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
  mediump float occlusion_10;
  occlusion_10 = ((1.0 - _OcclusionStrength) + (occ_8 * _OcclusionStrength));
  highp vec4 tmpvar_11;
  tmpvar_11 = unity_SpecCube0_HDR;
  mediump float tmpvar_12;
  tmpvar_12 = (1.0 - _Glossiness);
  mediump vec4 hdr_13;
  hdr_13 = tmpvar_11;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = xlv_TEXCOORD4.yzw;
  tmpvar_14.w = ((tmpvar_12 * (1.7 - 
    (0.7 * tmpvar_12)
  )) * 6.0);
  lowp vec4 tmpvar_15;
  tmpvar_15 = impl_low_textureCubeLodEXT (unity_SpecCube0, xlv_TEXCOORD4.yzw, tmpvar_14.w);
  mediump vec4 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = ((rl_2 * rl_2) * (rl_2 * rl_2));
  tmpvar_17.y = tmpvar_12;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (unity_NHxRoughness, tmpvar_17);
  c_1 = (((
    (xlv_TEXCOORD2.xyz * occlusion_10)
   * tmpvar_5) + (
    (((hdr_13.x * (
      (hdr_13.w * (tmpvar_16.w - 1.0))
     + 1.0)) * tmpvar_16.xyz) * occlusion_10)
   * 
    mix (tmpvar_6, xlv_TEXCOORD1.www, xlv_TEXCOORD5.www)
  )) + ((tmpvar_5 + 
    ((tmpvar_18.w * 16.0) * tmpvar_6)
  ) * (tmpvar_7 * 
    clamp (dot (xlv_TEXCOORD5.xyz, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  )));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  c_1 = (c_1 + (tmpvar_19.xyz * _EmissionColor.xyz));
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = c_1;
  mediump vec4 xlat_varoutput_21;
  xlat_varoutput_21.xyz = tmpvar_20.xyz;
  xlat_varoutput_21.w = 1.0;
  gl_FragData[0] = xlat_varoutput_21;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_EMISSION" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 normal_26;
  normal_26 = normalWorld_19;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (lengthSq_29, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_29 = tmpvar_33;
  ndotl_28 = (tmpvar_30 * normal_26.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * normal_26.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * normal_26.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(tmpvar_33)));
  ndotl_28 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (tmpvar_33 * lightAttenSq_25)
  ))));
  col_27 = (lightColor0_21 * tmpvar_35.x);
  col_27 = (col_27 + (lightColor1_22 * tmpvar_35.y));
  col_27 = (col_27 + (lightColor2_23 * tmpvar_35.z));
  col_27 = (col_27 + (lightColor3_24 * tmpvar_35.w));
  ambientOrLightmapUV_20.xyz = col_27;
  mediump vec3 x1_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_36.x = dot (unity_SHBr, tmpvar_37);
  x1_36.y = dot (unity_SHBg, tmpvar_37);
  x1_36.z = dot (unity_SHBb, tmpvar_37);
  ambientOrLightmapUV_20.xyz = ((ambientOrLightmapUV_20.xyz * (
    (ambientOrLightmapUV_20.xyz * ((ambientOrLightmapUV_20.xyz * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_36 + (unity_SHC.xyz * 
    ((normalWorld_19.x * normalWorld_19.x) - (normalWorld_19.y * normalWorld_19.y))
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  mediump float tmpvar_6;
  tmpvar_6 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_4 = (tmpvar_3 * tmpvar_6);
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_9;
  tmpvar_9 = _LightColor0.xyz;
  mediump float occ_10;
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_10 = tmpvar_11;
  mediump float occlusion_12;
  occlusion_12 = ((1.0 - _OcclusionStrength) + (occ_10 * _OcclusionStrength));
  highp vec4 tmpvar_13;
  tmpvar_13 = unity_SpecCube0_HDR;
  mediump vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_7;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, tmpvar_14);
  x_15.y = dot (unity_SHAg, tmpvar_14);
  x_15.z = dot (unity_SHAb, tmpvar_14);
  mediump vec3 tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = (1.0 - _Glossiness);
  tmpvar_16 = (tmpvar_8 - (2.0 * (
    dot (tmpvar_7, tmpvar_8)
   * tmpvar_7)));
  mediump vec4 hdr_18;
  hdr_18 = tmpvar_13;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = tmpvar_16;
  tmpvar_19.w = ((tmpvar_17 * (1.7 - 
    (0.7 * tmpvar_17)
  )) * 6.0);
  lowp vec4 tmpvar_20;
  tmpvar_20 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_16, tmpvar_19.w);
  mediump vec4 tmpvar_21;
  tmpvar_21 = tmpvar_20;
  mediump vec3 viewDir_22;
  viewDir_22 = -(tmpvar_8);
  mediump float specularTerm_23;
  mediump vec3 tmpvar_24;
  mediump vec3 inVec_25;
  inVec_25 = (_WorldSpaceLightPos0.xyz + viewDir_22);
  tmpvar_24 = (inVec_25 * inversesqrt(max (0.001, 
    dot (inVec_25, inVec_25)
  )));
  mediump float tmpvar_26;
  tmpvar_26 = clamp (dot (tmpvar_7, tmpvar_24), 0.0, 1.0);
  mediump float tmpvar_27;
  tmpvar_27 = (tmpvar_17 * tmpvar_17);
  specularTerm_23 = ((tmpvar_27 / (
    (max (0.32, clamp (dot (_WorldSpaceLightPos0.xyz, tmpvar_24), 0.0, 1.0)) * (1.5 + tmpvar_27))
   * 
    (((tmpvar_26 * tmpvar_26) * ((tmpvar_27 * tmpvar_27) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (specularTerm_23, 0.0, 100.0);
  specularTerm_23 = tmpvar_28;
  mediump float x_29;
  x_29 = (1.0 - clamp (dot (tmpvar_7, viewDir_22), 0.0, 1.0));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (((
    ((tmpvar_4 + (tmpvar_28 * tmpvar_5)) * tmpvar_9)
   * 
    clamp (dot (tmpvar_7, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (max (((1.055 * 
      pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_15)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0)) * occlusion_12)
   * tmpvar_4)) + ((
    (1.0 - ((tmpvar_27 * tmpvar_17) * 0.28))
   * 
    (((hdr_18.x * (
      (hdr_18.w * (tmpvar_21.w - 1.0))
     + 1.0)) * tmpvar_21.xyz) * occlusion_12)
  ) * mix (tmpvar_5, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_6)), 0.0, 1.0)
  ), vec3(
    ((x_29 * x_29) * (x_29 * x_29))
  ))));
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = tmpvar_30;
  c_1.w = tmpvar_31.w;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  c_1.xyz = (tmpvar_30 + (tmpvar_32.xyz * _EmissionColor.xyz));
  mediump vec4 xlat_varoutput_33;
  xlat_varoutput_33.xyz = c_1.xyz;
  xlat_varoutput_33.w = 1.0;
  gl_FragData[0] = xlat_varoutput_33;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_EMISSION" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 normal_26;
  normal_26 = normalWorld_19;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (lengthSq_29, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_29 = tmpvar_33;
  ndotl_28 = (tmpvar_30 * normal_26.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * normal_26.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * normal_26.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(tmpvar_33)));
  ndotl_28 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (tmpvar_33 * lightAttenSq_25)
  ))));
  col_27 = (lightColor0_21 * tmpvar_35.x);
  col_27 = (col_27 + (lightColor1_22 * tmpvar_35.y));
  col_27 = (col_27 + (lightColor2_23 * tmpvar_35.z));
  col_27 = (col_27 + (lightColor3_24 * tmpvar_35.w));
  ambientOrLightmapUV_20.xyz = col_27;
  mediump vec3 x1_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_36.x = dot (unity_SHBr, tmpvar_37);
  x1_36.y = dot (unity_SHBg, tmpvar_37);
  x1_36.z = dot (unity_SHBb, tmpvar_37);
  ambientOrLightmapUV_20.xyz = ((ambientOrLightmapUV_20.xyz * (
    (ambientOrLightmapUV_20.xyz * ((ambientOrLightmapUV_20.xyz * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_36 + (unity_SHC.xyz * 
    ((normalWorld_19.x * normalWorld_19.x) - (normalWorld_19.y * normalWorld_19.y))
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  mediump float tmpvar_6;
  tmpvar_6 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_4 = (tmpvar_3 * tmpvar_6);
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_9;
  tmpvar_9 = _LightColor0.xyz;
  mediump float occ_10;
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_10 = tmpvar_11;
  mediump float occlusion_12;
  occlusion_12 = ((1.0 - _OcclusionStrength) + (occ_10 * _OcclusionStrength));
  highp vec4 tmpvar_13;
  tmpvar_13 = unity_SpecCube0_HDR;
  mediump vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_7;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, tmpvar_14);
  x_15.y = dot (unity_SHAg, tmpvar_14);
  x_15.z = dot (unity_SHAb, tmpvar_14);
  mediump vec3 tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = (1.0 - _Glossiness);
  tmpvar_16 = (tmpvar_8 - (2.0 * (
    dot (tmpvar_7, tmpvar_8)
   * tmpvar_7)));
  mediump vec4 hdr_18;
  hdr_18 = tmpvar_13;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = tmpvar_16;
  tmpvar_19.w = ((tmpvar_17 * (1.7 - 
    (0.7 * tmpvar_17)
  )) * 6.0);
  lowp vec4 tmpvar_20;
  tmpvar_20 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_16, tmpvar_19.w);
  mediump vec4 tmpvar_21;
  tmpvar_21 = tmpvar_20;
  mediump vec3 viewDir_22;
  viewDir_22 = -(tmpvar_8);
  mediump float specularTerm_23;
  mediump vec3 tmpvar_24;
  mediump vec3 inVec_25;
  inVec_25 = (_WorldSpaceLightPos0.xyz + viewDir_22);
  tmpvar_24 = (inVec_25 * inversesqrt(max (0.001, 
    dot (inVec_25, inVec_25)
  )));
  mediump float tmpvar_26;
  tmpvar_26 = clamp (dot (tmpvar_7, tmpvar_24), 0.0, 1.0);
  mediump float tmpvar_27;
  tmpvar_27 = (tmpvar_17 * tmpvar_17);
  specularTerm_23 = ((tmpvar_27 / (
    (max (0.32, clamp (dot (_WorldSpaceLightPos0.xyz, tmpvar_24), 0.0, 1.0)) * (1.5 + tmpvar_27))
   * 
    (((tmpvar_26 * tmpvar_26) * ((tmpvar_27 * tmpvar_27) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (specularTerm_23, 0.0, 100.0);
  specularTerm_23 = tmpvar_28;
  mediump float x_29;
  x_29 = (1.0 - clamp (dot (tmpvar_7, viewDir_22), 0.0, 1.0));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (((
    ((tmpvar_4 + (tmpvar_28 * tmpvar_5)) * tmpvar_9)
   * 
    clamp (dot (tmpvar_7, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (max (((1.055 * 
      pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_15)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0)) * occlusion_12)
   * tmpvar_4)) + ((
    (1.0 - ((tmpvar_27 * tmpvar_17) * 0.28))
   * 
    (((hdr_18.x * (
      (hdr_18.w * (tmpvar_21.w - 1.0))
     + 1.0)) * tmpvar_21.xyz) * occlusion_12)
  ) * mix (tmpvar_5, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_6)), 0.0, 1.0)
  ), vec3(
    ((x_29 * x_29) * (x_29 * x_29))
  ))));
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = tmpvar_30;
  c_1.w = tmpvar_31.w;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  c_1.xyz = (tmpvar_30 + (tmpvar_32.xyz * _EmissionColor.xyz));
  mediump vec4 xlat_varoutput_33;
  xlat_varoutput_33.xyz = c_1.xyz;
  xlat_varoutput_33.w = 1.0;
  gl_FragData[0] = xlat_varoutput_33;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_EMISSION" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  normalWorld_4 = tmpvar_17;
  tmpvar_8.xyz = normalWorld_4;
  tmpvar_6.xyz = eyeVec_5;
  mediump vec4 ambientOrLightmapUV_18;
  ambientOrLightmapUV_18.w = 0.0;
  highp vec3 lightColor0_19;
  lightColor0_19 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_20;
  lightColor1_20 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_21;
  lightColor2_21 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_22;
  lightColor3_22 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_23;
  lightAttenSq_23 = unity_4LightAtten0;
  highp vec3 normal_24;
  normal_24 = normalWorld_4;
  highp vec3 col_25;
  highp vec4 ndotl_26;
  highp vec4 lengthSq_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_27 = (tmpvar_28 * tmpvar_28);
  lengthSq_27 = (lengthSq_27 + (tmpvar_29 * tmpvar_29));
  lengthSq_27 = (lengthSq_27 + (tmpvar_30 * tmpvar_30));
  highp vec4 tmpvar_31;
  tmpvar_31 = max (lengthSq_27, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_27 = tmpvar_31;
  ndotl_26 = (tmpvar_28 * normal_24.x);
  ndotl_26 = (ndotl_26 + (tmpvar_29 * normal_24.y));
  ndotl_26 = (ndotl_26 + (tmpvar_30 * normal_24.z));
  highp vec4 tmpvar_32;
  tmpvar_32 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_26 * inversesqrt(tmpvar_31)));
  ndotl_26 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_32 * (1.0/((1.0 + 
    (tmpvar_31 * lightAttenSq_23)
  ))));
  col_25 = (lightColor0_19 * tmpvar_33.x);
  col_25 = (col_25 + (lightColor1_20 * tmpvar_33.y));
  col_25 = (col_25 + (lightColor2_21 * tmpvar_33.z));
  col_25 = (col_25 + (lightColor3_22 * tmpvar_33.w));
  ambientOrLightmapUV_18.xyz = col_25;
  mediump vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = normalWorld_4;
  mediump vec3 res_35;
  mediump vec3 x_36;
  x_36.x = dot (unity_SHAr, tmpvar_34);
  x_36.y = dot (unity_SHAg, tmpvar_34);
  x_36.z = dot (unity_SHAb, tmpvar_34);
  mediump vec3 x1_37;
  mediump vec4 tmpvar_38;
  tmpvar_38 = (normalWorld_4.xyzz * normalWorld_4.yzzx);
  x1_37.x = dot (unity_SHBr, tmpvar_38);
  x1_37.y = dot (unity_SHBg, tmpvar_38);
  x1_37.z = dot (unity_SHBb, tmpvar_38);
  res_35 = (x_36 + (x1_37 + (unity_SHC.xyz * 
    ((normalWorld_4.x * normalWorld_4.x) - (normalWorld_4.y * normalWorld_4.y))
  )));
  mediump vec3 tmpvar_39;
  tmpvar_39 = max (((1.055 * 
    pow (max (res_35, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_35 = tmpvar_39;
  ambientOrLightmapUV_18.xyz = (ambientOrLightmapUV_18.xyz + max (vec3(0.0, 0.0, 0.0), tmpvar_39));
  tmpvar_7.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  mediump float x_40;
  x_40 = (1.0 - clamp (dot (normalWorld_4, 
    -(eyeVec_5)
  ), 0.0, 1.0));
  tmpvar_8.w = ((x_40 * x_40) * (x_40 * x_40));
  tmpvar_6.w = clamp ((_Glossiness + (1.0 - 
    (0.7790837 - (_Metallic * 0.7790837))
  )), 0.0, 1.0);
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = ambientOrLightmapUV_18;
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 c_1;
  mediump float rl_2;
  mediump float realtimeShadowAttenuation_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_5;
  tmpvar_5 = (_Color.xyz * tmpvar_4.xyz);
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_5, vec3(_Metallic));
  tmpvar_6 = (tmpvar_5 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_8;
  tmpvar_8 = _LightColor0.xyz;
  lowp float tmpvar_9;
  highp float lightShadowDataX_10;
  mediump float tmpvar_11;
  tmpvar_11 = _LightShadowData.x;
  lightShadowDataX_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD3.xy).x > xlv_TEXCOORD3.z)), lightShadowDataX_10);
  tmpvar_9 = tmpvar_12;
  realtimeShadowAttenuation_3 = tmpvar_9;
  mediump float occ_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_13 = tmpvar_14;
  rl_2 = dot (xlv_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
  mediump float occlusion_15;
  occlusion_15 = ((1.0 - _OcclusionStrength) + (occ_13 * _OcclusionStrength));
  highp vec4 tmpvar_16;
  tmpvar_16 = unity_SpecCube0_HDR;
  mediump float tmpvar_17;
  tmpvar_17 = (1.0 - _Glossiness);
  mediump vec4 hdr_18;
  hdr_18 = tmpvar_16;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = xlv_TEXCOORD4.yzw;
  tmpvar_19.w = ((tmpvar_17 * (1.7 - 
    (0.7 * tmpvar_17)
  )) * 6.0);
  lowp vec4 tmpvar_20;
  tmpvar_20 = impl_low_textureCubeLodEXT (unity_SpecCube0, xlv_TEXCOORD4.yzw, tmpvar_19.w);
  mediump vec4 tmpvar_21;
  tmpvar_21 = tmpvar_20;
  mediump vec2 tmpvar_22;
  tmpvar_22.x = ((rl_2 * rl_2) * (rl_2 * rl_2));
  tmpvar_22.y = tmpvar_17;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (unity_NHxRoughness, tmpvar_22);
  c_1 = (((
    (xlv_TEXCOORD2.xyz * occlusion_15)
   * tmpvar_6) + (
    (((hdr_18.x * (
      (hdr_18.w * (tmpvar_21.w - 1.0))
     + 1.0)) * tmpvar_21.xyz) * occlusion_15)
   * 
    mix (tmpvar_7, xlv_TEXCOORD1.www, xlv_TEXCOORD5.www)
  )) + ((tmpvar_6 + 
    ((tmpvar_23.w * 16.0) * tmpvar_7)
  ) * (
    (tmpvar_8 * realtimeShadowAttenuation_3)
   * 
    clamp (dot (xlv_TEXCOORD5.xyz, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  c_1 = (c_1 + (tmpvar_24.xyz * _EmissionColor.xyz));
  mediump vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = c_1;
  mediump vec4 xlat_varoutput_26;
  xlat_varoutput_26.xyz = tmpvar_25.xyz;
  xlat_varoutput_26.w = 1.0;
  gl_FragData[0] = xlat_varoutput_26;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_EMISSION" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 normal_26;
  normal_26 = normalWorld_19;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (lengthSq_29, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_29 = tmpvar_33;
  ndotl_28 = (tmpvar_30 * normal_26.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * normal_26.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * normal_26.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(tmpvar_33)));
  ndotl_28 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (tmpvar_33 * lightAttenSq_25)
  ))));
  col_27 = (lightColor0_21 * tmpvar_35.x);
  col_27 = (col_27 + (lightColor1_22 * tmpvar_35.y));
  col_27 = (col_27 + (lightColor2_23 * tmpvar_35.z));
  col_27 = (col_27 + (lightColor3_24 * tmpvar_35.w));
  ambientOrLightmapUV_20.xyz = col_27;
  mediump vec3 x1_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_36.x = dot (unity_SHBr, tmpvar_37);
  x1_36.y = dot (unity_SHBg, tmpvar_37);
  x1_36.z = dot (unity_SHBb, tmpvar_37);
  ambientOrLightmapUV_20.xyz = ((ambientOrLightmapUV_20.xyz * (
    (ambientOrLightmapUV_20.xyz * ((ambientOrLightmapUV_20.xyz * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_36 + (unity_SHC.xyz * 
    ((normalWorld_19.x * normalWorld_19.x) - (normalWorld_19.y * normalWorld_19.y))
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 c_1;
  lowp float atten_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  mediump float tmpvar_7;
  tmpvar_7 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_5 = (tmpvar_4 * tmpvar_7);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_10;
  tmpvar_10 = _LightColor0.xyz;
  mediump float realtimeShadowAttenuation_11;
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].z;
  v_12.y = unity_MatrixV[1].z;
  v_12.z = unity_MatrixV[2].z;
  v_12.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD8 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD8), v_12.xyz), sqrt(dot (tmpvar_13, tmpvar_13)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = xlv_TEXCOORD8;
  lowp float tmpvar_17;
  highp vec4 shadowCoord_18;
  shadowCoord_18 = (unity_WorldToShadow[0] * tmpvar_16);
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, shadowCoord_18.xy).x > shadowCoord_18.z)), lightShadowDataX_19);
  tmpvar_17 = tmpvar_21;
  realtimeShadowAttenuation_11 = tmpvar_17;
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((realtimeShadowAttenuation_11 + tmpvar_14), 0.0, 1.0);
  atten_2 = tmpvar_22;
  mediump float occ_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_23 = tmpvar_24;
  mediump float atten_25;
  atten_25 = atten_2;
  mediump float occlusion_26;
  occlusion_26 = ((1.0 - _OcclusionStrength) + (occ_23 * _OcclusionStrength));
  highp vec4 tmpvar_27;
  tmpvar_27 = unity_SpecCube0_HDR;
  mediump vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_8;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, tmpvar_28);
  x_29.y = dot (unity_SHAg, tmpvar_28);
  x_29.z = dot (unity_SHAb, tmpvar_28);
  mediump vec3 tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = (1.0 - _Glossiness);
  tmpvar_30 = (tmpvar_9 - (2.0 * (
    dot (tmpvar_8, tmpvar_9)
   * tmpvar_8)));
  mediump vec4 hdr_32;
  hdr_32 = tmpvar_27;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = ((tmpvar_31 * (1.7 - 
    (0.7 * tmpvar_31)
  )) * 6.0);
  lowp vec4 tmpvar_34;
  tmpvar_34 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_30, tmpvar_33.w);
  mediump vec4 tmpvar_35;
  tmpvar_35 = tmpvar_34;
  mediump vec3 viewDir_36;
  viewDir_36 = -(tmpvar_9);
  mediump float specularTerm_37;
  mediump vec3 tmpvar_38;
  mediump vec3 inVec_39;
  inVec_39 = (_WorldSpaceLightPos0.xyz + viewDir_36);
  tmpvar_38 = (inVec_39 * inversesqrt(max (0.001, 
    dot (inVec_39, inVec_39)
  )));
  mediump float tmpvar_40;
  tmpvar_40 = clamp (dot (tmpvar_8, tmpvar_38), 0.0, 1.0);
  mediump float tmpvar_41;
  tmpvar_41 = (tmpvar_31 * tmpvar_31);
  specularTerm_37 = ((tmpvar_41 / (
    (max (0.32, clamp (dot (_WorldSpaceLightPos0.xyz, tmpvar_38), 0.0, 1.0)) * (1.5 + tmpvar_41))
   * 
    (((tmpvar_40 * tmpvar_40) * ((tmpvar_41 * tmpvar_41) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_42;
  tmpvar_42 = clamp (specularTerm_37, 0.0, 100.0);
  specularTerm_37 = tmpvar_42;
  mediump float x_43;
  x_43 = (1.0 - clamp (dot (tmpvar_8, viewDir_36), 0.0, 1.0));
  mediump vec3 tmpvar_44;
  tmpvar_44 = (((
    ((tmpvar_5 + (tmpvar_42 * tmpvar_6)) * (tmpvar_10 * atten_25))
   * 
    clamp (dot (tmpvar_8, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (max (((1.055 * 
      pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_29)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0)) * occlusion_26)
   * tmpvar_5)) + ((
    (1.0 - ((tmpvar_41 * tmpvar_31) * 0.28))
   * 
    (((hdr_32.x * (
      (hdr_32.w * (tmpvar_35.w - 1.0))
     + 1.0)) * tmpvar_35.xyz) * occlusion_26)
  ) * mix (tmpvar_6, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_7)), 0.0, 1.0)
  ), vec3(
    ((x_43 * x_43) * (x_43 * x_43))
  ))));
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = tmpvar_44;
  c_1.w = tmpvar_45.w;
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  c_1.xyz = (tmpvar_44 + (tmpvar_46.xyz * _EmissionColor.xyz));
  mediump vec4 xlat_varoutput_47;
  xlat_varoutput_47.xyz = c_1.xyz;
  xlat_varoutput_47.w = 1.0;
  gl_FragData[0] = xlat_varoutput_47;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_EMISSION" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 normal_26;
  normal_26 = normalWorld_19;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (lengthSq_29, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_29 = tmpvar_33;
  ndotl_28 = (tmpvar_30 * normal_26.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * normal_26.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * normal_26.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(tmpvar_33)));
  ndotl_28 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (tmpvar_33 * lightAttenSq_25)
  ))));
  col_27 = (lightColor0_21 * tmpvar_35.x);
  col_27 = (col_27 + (lightColor1_22 * tmpvar_35.y));
  col_27 = (col_27 + (lightColor2_23 * tmpvar_35.z));
  col_27 = (col_27 + (lightColor3_24 * tmpvar_35.w));
  ambientOrLightmapUV_20.xyz = col_27;
  mediump vec3 x1_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_36.x = dot (unity_SHBr, tmpvar_37);
  x1_36.y = dot (unity_SHBg, tmpvar_37);
  x1_36.z = dot (unity_SHBb, tmpvar_37);
  ambientOrLightmapUV_20.xyz = ((ambientOrLightmapUV_20.xyz * (
    (ambientOrLightmapUV_20.xyz * ((ambientOrLightmapUV_20.xyz * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_36 + (unity_SHC.xyz * 
    ((normalWorld_19.x * normalWorld_19.x) - (normalWorld_19.y * normalWorld_19.y))
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 c_1;
  lowp float atten_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  mediump float tmpvar_7;
  tmpvar_7 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_5 = (tmpvar_4 * tmpvar_7);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_10;
  tmpvar_10 = _LightColor0.xyz;
  mediump float realtimeShadowAttenuation_11;
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].z;
  v_12.y = unity_MatrixV[1].z;
  v_12.z = unity_MatrixV[2].z;
  v_12.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD8 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD8), v_12.xyz), sqrt(dot (tmpvar_13, tmpvar_13)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = xlv_TEXCOORD8;
  lowp float tmpvar_17;
  highp vec4 shadowCoord_18;
  shadowCoord_18 = (unity_WorldToShadow[0] * tmpvar_16);
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, shadowCoord_18.xy).x > shadowCoord_18.z)), lightShadowDataX_19);
  tmpvar_17 = tmpvar_21;
  realtimeShadowAttenuation_11 = tmpvar_17;
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((realtimeShadowAttenuation_11 + tmpvar_14), 0.0, 1.0);
  atten_2 = tmpvar_22;
  mediump float occ_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_23 = tmpvar_24;
  mediump float atten_25;
  atten_25 = atten_2;
  mediump float occlusion_26;
  occlusion_26 = ((1.0 - _OcclusionStrength) + (occ_23 * _OcclusionStrength));
  highp vec4 tmpvar_27;
  tmpvar_27 = unity_SpecCube0_HDR;
  mediump vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_8;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, tmpvar_28);
  x_29.y = dot (unity_SHAg, tmpvar_28);
  x_29.z = dot (unity_SHAb, tmpvar_28);
  mediump vec3 tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = (1.0 - _Glossiness);
  tmpvar_30 = (tmpvar_9 - (2.0 * (
    dot (tmpvar_8, tmpvar_9)
   * tmpvar_8)));
  mediump vec4 hdr_32;
  hdr_32 = tmpvar_27;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = ((tmpvar_31 * (1.7 - 
    (0.7 * tmpvar_31)
  )) * 6.0);
  lowp vec4 tmpvar_34;
  tmpvar_34 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_30, tmpvar_33.w);
  mediump vec4 tmpvar_35;
  tmpvar_35 = tmpvar_34;
  mediump vec3 viewDir_36;
  viewDir_36 = -(tmpvar_9);
  mediump float specularTerm_37;
  mediump vec3 tmpvar_38;
  mediump vec3 inVec_39;
  inVec_39 = (_WorldSpaceLightPos0.xyz + viewDir_36);
  tmpvar_38 = (inVec_39 * inversesqrt(max (0.001, 
    dot (inVec_39, inVec_39)
  )));
  mediump float tmpvar_40;
  tmpvar_40 = clamp (dot (tmpvar_8, tmpvar_38), 0.0, 1.0);
  mediump float tmpvar_41;
  tmpvar_41 = (tmpvar_31 * tmpvar_31);
  specularTerm_37 = ((tmpvar_41 / (
    (max (0.32, clamp (dot (_WorldSpaceLightPos0.xyz, tmpvar_38), 0.0, 1.0)) * (1.5 + tmpvar_41))
   * 
    (((tmpvar_40 * tmpvar_40) * ((tmpvar_41 * tmpvar_41) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_42;
  tmpvar_42 = clamp (specularTerm_37, 0.0, 100.0);
  specularTerm_37 = tmpvar_42;
  mediump float x_43;
  x_43 = (1.0 - clamp (dot (tmpvar_8, viewDir_36), 0.0, 1.0));
  mediump vec3 tmpvar_44;
  tmpvar_44 = (((
    ((tmpvar_5 + (tmpvar_42 * tmpvar_6)) * (tmpvar_10 * atten_25))
   * 
    clamp (dot (tmpvar_8, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (max (((1.055 * 
      pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_29)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0)) * occlusion_26)
   * tmpvar_5)) + ((
    (1.0 - ((tmpvar_41 * tmpvar_31) * 0.28))
   * 
    (((hdr_32.x * (
      (hdr_32.w * (tmpvar_35.w - 1.0))
     + 1.0)) * tmpvar_35.xyz) * occlusion_26)
  ) * mix (tmpvar_6, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_7)), 0.0, 1.0)
  ), vec3(
    ((x_43 * x_43) * (x_43 * x_43))
  ))));
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = tmpvar_44;
  c_1.w = tmpvar_45.w;
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  c_1.xyz = (tmpvar_44 + (tmpvar_46.xyz * _EmissionColor.xyz));
  mediump vec4 xlat_varoutput_47;
  xlat_varoutput_47.xyz = c_1.xyz;
  xlat_varoutput_47.w = 1.0;
  gl_FragData[0] = xlat_varoutput_47;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "_EMISSION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_EMISSION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_EMISSION" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_EMISSION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_EMISSION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_EMISSION" }
""
}
}
}
 Pass {
  Name "FORWARD_DELTA"
  LOD 300
  Tags { "LIGHTMODE" = "FORWARDADD" "PerformanceChecks" = "False" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ZClip Off
  ZWrite Off
  GpuProgramID 72038
Program "vp" {
SubProgram "gles " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec3 lightDir_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  lightDir_6 = tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec3 n_16;
  n_16 = lightDir_6;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(n_16);
  tmpvar_15 = tmpvar_17;
  lightDir_6 = tmpvar_15;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_18;
  highp vec3 norm_19;
  norm_19 = tmpvar_1;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((norm_19 * tmpvar_20));
  normalWorld_4 = tmpvar_21;
  tmpvar_8.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_15;
  xlv_TEXCOORD5 = normalWorld_4;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec3 lightCoord_1;
  mediump vec3 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD3.yzw, xlv_TEXCOORD4);
  mediump vec2 tmpvar_6;
  tmpvar_6.x = ((tmpvar_5 * tmpvar_5) * (tmpvar_5 * tmpvar_5));
  tmpvar_6.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_NHxRoughness, tmpvar_6);
  c_2 = (((tmpvar_4 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_7.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic))
  )) * _LightColor0.xyz);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD1;
  lightCoord_1 = (unity_WorldToLight * tmpvar_8).xyz;
  highp float tmpvar_9;
  tmpvar_9 = dot (lightCoord_1, lightCoord_1);
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, vec2(tmpvar_9)).w;
  c_2 = (c_2 * (tmpvar_10 * clamp (
    dot (xlv_TEXCOORD5, xlv_TEXCOORD4)
  , 0.0, 1.0)));
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = c_2;
  mediump vec4 xlat_varoutput_12;
  xlat_varoutput_12.xyz = tmpvar_11.xyz;
  xlat_varoutput_12.w = 1.0;
  gl_FragData[0] = xlat_varoutput_12;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  mediump vec3 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  lightDir_4 = tmpvar_20;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec3 lightCoord_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD5;
  lightCoord_1 = (unity_WorldToLight * tmpvar_5).xyz;
  highp float tmpvar_6;
  tmpvar_6 = dot (lightCoord_1, lightCoord_1);
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_LightTexture0, vec2(tmpvar_6)).w;
  mediump vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD2.w;
  tmpvar_8.y = xlv_TEXCOORD2_1.w;
  tmpvar_8.z = xlv_TEXCOORD2_2.w;
  mediump float atten_9;
  atten_9 = tmpvar_7;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _LightColor0.xyz;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(tmpvar_8);
  tmpvar_10 = (tmpvar_10 * atten_9);
  mediump float specularTerm_12;
  mediump vec3 tmpvar_13;
  mediump vec3 inVec_14;
  inVec_14 = (tmpvar_11 - normalize(xlv_TEXCOORD1));
  tmpvar_13 = (inVec_14 * inversesqrt(max (0.001, 
    dot (inVec_14, inVec_14)
  )));
  mediump float tmpvar_15;
  tmpvar_15 = clamp (dot (tmpvar_4, tmpvar_13), 0.0, 1.0);
  mediump float tmpvar_16;
  tmpvar_16 = (1.0 - _Glossiness);
  mediump float tmpvar_17;
  tmpvar_17 = (tmpvar_16 * tmpvar_16);
  specularTerm_12 = ((tmpvar_17 / (
    (max (0.32, clamp (dot (tmpvar_11, tmpvar_13), 0.0, 1.0)) * (1.5 + tmpvar_17))
   * 
    (((tmpvar_15 * tmpvar_15) * ((tmpvar_17 * tmpvar_17) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (specularTerm_12, 0.0, 100.0);
  specularTerm_12 = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = (((
    (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)))
   + 
    (tmpvar_18 * mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic)))
  ) * tmpvar_10) * clamp (dot (tmpvar_4, tmpvar_11), 0.0, 1.0));
  mediump vec4 xlat_varoutput_20;
  xlat_varoutput_20.xyz = tmpvar_19.xyz;
  xlat_varoutput_20.w = 1.0;
  gl_FragData[0] = xlat_varoutput_20;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  mediump vec3 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  lightDir_4 = tmpvar_20;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec3 lightCoord_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD5;
  lightCoord_1 = (unity_WorldToLight * tmpvar_5).xyz;
  highp float tmpvar_6;
  tmpvar_6 = dot (lightCoord_1, lightCoord_1);
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_LightTexture0, vec2(tmpvar_6)).w;
  mediump vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD2.w;
  tmpvar_8.y = xlv_TEXCOORD2_1.w;
  tmpvar_8.z = xlv_TEXCOORD2_2.w;
  mediump float atten_9;
  atten_9 = tmpvar_7;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _LightColor0.xyz;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(tmpvar_8);
  tmpvar_10 = (tmpvar_10 * atten_9);
  mediump float specularTerm_12;
  mediump vec3 tmpvar_13;
  mediump vec3 inVec_14;
  inVec_14 = (tmpvar_11 - normalize(xlv_TEXCOORD1));
  tmpvar_13 = (inVec_14 * inversesqrt(max (0.001, 
    dot (inVec_14, inVec_14)
  )));
  mediump float tmpvar_15;
  tmpvar_15 = clamp (dot (tmpvar_4, tmpvar_13), 0.0, 1.0);
  mediump float tmpvar_16;
  tmpvar_16 = (1.0 - _Glossiness);
  mediump float tmpvar_17;
  tmpvar_17 = (tmpvar_16 * tmpvar_16);
  specularTerm_12 = ((tmpvar_17 / (
    (max (0.32, clamp (dot (tmpvar_11, tmpvar_13), 0.0, 1.0)) * (1.5 + tmpvar_17))
   * 
    (((tmpvar_15 * tmpvar_15) * ((tmpvar_17 * tmpvar_17) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (specularTerm_12, 0.0, 100.0);
  specularTerm_12 = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = (((
    (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)))
   + 
    (tmpvar_18 * mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic)))
  ) * tmpvar_10) * clamp (dot (tmpvar_4, tmpvar_11), 0.0, 1.0));
  mediump vec4 xlat_varoutput_20;
  xlat_varoutput_20.xyz = tmpvar_19.xyz;
  xlat_varoutput_20.w = 1.0;
  gl_FragData[0] = xlat_varoutput_20;
}


#endif
"
}
SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec3 lightDir_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  lightDir_6 = tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec3 n_16;
  n_16 = lightDir_6;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(n_16);
  tmpvar_15 = tmpvar_17;
  lightDir_6 = tmpvar_15;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_18;
  highp vec3 norm_19;
  norm_19 = tmpvar_1;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((norm_19 * tmpvar_20));
  normalWorld_4 = tmpvar_21;
  tmpvar_8.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_15;
  xlv_TEXCOORD5 = normalWorld_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform highp samplerCube _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float shadow_1;
  highp vec3 lightCoord_2;
  mediump vec3 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_5;
  tmpvar_5 = (_Color.xyz * tmpvar_4.xyz);
  mediump float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD3.yzw, xlv_TEXCOORD4);
  mediump vec2 tmpvar_7;
  tmpvar_7.x = ((tmpvar_6 * tmpvar_6) * (tmpvar_6 * tmpvar_6));
  tmpvar_7.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_NHxRoughness, tmpvar_7);
  c_3 = (((tmpvar_5 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_8.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_5, vec3(_Metallic))
  )) * _LightColor0.xyz);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD1;
  lightCoord_2 = (unity_WorldToLight * tmpvar_9).xyz;
  highp vec3 vec_10;
  vec_10 = (xlv_TEXCOORD1 - _LightPositionRange.xyz);
  highp vec4 shadowVals_11;
  highp float mydist_12;
  mydist_12 = ((sqrt(
    dot (vec_10, vec_10)
  ) * _LightPositionRange.w) * 0.97);
  shadowVals_11.x = dot (textureCube (_ShadowMapTexture, (vec_10 + vec3(0.0078125, 0.0078125, 0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  shadowVals_11.y = dot (textureCube (_ShadowMapTexture, (vec_10 + vec3(-0.0078125, -0.0078125, 0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  shadowVals_11.z = dot (textureCube (_ShadowMapTexture, (vec_10 + vec3(-0.0078125, 0.0078125, -0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  shadowVals_11.w = dot (textureCube (_ShadowMapTexture, (vec_10 + vec3(0.0078125, -0.0078125, -0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  bvec4 tmpvar_13;
  tmpvar_13 = lessThan (shadowVals_11, vec4(mydist_12));
  mediump vec4 tmpvar_14;
  tmpvar_14 = _LightShadowData.xxxx;
  mediump float tmpvar_15;
  if (tmpvar_13.x) {
    tmpvar_15 = tmpvar_14.x;
  } else {
    tmpvar_15 = 1.0;
  };
  mediump float tmpvar_16;
  if (tmpvar_13.y) {
    tmpvar_16 = tmpvar_14.y;
  } else {
    tmpvar_16 = 1.0;
  };
  mediump float tmpvar_17;
  if (tmpvar_13.z) {
    tmpvar_17 = tmpvar_14.z;
  } else {
    tmpvar_17 = 1.0;
  };
  mediump float tmpvar_18;
  if (tmpvar_13.w) {
    tmpvar_18 = tmpvar_14.w;
  } else {
    tmpvar_18 = 1.0;
  };
  mediump vec4 tmpvar_19;
  tmpvar_19.x = tmpvar_15;
  tmpvar_19.y = tmpvar_16;
  tmpvar_19.z = tmpvar_17;
  tmpvar_19.w = tmpvar_18;
  mediump float tmpvar_20;
  tmpvar_20 = dot (tmpvar_19, vec4(0.25, 0.25, 0.25, 0.25));
  shadow_1 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (lightCoord_2, lightCoord_2);
  lowp float tmpvar_22;
  tmpvar_22 = (texture2D (_LightTexture0, vec2(tmpvar_21)).w * shadow_1);
  c_3 = (c_3 * (tmpvar_22 * clamp (
    dot (xlv_TEXCOORD5, xlv_TEXCOORD4)
  , 0.0, 1.0)));
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = c_3;
  mediump vec4 xlat_varoutput_24;
  xlat_varoutput_24.xyz = tmpvar_23.xyz;
  xlat_varoutput_24.w = 1.0;
  gl_FragData[0] = xlat_varoutput_24;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  mediump vec3 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  lightDir_4 = tmpvar_20;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _LightPositionRange;
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float shadow_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD5;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xyz;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD5 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD5), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  highp vec3 vec_14;
  vec_14 = (xlv_TEXCOORD5 - _LightPositionRange.xyz);
  highp vec4 shadowVals_15;
  highp float mydist_16;
  mydist_16 = ((sqrt(
    dot (vec_14, vec_14)
  ) * _LightPositionRange.w) * 0.97);
  shadowVals_15.x = dot (textureCube (_ShadowMapTexture, (vec_14 + vec3(0.0078125, 0.0078125, 0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  shadowVals_15.y = dot (textureCube (_ShadowMapTexture, (vec_14 + vec3(-0.0078125, -0.0078125, 0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  shadowVals_15.z = dot (textureCube (_ShadowMapTexture, (vec_14 + vec3(-0.0078125, 0.0078125, -0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  shadowVals_15.w = dot (textureCube (_ShadowMapTexture, (vec_14 + vec3(0.0078125, -0.0078125, -0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  bvec4 tmpvar_17;
  tmpvar_17 = lessThan (shadowVals_15, vec4(mydist_16));
  mediump vec4 tmpvar_18;
  tmpvar_18 = _LightShadowData.xxxx;
  mediump float tmpvar_19;
  if (tmpvar_17.x) {
    tmpvar_19 = tmpvar_18.x;
  } else {
    tmpvar_19 = 1.0;
  };
  mediump float tmpvar_20;
  if (tmpvar_17.y) {
    tmpvar_20 = tmpvar_18.y;
  } else {
    tmpvar_20 = 1.0;
  };
  mediump float tmpvar_21;
  if (tmpvar_17.z) {
    tmpvar_21 = tmpvar_18.z;
  } else {
    tmpvar_21 = 1.0;
  };
  mediump float tmpvar_22;
  if (tmpvar_17.w) {
    tmpvar_22 = tmpvar_18.w;
  } else {
    tmpvar_22 = 1.0;
  };
  mediump vec4 tmpvar_23;
  tmpvar_23.x = tmpvar_19;
  tmpvar_23.y = tmpvar_20;
  tmpvar_23.z = tmpvar_21;
  tmpvar_23.w = tmpvar_22;
  mediump float tmpvar_24;
  tmpvar_24 = clamp ((dot (tmpvar_23, vec4(0.25, 0.25, 0.25, 0.25)) + tmpvar_12), 0.0, 1.0);
  shadow_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (tmpvar_9, tmpvar_9);
  lowp float tmpvar_26;
  tmpvar_26 = (texture2D (_LightTexture0, vec2(tmpvar_25)).w * shadow_1);
  mediump vec3 tmpvar_27;
  tmpvar_27.x = xlv_TEXCOORD2.w;
  tmpvar_27.y = xlv_TEXCOORD2_1.w;
  tmpvar_27.z = xlv_TEXCOORD2_2.w;
  mediump float atten_28;
  atten_28 = tmpvar_26;
  mediump vec3 tmpvar_29;
  tmpvar_29 = _LightColor0.xyz;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(tmpvar_27);
  tmpvar_29 = (tmpvar_29 * atten_28);
  mediump float specularTerm_31;
  mediump vec3 tmpvar_32;
  mediump vec3 inVec_33;
  inVec_33 = (tmpvar_30 - tmpvar_7);
  tmpvar_32 = (inVec_33 * inversesqrt(max (0.001, 
    dot (inVec_33, inVec_33)
  )));
  mediump float tmpvar_34;
  tmpvar_34 = clamp (dot (tmpvar_6, tmpvar_32), 0.0, 1.0);
  mediump float tmpvar_35;
  tmpvar_35 = (1.0 - _Glossiness);
  mediump float tmpvar_36;
  tmpvar_36 = (tmpvar_35 * tmpvar_35);
  specularTerm_31 = ((tmpvar_36 / (
    (max (0.32, clamp (dot (tmpvar_30, tmpvar_32), 0.0, 1.0)) * (1.5 + tmpvar_36))
   * 
    (((tmpvar_34 * tmpvar_34) * ((tmpvar_36 * tmpvar_36) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (specularTerm_31, 0.0, 100.0);
  specularTerm_31 = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = (((tmpvar_4 + 
    (tmpvar_37 * tmpvar_5)
  ) * tmpvar_29) * clamp (dot (tmpvar_6, tmpvar_30), 0.0, 1.0));
  mediump vec4 xlat_varoutput_39;
  xlat_varoutput_39.xyz = tmpvar_38.xyz;
  xlat_varoutput_39.w = 1.0;
  gl_FragData[0] = xlat_varoutput_39;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  mediump vec3 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  lightDir_4 = tmpvar_20;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _LightPositionRange;
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float shadow_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD5;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xyz;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD5 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD5), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  highp vec3 vec_14;
  vec_14 = (xlv_TEXCOORD5 - _LightPositionRange.xyz);
  highp vec4 shadowVals_15;
  highp float mydist_16;
  mydist_16 = ((sqrt(
    dot (vec_14, vec_14)
  ) * _LightPositionRange.w) * 0.97);
  shadowVals_15.x = dot (textureCube (_ShadowMapTexture, (vec_14 + vec3(0.0078125, 0.0078125, 0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  shadowVals_15.y = dot (textureCube (_ShadowMapTexture, (vec_14 + vec3(-0.0078125, -0.0078125, 0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  shadowVals_15.z = dot (textureCube (_ShadowMapTexture, (vec_14 + vec3(-0.0078125, 0.0078125, -0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  shadowVals_15.w = dot (textureCube (_ShadowMapTexture, (vec_14 + vec3(0.0078125, -0.0078125, -0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  bvec4 tmpvar_17;
  tmpvar_17 = lessThan (shadowVals_15, vec4(mydist_16));
  mediump vec4 tmpvar_18;
  tmpvar_18 = _LightShadowData.xxxx;
  mediump float tmpvar_19;
  if (tmpvar_17.x) {
    tmpvar_19 = tmpvar_18.x;
  } else {
    tmpvar_19 = 1.0;
  };
  mediump float tmpvar_20;
  if (tmpvar_17.y) {
    tmpvar_20 = tmpvar_18.y;
  } else {
    tmpvar_20 = 1.0;
  };
  mediump float tmpvar_21;
  if (tmpvar_17.z) {
    tmpvar_21 = tmpvar_18.z;
  } else {
    tmpvar_21 = 1.0;
  };
  mediump float tmpvar_22;
  if (tmpvar_17.w) {
    tmpvar_22 = tmpvar_18.w;
  } else {
    tmpvar_22 = 1.0;
  };
  mediump vec4 tmpvar_23;
  tmpvar_23.x = tmpvar_19;
  tmpvar_23.y = tmpvar_20;
  tmpvar_23.z = tmpvar_21;
  tmpvar_23.w = tmpvar_22;
  mediump float tmpvar_24;
  tmpvar_24 = clamp ((dot (tmpvar_23, vec4(0.25, 0.25, 0.25, 0.25)) + tmpvar_12), 0.0, 1.0);
  shadow_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (tmpvar_9, tmpvar_9);
  lowp float tmpvar_26;
  tmpvar_26 = (texture2D (_LightTexture0, vec2(tmpvar_25)).w * shadow_1);
  mediump vec3 tmpvar_27;
  tmpvar_27.x = xlv_TEXCOORD2.w;
  tmpvar_27.y = xlv_TEXCOORD2_1.w;
  tmpvar_27.z = xlv_TEXCOORD2_2.w;
  mediump float atten_28;
  atten_28 = tmpvar_26;
  mediump vec3 tmpvar_29;
  tmpvar_29 = _LightColor0.xyz;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(tmpvar_27);
  tmpvar_29 = (tmpvar_29 * atten_28);
  mediump float specularTerm_31;
  mediump vec3 tmpvar_32;
  mediump vec3 inVec_33;
  inVec_33 = (tmpvar_30 - tmpvar_7);
  tmpvar_32 = (inVec_33 * inversesqrt(max (0.001, 
    dot (inVec_33, inVec_33)
  )));
  mediump float tmpvar_34;
  tmpvar_34 = clamp (dot (tmpvar_6, tmpvar_32), 0.0, 1.0);
  mediump float tmpvar_35;
  tmpvar_35 = (1.0 - _Glossiness);
  mediump float tmpvar_36;
  tmpvar_36 = (tmpvar_35 * tmpvar_35);
  specularTerm_31 = ((tmpvar_36 / (
    (max (0.32, clamp (dot (tmpvar_30, tmpvar_32), 0.0, 1.0)) * (1.5 + tmpvar_36))
   * 
    (((tmpvar_34 * tmpvar_34) * ((tmpvar_36 * tmpvar_36) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (specularTerm_31, 0.0, 100.0);
  specularTerm_31 = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = (((tmpvar_4 + 
    (tmpvar_37 * tmpvar_5)
  ) * tmpvar_29) * clamp (dot (tmpvar_6, tmpvar_30), 0.0, 1.0));
  mediump vec4 xlat_varoutput_39;
  xlat_varoutput_39.xyz = tmpvar_38.xyz;
  xlat_varoutput_39.w = 1.0;
  gl_FragData[0] = xlat_varoutput_39;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec3 lightDir_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  lightDir_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  normalWorld_4 = tmpvar_18;
  tmpvar_8.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = lightDir_6;
  xlv_TEXCOORD5 = normalWorld_4;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD3.yzw, xlv_TEXCOORD4);
  mediump vec2 tmpvar_5;
  tmpvar_5.x = ((tmpvar_4 * tmpvar_4) * (tmpvar_4 * tmpvar_4));
  tmpvar_5.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (unity_NHxRoughness, tmpvar_5);
  c_1 = (((tmpvar_3 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_6.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic))
  )) * _LightColor0.xyz);
  c_1 = (c_1 * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD4), 0.0, 1.0));
  mediump vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = c_1;
  mediump vec4 xlat_varoutput_8;
  xlat_varoutput_8.xyz = tmpvar_7.xyz;
  xlat_varoutput_8.w = 1.0;
  gl_FragData[0] = xlat_varoutput_8;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 texcoord_11;
  texcoord_11.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_12;
  if ((_UVSec == 0.0)) {
    tmpvar_12 = tmpvar_2;
  } else {
    tmpvar_12 = tmpvar_3;
  };
  texcoord_11.zw = ((tmpvar_12 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_13;
  highp vec3 n_14;
  n_14 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  tmpvar_13 = n_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (_WorldSpaceLightPos0.xyz - (tmpvar_8.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_18.x;
  tmpvar_5.w = tmpvar_18.y;
  tmpvar_6.w = tmpvar_18.z;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = texcoord_11;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_8.xyz;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * tmpvar_1.xyz);
  mediump vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4.x = xlv_TEXCOORD2.w;
  tmpvar_4.y = xlv_TEXCOORD2_1.w;
  tmpvar_4.z = xlv_TEXCOORD2_2.w;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _LightColor0.xyz;
  mediump float specularTerm_6;
  mediump vec3 tmpvar_7;
  mediump vec3 inVec_8;
  inVec_8 = (tmpvar_4 - normalize(xlv_TEXCOORD1));
  tmpvar_7 = (inVec_8 * inversesqrt(max (0.001, 
    dot (inVec_8, inVec_8)
  )));
  mediump float tmpvar_9;
  tmpvar_9 = clamp (dot (tmpvar_3, tmpvar_7), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = (1.0 - _Glossiness);
  mediump float tmpvar_11;
  tmpvar_11 = (tmpvar_10 * tmpvar_10);
  specularTerm_6 = ((tmpvar_11 / (
    (max (0.32, clamp (dot (tmpvar_4, tmpvar_7), 0.0, 1.0)) * (1.5 + tmpvar_11))
   * 
    (((tmpvar_9 * tmpvar_9) * ((tmpvar_11 * tmpvar_11) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (specularTerm_6, 0.0, 100.0);
  specularTerm_6 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = (((
    (tmpvar_2 * (0.7790837 - (_Metallic * 0.7790837)))
   + 
    (tmpvar_12 * mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_2, vec3(_Metallic)))
  ) * tmpvar_5) * clamp (dot (tmpvar_3, tmpvar_4), 0.0, 1.0));
  mediump vec4 xlat_varoutput_14;
  xlat_varoutput_14.xyz = tmpvar_13.xyz;
  xlat_varoutput_14.w = 1.0;
  gl_FragData[0] = xlat_varoutput_14;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 texcoord_11;
  texcoord_11.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_12;
  if ((_UVSec == 0.0)) {
    tmpvar_12 = tmpvar_2;
  } else {
    tmpvar_12 = tmpvar_3;
  };
  texcoord_11.zw = ((tmpvar_12 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_13;
  highp vec3 n_14;
  n_14 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  tmpvar_13 = n_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (_WorldSpaceLightPos0.xyz - (tmpvar_8.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_18.x;
  tmpvar_5.w = tmpvar_18.y;
  tmpvar_6.w = tmpvar_18.z;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = texcoord_11;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_8.xyz;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * tmpvar_1.xyz);
  mediump vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4.x = xlv_TEXCOORD2.w;
  tmpvar_4.y = xlv_TEXCOORD2_1.w;
  tmpvar_4.z = xlv_TEXCOORD2_2.w;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _LightColor0.xyz;
  mediump float specularTerm_6;
  mediump vec3 tmpvar_7;
  mediump vec3 inVec_8;
  inVec_8 = (tmpvar_4 - normalize(xlv_TEXCOORD1));
  tmpvar_7 = (inVec_8 * inversesqrt(max (0.001, 
    dot (inVec_8, inVec_8)
  )));
  mediump float tmpvar_9;
  tmpvar_9 = clamp (dot (tmpvar_3, tmpvar_7), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = (1.0 - _Glossiness);
  mediump float tmpvar_11;
  tmpvar_11 = (tmpvar_10 * tmpvar_10);
  specularTerm_6 = ((tmpvar_11 / (
    (max (0.32, clamp (dot (tmpvar_4, tmpvar_7), 0.0, 1.0)) * (1.5 + tmpvar_11))
   * 
    (((tmpvar_9 * tmpvar_9) * ((tmpvar_11 * tmpvar_11) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (specularTerm_6, 0.0, 100.0);
  specularTerm_6 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = (((
    (tmpvar_2 * (0.7790837 - (_Metallic * 0.7790837)))
   + 
    (tmpvar_12 * mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_2, vec3(_Metallic)))
  ) * tmpvar_5) * clamp (dot (tmpvar_3, tmpvar_4), 0.0, 1.0));
  mediump vec4 xlat_varoutput_14;
  xlat_varoutput_14.xyz = tmpvar_13.xyz;
  xlat_varoutput_14.w = 1.0;
  gl_FragData[0] = xlat_varoutput_14;
}


#endif
"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec3 lightDir_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  lightDir_6 = tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec3 n_16;
  n_16 = lightDir_6;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(n_16);
  tmpvar_15 = tmpvar_17;
  lightDir_6 = tmpvar_15;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_18;
  highp vec3 norm_19;
  norm_19 = tmpvar_1;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((norm_19 * tmpvar_20));
  normalWorld_4 = tmpvar_21;
  tmpvar_8.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_15;
  xlv_TEXCOORD5 = normalWorld_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform highp samplerCube _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float shadow_1;
  highp vec3 lightCoord_2;
  mediump vec3 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_5;
  tmpvar_5 = (_Color.xyz * tmpvar_4.xyz);
  mediump float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD3.yzw, xlv_TEXCOORD4);
  mediump vec2 tmpvar_7;
  tmpvar_7.x = ((tmpvar_6 * tmpvar_6) * (tmpvar_6 * tmpvar_6));
  tmpvar_7.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_NHxRoughness, tmpvar_7);
  c_3 = (((tmpvar_5 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_8.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_5, vec3(_Metallic))
  )) * _LightColor0.xyz);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD1;
  lightCoord_2 = (unity_WorldToLight * tmpvar_9).xyz;
  highp vec3 vec_10;
  vec_10 = (xlv_TEXCOORD1 - _LightPositionRange.xyz);
  highp float mydist_11;
  mydist_11 = ((sqrt(
    dot (vec_10, vec_10)
  ) * _LightPositionRange.w) * 0.97);
  highp float tmpvar_12;
  tmpvar_12 = dot (textureCube (_ShadowMapTexture, vec_10), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  mediump float tmpvar_13;
  if ((tmpvar_12 < mydist_11)) {
    tmpvar_13 = _LightShadowData.x;
  } else {
    tmpvar_13 = 1.0;
  };
  shadow_1 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (lightCoord_2, lightCoord_2);
  lowp float tmpvar_15;
  tmpvar_15 = ((texture2D (_LightTextureB0, vec2(tmpvar_14)).w * textureCube (_LightTexture0, lightCoord_2).w) * shadow_1);
  c_3 = (c_3 * (tmpvar_15 * clamp (
    dot (xlv_TEXCOORD5, xlv_TEXCOORD4)
  , 0.0, 1.0)));
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = c_3;
  mediump vec4 xlat_varoutput_17;
  xlat_varoutput_17.xyz = tmpvar_16.xyz;
  xlat_varoutput_17.w = 1.0;
  gl_FragData[0] = xlat_varoutput_17;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  mediump vec3 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  lightDir_4 = tmpvar_20;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _LightPositionRange;
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float shadow_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD5;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xyz;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD5 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD5), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  highp vec3 vec_14;
  vec_14 = (xlv_TEXCOORD5 - _LightPositionRange.xyz);
  highp float mydist_15;
  mydist_15 = ((sqrt(
    dot (vec_14, vec_14)
  ) * _LightPositionRange.w) * 0.97);
  highp float tmpvar_16;
  tmpvar_16 = dot (textureCube (_ShadowMapTexture, vec_14), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  mediump float tmpvar_17;
  if ((tmpvar_16 < mydist_15)) {
    tmpvar_17 = _LightShadowData.x;
  } else {
    tmpvar_17 = 1.0;
  };
  mediump float tmpvar_18;
  tmpvar_18 = clamp ((tmpvar_17 + tmpvar_12), 0.0, 1.0);
  shadow_1 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_9, tmpvar_9);
  lowp float tmpvar_20;
  tmpvar_20 = ((texture2D (_LightTextureB0, vec2(tmpvar_19)).w * textureCube (_LightTexture0, tmpvar_9).w) * shadow_1);
  mediump vec3 tmpvar_21;
  tmpvar_21.x = xlv_TEXCOORD2.w;
  tmpvar_21.y = xlv_TEXCOORD2_1.w;
  tmpvar_21.z = xlv_TEXCOORD2_2.w;
  mediump float atten_22;
  atten_22 = tmpvar_20;
  mediump vec3 tmpvar_23;
  tmpvar_23 = _LightColor0.xyz;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(tmpvar_21);
  tmpvar_23 = (tmpvar_23 * atten_22);
  mediump float specularTerm_25;
  mediump vec3 tmpvar_26;
  mediump vec3 inVec_27;
  inVec_27 = (tmpvar_24 - tmpvar_7);
  tmpvar_26 = (inVec_27 * inversesqrt(max (0.001, 
    dot (inVec_27, inVec_27)
  )));
  mediump float tmpvar_28;
  tmpvar_28 = clamp (dot (tmpvar_6, tmpvar_26), 0.0, 1.0);
  mediump float tmpvar_29;
  tmpvar_29 = (1.0 - _Glossiness);
  mediump float tmpvar_30;
  tmpvar_30 = (tmpvar_29 * tmpvar_29);
  specularTerm_25 = ((tmpvar_30 / (
    (max (0.32, clamp (dot (tmpvar_24, tmpvar_26), 0.0, 1.0)) * (1.5 + tmpvar_30))
   * 
    (((tmpvar_28 * tmpvar_28) * ((tmpvar_30 * tmpvar_30) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_31;
  tmpvar_31 = clamp (specularTerm_25, 0.0, 100.0);
  specularTerm_25 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = (((tmpvar_4 + 
    (tmpvar_31 * tmpvar_5)
  ) * tmpvar_23) * clamp (dot (tmpvar_6, tmpvar_24), 0.0, 1.0));
  mediump vec4 xlat_varoutput_33;
  xlat_varoutput_33.xyz = tmpvar_32.xyz;
  xlat_varoutput_33.w = 1.0;
  gl_FragData[0] = xlat_varoutput_33;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  mediump vec3 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  lightDir_4 = tmpvar_20;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _LightPositionRange;
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float shadow_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD5;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xyz;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD5 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD5), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  highp vec3 vec_14;
  vec_14 = (xlv_TEXCOORD5 - _LightPositionRange.xyz);
  highp float mydist_15;
  mydist_15 = ((sqrt(
    dot (vec_14, vec_14)
  ) * _LightPositionRange.w) * 0.97);
  highp float tmpvar_16;
  tmpvar_16 = dot (textureCube (_ShadowMapTexture, vec_14), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  mediump float tmpvar_17;
  if ((tmpvar_16 < mydist_15)) {
    tmpvar_17 = _LightShadowData.x;
  } else {
    tmpvar_17 = 1.0;
  };
  mediump float tmpvar_18;
  tmpvar_18 = clamp ((tmpvar_17 + tmpvar_12), 0.0, 1.0);
  shadow_1 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_9, tmpvar_9);
  lowp float tmpvar_20;
  tmpvar_20 = ((texture2D (_LightTextureB0, vec2(tmpvar_19)).w * textureCube (_LightTexture0, tmpvar_9).w) * shadow_1);
  mediump vec3 tmpvar_21;
  tmpvar_21.x = xlv_TEXCOORD2.w;
  tmpvar_21.y = xlv_TEXCOORD2_1.w;
  tmpvar_21.z = xlv_TEXCOORD2_2.w;
  mediump float atten_22;
  atten_22 = tmpvar_20;
  mediump vec3 tmpvar_23;
  tmpvar_23 = _LightColor0.xyz;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(tmpvar_21);
  tmpvar_23 = (tmpvar_23 * atten_22);
  mediump float specularTerm_25;
  mediump vec3 tmpvar_26;
  mediump vec3 inVec_27;
  inVec_27 = (tmpvar_24 - tmpvar_7);
  tmpvar_26 = (inVec_27 * inversesqrt(max (0.001, 
    dot (inVec_27, inVec_27)
  )));
  mediump float tmpvar_28;
  tmpvar_28 = clamp (dot (tmpvar_6, tmpvar_26), 0.0, 1.0);
  mediump float tmpvar_29;
  tmpvar_29 = (1.0 - _Glossiness);
  mediump float tmpvar_30;
  tmpvar_30 = (tmpvar_29 * tmpvar_29);
  specularTerm_25 = ((tmpvar_30 / (
    (max (0.32, clamp (dot (tmpvar_24, tmpvar_26), 0.0, 1.0)) * (1.5 + tmpvar_30))
   * 
    (((tmpvar_28 * tmpvar_28) * ((tmpvar_30 * tmpvar_30) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_31;
  tmpvar_31 = clamp (specularTerm_25, 0.0, 100.0);
  specularTerm_25 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = (((tmpvar_4 + 
    (tmpvar_31 * tmpvar_5)
  ) * tmpvar_23) * clamp (dot (tmpvar_6, tmpvar_24), 0.0, 1.0));
  mediump vec4 xlat_varoutput_33;
  xlat_varoutput_33.xyz = tmpvar_32.xyz;
  xlat_varoutput_33.w = 1.0;
  gl_FragData[0] = xlat_varoutput_33;
}


#endif
"
}
SubProgram "gles " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec3 lightDir_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  lightDir_6 = tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec3 n_16;
  n_16 = lightDir_6;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(n_16);
  tmpvar_15 = tmpvar_17;
  lightDir_6 = tmpvar_15;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_18;
  highp vec3 norm_19;
  norm_19 = tmpvar_1;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((norm_19 * tmpvar_20));
  normalWorld_4 = tmpvar_21;
  tmpvar_8.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_15;
  xlv_TEXCOORD5 = normalWorld_4;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float atten_1;
  highp vec4 lightCoord_2;
  mediump vec3 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_5;
  tmpvar_5 = (_Color.xyz * tmpvar_4.xyz);
  mediump float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD3.yzw, xlv_TEXCOORD4);
  mediump vec2 tmpvar_7;
  tmpvar_7.x = ((tmpvar_6 * tmpvar_6) * (tmpvar_6 * tmpvar_6));
  tmpvar_7.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_NHxRoughness, tmpvar_7);
  c_3 = (((tmpvar_5 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_8.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_5, vec3(_Metallic))
  )) * _LightColor0.xyz);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD1;
  lightCoord_2 = (unity_WorldToLight * tmpvar_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((lightCoord_2.xy / lightCoord_2.w) + 0.5);
  tmpvar_10 = texture2D (_LightTexture0, P_11);
  highp float tmpvar_12;
  tmpvar_12 = dot (lightCoord_2.xyz, lightCoord_2.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightTextureB0, vec2(tmpvar_12));
  highp float tmpvar_14;
  tmpvar_14 = ((float(
    (lightCoord_2.z > 0.0)
  ) * tmpvar_10.w) * tmpvar_13.w);
  atten_1 = tmpvar_14;
  c_3 = (c_3 * (atten_1 * clamp (
    dot (xlv_TEXCOORD5, xlv_TEXCOORD4)
  , 0.0, 1.0)));
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = c_3;
  mediump vec4 xlat_varoutput_16;
  xlat_varoutput_16.xyz = tmpvar_15.xyz;
  xlat_varoutput_16.w = 1.0;
  gl_FragData[0] = xlat_varoutput_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  mediump vec3 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  lightDir_4 = tmpvar_20;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float atten_1;
  highp vec4 lightCoord_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = xlv_TEXCOORD5;
  lightCoord_2 = (unity_WorldToLight * tmpvar_6);
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((lightCoord_2.xy / lightCoord_2.w) + 0.5);
  tmpvar_7 = texture2D (_LightTexture0, P_8);
  highp float tmpvar_9;
  tmpvar_9 = dot (lightCoord_2.xyz, lightCoord_2.xyz);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightTextureB0, vec2(tmpvar_9));
  highp float tmpvar_11;
  tmpvar_11 = ((float(
    (lightCoord_2.z > 0.0)
  ) * tmpvar_7.w) * tmpvar_10.w);
  atten_1 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12.x = xlv_TEXCOORD2.w;
  tmpvar_12.y = xlv_TEXCOORD2_1.w;
  tmpvar_12.z = xlv_TEXCOORD2_2.w;
  mediump float atten_13;
  atten_13 = atten_1;
  mediump vec3 tmpvar_14;
  tmpvar_14 = _LightColor0.xyz;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(tmpvar_12);
  tmpvar_14 = (tmpvar_14 * atten_13);
  mediump float specularTerm_16;
  mediump vec3 tmpvar_17;
  mediump vec3 inVec_18;
  inVec_18 = (tmpvar_15 - normalize(xlv_TEXCOORD1));
  tmpvar_17 = (inVec_18 * inversesqrt(max (0.001, 
    dot (inVec_18, inVec_18)
  )));
  mediump float tmpvar_19;
  tmpvar_19 = clamp (dot (tmpvar_5, tmpvar_17), 0.0, 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = (1.0 - _Glossiness);
  mediump float tmpvar_21;
  tmpvar_21 = (tmpvar_20 * tmpvar_20);
  specularTerm_16 = ((tmpvar_21 / (
    (max (0.32, clamp (dot (tmpvar_15, tmpvar_17), 0.0, 1.0)) * (1.5 + tmpvar_21))
   * 
    (((tmpvar_19 * tmpvar_19) * ((tmpvar_21 * tmpvar_21) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_22;
  tmpvar_22 = clamp (specularTerm_16, 0.0, 100.0);
  specularTerm_16 = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = (((
    (tmpvar_4 * (0.7790837 - (_Metallic * 0.7790837)))
   + 
    (tmpvar_22 * mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic)))
  ) * tmpvar_14) * clamp (dot (tmpvar_5, tmpvar_15), 0.0, 1.0));
  mediump vec4 xlat_varoutput_24;
  xlat_varoutput_24.xyz = tmpvar_23.xyz;
  xlat_varoutput_24.w = 1.0;
  gl_FragData[0] = xlat_varoutput_24;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  mediump vec3 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  lightDir_4 = tmpvar_20;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float atten_1;
  highp vec4 lightCoord_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = xlv_TEXCOORD5;
  lightCoord_2 = (unity_WorldToLight * tmpvar_6);
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((lightCoord_2.xy / lightCoord_2.w) + 0.5);
  tmpvar_7 = texture2D (_LightTexture0, P_8);
  highp float tmpvar_9;
  tmpvar_9 = dot (lightCoord_2.xyz, lightCoord_2.xyz);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightTextureB0, vec2(tmpvar_9));
  highp float tmpvar_11;
  tmpvar_11 = ((float(
    (lightCoord_2.z > 0.0)
  ) * tmpvar_7.w) * tmpvar_10.w);
  atten_1 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12.x = xlv_TEXCOORD2.w;
  tmpvar_12.y = xlv_TEXCOORD2_1.w;
  tmpvar_12.z = xlv_TEXCOORD2_2.w;
  mediump float atten_13;
  atten_13 = atten_1;
  mediump vec3 tmpvar_14;
  tmpvar_14 = _LightColor0.xyz;
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(tmpvar_12);
  tmpvar_14 = (tmpvar_14 * atten_13);
  mediump float specularTerm_16;
  mediump vec3 tmpvar_17;
  mediump vec3 inVec_18;
  inVec_18 = (tmpvar_15 - normalize(xlv_TEXCOORD1));
  tmpvar_17 = (inVec_18 * inversesqrt(max (0.001, 
    dot (inVec_18, inVec_18)
  )));
  mediump float tmpvar_19;
  tmpvar_19 = clamp (dot (tmpvar_5, tmpvar_17), 0.0, 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = (1.0 - _Glossiness);
  mediump float tmpvar_21;
  tmpvar_21 = (tmpvar_20 * tmpvar_20);
  specularTerm_16 = ((tmpvar_21 / (
    (max (0.32, clamp (dot (tmpvar_15, tmpvar_17), 0.0, 1.0)) * (1.5 + tmpvar_21))
   * 
    (((tmpvar_19 * tmpvar_19) * ((tmpvar_21 * tmpvar_21) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_22;
  tmpvar_22 = clamp (specularTerm_16, 0.0, 100.0);
  specularTerm_16 = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = (((
    (tmpvar_4 * (0.7790837 - (_Metallic * 0.7790837)))
   + 
    (tmpvar_22 * mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic)))
  ) * tmpvar_14) * clamp (dot (tmpvar_5, tmpvar_15), 0.0, 1.0));
  mediump vec4 xlat_varoutput_24;
  xlat_varoutput_24.xyz = tmpvar_23.xyz;
  xlat_varoutput_24.w = 1.0;
  gl_FragData[0] = xlat_varoutput_24;
}


#endif
"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec3 lightDir_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  lightDir_6 = tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec3 n_16;
  n_16 = lightDir_6;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(n_16);
  tmpvar_15 = tmpvar_17;
  lightDir_6 = tmpvar_15;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_18;
  highp vec3 norm_19;
  norm_19 = tmpvar_1;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((norm_19 * tmpvar_20));
  normalWorld_4 = tmpvar_21;
  tmpvar_8.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_15;
  xlv_TEXCOORD5 = normalWorld_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform highp samplerCube _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float shadow_1;
  highp vec3 lightCoord_2;
  mediump vec3 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_5;
  tmpvar_5 = (_Color.xyz * tmpvar_4.xyz);
  mediump float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD3.yzw, xlv_TEXCOORD4);
  mediump vec2 tmpvar_7;
  tmpvar_7.x = ((tmpvar_6 * tmpvar_6) * (tmpvar_6 * tmpvar_6));
  tmpvar_7.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_NHxRoughness, tmpvar_7);
  c_3 = (((tmpvar_5 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_8.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_5, vec3(_Metallic))
  )) * _LightColor0.xyz);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD1;
  lightCoord_2 = (unity_WorldToLight * tmpvar_9).xyz;
  highp vec3 vec_10;
  vec_10 = (xlv_TEXCOORD1 - _LightPositionRange.xyz);
  highp vec4 shadowVals_11;
  highp float mydist_12;
  mydist_12 = ((sqrt(
    dot (vec_10, vec_10)
  ) * _LightPositionRange.w) * 0.97);
  shadowVals_11.x = dot (textureCube (_ShadowMapTexture, (vec_10 + vec3(0.0078125, 0.0078125, 0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  shadowVals_11.y = dot (textureCube (_ShadowMapTexture, (vec_10 + vec3(-0.0078125, -0.0078125, 0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  shadowVals_11.z = dot (textureCube (_ShadowMapTexture, (vec_10 + vec3(-0.0078125, 0.0078125, -0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  shadowVals_11.w = dot (textureCube (_ShadowMapTexture, (vec_10 + vec3(0.0078125, -0.0078125, -0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  bvec4 tmpvar_13;
  tmpvar_13 = lessThan (shadowVals_11, vec4(mydist_12));
  mediump vec4 tmpvar_14;
  tmpvar_14 = _LightShadowData.xxxx;
  mediump float tmpvar_15;
  if (tmpvar_13.x) {
    tmpvar_15 = tmpvar_14.x;
  } else {
    tmpvar_15 = 1.0;
  };
  mediump float tmpvar_16;
  if (tmpvar_13.y) {
    tmpvar_16 = tmpvar_14.y;
  } else {
    tmpvar_16 = 1.0;
  };
  mediump float tmpvar_17;
  if (tmpvar_13.z) {
    tmpvar_17 = tmpvar_14.z;
  } else {
    tmpvar_17 = 1.0;
  };
  mediump float tmpvar_18;
  if (tmpvar_13.w) {
    tmpvar_18 = tmpvar_14.w;
  } else {
    tmpvar_18 = 1.0;
  };
  mediump vec4 tmpvar_19;
  tmpvar_19.x = tmpvar_15;
  tmpvar_19.y = tmpvar_16;
  tmpvar_19.z = tmpvar_17;
  tmpvar_19.w = tmpvar_18;
  mediump float tmpvar_20;
  tmpvar_20 = dot (tmpvar_19, vec4(0.25, 0.25, 0.25, 0.25));
  shadow_1 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (lightCoord_2, lightCoord_2);
  lowp float tmpvar_22;
  tmpvar_22 = ((texture2D (_LightTextureB0, vec2(tmpvar_21)).w * textureCube (_LightTexture0, lightCoord_2).w) * shadow_1);
  c_3 = (c_3 * (tmpvar_22 * clamp (
    dot (xlv_TEXCOORD5, xlv_TEXCOORD4)
  , 0.0, 1.0)));
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = c_3;
  mediump vec4 xlat_varoutput_24;
  xlat_varoutput_24.xyz = tmpvar_23.xyz;
  xlat_varoutput_24.w = 1.0;
  gl_FragData[0] = xlat_varoutput_24;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  mediump vec3 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  lightDir_4 = tmpvar_20;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _LightPositionRange;
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float shadow_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD5;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xyz;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD5 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD5), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  highp vec3 vec_14;
  vec_14 = (xlv_TEXCOORD5 - _LightPositionRange.xyz);
  highp vec4 shadowVals_15;
  highp float mydist_16;
  mydist_16 = ((sqrt(
    dot (vec_14, vec_14)
  ) * _LightPositionRange.w) * 0.97);
  shadowVals_15.x = dot (textureCube (_ShadowMapTexture, (vec_14 + vec3(0.0078125, 0.0078125, 0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  shadowVals_15.y = dot (textureCube (_ShadowMapTexture, (vec_14 + vec3(-0.0078125, -0.0078125, 0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  shadowVals_15.z = dot (textureCube (_ShadowMapTexture, (vec_14 + vec3(-0.0078125, 0.0078125, -0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  shadowVals_15.w = dot (textureCube (_ShadowMapTexture, (vec_14 + vec3(0.0078125, -0.0078125, -0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  bvec4 tmpvar_17;
  tmpvar_17 = lessThan (shadowVals_15, vec4(mydist_16));
  mediump vec4 tmpvar_18;
  tmpvar_18 = _LightShadowData.xxxx;
  mediump float tmpvar_19;
  if (tmpvar_17.x) {
    tmpvar_19 = tmpvar_18.x;
  } else {
    tmpvar_19 = 1.0;
  };
  mediump float tmpvar_20;
  if (tmpvar_17.y) {
    tmpvar_20 = tmpvar_18.y;
  } else {
    tmpvar_20 = 1.0;
  };
  mediump float tmpvar_21;
  if (tmpvar_17.z) {
    tmpvar_21 = tmpvar_18.z;
  } else {
    tmpvar_21 = 1.0;
  };
  mediump float tmpvar_22;
  if (tmpvar_17.w) {
    tmpvar_22 = tmpvar_18.w;
  } else {
    tmpvar_22 = 1.0;
  };
  mediump vec4 tmpvar_23;
  tmpvar_23.x = tmpvar_19;
  tmpvar_23.y = tmpvar_20;
  tmpvar_23.z = tmpvar_21;
  tmpvar_23.w = tmpvar_22;
  mediump float tmpvar_24;
  tmpvar_24 = clamp ((dot (tmpvar_23, vec4(0.25, 0.25, 0.25, 0.25)) + tmpvar_12), 0.0, 1.0);
  shadow_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (tmpvar_9, tmpvar_9);
  lowp float tmpvar_26;
  tmpvar_26 = ((texture2D (_LightTextureB0, vec2(tmpvar_25)).w * textureCube (_LightTexture0, tmpvar_9).w) * shadow_1);
  mediump vec3 tmpvar_27;
  tmpvar_27.x = xlv_TEXCOORD2.w;
  tmpvar_27.y = xlv_TEXCOORD2_1.w;
  tmpvar_27.z = xlv_TEXCOORD2_2.w;
  mediump float atten_28;
  atten_28 = tmpvar_26;
  mediump vec3 tmpvar_29;
  tmpvar_29 = _LightColor0.xyz;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(tmpvar_27);
  tmpvar_29 = (tmpvar_29 * atten_28);
  mediump float specularTerm_31;
  mediump vec3 tmpvar_32;
  mediump vec3 inVec_33;
  inVec_33 = (tmpvar_30 - tmpvar_7);
  tmpvar_32 = (inVec_33 * inversesqrt(max (0.001, 
    dot (inVec_33, inVec_33)
  )));
  mediump float tmpvar_34;
  tmpvar_34 = clamp (dot (tmpvar_6, tmpvar_32), 0.0, 1.0);
  mediump float tmpvar_35;
  tmpvar_35 = (1.0 - _Glossiness);
  mediump float tmpvar_36;
  tmpvar_36 = (tmpvar_35 * tmpvar_35);
  specularTerm_31 = ((tmpvar_36 / (
    (max (0.32, clamp (dot (tmpvar_30, tmpvar_32), 0.0, 1.0)) * (1.5 + tmpvar_36))
   * 
    (((tmpvar_34 * tmpvar_34) * ((tmpvar_36 * tmpvar_36) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (specularTerm_31, 0.0, 100.0);
  specularTerm_31 = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = (((tmpvar_4 + 
    (tmpvar_37 * tmpvar_5)
  ) * tmpvar_29) * clamp (dot (tmpvar_6, tmpvar_30), 0.0, 1.0));
  mediump vec4 xlat_varoutput_39;
  xlat_varoutput_39.xyz = tmpvar_38.xyz;
  xlat_varoutput_39.w = 1.0;
  gl_FragData[0] = xlat_varoutput_39;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  mediump vec3 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  lightDir_4 = tmpvar_20;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _LightPositionRange;
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float shadow_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD5;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xyz;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD5 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD5), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  highp vec3 vec_14;
  vec_14 = (xlv_TEXCOORD5 - _LightPositionRange.xyz);
  highp vec4 shadowVals_15;
  highp float mydist_16;
  mydist_16 = ((sqrt(
    dot (vec_14, vec_14)
  ) * _LightPositionRange.w) * 0.97);
  shadowVals_15.x = dot (textureCube (_ShadowMapTexture, (vec_14 + vec3(0.0078125, 0.0078125, 0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  shadowVals_15.y = dot (textureCube (_ShadowMapTexture, (vec_14 + vec3(-0.0078125, -0.0078125, 0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  shadowVals_15.z = dot (textureCube (_ShadowMapTexture, (vec_14 + vec3(-0.0078125, 0.0078125, -0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  shadowVals_15.w = dot (textureCube (_ShadowMapTexture, (vec_14 + vec3(0.0078125, -0.0078125, -0.0078125))), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  bvec4 tmpvar_17;
  tmpvar_17 = lessThan (shadowVals_15, vec4(mydist_16));
  mediump vec4 tmpvar_18;
  tmpvar_18 = _LightShadowData.xxxx;
  mediump float tmpvar_19;
  if (tmpvar_17.x) {
    tmpvar_19 = tmpvar_18.x;
  } else {
    tmpvar_19 = 1.0;
  };
  mediump float tmpvar_20;
  if (tmpvar_17.y) {
    tmpvar_20 = tmpvar_18.y;
  } else {
    tmpvar_20 = 1.0;
  };
  mediump float tmpvar_21;
  if (tmpvar_17.z) {
    tmpvar_21 = tmpvar_18.z;
  } else {
    tmpvar_21 = 1.0;
  };
  mediump float tmpvar_22;
  if (tmpvar_17.w) {
    tmpvar_22 = tmpvar_18.w;
  } else {
    tmpvar_22 = 1.0;
  };
  mediump vec4 tmpvar_23;
  tmpvar_23.x = tmpvar_19;
  tmpvar_23.y = tmpvar_20;
  tmpvar_23.z = tmpvar_21;
  tmpvar_23.w = tmpvar_22;
  mediump float tmpvar_24;
  tmpvar_24 = clamp ((dot (tmpvar_23, vec4(0.25, 0.25, 0.25, 0.25)) + tmpvar_12), 0.0, 1.0);
  shadow_1 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (tmpvar_9, tmpvar_9);
  lowp float tmpvar_26;
  tmpvar_26 = ((texture2D (_LightTextureB0, vec2(tmpvar_25)).w * textureCube (_LightTexture0, tmpvar_9).w) * shadow_1);
  mediump vec3 tmpvar_27;
  tmpvar_27.x = xlv_TEXCOORD2.w;
  tmpvar_27.y = xlv_TEXCOORD2_1.w;
  tmpvar_27.z = xlv_TEXCOORD2_2.w;
  mediump float atten_28;
  atten_28 = tmpvar_26;
  mediump vec3 tmpvar_29;
  tmpvar_29 = _LightColor0.xyz;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(tmpvar_27);
  tmpvar_29 = (tmpvar_29 * atten_28);
  mediump float specularTerm_31;
  mediump vec3 tmpvar_32;
  mediump vec3 inVec_33;
  inVec_33 = (tmpvar_30 - tmpvar_7);
  tmpvar_32 = (inVec_33 * inversesqrt(max (0.001, 
    dot (inVec_33, inVec_33)
  )));
  mediump float tmpvar_34;
  tmpvar_34 = clamp (dot (tmpvar_6, tmpvar_32), 0.0, 1.0);
  mediump float tmpvar_35;
  tmpvar_35 = (1.0 - _Glossiness);
  mediump float tmpvar_36;
  tmpvar_36 = (tmpvar_35 * tmpvar_35);
  specularTerm_31 = ((tmpvar_36 / (
    (max (0.32, clamp (dot (tmpvar_30, tmpvar_32), 0.0, 1.0)) * (1.5 + tmpvar_36))
   * 
    (((tmpvar_34 * tmpvar_34) * ((tmpvar_36 * tmpvar_36) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (specularTerm_31, 0.0, 100.0);
  specularTerm_31 = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = (((tmpvar_4 + 
    (tmpvar_37 * tmpvar_5)
  ) * tmpvar_29) * clamp (dot (tmpvar_6, tmpvar_30), 0.0, 1.0));
  mediump vec4 xlat_varoutput_39;
  xlat_varoutput_39.xyz = tmpvar_38.xyz;
  xlat_varoutput_39.w = 1.0;
  gl_FragData[0] = xlat_varoutput_39;
}


#endif
"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec3 lightDir_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  lightDir_6 = tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec3 n_16;
  n_16 = lightDir_6;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(n_16);
  tmpvar_15 = tmpvar_17;
  lightDir_6 = tmpvar_15;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_18;
  highp vec3 norm_19;
  norm_19 = tmpvar_1;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((norm_19 * tmpvar_20));
  normalWorld_4 = tmpvar_21;
  tmpvar_8.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_15;
  xlv_TEXCOORD5 = normalWorld_4;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec3 lightCoord_1;
  mediump vec3 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD3.yzw, xlv_TEXCOORD4);
  mediump vec2 tmpvar_6;
  tmpvar_6.x = ((tmpvar_5 * tmpvar_5) * (tmpvar_5 * tmpvar_5));
  tmpvar_6.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_NHxRoughness, tmpvar_6);
  c_2 = (((tmpvar_4 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_7.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic))
  )) * _LightColor0.xyz);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD1;
  lightCoord_1 = (unity_WorldToLight * tmpvar_8).xyz;
  highp float tmpvar_9;
  tmpvar_9 = dot (lightCoord_1, lightCoord_1);
  lowp float tmpvar_10;
  tmpvar_10 = (texture2D (_LightTextureB0, vec2(tmpvar_9)).w * textureCube (_LightTexture0, lightCoord_1).w);
  c_2 = (c_2 * (tmpvar_10 * clamp (
    dot (xlv_TEXCOORD5, xlv_TEXCOORD4)
  , 0.0, 1.0)));
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = c_2;
  mediump vec4 xlat_varoutput_12;
  xlat_varoutput_12.xyz = tmpvar_11.xyz;
  xlat_varoutput_12.w = 1.0;
  gl_FragData[0] = xlat_varoutput_12;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  mediump vec3 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  lightDir_4 = tmpvar_20;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec3 lightCoord_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD5;
  lightCoord_1 = (unity_WorldToLight * tmpvar_5).xyz;
  highp float tmpvar_6;
  tmpvar_6 = dot (lightCoord_1, lightCoord_1);
  lowp float tmpvar_7;
  tmpvar_7 = (texture2D (_LightTextureB0, vec2(tmpvar_6)).w * textureCube (_LightTexture0, lightCoord_1).w);
  mediump vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD2.w;
  tmpvar_8.y = xlv_TEXCOORD2_1.w;
  tmpvar_8.z = xlv_TEXCOORD2_2.w;
  mediump float atten_9;
  atten_9 = tmpvar_7;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _LightColor0.xyz;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(tmpvar_8);
  tmpvar_10 = (tmpvar_10 * atten_9);
  mediump float specularTerm_12;
  mediump vec3 tmpvar_13;
  mediump vec3 inVec_14;
  inVec_14 = (tmpvar_11 - normalize(xlv_TEXCOORD1));
  tmpvar_13 = (inVec_14 * inversesqrt(max (0.001, 
    dot (inVec_14, inVec_14)
  )));
  mediump float tmpvar_15;
  tmpvar_15 = clamp (dot (tmpvar_4, tmpvar_13), 0.0, 1.0);
  mediump float tmpvar_16;
  tmpvar_16 = (1.0 - _Glossiness);
  mediump float tmpvar_17;
  tmpvar_17 = (tmpvar_16 * tmpvar_16);
  specularTerm_12 = ((tmpvar_17 / (
    (max (0.32, clamp (dot (tmpvar_11, tmpvar_13), 0.0, 1.0)) * (1.5 + tmpvar_17))
   * 
    (((tmpvar_15 * tmpvar_15) * ((tmpvar_17 * tmpvar_17) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (specularTerm_12, 0.0, 100.0);
  specularTerm_12 = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = (((
    (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)))
   + 
    (tmpvar_18 * mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic)))
  ) * tmpvar_10) * clamp (dot (tmpvar_4, tmpvar_11), 0.0, 1.0));
  mediump vec4 xlat_varoutput_20;
  xlat_varoutput_20.xyz = tmpvar_19.xyz;
  xlat_varoutput_20.w = 1.0;
  gl_FragData[0] = xlat_varoutput_20;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  mediump vec3 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  lightDir_4 = tmpvar_20;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec3 lightCoord_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD5;
  lightCoord_1 = (unity_WorldToLight * tmpvar_5).xyz;
  highp float tmpvar_6;
  tmpvar_6 = dot (lightCoord_1, lightCoord_1);
  lowp float tmpvar_7;
  tmpvar_7 = (texture2D (_LightTextureB0, vec2(tmpvar_6)).w * textureCube (_LightTexture0, lightCoord_1).w);
  mediump vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD2.w;
  tmpvar_8.y = xlv_TEXCOORD2_1.w;
  tmpvar_8.z = xlv_TEXCOORD2_2.w;
  mediump float atten_9;
  atten_9 = tmpvar_7;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _LightColor0.xyz;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(tmpvar_8);
  tmpvar_10 = (tmpvar_10 * atten_9);
  mediump float specularTerm_12;
  mediump vec3 tmpvar_13;
  mediump vec3 inVec_14;
  inVec_14 = (tmpvar_11 - normalize(xlv_TEXCOORD1));
  tmpvar_13 = (inVec_14 * inversesqrt(max (0.001, 
    dot (inVec_14, inVec_14)
  )));
  mediump float tmpvar_15;
  tmpvar_15 = clamp (dot (tmpvar_4, tmpvar_13), 0.0, 1.0);
  mediump float tmpvar_16;
  tmpvar_16 = (1.0 - _Glossiness);
  mediump float tmpvar_17;
  tmpvar_17 = (tmpvar_16 * tmpvar_16);
  specularTerm_12 = ((tmpvar_17 / (
    (max (0.32, clamp (dot (tmpvar_11, tmpvar_13), 0.0, 1.0)) * (1.5 + tmpvar_17))
   * 
    (((tmpvar_15 * tmpvar_15) * ((tmpvar_17 * tmpvar_17) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_18;
  tmpvar_18 = clamp (specularTerm_12, 0.0, 100.0);
  specularTerm_12 = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = (((
    (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)))
   + 
    (tmpvar_18 * mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic)))
  ) * tmpvar_10) * clamp (dot (tmpvar_4, tmpvar_11), 0.0, 1.0));
  mediump vec4 xlat_varoutput_20;
  xlat_varoutput_20.xyz = tmpvar_19.xyz;
  xlat_varoutput_20.w = 1.0;
  gl_FragData[0] = xlat_varoutput_20;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec3 lightDir_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  lightDir_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  normalWorld_4 = tmpvar_18;
  tmpvar_8.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = lightDir_6;
  xlv_TEXCOORD5 = normalWorld_4;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec2 lightCoord_1;
  mediump vec3 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD3.yzw, xlv_TEXCOORD4);
  mediump vec2 tmpvar_6;
  tmpvar_6.x = ((tmpvar_5 * tmpvar_5) * (tmpvar_5 * tmpvar_5));
  tmpvar_6.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_NHxRoughness, tmpvar_6);
  c_2 = (((tmpvar_4 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_7.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic))
  )) * _LightColor0.xyz);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD1;
  lightCoord_1 = (unity_WorldToLight * tmpvar_8).xy;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_LightTexture0, lightCoord_1).w;
  c_2 = (c_2 * (tmpvar_9 * clamp (
    dot (xlv_TEXCOORD5, xlv_TEXCOORD4)
  , 0.0, 1.0)));
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = c_2;
  mediump vec4 xlat_varoutput_11;
  xlat_varoutput_11.xyz = tmpvar_10.xyz;
  xlat_varoutput_11.w = 1.0;
  gl_FragData[0] = xlat_varoutput_11;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 texcoord_11;
  texcoord_11.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_12;
  if ((_UVSec == 0.0)) {
    tmpvar_12 = tmpvar_2;
  } else {
    tmpvar_12 = tmpvar_3;
  };
  texcoord_11.zw = ((tmpvar_12 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_13;
  highp vec3 n_14;
  n_14 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  tmpvar_13 = n_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (_WorldSpaceLightPos0.xyz - (tmpvar_8.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_18.x;
  tmpvar_5.w = tmpvar_18.y;
  tmpvar_6.w = tmpvar_18.z;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = texcoord_11;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_8.xyz;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec2 lightCoord_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD5;
  lightCoord_1 = (unity_WorldToLight * tmpvar_5).xy;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_LightTexture0, lightCoord_1).w;
  mediump vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD2.w;
  tmpvar_7.y = xlv_TEXCOORD2_1.w;
  tmpvar_7.z = xlv_TEXCOORD2_2.w;
  mediump float atten_8;
  atten_8 = tmpvar_6;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _LightColor0.xyz;
  tmpvar_9 = (tmpvar_9 * atten_8);
  mediump float specularTerm_10;
  mediump vec3 tmpvar_11;
  mediump vec3 inVec_12;
  inVec_12 = (tmpvar_7 - normalize(xlv_TEXCOORD1));
  tmpvar_11 = (inVec_12 * inversesqrt(max (0.001, 
    dot (inVec_12, inVec_12)
  )));
  mediump float tmpvar_13;
  tmpvar_13 = clamp (dot (tmpvar_4, tmpvar_11), 0.0, 1.0);
  mediump float tmpvar_14;
  tmpvar_14 = (1.0 - _Glossiness);
  mediump float tmpvar_15;
  tmpvar_15 = (tmpvar_14 * tmpvar_14);
  specularTerm_10 = ((tmpvar_15 / (
    (max (0.32, clamp (dot (tmpvar_7, tmpvar_11), 0.0, 1.0)) * (1.5 + tmpvar_15))
   * 
    (((tmpvar_13 * tmpvar_13) * ((tmpvar_15 * tmpvar_15) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (specularTerm_10, 0.0, 100.0);
  specularTerm_10 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = (((
    (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)))
   + 
    (tmpvar_16 * mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic)))
  ) * tmpvar_9) * clamp (dot (tmpvar_4, tmpvar_7), 0.0, 1.0));
  mediump vec4 xlat_varoutput_18;
  xlat_varoutput_18.xyz = tmpvar_17.xyz;
  xlat_varoutput_18.w = 1.0;
  gl_FragData[0] = xlat_varoutput_18;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 texcoord_11;
  texcoord_11.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_12;
  if ((_UVSec == 0.0)) {
    tmpvar_12 = tmpvar_2;
  } else {
    tmpvar_12 = tmpvar_3;
  };
  texcoord_11.zw = ((tmpvar_12 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_13;
  highp vec3 n_14;
  n_14 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  tmpvar_13 = n_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (_WorldSpaceLightPos0.xyz - (tmpvar_8.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_18.x;
  tmpvar_5.w = tmpvar_18.y;
  tmpvar_6.w = tmpvar_18.z;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = texcoord_11;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_8.xyz;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec2 lightCoord_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD5;
  lightCoord_1 = (unity_WorldToLight * tmpvar_5).xy;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_LightTexture0, lightCoord_1).w;
  mediump vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD2.w;
  tmpvar_7.y = xlv_TEXCOORD2_1.w;
  tmpvar_7.z = xlv_TEXCOORD2_2.w;
  mediump float atten_8;
  atten_8 = tmpvar_6;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _LightColor0.xyz;
  tmpvar_9 = (tmpvar_9 * atten_8);
  mediump float specularTerm_10;
  mediump vec3 tmpvar_11;
  mediump vec3 inVec_12;
  inVec_12 = (tmpvar_7 - normalize(xlv_TEXCOORD1));
  tmpvar_11 = (inVec_12 * inversesqrt(max (0.001, 
    dot (inVec_12, inVec_12)
  )));
  mediump float tmpvar_13;
  tmpvar_13 = clamp (dot (tmpvar_4, tmpvar_11), 0.0, 1.0);
  mediump float tmpvar_14;
  tmpvar_14 = (1.0 - _Glossiness);
  mediump float tmpvar_15;
  tmpvar_15 = (tmpvar_14 * tmpvar_14);
  specularTerm_10 = ((tmpvar_15 / (
    (max (0.32, clamp (dot (tmpvar_7, tmpvar_11), 0.0, 1.0)) * (1.5 + tmpvar_15))
   * 
    (((tmpvar_13 * tmpvar_13) * ((tmpvar_15 * tmpvar_15) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (specularTerm_10, 0.0, 100.0);
  specularTerm_10 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = (((
    (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)))
   + 
    (tmpvar_16 * mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic)))
  ) * tmpvar_9) * clamp (dot (tmpvar_4, tmpvar_7), 0.0, 1.0));
  mediump vec4 xlat_varoutput_18;
  xlat_varoutput_18.xyz = tmpvar_17.xyz;
  xlat_varoutput_18.w = 1.0;
  gl_FragData[0] = xlat_varoutput_18;
}


#endif
"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec3 lightDir_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  lightDir_6 = tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec3 n_16;
  n_16 = lightDir_6;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(n_16);
  tmpvar_15 = tmpvar_17;
  lightDir_6 = tmpvar_15;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_18;
  highp vec3 norm_19;
  norm_19 = tmpvar_1;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((norm_19 * tmpvar_20));
  normalWorld_4 = tmpvar_21;
  tmpvar_8.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_15;
  xlv_TEXCOORD5 = normalWorld_4;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float atten_1;
  lowp float shadow_2;
  highp vec4 lightCoord_3;
  mediump vec3 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_6;
  tmpvar_6 = (_Color.xyz * tmpvar_5.xyz);
  mediump float tmpvar_7;
  tmpvar_7 = dot (xlv_TEXCOORD3.yzw, xlv_TEXCOORD4);
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((tmpvar_7 * tmpvar_7) * (tmpvar_7 * tmpvar_7));
  tmpvar_8.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_NHxRoughness, tmpvar_8);
  c_4 = (((tmpvar_6 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_9.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_6, vec3(_Metallic))
  )) * _LightColor0.xyz);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
  lightCoord_3 = (unity_WorldToLight * tmpvar_10);
  mediump float realtimeShadowAttenuation_11;
  realtimeShadowAttenuation_11 = 1.0;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = xlv_TEXCOORD1;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_WorldToShadow[0] * tmpvar_12);
  lowp float tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = texture2DProj (_ShadowMapTexture, tmpvar_13);
  mediump float tmpvar_16;
  if ((tmpvar_15.x < (tmpvar_13.z / tmpvar_13.w))) {
    tmpvar_16 = _LightShadowData.x;
  } else {
    tmpvar_16 = 1.0;
  };
  tmpvar_14 = tmpvar_16;
  realtimeShadowAttenuation_11 = tmpvar_14;
  shadow_2 = realtimeShadowAttenuation_11;
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = ((lightCoord_3.xy / lightCoord_3.w) + 0.5);
  tmpvar_17 = texture2D (_LightTexture0, P_18);
  highp float tmpvar_19;
  tmpvar_19 = dot (lightCoord_3.xyz, lightCoord_3.xyz);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_LightTextureB0, vec2(tmpvar_19));
  highp float tmpvar_21;
  tmpvar_21 = (((
    float((lightCoord_3.z > 0.0))
   * tmpvar_17.w) * tmpvar_20.w) * shadow_2);
  atten_1 = tmpvar_21;
  c_4 = (c_4 * (atten_1 * clamp (
    dot (xlv_TEXCOORD5, xlv_TEXCOORD4)
  , 0.0, 1.0)));
  mediump vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = c_4;
  mediump vec4 xlat_varoutput_23;
  xlat_varoutput_23.xyz = tmpvar_22.xyz;
  xlat_varoutput_23.w = 1.0;
  gl_FragData[0] = xlat_varoutput_23;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  mediump vec3 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  lightDir_4 = tmpvar_20;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float atten_1;
  lowp float shadow_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  tmpvar_5 = (tmpvar_4 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD1);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD5;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_WorldToLight * tmpvar_9);
  mediump float realtimeShadowAttenuation_11;
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].z;
  v_12.y = unity_MatrixV[1].z;
  v_12.z = unity_MatrixV[2].z;
  v_12.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD5 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD5), v_12.xyz), sqrt(dot (tmpvar_13, tmpvar_13)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  realtimeShadowAttenuation_11 = 1.0;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = xlv_TEXCOORD5;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_WorldToShadow[0] * tmpvar_16);
  lowp float tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = texture2DProj (_ShadowMapTexture, tmpvar_17);
  mediump float tmpvar_20;
  if ((tmpvar_19.x < (tmpvar_17.z / tmpvar_17.w))) {
    tmpvar_20 = _LightShadowData.x;
  } else {
    tmpvar_20 = 1.0;
  };
  tmpvar_18 = tmpvar_20;
  realtimeShadowAttenuation_11 = tmpvar_18;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_11 + tmpvar_14), 0.0, 1.0);
  shadow_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((tmpvar_10.xy / tmpvar_10.w) + 0.5);
  tmpvar_22 = texture2D (_LightTexture0, P_23);
  highp float tmpvar_24;
  tmpvar_24 = dot (tmpvar_10.xyz, tmpvar_10.xyz);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_LightTextureB0, vec2(tmpvar_24));
  highp float tmpvar_26;
  tmpvar_26 = (((
    float((tmpvar_10.z > 0.0))
   * tmpvar_22.w) * tmpvar_25.w) * shadow_2);
  atten_1 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27.x = xlv_TEXCOORD2.w;
  tmpvar_27.y = xlv_TEXCOORD2_1.w;
  tmpvar_27.z = xlv_TEXCOORD2_2.w;
  mediump float atten_28;
  atten_28 = atten_1;
  mediump vec3 tmpvar_29;
  tmpvar_29 = _LightColor0.xyz;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(tmpvar_27);
  tmpvar_29 = (tmpvar_29 * atten_28);
  mediump float specularTerm_31;
  mediump vec3 tmpvar_32;
  mediump vec3 inVec_33;
  inVec_33 = (tmpvar_30 - tmpvar_8);
  tmpvar_32 = (inVec_33 * inversesqrt(max (0.001, 
    dot (inVec_33, inVec_33)
  )));
  mediump float tmpvar_34;
  tmpvar_34 = clamp (dot (tmpvar_7, tmpvar_32), 0.0, 1.0);
  mediump float tmpvar_35;
  tmpvar_35 = (1.0 - _Glossiness);
  mediump float tmpvar_36;
  tmpvar_36 = (tmpvar_35 * tmpvar_35);
  specularTerm_31 = ((tmpvar_36 / (
    (max (0.32, clamp (dot (tmpvar_30, tmpvar_32), 0.0, 1.0)) * (1.5 + tmpvar_36))
   * 
    (((tmpvar_34 * tmpvar_34) * ((tmpvar_36 * tmpvar_36) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (specularTerm_31, 0.0, 100.0);
  specularTerm_31 = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = (((tmpvar_5 + 
    (tmpvar_37 * tmpvar_6)
  ) * tmpvar_29) * clamp (dot (tmpvar_7, tmpvar_30), 0.0, 1.0));
  mediump vec4 xlat_varoutput_39;
  xlat_varoutput_39.xyz = tmpvar_38.xyz;
  xlat_varoutput_39.w = 1.0;
  gl_FragData[0] = xlat_varoutput_39;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  mediump vec3 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  lightDir_4 = tmpvar_20;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float atten_1;
  lowp float shadow_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  tmpvar_5 = (tmpvar_4 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD1);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD5;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_WorldToLight * tmpvar_9);
  mediump float realtimeShadowAttenuation_11;
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].z;
  v_12.y = unity_MatrixV[1].z;
  v_12.z = unity_MatrixV[2].z;
  v_12.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD5 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD5), v_12.xyz), sqrt(dot (tmpvar_13, tmpvar_13)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  realtimeShadowAttenuation_11 = 1.0;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = xlv_TEXCOORD5;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_WorldToShadow[0] * tmpvar_16);
  lowp float tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = texture2DProj (_ShadowMapTexture, tmpvar_17);
  mediump float tmpvar_20;
  if ((tmpvar_19.x < (tmpvar_17.z / tmpvar_17.w))) {
    tmpvar_20 = _LightShadowData.x;
  } else {
    tmpvar_20 = 1.0;
  };
  tmpvar_18 = tmpvar_20;
  realtimeShadowAttenuation_11 = tmpvar_18;
  mediump float tmpvar_21;
  tmpvar_21 = clamp ((realtimeShadowAttenuation_11 + tmpvar_14), 0.0, 1.0);
  shadow_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = ((tmpvar_10.xy / tmpvar_10.w) + 0.5);
  tmpvar_22 = texture2D (_LightTexture0, P_23);
  highp float tmpvar_24;
  tmpvar_24 = dot (tmpvar_10.xyz, tmpvar_10.xyz);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_LightTextureB0, vec2(tmpvar_24));
  highp float tmpvar_26;
  tmpvar_26 = (((
    float((tmpvar_10.z > 0.0))
   * tmpvar_22.w) * tmpvar_25.w) * shadow_2);
  atten_1 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27.x = xlv_TEXCOORD2.w;
  tmpvar_27.y = xlv_TEXCOORD2_1.w;
  tmpvar_27.z = xlv_TEXCOORD2_2.w;
  mediump float atten_28;
  atten_28 = atten_1;
  mediump vec3 tmpvar_29;
  tmpvar_29 = _LightColor0.xyz;
  mediump vec3 tmpvar_30;
  tmpvar_30 = normalize(tmpvar_27);
  tmpvar_29 = (tmpvar_29 * atten_28);
  mediump float specularTerm_31;
  mediump vec3 tmpvar_32;
  mediump vec3 inVec_33;
  inVec_33 = (tmpvar_30 - tmpvar_8);
  tmpvar_32 = (inVec_33 * inversesqrt(max (0.001, 
    dot (inVec_33, inVec_33)
  )));
  mediump float tmpvar_34;
  tmpvar_34 = clamp (dot (tmpvar_7, tmpvar_32), 0.0, 1.0);
  mediump float tmpvar_35;
  tmpvar_35 = (1.0 - _Glossiness);
  mediump float tmpvar_36;
  tmpvar_36 = (tmpvar_35 * tmpvar_35);
  specularTerm_31 = ((tmpvar_36 / (
    (max (0.32, clamp (dot (tmpvar_30, tmpvar_32), 0.0, 1.0)) * (1.5 + tmpvar_36))
   * 
    (((tmpvar_34 * tmpvar_34) * ((tmpvar_36 * tmpvar_36) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (specularTerm_31, 0.0, 100.0);
  specularTerm_31 = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = (((tmpvar_5 + 
    (tmpvar_37 * tmpvar_6)
  ) * tmpvar_29) * clamp (dot (tmpvar_7, tmpvar_30), 0.0, 1.0));
  mediump vec4 xlat_varoutput_39;
  xlat_varoutput_39.xyz = tmpvar_38.xyz;
  xlat_varoutput_39.w = 1.0;
  gl_FragData[0] = xlat_varoutput_39;
}


#endif
"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec3 lightDir_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  lightDir_6 = tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec3 n_16;
  n_16 = lightDir_6;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(n_16);
  tmpvar_15 = tmpvar_17;
  lightDir_6 = tmpvar_15;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_18;
  highp vec3 norm_19;
  norm_19 = tmpvar_1;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((norm_19 * tmpvar_20));
  normalWorld_4 = tmpvar_21;
  tmpvar_8.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_15;
  xlv_TEXCOORD5 = normalWorld_4;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float atten_1;
  lowp float shadow_2;
  highp vec4 lightCoord_3;
  mediump vec3 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_6;
  tmpvar_6 = (_Color.xyz * tmpvar_5.xyz);
  mediump float tmpvar_7;
  tmpvar_7 = dot (xlv_TEXCOORD3.yzw, xlv_TEXCOORD4);
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((tmpvar_7 * tmpvar_7) * (tmpvar_7 * tmpvar_7));
  tmpvar_8.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_NHxRoughness, tmpvar_8);
  c_4 = (((tmpvar_6 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_9.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_6, vec3(_Metallic))
  )) * _LightColor0.xyz);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
  lightCoord_3 = (unity_WorldToLight * tmpvar_10);
  mediump float realtimeShadowAttenuation_11;
  realtimeShadowAttenuation_11 = 1.0;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = xlv_TEXCOORD1;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_WorldToShadow[0] * tmpvar_12);
  lowp float tmpvar_14;
  highp vec4 shadowVals_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_13.xyz / tmpvar_13.w);
  shadowVals_15.x = texture2D (_ShadowMapTexture, (tmpvar_16.xy + _ShadowOffsets[0].xy)).x;
  shadowVals_15.y = texture2D (_ShadowMapTexture, (tmpvar_16.xy + _ShadowOffsets[1].xy)).x;
  shadowVals_15.z = texture2D (_ShadowMapTexture, (tmpvar_16.xy + _ShadowOffsets[2].xy)).x;
  shadowVals_15.w = texture2D (_ShadowMapTexture, (tmpvar_16.xy + _ShadowOffsets[3].xy)).x;
  bvec4 tmpvar_17;
  tmpvar_17 = lessThan (shadowVals_15, tmpvar_16.zzzz);
  mediump vec4 tmpvar_18;
  tmpvar_18 = _LightShadowData.xxxx;
  mediump float tmpvar_19;
  if (tmpvar_17.x) {
    tmpvar_19 = tmpvar_18.x;
  } else {
    tmpvar_19 = 1.0;
  };
  mediump float tmpvar_20;
  if (tmpvar_17.y) {
    tmpvar_20 = tmpvar_18.y;
  } else {
    tmpvar_20 = 1.0;
  };
  mediump float tmpvar_21;
  if (tmpvar_17.z) {
    tmpvar_21 = tmpvar_18.z;
  } else {
    tmpvar_21 = 1.0;
  };
  mediump float tmpvar_22;
  if (tmpvar_17.w) {
    tmpvar_22 = tmpvar_18.w;
  } else {
    tmpvar_22 = 1.0;
  };
  mediump vec4 tmpvar_23;
  tmpvar_23.x = tmpvar_19;
  tmpvar_23.y = tmpvar_20;
  tmpvar_23.z = tmpvar_21;
  tmpvar_23.w = tmpvar_22;
  mediump float tmpvar_24;
  tmpvar_24 = dot (tmpvar_23, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_14 = tmpvar_24;
  realtimeShadowAttenuation_11 = tmpvar_14;
  shadow_2 = realtimeShadowAttenuation_11;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = ((lightCoord_3.xy / lightCoord_3.w) + 0.5);
  tmpvar_25 = texture2D (_LightTexture0, P_26);
  highp float tmpvar_27;
  tmpvar_27 = dot (lightCoord_3.xyz, lightCoord_3.xyz);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_LightTextureB0, vec2(tmpvar_27));
  highp float tmpvar_29;
  tmpvar_29 = (((
    float((lightCoord_3.z > 0.0))
   * tmpvar_25.w) * tmpvar_28.w) * shadow_2);
  atten_1 = tmpvar_29;
  c_4 = (c_4 * (atten_1 * clamp (
    dot (xlv_TEXCOORD5, xlv_TEXCOORD4)
  , 0.0, 1.0)));
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = c_4;
  mediump vec4 xlat_varoutput_31;
  xlat_varoutput_31.xyz = tmpvar_30.xyz;
  xlat_varoutput_31.w = 1.0;
  gl_FragData[0] = xlat_varoutput_31;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  mediump vec3 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  lightDir_4 = tmpvar_20;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float atten_1;
  lowp float shadow_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  tmpvar_5 = (tmpvar_4 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD1);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD5;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_WorldToLight * tmpvar_9);
  mediump float realtimeShadowAttenuation_11;
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].z;
  v_12.y = unity_MatrixV[1].z;
  v_12.z = unity_MatrixV[2].z;
  v_12.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD5 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD5), v_12.xyz), sqrt(dot (tmpvar_13, tmpvar_13)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  realtimeShadowAttenuation_11 = 1.0;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = xlv_TEXCOORD5;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_WorldToShadow[0] * tmpvar_16);
  lowp float tmpvar_18;
  highp vec4 shadowVals_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_17.xyz / tmpvar_17.w);
  shadowVals_19.x = texture2D (_ShadowMapTexture, (tmpvar_20.xy + _ShadowOffsets[0].xy)).x;
  shadowVals_19.y = texture2D (_ShadowMapTexture, (tmpvar_20.xy + _ShadowOffsets[1].xy)).x;
  shadowVals_19.z = texture2D (_ShadowMapTexture, (tmpvar_20.xy + _ShadowOffsets[2].xy)).x;
  shadowVals_19.w = texture2D (_ShadowMapTexture, (tmpvar_20.xy + _ShadowOffsets[3].xy)).x;
  bvec4 tmpvar_21;
  tmpvar_21 = lessThan (shadowVals_19, tmpvar_20.zzzz);
  mediump vec4 tmpvar_22;
  tmpvar_22 = _LightShadowData.xxxx;
  mediump float tmpvar_23;
  if (tmpvar_21.x) {
    tmpvar_23 = tmpvar_22.x;
  } else {
    tmpvar_23 = 1.0;
  };
  mediump float tmpvar_24;
  if (tmpvar_21.y) {
    tmpvar_24 = tmpvar_22.y;
  } else {
    tmpvar_24 = 1.0;
  };
  mediump float tmpvar_25;
  if (tmpvar_21.z) {
    tmpvar_25 = tmpvar_22.z;
  } else {
    tmpvar_25 = 1.0;
  };
  mediump float tmpvar_26;
  if (tmpvar_21.w) {
    tmpvar_26 = tmpvar_22.w;
  } else {
    tmpvar_26 = 1.0;
  };
  mediump vec4 tmpvar_27;
  tmpvar_27.x = tmpvar_23;
  tmpvar_27.y = tmpvar_24;
  tmpvar_27.z = tmpvar_25;
  tmpvar_27.w = tmpvar_26;
  mediump float tmpvar_28;
  tmpvar_28 = dot (tmpvar_27, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_18 = tmpvar_28;
  realtimeShadowAttenuation_11 = tmpvar_18;
  mediump float tmpvar_29;
  tmpvar_29 = clamp ((realtimeShadowAttenuation_11 + tmpvar_14), 0.0, 1.0);
  shadow_2 = tmpvar_29;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((tmpvar_10.xy / tmpvar_10.w) + 0.5);
  tmpvar_30 = texture2D (_LightTexture0, P_31);
  highp float tmpvar_32;
  tmpvar_32 = dot (tmpvar_10.xyz, tmpvar_10.xyz);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_LightTextureB0, vec2(tmpvar_32));
  highp float tmpvar_34;
  tmpvar_34 = (((
    float((tmpvar_10.z > 0.0))
   * tmpvar_30.w) * tmpvar_33.w) * shadow_2);
  atten_1 = tmpvar_34;
  mediump vec3 tmpvar_35;
  tmpvar_35.x = xlv_TEXCOORD2.w;
  tmpvar_35.y = xlv_TEXCOORD2_1.w;
  tmpvar_35.z = xlv_TEXCOORD2_2.w;
  mediump float atten_36;
  atten_36 = atten_1;
  mediump vec3 tmpvar_37;
  tmpvar_37 = _LightColor0.xyz;
  mediump vec3 tmpvar_38;
  tmpvar_38 = normalize(tmpvar_35);
  tmpvar_37 = (tmpvar_37 * atten_36);
  mediump float specularTerm_39;
  mediump vec3 tmpvar_40;
  mediump vec3 inVec_41;
  inVec_41 = (tmpvar_38 - tmpvar_8);
  tmpvar_40 = (inVec_41 * inversesqrt(max (0.001, 
    dot (inVec_41, inVec_41)
  )));
  mediump float tmpvar_42;
  tmpvar_42 = clamp (dot (tmpvar_7, tmpvar_40), 0.0, 1.0);
  mediump float tmpvar_43;
  tmpvar_43 = (1.0 - _Glossiness);
  mediump float tmpvar_44;
  tmpvar_44 = (tmpvar_43 * tmpvar_43);
  specularTerm_39 = ((tmpvar_44 / (
    (max (0.32, clamp (dot (tmpvar_38, tmpvar_40), 0.0, 1.0)) * (1.5 + tmpvar_44))
   * 
    (((tmpvar_42 * tmpvar_42) * ((tmpvar_44 * tmpvar_44) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_45;
  tmpvar_45 = clamp (specularTerm_39, 0.0, 100.0);
  specularTerm_39 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 1.0;
  tmpvar_46.xyz = (((tmpvar_5 + 
    (tmpvar_45 * tmpvar_6)
  ) * tmpvar_37) * clamp (dot (tmpvar_7, tmpvar_38), 0.0, 1.0));
  mediump vec4 xlat_varoutput_47;
  xlat_varoutput_47.xyz = tmpvar_46.xyz;
  xlat_varoutput_47.w = 1.0;
  gl_FragData[0] = xlat_varoutput_47;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  mediump vec3 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  lightDir_4 = tmpvar_20;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float atten_1;
  lowp float shadow_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  tmpvar_5 = (tmpvar_4 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD1);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD5;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_WorldToLight * tmpvar_9);
  mediump float realtimeShadowAttenuation_11;
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].z;
  v_12.y = unity_MatrixV[1].z;
  v_12.z = unity_MatrixV[2].z;
  v_12.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD5 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD5), v_12.xyz), sqrt(dot (tmpvar_13, tmpvar_13)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  realtimeShadowAttenuation_11 = 1.0;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = xlv_TEXCOORD5;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_WorldToShadow[0] * tmpvar_16);
  lowp float tmpvar_18;
  highp vec4 shadowVals_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_17.xyz / tmpvar_17.w);
  shadowVals_19.x = texture2D (_ShadowMapTexture, (tmpvar_20.xy + _ShadowOffsets[0].xy)).x;
  shadowVals_19.y = texture2D (_ShadowMapTexture, (tmpvar_20.xy + _ShadowOffsets[1].xy)).x;
  shadowVals_19.z = texture2D (_ShadowMapTexture, (tmpvar_20.xy + _ShadowOffsets[2].xy)).x;
  shadowVals_19.w = texture2D (_ShadowMapTexture, (tmpvar_20.xy + _ShadowOffsets[3].xy)).x;
  bvec4 tmpvar_21;
  tmpvar_21 = lessThan (shadowVals_19, tmpvar_20.zzzz);
  mediump vec4 tmpvar_22;
  tmpvar_22 = _LightShadowData.xxxx;
  mediump float tmpvar_23;
  if (tmpvar_21.x) {
    tmpvar_23 = tmpvar_22.x;
  } else {
    tmpvar_23 = 1.0;
  };
  mediump float tmpvar_24;
  if (tmpvar_21.y) {
    tmpvar_24 = tmpvar_22.y;
  } else {
    tmpvar_24 = 1.0;
  };
  mediump float tmpvar_25;
  if (tmpvar_21.z) {
    tmpvar_25 = tmpvar_22.z;
  } else {
    tmpvar_25 = 1.0;
  };
  mediump float tmpvar_26;
  if (tmpvar_21.w) {
    tmpvar_26 = tmpvar_22.w;
  } else {
    tmpvar_26 = 1.0;
  };
  mediump vec4 tmpvar_27;
  tmpvar_27.x = tmpvar_23;
  tmpvar_27.y = tmpvar_24;
  tmpvar_27.z = tmpvar_25;
  tmpvar_27.w = tmpvar_26;
  mediump float tmpvar_28;
  tmpvar_28 = dot (tmpvar_27, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_18 = tmpvar_28;
  realtimeShadowAttenuation_11 = tmpvar_18;
  mediump float tmpvar_29;
  tmpvar_29 = clamp ((realtimeShadowAttenuation_11 + tmpvar_14), 0.0, 1.0);
  shadow_2 = tmpvar_29;
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = ((tmpvar_10.xy / tmpvar_10.w) + 0.5);
  tmpvar_30 = texture2D (_LightTexture0, P_31);
  highp float tmpvar_32;
  tmpvar_32 = dot (tmpvar_10.xyz, tmpvar_10.xyz);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_LightTextureB0, vec2(tmpvar_32));
  highp float tmpvar_34;
  tmpvar_34 = (((
    float((tmpvar_10.z > 0.0))
   * tmpvar_30.w) * tmpvar_33.w) * shadow_2);
  atten_1 = tmpvar_34;
  mediump vec3 tmpvar_35;
  tmpvar_35.x = xlv_TEXCOORD2.w;
  tmpvar_35.y = xlv_TEXCOORD2_1.w;
  tmpvar_35.z = xlv_TEXCOORD2_2.w;
  mediump float atten_36;
  atten_36 = atten_1;
  mediump vec3 tmpvar_37;
  tmpvar_37 = _LightColor0.xyz;
  mediump vec3 tmpvar_38;
  tmpvar_38 = normalize(tmpvar_35);
  tmpvar_37 = (tmpvar_37 * atten_36);
  mediump float specularTerm_39;
  mediump vec3 tmpvar_40;
  mediump vec3 inVec_41;
  inVec_41 = (tmpvar_38 - tmpvar_8);
  tmpvar_40 = (inVec_41 * inversesqrt(max (0.001, 
    dot (inVec_41, inVec_41)
  )));
  mediump float tmpvar_42;
  tmpvar_42 = clamp (dot (tmpvar_7, tmpvar_40), 0.0, 1.0);
  mediump float tmpvar_43;
  tmpvar_43 = (1.0 - _Glossiness);
  mediump float tmpvar_44;
  tmpvar_44 = (tmpvar_43 * tmpvar_43);
  specularTerm_39 = ((tmpvar_44 / (
    (max (0.32, clamp (dot (tmpvar_38, tmpvar_40), 0.0, 1.0)) * (1.5 + tmpvar_44))
   * 
    (((tmpvar_42 * tmpvar_42) * ((tmpvar_44 * tmpvar_44) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_45;
  tmpvar_45 = clamp (specularTerm_39, 0.0, 100.0);
  specularTerm_39 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 1.0;
  tmpvar_46.xyz = (((tmpvar_5 + 
    (tmpvar_45 * tmpvar_6)
  ) * tmpvar_37) * clamp (dot (tmpvar_7, tmpvar_38), 0.0, 1.0));
  mediump vec4 xlat_varoutput_47;
  xlat_varoutput_47.xyz = tmpvar_46.xyz;
  xlat_varoutput_47.w = 1.0;
  gl_FragData[0] = xlat_varoutput_47;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec3 lightDir_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  lightDir_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  normalWorld_4 = tmpvar_18;
  tmpvar_8.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = lightDir_6;
  xlv_TEXCOORD5 = normalWorld_4;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float atten_1;
  mediump vec3 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD3.yzw, xlv_TEXCOORD4);
  mediump vec2 tmpvar_6;
  tmpvar_6.x = ((tmpvar_5 * tmpvar_5) * (tmpvar_5 * tmpvar_5));
  tmpvar_6.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_NHxRoughness, tmpvar_6);
  c_2 = (((tmpvar_4 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_7.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic))
  )) * _LightColor0.xyz);
  mediump float realtimeShadowAttenuation_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD1;
  lowp float tmpvar_10;
  highp vec4 shadowCoord_11;
  shadowCoord_11 = (unity_WorldToShadow[0] * tmpvar_9);
  highp float lightShadowDataX_12;
  mediump float tmpvar_13;
  tmpvar_13 = _LightShadowData.x;
  lightShadowDataX_12 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = max (float((texture2D (_ShadowMapTexture, shadowCoord_11.xy).x > shadowCoord_11.z)), lightShadowDataX_12);
  tmpvar_10 = tmpvar_14;
  realtimeShadowAttenuation_8 = tmpvar_10;
  atten_1 = realtimeShadowAttenuation_8;
  c_2 = (c_2 * (atten_1 * clamp (
    dot (xlv_TEXCOORD5, xlv_TEXCOORD4)
  , 0.0, 1.0)));
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = c_2;
  mediump vec4 xlat_varoutput_16;
  xlat_varoutput_16.xyz = tmpvar_15.xyz;
  xlat_varoutput_16.w = 1.0;
  gl_FragData[0] = xlat_varoutput_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 texcoord_11;
  texcoord_11.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_12;
  if ((_UVSec == 0.0)) {
    tmpvar_12 = tmpvar_2;
  } else {
    tmpvar_12 = tmpvar_3;
  };
  texcoord_11.zw = ((tmpvar_12 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_13;
  highp vec3 n_14;
  n_14 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  tmpvar_13 = n_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (_WorldSpaceLightPos0.xyz - (tmpvar_8.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_18.x;
  tmpvar_5.w = tmpvar_18.y;
  tmpvar_6.w = tmpvar_18.z;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = texcoord_11;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_8.xyz;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float atten_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump float realtimeShadowAttenuation_5;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].z;
  v_6.y = unity_MatrixV[1].z;
  v_6.z = unity_MatrixV[2].z;
  v_6.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD5 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD5), v_6.xyz), sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD5;
  lowp float tmpvar_11;
  highp vec4 shadowCoord_12;
  shadowCoord_12 = (unity_WorldToShadow[0] * tmpvar_10);
  highp float lightShadowDataX_13;
  mediump float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((texture2D (_ShadowMapTexture, shadowCoord_12.xy).x > shadowCoord_12.z)), lightShadowDataX_13);
  tmpvar_11 = tmpvar_15;
  realtimeShadowAttenuation_5 = tmpvar_11;
  mediump float tmpvar_16;
  tmpvar_16 = clamp ((realtimeShadowAttenuation_5 + tmpvar_8), 0.0, 1.0);
  atten_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = xlv_TEXCOORD2.w;
  tmpvar_17.y = xlv_TEXCOORD2_1.w;
  tmpvar_17.z = xlv_TEXCOORD2_2.w;
  mediump float atten_18;
  atten_18 = atten_1;
  mediump vec3 tmpvar_19;
  tmpvar_19 = _LightColor0.xyz;
  tmpvar_19 = (tmpvar_19 * atten_18);
  mediump float specularTerm_20;
  mediump vec3 tmpvar_21;
  mediump vec3 inVec_22;
  inVec_22 = (tmpvar_17 - normalize(xlv_TEXCOORD1));
  tmpvar_21 = (inVec_22 * inversesqrt(max (0.001, 
    dot (inVec_22, inVec_22)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = clamp (dot (tmpvar_4, tmpvar_21), 0.0, 1.0);
  mediump float tmpvar_24;
  tmpvar_24 = (1.0 - _Glossiness);
  mediump float tmpvar_25;
  tmpvar_25 = (tmpvar_24 * tmpvar_24);
  specularTerm_20 = ((tmpvar_25 / (
    (max (0.32, clamp (dot (tmpvar_17, tmpvar_21), 0.0, 1.0)) * (1.5 + tmpvar_25))
   * 
    (((tmpvar_23 * tmpvar_23) * ((tmpvar_25 * tmpvar_25) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_26;
  tmpvar_26 = clamp (specularTerm_20, 0.0, 100.0);
  specularTerm_20 = tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = (((
    (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)))
   + 
    (tmpvar_26 * mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic)))
  ) * tmpvar_19) * clamp (dot (tmpvar_4, tmpvar_17), 0.0, 1.0));
  mediump vec4 xlat_varoutput_28;
  xlat_varoutput_28.xyz = tmpvar_27.xyz;
  xlat_varoutput_28.w = 1.0;
  gl_FragData[0] = xlat_varoutput_28;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 texcoord_11;
  texcoord_11.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_12;
  if ((_UVSec == 0.0)) {
    tmpvar_12 = tmpvar_2;
  } else {
    tmpvar_12 = tmpvar_3;
  };
  texcoord_11.zw = ((tmpvar_12 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_13;
  highp vec3 n_14;
  n_14 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  tmpvar_13 = n_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (_WorldSpaceLightPos0.xyz - (tmpvar_8.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_18.x;
  tmpvar_5.w = tmpvar_18.y;
  tmpvar_6.w = tmpvar_18.z;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = texcoord_11;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_8.xyz;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float atten_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump float realtimeShadowAttenuation_5;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].z;
  v_6.y = unity_MatrixV[1].z;
  v_6.z = unity_MatrixV[2].z;
  v_6.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD5 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD5), v_6.xyz), sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD5;
  lowp float tmpvar_11;
  highp vec4 shadowCoord_12;
  shadowCoord_12 = (unity_WorldToShadow[0] * tmpvar_10);
  highp float lightShadowDataX_13;
  mediump float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((texture2D (_ShadowMapTexture, shadowCoord_12.xy).x > shadowCoord_12.z)), lightShadowDataX_13);
  tmpvar_11 = tmpvar_15;
  realtimeShadowAttenuation_5 = tmpvar_11;
  mediump float tmpvar_16;
  tmpvar_16 = clamp ((realtimeShadowAttenuation_5 + tmpvar_8), 0.0, 1.0);
  atten_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = xlv_TEXCOORD2.w;
  tmpvar_17.y = xlv_TEXCOORD2_1.w;
  tmpvar_17.z = xlv_TEXCOORD2_2.w;
  mediump float atten_18;
  atten_18 = atten_1;
  mediump vec3 tmpvar_19;
  tmpvar_19 = _LightColor0.xyz;
  tmpvar_19 = (tmpvar_19 * atten_18);
  mediump float specularTerm_20;
  mediump vec3 tmpvar_21;
  mediump vec3 inVec_22;
  inVec_22 = (tmpvar_17 - normalize(xlv_TEXCOORD1));
  tmpvar_21 = (inVec_22 * inversesqrt(max (0.001, 
    dot (inVec_22, inVec_22)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = clamp (dot (tmpvar_4, tmpvar_21), 0.0, 1.0);
  mediump float tmpvar_24;
  tmpvar_24 = (1.0 - _Glossiness);
  mediump float tmpvar_25;
  tmpvar_25 = (tmpvar_24 * tmpvar_24);
  specularTerm_20 = ((tmpvar_25 / (
    (max (0.32, clamp (dot (tmpvar_17, tmpvar_21), 0.0, 1.0)) * (1.5 + tmpvar_25))
   * 
    (((tmpvar_23 * tmpvar_23) * ((tmpvar_25 * tmpvar_25) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_26;
  tmpvar_26 = clamp (specularTerm_20, 0.0, 100.0);
  specularTerm_20 = tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = (((
    (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)))
   + 
    (tmpvar_26 * mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic)))
  ) * tmpvar_19) * clamp (dot (tmpvar_4, tmpvar_17), 0.0, 1.0));
  mediump vec4 xlat_varoutput_28;
  xlat_varoutput_28.xyz = tmpvar_27.xyz;
  xlat_varoutput_28.w = 1.0;
  gl_FragData[0] = xlat_varoutput_28;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec3 lightDir_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  lightDir_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  normalWorld_4 = tmpvar_18;
  tmpvar_8.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = lightDir_6;
  xlv_TEXCOORD5 = normalWorld_4;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float shadow_1;
  highp vec2 lightCoord_2;
  mediump vec3 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_5;
  tmpvar_5 = (_Color.xyz * tmpvar_4.xyz);
  mediump float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD3.yzw, xlv_TEXCOORD4);
  mediump vec2 tmpvar_7;
  tmpvar_7.x = ((tmpvar_6 * tmpvar_6) * (tmpvar_6 * tmpvar_6));
  tmpvar_7.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_NHxRoughness, tmpvar_7);
  c_3 = (((tmpvar_5 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_8.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_5, vec3(_Metallic))
  )) * _LightColor0.xyz);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD1;
  lightCoord_2 = (unity_WorldToLight * tmpvar_9).xy;
  mediump float realtimeShadowAttenuation_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = xlv_TEXCOORD1;
  lowp float tmpvar_12;
  highp vec4 shadowCoord_13;
  shadowCoord_13 = (unity_WorldToShadow[0] * tmpvar_11);
  highp float lightShadowDataX_14;
  mediump float tmpvar_15;
  tmpvar_15 = _LightShadowData.x;
  lightShadowDataX_14 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = max (float((texture2D (_ShadowMapTexture, shadowCoord_13.xy).x > shadowCoord_13.z)), lightShadowDataX_14);
  tmpvar_12 = tmpvar_16;
  realtimeShadowAttenuation_10 = tmpvar_12;
  shadow_1 = realtimeShadowAttenuation_10;
  lowp float tmpvar_17;
  tmpvar_17 = (texture2D (_LightTexture0, lightCoord_2).w * shadow_1);
  c_3 = (c_3 * (tmpvar_17 * clamp (
    dot (xlv_TEXCOORD5, xlv_TEXCOORD4)
  , 0.0, 1.0)));
  mediump vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = c_3;
  mediump vec4 xlat_varoutput_19;
  xlat_varoutput_19.xyz = tmpvar_18.xyz;
  xlat_varoutput_19.w = 1.0;
  gl_FragData[0] = xlat_varoutput_19;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 texcoord_11;
  texcoord_11.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_12;
  if ((_UVSec == 0.0)) {
    tmpvar_12 = tmpvar_2;
  } else {
    tmpvar_12 = tmpvar_3;
  };
  texcoord_11.zw = ((tmpvar_12 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_13;
  highp vec3 n_14;
  n_14 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  tmpvar_13 = n_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (_WorldSpaceLightPos0.xyz - (tmpvar_8.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_18.x;
  tmpvar_5.w = tmpvar_18.y;
  tmpvar_6.w = tmpvar_18.z;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = texcoord_11;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_8.xyz;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float shadow_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (unity_WorldToLight * tmpvar_5).xy;
  mediump float realtimeShadowAttenuation_7;
  highp vec4 v_8;
  v_8.x = unity_MatrixV[0].z;
  v_8.y = unity_MatrixV[1].z;
  v_8.z = unity_MatrixV[2].z;
  v_8.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD5 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD5), v_8.xyz), sqrt(dot (tmpvar_9, tmpvar_9)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = xlv_TEXCOORD5;
  lowp float tmpvar_13;
  highp vec4 shadowCoord_14;
  shadowCoord_14 = (unity_WorldToShadow[0] * tmpvar_12);
  highp float lightShadowDataX_15;
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((texture2D (_ShadowMapTexture, shadowCoord_14.xy).x > shadowCoord_14.z)), lightShadowDataX_15);
  tmpvar_13 = tmpvar_17;
  realtimeShadowAttenuation_7 = tmpvar_13;
  mediump float tmpvar_18;
  tmpvar_18 = clamp ((realtimeShadowAttenuation_7 + tmpvar_10), 0.0, 1.0);
  shadow_1 = tmpvar_18;
  lowp float tmpvar_19;
  tmpvar_19 = (texture2D (_LightTexture0, tmpvar_6).w * shadow_1);
  mediump vec3 tmpvar_20;
  tmpvar_20.x = xlv_TEXCOORD2.w;
  tmpvar_20.y = xlv_TEXCOORD2_1.w;
  tmpvar_20.z = xlv_TEXCOORD2_2.w;
  mediump float atten_21;
  atten_21 = tmpvar_19;
  mediump vec3 tmpvar_22;
  tmpvar_22 = _LightColor0.xyz;
  tmpvar_22 = (tmpvar_22 * atten_21);
  mediump float specularTerm_23;
  mediump vec3 tmpvar_24;
  mediump vec3 inVec_25;
  inVec_25 = (tmpvar_20 - normalize(xlv_TEXCOORD1));
  tmpvar_24 = (inVec_25 * inversesqrt(max (0.001, 
    dot (inVec_25, inVec_25)
  )));
  mediump float tmpvar_26;
  tmpvar_26 = clamp (dot (tmpvar_4, tmpvar_24), 0.0, 1.0);
  mediump float tmpvar_27;
  tmpvar_27 = (1.0 - _Glossiness);
  mediump float tmpvar_28;
  tmpvar_28 = (tmpvar_27 * tmpvar_27);
  specularTerm_23 = ((tmpvar_28 / (
    (max (0.32, clamp (dot (tmpvar_20, tmpvar_24), 0.0, 1.0)) * (1.5 + tmpvar_28))
   * 
    (((tmpvar_26 * tmpvar_26) * ((tmpvar_28 * tmpvar_28) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_29;
  tmpvar_29 = clamp (specularTerm_23, 0.0, 100.0);
  specularTerm_23 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = (((
    (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)))
   + 
    (tmpvar_29 * mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic)))
  ) * tmpvar_22) * clamp (dot (tmpvar_4, tmpvar_20), 0.0, 1.0));
  mediump vec4 xlat_varoutput_31;
  xlat_varoutput_31.xyz = tmpvar_30.xyz;
  xlat_varoutput_31.w = 1.0;
  gl_FragData[0] = xlat_varoutput_31;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 texcoord_11;
  texcoord_11.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_12;
  if ((_UVSec == 0.0)) {
    tmpvar_12 = tmpvar_2;
  } else {
    tmpvar_12 = tmpvar_3;
  };
  texcoord_11.zw = ((tmpvar_12 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_13;
  highp vec3 n_14;
  n_14 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  tmpvar_13 = n_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (_WorldSpaceLightPos0.xyz - (tmpvar_8.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_18.x;
  tmpvar_5.w = tmpvar_18.y;
  tmpvar_6.w = tmpvar_18.z;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = texcoord_11;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_8.xyz;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float shadow_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (unity_WorldToLight * tmpvar_5).xy;
  mediump float realtimeShadowAttenuation_7;
  highp vec4 v_8;
  v_8.x = unity_MatrixV[0].z;
  v_8.y = unity_MatrixV[1].z;
  v_8.z = unity_MatrixV[2].z;
  v_8.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD5 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD5), v_8.xyz), sqrt(dot (tmpvar_9, tmpvar_9)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = xlv_TEXCOORD5;
  lowp float tmpvar_13;
  highp vec4 shadowCoord_14;
  shadowCoord_14 = (unity_WorldToShadow[0] * tmpvar_12);
  highp float lightShadowDataX_15;
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((texture2D (_ShadowMapTexture, shadowCoord_14.xy).x > shadowCoord_14.z)), lightShadowDataX_15);
  tmpvar_13 = tmpvar_17;
  realtimeShadowAttenuation_7 = tmpvar_13;
  mediump float tmpvar_18;
  tmpvar_18 = clamp ((realtimeShadowAttenuation_7 + tmpvar_10), 0.0, 1.0);
  shadow_1 = tmpvar_18;
  lowp float tmpvar_19;
  tmpvar_19 = (texture2D (_LightTexture0, tmpvar_6).w * shadow_1);
  mediump vec3 tmpvar_20;
  tmpvar_20.x = xlv_TEXCOORD2.w;
  tmpvar_20.y = xlv_TEXCOORD2_1.w;
  tmpvar_20.z = xlv_TEXCOORD2_2.w;
  mediump float atten_21;
  atten_21 = tmpvar_19;
  mediump vec3 tmpvar_22;
  tmpvar_22 = _LightColor0.xyz;
  tmpvar_22 = (tmpvar_22 * atten_21);
  mediump float specularTerm_23;
  mediump vec3 tmpvar_24;
  mediump vec3 inVec_25;
  inVec_25 = (tmpvar_20 - normalize(xlv_TEXCOORD1));
  tmpvar_24 = (inVec_25 * inversesqrt(max (0.001, 
    dot (inVec_25, inVec_25)
  )));
  mediump float tmpvar_26;
  tmpvar_26 = clamp (dot (tmpvar_4, tmpvar_24), 0.0, 1.0);
  mediump float tmpvar_27;
  tmpvar_27 = (1.0 - _Glossiness);
  mediump float tmpvar_28;
  tmpvar_28 = (tmpvar_27 * tmpvar_27);
  specularTerm_23 = ((tmpvar_28 / (
    (max (0.32, clamp (dot (tmpvar_20, tmpvar_24), 0.0, 1.0)) * (1.5 + tmpvar_28))
   * 
    (((tmpvar_26 * tmpvar_26) * ((tmpvar_28 * tmpvar_28) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_29;
  tmpvar_29 = clamp (specularTerm_23, 0.0, 100.0);
  specularTerm_23 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = (((
    (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)))
   + 
    (tmpvar_29 * mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic)))
  ) * tmpvar_22) * clamp (dot (tmpvar_4, tmpvar_20), 0.0, 1.0));
  mediump vec4 xlat_varoutput_31;
  xlat_varoutput_31.xyz = tmpvar_30.xyz;
  xlat_varoutput_31.w = 1.0;
  gl_FragData[0] = xlat_varoutput_31;
}


#endif
"
}
SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec3 lightDir_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  lightDir_6 = tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec3 n_16;
  n_16 = lightDir_6;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(n_16);
  tmpvar_15 = tmpvar_17;
  lightDir_6 = tmpvar_15;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_18;
  highp vec3 norm_19;
  norm_19 = tmpvar_1;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((norm_19 * tmpvar_20));
  normalWorld_4 = tmpvar_21;
  tmpvar_8.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_15;
  xlv_TEXCOORD5 = normalWorld_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform highp samplerCube _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float shadow_1;
  highp vec3 lightCoord_2;
  mediump vec3 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_5;
  tmpvar_5 = (_Color.xyz * tmpvar_4.xyz);
  mediump float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD3.yzw, xlv_TEXCOORD4);
  mediump vec2 tmpvar_7;
  tmpvar_7.x = ((tmpvar_6 * tmpvar_6) * (tmpvar_6 * tmpvar_6));
  tmpvar_7.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_NHxRoughness, tmpvar_7);
  c_3 = (((tmpvar_5 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_8.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_5, vec3(_Metallic))
  )) * _LightColor0.xyz);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD1;
  lightCoord_2 = (unity_WorldToLight * tmpvar_9).xyz;
  highp vec3 vec_10;
  vec_10 = (xlv_TEXCOORD1 - _LightPositionRange.xyz);
  highp float mydist_11;
  mydist_11 = ((sqrt(
    dot (vec_10, vec_10)
  ) * _LightPositionRange.w) * 0.97);
  highp float tmpvar_12;
  tmpvar_12 = dot (textureCube (_ShadowMapTexture, vec_10), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  mediump float tmpvar_13;
  if ((tmpvar_12 < mydist_11)) {
    tmpvar_13 = _LightShadowData.x;
  } else {
    tmpvar_13 = 1.0;
  };
  shadow_1 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (lightCoord_2, lightCoord_2);
  lowp float tmpvar_15;
  tmpvar_15 = (texture2D (_LightTexture0, vec2(tmpvar_14)).w * shadow_1);
  c_3 = (c_3 * (tmpvar_15 * clamp (
    dot (xlv_TEXCOORD5, xlv_TEXCOORD4)
  , 0.0, 1.0)));
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = c_3;
  mediump vec4 xlat_varoutput_17;
  xlat_varoutput_17.xyz = tmpvar_16.xyz;
  xlat_varoutput_17.w = 1.0;
  gl_FragData[0] = xlat_varoutput_17;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  mediump vec3 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  lightDir_4 = tmpvar_20;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _LightPositionRange;
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float shadow_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD5;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xyz;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD5 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD5), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  highp vec3 vec_14;
  vec_14 = (xlv_TEXCOORD5 - _LightPositionRange.xyz);
  highp float mydist_15;
  mydist_15 = ((sqrt(
    dot (vec_14, vec_14)
  ) * _LightPositionRange.w) * 0.97);
  highp float tmpvar_16;
  tmpvar_16 = dot (textureCube (_ShadowMapTexture, vec_14), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  mediump float tmpvar_17;
  if ((tmpvar_16 < mydist_15)) {
    tmpvar_17 = _LightShadowData.x;
  } else {
    tmpvar_17 = 1.0;
  };
  mediump float tmpvar_18;
  tmpvar_18 = clamp ((tmpvar_17 + tmpvar_12), 0.0, 1.0);
  shadow_1 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_9, tmpvar_9);
  lowp float tmpvar_20;
  tmpvar_20 = (texture2D (_LightTexture0, vec2(tmpvar_19)).w * shadow_1);
  mediump vec3 tmpvar_21;
  tmpvar_21.x = xlv_TEXCOORD2.w;
  tmpvar_21.y = xlv_TEXCOORD2_1.w;
  tmpvar_21.z = xlv_TEXCOORD2_2.w;
  mediump float atten_22;
  atten_22 = tmpvar_20;
  mediump vec3 tmpvar_23;
  tmpvar_23 = _LightColor0.xyz;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(tmpvar_21);
  tmpvar_23 = (tmpvar_23 * atten_22);
  mediump float specularTerm_25;
  mediump vec3 tmpvar_26;
  mediump vec3 inVec_27;
  inVec_27 = (tmpvar_24 - tmpvar_7);
  tmpvar_26 = (inVec_27 * inversesqrt(max (0.001, 
    dot (inVec_27, inVec_27)
  )));
  mediump float tmpvar_28;
  tmpvar_28 = clamp (dot (tmpvar_6, tmpvar_26), 0.0, 1.0);
  mediump float tmpvar_29;
  tmpvar_29 = (1.0 - _Glossiness);
  mediump float tmpvar_30;
  tmpvar_30 = (tmpvar_29 * tmpvar_29);
  specularTerm_25 = ((tmpvar_30 / (
    (max (0.32, clamp (dot (tmpvar_24, tmpvar_26), 0.0, 1.0)) * (1.5 + tmpvar_30))
   * 
    (((tmpvar_28 * tmpvar_28) * ((tmpvar_30 * tmpvar_30) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_31;
  tmpvar_31 = clamp (specularTerm_25, 0.0, 100.0);
  specularTerm_25 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = (((tmpvar_4 + 
    (tmpvar_31 * tmpvar_5)
  ) * tmpvar_23) * clamp (dot (tmpvar_6, tmpvar_24), 0.0, 1.0));
  mediump vec4 xlat_varoutput_33;
  xlat_varoutput_33.xyz = tmpvar_32.xyz;
  xlat_varoutput_33.w = 1.0;
  gl_FragData[0] = xlat_varoutput_33;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  mediump vec3 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  lightDir_4 = tmpvar_20;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _LightPositionRange;
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float shadow_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD5;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xyz;
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].z;
  v_10.y = unity_MatrixV[1].z;
  v_10.z = unity_MatrixV[2].z;
  v_10.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD5 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD5), v_10.xyz), sqrt(dot (tmpvar_11, tmpvar_11)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  highp vec3 vec_14;
  vec_14 = (xlv_TEXCOORD5 - _LightPositionRange.xyz);
  highp float mydist_15;
  mydist_15 = ((sqrt(
    dot (vec_14, vec_14)
  ) * _LightPositionRange.w) * 0.97);
  highp float tmpvar_16;
  tmpvar_16 = dot (textureCube (_ShadowMapTexture, vec_14), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  mediump float tmpvar_17;
  if ((tmpvar_16 < mydist_15)) {
    tmpvar_17 = _LightShadowData.x;
  } else {
    tmpvar_17 = 1.0;
  };
  mediump float tmpvar_18;
  tmpvar_18 = clamp ((tmpvar_17 + tmpvar_12), 0.0, 1.0);
  shadow_1 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_9, tmpvar_9);
  lowp float tmpvar_20;
  tmpvar_20 = (texture2D (_LightTexture0, vec2(tmpvar_19)).w * shadow_1);
  mediump vec3 tmpvar_21;
  tmpvar_21.x = xlv_TEXCOORD2.w;
  tmpvar_21.y = xlv_TEXCOORD2_1.w;
  tmpvar_21.z = xlv_TEXCOORD2_2.w;
  mediump float atten_22;
  atten_22 = tmpvar_20;
  mediump vec3 tmpvar_23;
  tmpvar_23 = _LightColor0.xyz;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(tmpvar_21);
  tmpvar_23 = (tmpvar_23 * atten_22);
  mediump float specularTerm_25;
  mediump vec3 tmpvar_26;
  mediump vec3 inVec_27;
  inVec_27 = (tmpvar_24 - tmpvar_7);
  tmpvar_26 = (inVec_27 * inversesqrt(max (0.001, 
    dot (inVec_27, inVec_27)
  )));
  mediump float tmpvar_28;
  tmpvar_28 = clamp (dot (tmpvar_6, tmpvar_26), 0.0, 1.0);
  mediump float tmpvar_29;
  tmpvar_29 = (1.0 - _Glossiness);
  mediump float tmpvar_30;
  tmpvar_30 = (tmpvar_29 * tmpvar_29);
  specularTerm_25 = ((tmpvar_30 / (
    (max (0.32, clamp (dot (tmpvar_24, tmpvar_26), 0.0, 1.0)) * (1.5 + tmpvar_30))
   * 
    (((tmpvar_28 * tmpvar_28) * ((tmpvar_30 * tmpvar_30) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_31;
  tmpvar_31 = clamp (specularTerm_25, 0.0, 100.0);
  specularTerm_25 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = (((tmpvar_4 + 
    (tmpvar_31 * tmpvar_5)
  ) * tmpvar_23) * clamp (dot (tmpvar_6, tmpvar_24), 0.0, 1.0));
  mediump vec4 xlat_varoutput_33;
  xlat_varoutput_33.xyz = tmpvar_32.xyz;
  xlat_varoutput_33.w = 1.0;
  gl_FragData[0] = xlat_varoutput_33;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
""
}
}
}
 Pass {
  Name "SHADOWCASTER"
  LOD 300
  Tags { "LIGHTMODE" = "SHADOWCASTER" "PerformanceChecks" = "False" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ZClip Off
  GpuProgramID 162081
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 wPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  wPos_2 = tmpvar_3;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp mat3 tmpvar_4;
    tmpvar_4[0] = unity_WorldToObject[0].xyz;
    tmpvar_4[1] = unity_WorldToObject[1].xyz;
    tmpvar_4[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_5;
    tmpvar_5 = normalize((_glesNormal * tmpvar_4));
    highp float tmpvar_6;
    tmpvar_6 = dot (tmpvar_5, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_3.xyz * _WorldSpaceLightPos0.w)
    )));
    wPos_2.xyz = (tmpvar_3.xyz - (tmpvar_5 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_6 * tmpvar_6)))
    )));
  };
  tmpvar_1 = (unity_MatrixVP * wPos_2);
  highp vec4 clipPos_7;
  clipPos_7.xyw = tmpvar_1.xyw;
  clipPos_7.z = (tmpvar_1.z + clamp ((unity_LightShadowBias.x / tmpvar_1.w), 0.0, 1.0));
  clipPos_7.z = mix (clipPos_7.z, max (clipPos_7.z, -(tmpvar_1.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_7;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 wPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  wPos_2 = tmpvar_3;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp mat3 tmpvar_4;
    tmpvar_4[0] = unity_WorldToObject[0].xyz;
    tmpvar_4[1] = unity_WorldToObject[1].xyz;
    tmpvar_4[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_5;
    tmpvar_5 = normalize((_glesNormal * tmpvar_4));
    highp float tmpvar_6;
    tmpvar_6 = dot (tmpvar_5, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_3.xyz * _WorldSpaceLightPos0.w)
    )));
    wPos_2.xyz = (tmpvar_3.xyz - (tmpvar_5 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_6 * tmpvar_6)))
    )));
  };
  tmpvar_1 = (unity_MatrixVP * wPos_2);
  highp vec4 clipPos_7;
  clipPos_7.xyw = tmpvar_1.xyw;
  clipPos_7.z = (tmpvar_1.z + clamp ((unity_LightShadowBias.x / tmpvar_1.w), 0.0, 1.0));
  clipPos_7.z = mix (clipPos_7.z, max (clipPos_7.z, -(tmpvar_1.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_7;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 wPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  wPos_2 = tmpvar_3;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp mat3 tmpvar_4;
    tmpvar_4[0] = unity_WorldToObject[0].xyz;
    tmpvar_4[1] = unity_WorldToObject[1].xyz;
    tmpvar_4[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_5;
    tmpvar_5 = normalize((_glesNormal * tmpvar_4));
    highp float tmpvar_6;
    tmpvar_6 = dot (tmpvar_5, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_3.xyz * _WorldSpaceLightPos0.w)
    )));
    wPos_2.xyz = (tmpvar_3.xyz - (tmpvar_5 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_6 * tmpvar_6)))
    )));
  };
  tmpvar_1 = (unity_MatrixVP * wPos_2);
  highp vec4 clipPos_7;
  clipPos_7.xyw = tmpvar_1.xyw;
  clipPos_7.z = (tmpvar_1.z + clamp ((unity_LightShadowBias.x / tmpvar_1.w), 0.0, 1.0));
  clipPos_7.z = mix (clipPos_7.z, max (clipPos_7.z, -(tmpvar_1.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_7;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_2 = (tmpvar_3 - (tmpvar_3.yzww * 0.003921569));
  tmpvar_1 = enc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_2 = (tmpvar_3 - (tmpvar_3.yzww * 0.003921569));
  tmpvar_1 = enc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_2 = (tmpvar_3 - (tmpvar_3.yzww * 0.003921569));
  tmpvar_1 = enc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
""
}
}
}
 Pass {
  Name "DEFERRED"
  LOD 300
  Tags { "LIGHTMODE" = "DEFERRED" "PerformanceChecks" = "False" "RenderType" = "Opaque" }
  ZClip Off
  GpuProgramID 244627
Program "vp" {
SubProgram "gles " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  tmpvar_7.w = 0.0;
  mediump vec3 normal_19;
  normal_19 = tmpvar_18;
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_19.xyzz * normal_19.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  tmpvar_7.xyz = (x1_20 + (unity_SHC.xyz * (
    (normal_19.x * normal_19.x)
   - 
    (normal_19.y * normal_19.y)
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
#extension GL_EXT_draw_buffers : enable
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec2 mg_2;
  mg_2.x = _Metallic;
  mg_2.y = _Glossiness;
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_1.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump float occ_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((1.0 - _OcclusionStrength) + (occ_6 * _OcclusionStrength));
  mediump vec3 tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_5;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_10);
  x_11.y = dot (unity_SHAg, tmpvar_10);
  x_11.z = dot (unity_SHAb, tmpvar_10);
  tmpvar_9 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_11)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_9 = (tmpvar_9 * tmpvar_8);
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = tmpvar_4;
  tmpvar_12.w = tmpvar_8;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  tmpvar_13.w = mg_2.y;
  mediump vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((tmpvar_5 * 0.5) + 0.5);
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = exp2(-((tmpvar_9 * tmpvar_4)));
  gl_FragData[0] = tmpvar_12;
  gl_FragData[1] = tmpvar_13;
  gl_FragData[2] = tmpvar_14;
  gl_FragData[3] = tmpvar_15;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  tmpvar_7.w = 0.0;
  mediump vec3 normal_19;
  normal_19 = tmpvar_18;
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_19.xyzz * normal_19.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  tmpvar_7.xyz = (x1_20 + (unity_SHC.xyz * (
    (normal_19.x * normal_19.x)
   - 
    (normal_19.y * normal_19.y)
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
#extension GL_EXT_draw_buffers : enable
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec2 mg_2;
  mg_2.x = _Metallic;
  mg_2.y = _Glossiness;
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_1.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump float occ_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((1.0 - _OcclusionStrength) + (occ_6 * _OcclusionStrength));
  mediump vec3 tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_5;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_10);
  x_11.y = dot (unity_SHAg, tmpvar_10);
  x_11.z = dot (unity_SHAb, tmpvar_10);
  tmpvar_9 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_11)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_9 = (tmpvar_9 * tmpvar_8);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (tmpvar_9 * tmpvar_4);
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = tmpvar_4;
  tmpvar_13.w = tmpvar_8;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  tmpvar_14.w = mg_2.y;
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = ((tmpvar_5 * 0.5) + 0.5);
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = exp2(-(tmpvar_12.xyz));
  gl_FragData[0] = tmpvar_13;
  gl_FragData[1] = tmpvar_14;
  gl_FragData[2] = tmpvar_15;
  gl_FragData[3] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  tmpvar_7.w = 0.0;
  mediump vec3 normal_19;
  normal_19 = tmpvar_18;
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_19.xyzz * normal_19.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  tmpvar_7.xyz = (x1_20 + (unity_SHC.xyz * (
    (normal_19.x * normal_19.x)
   - 
    (normal_19.y * normal_19.y)
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
#extension GL_EXT_draw_buffers : enable
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec2 mg_2;
  mg_2.x = _Metallic;
  mg_2.y = _Glossiness;
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_1.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump float occ_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((1.0 - _OcclusionStrength) + (occ_6 * _OcclusionStrength));
  mediump vec3 tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_5;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_10);
  x_11.y = dot (unity_SHAg, tmpvar_10);
  x_11.z = dot (unity_SHAb, tmpvar_10);
  tmpvar_9 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_11)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_9 = (tmpvar_9 * tmpvar_8);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (tmpvar_9 * tmpvar_4);
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = tmpvar_4;
  tmpvar_13.w = tmpvar_8;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  tmpvar_14.w = mg_2.y;
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = ((tmpvar_5 * 0.5) + 0.5);
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = exp2(-(tmpvar_12.xyz));
  gl_FragData[0] = tmpvar_13;
  gl_FragData[1] = tmpvar_14;
  gl_FragData[2] = tmpvar_15;
  gl_FragData[3] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  tmpvar_7.w = 0.0;
  mediump vec3 normal_19;
  normal_19 = tmpvar_18;
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_19.xyzz * normal_19.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  tmpvar_7.xyz = (x1_20 + (unity_SHC.xyz * (
    (normal_19.x * normal_19.x)
   - 
    (normal_19.y * normal_19.y)
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
#extension GL_EXT_draw_buffers : enable
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec2 mg_2;
  mg_2.x = _Metallic;
  mg_2.y = _Glossiness;
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_1.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump float occ_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((1.0 - _OcclusionStrength) + (occ_6 * _OcclusionStrength));
  mediump vec3 tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_5;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_10);
  x_11.y = dot (unity_SHAg, tmpvar_10);
  x_11.z = dot (unity_SHAb, tmpvar_10);
  tmpvar_9 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_11)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_9 = (tmpvar_9 * tmpvar_8);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (tmpvar_9 * tmpvar_4);
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = tmpvar_4;
  tmpvar_13.w = tmpvar_8;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  tmpvar_14.w = mg_2.y;
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = ((tmpvar_5 * 0.5) + 0.5);
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_12.xyz;
  gl_FragData[0] = tmpvar_13;
  gl_FragData[1] = tmpvar_14;
  gl_FragData[2] = tmpvar_15;
  gl_FragData[3] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  tmpvar_7.w = 0.0;
  mediump vec3 normal_19;
  normal_19 = tmpvar_18;
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_19.xyzz * normal_19.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  tmpvar_7.xyz = (x1_20 + (unity_SHC.xyz * (
    (normal_19.x * normal_19.x)
   - 
    (normal_19.y * normal_19.y)
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
#extension GL_EXT_draw_buffers : enable
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec2 mg_2;
  mg_2.x = _Metallic;
  mg_2.y = _Glossiness;
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_1.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump float occ_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((1.0 - _OcclusionStrength) + (occ_6 * _OcclusionStrength));
  mediump vec3 tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_5;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_10);
  x_11.y = dot (unity_SHAg, tmpvar_10);
  x_11.z = dot (unity_SHAb, tmpvar_10);
  tmpvar_9 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_11)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_9 = (tmpvar_9 * tmpvar_8);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (tmpvar_9 * tmpvar_4);
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = tmpvar_4;
  tmpvar_13.w = tmpvar_8;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  tmpvar_14.w = mg_2.y;
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = ((tmpvar_5 * 0.5) + 0.5);
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_12.xyz;
  gl_FragData[0] = tmpvar_13;
  gl_FragData[1] = tmpvar_14;
  gl_FragData[2] = tmpvar_15;
  gl_FragData[3] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  tmpvar_7.w = 0.0;
  mediump vec3 normal_19;
  normal_19 = tmpvar_18;
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_19.xyzz * normal_19.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  tmpvar_7.xyz = (x1_20 + (unity_SHC.xyz * (
    (normal_19.x * normal_19.x)
   - 
    (normal_19.y * normal_19.y)
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
#extension GL_EXT_draw_buffers : enable
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec2 mg_2;
  mg_2.x = _Metallic;
  mg_2.y = _Glossiness;
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_1.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump float occ_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((1.0 - _OcclusionStrength) + (occ_6 * _OcclusionStrength));
  mediump vec3 tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_5;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_10);
  x_11.y = dot (unity_SHAg, tmpvar_10);
  x_11.z = dot (unity_SHAb, tmpvar_10);
  tmpvar_9 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_11)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_9 = (tmpvar_9 * tmpvar_8);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (tmpvar_9 * tmpvar_4);
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = tmpvar_4;
  tmpvar_13.w = tmpvar_8;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  tmpvar_14.w = mg_2.y;
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = ((tmpvar_5 * 0.5) + 0.5);
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_12.xyz;
  gl_FragData[0] = tmpvar_13;
  gl_FragData[1] = tmpvar_14;
  gl_FragData[2] = tmpvar_15;
  gl_FragData[3] = tmpvar_16;
}


#endif
"
}
SubProgram "gles " {
Keywords { "_EMISSION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  tmpvar_7.w = 0.0;
  mediump vec3 normal_19;
  normal_19 = tmpvar_18;
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_19.xyzz * normal_19.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  tmpvar_7.xyz = (x1_20 + (unity_SHC.xyz * (
    (normal_19.x * normal_19.x)
   - 
    (normal_19.y * normal_19.y)
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
#extension GL_EXT_draw_buffers : enable
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 emissiveColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec2 mg_3;
  mg_3.x = _Metallic;
  mg_3.y = _Glossiness;
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump float occ_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_7 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = ((1.0 - _OcclusionStrength) + (occ_7 * _OcclusionStrength));
  mediump vec3 tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_6;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, tmpvar_11);
  x_12.y = dot (unity_SHAg, tmpvar_11);
  x_12.z = dot (unity_SHAb, tmpvar_11);
  tmpvar_10 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_12)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_10 = (tmpvar_10 * tmpvar_9);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  emissiveColor_1 = ((tmpvar_10 * tmpvar_5) + (tmpvar_13.xyz * _EmissionColor.xyz));
  emissiveColor_1 = exp2(-(emissiveColor_1));
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_5;
  tmpvar_14.w = tmpvar_9;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  tmpvar_15.w = mg_3.y;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = ((tmpvar_6 * 0.5) + 0.5);
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = emissiveColor_1;
  gl_FragData[0] = tmpvar_14;
  gl_FragData[1] = tmpvar_15;
  gl_FragData[2] = tmpvar_16;
  gl_FragData[3] = tmpvar_17;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_EMISSION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  tmpvar_7.w = 0.0;
  mediump vec3 normal_19;
  normal_19 = tmpvar_18;
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_19.xyzz * normal_19.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  tmpvar_7.xyz = (x1_20 + (unity_SHC.xyz * (
    (normal_19.x * normal_19.x)
   - 
    (normal_19.y * normal_19.y)
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
#extension GL_EXT_draw_buffers : enable
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 emissiveColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec2 mg_3;
  mg_3.x = _Metallic;
  mg_3.y = _Glossiness;
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump float occ_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_7 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = ((1.0 - _OcclusionStrength) + (occ_7 * _OcclusionStrength));
  mediump vec3 tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_6;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, tmpvar_11);
  x_12.y = dot (unity_SHAg, tmpvar_11);
  x_12.z = dot (unity_SHAb, tmpvar_11);
  tmpvar_10 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_12)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_10 = (tmpvar_10 * tmpvar_9);
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = (tmpvar_10 * tmpvar_5);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  emissiveColor_1 = (tmpvar_13.xyz + (tmpvar_14.xyz * _EmissionColor.xyz));
  emissiveColor_1 = exp2(-(emissiveColor_1));
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_5;
  tmpvar_15.w = tmpvar_9;
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  tmpvar_16.w = mg_3.y;
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = ((tmpvar_6 * 0.5) + 0.5);
  mediump vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = emissiveColor_1;
  gl_FragData[0] = tmpvar_15;
  gl_FragData[1] = tmpvar_16;
  gl_FragData[2] = tmpvar_17;
  gl_FragData[3] = tmpvar_18;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_EMISSION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  tmpvar_7.w = 0.0;
  mediump vec3 normal_19;
  normal_19 = tmpvar_18;
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_19.xyzz * normal_19.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  tmpvar_7.xyz = (x1_20 + (unity_SHC.xyz * (
    (normal_19.x * normal_19.x)
   - 
    (normal_19.y * normal_19.y)
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
#extension GL_EXT_draw_buffers : enable
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 emissiveColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec2 mg_3;
  mg_3.x = _Metallic;
  mg_3.y = _Glossiness;
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump float occ_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_7 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = ((1.0 - _OcclusionStrength) + (occ_7 * _OcclusionStrength));
  mediump vec3 tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_6;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, tmpvar_11);
  x_12.y = dot (unity_SHAg, tmpvar_11);
  x_12.z = dot (unity_SHAb, tmpvar_11);
  tmpvar_10 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_12)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_10 = (tmpvar_10 * tmpvar_9);
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = (tmpvar_10 * tmpvar_5);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  emissiveColor_1 = (tmpvar_13.xyz + (tmpvar_14.xyz * _EmissionColor.xyz));
  emissiveColor_1 = exp2(-(emissiveColor_1));
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_5;
  tmpvar_15.w = tmpvar_9;
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  tmpvar_16.w = mg_3.y;
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = ((tmpvar_6 * 0.5) + 0.5);
  mediump vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = emissiveColor_1;
  gl_FragData[0] = tmpvar_15;
  gl_FragData[1] = tmpvar_16;
  gl_FragData[2] = tmpvar_17;
  gl_FragData[3] = tmpvar_18;
}


#endif
"
}
SubProgram "gles " {
Keywords { "_EMISSION" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  tmpvar_7.w = 0.0;
  mediump vec3 normal_19;
  normal_19 = tmpvar_18;
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_19.xyzz * normal_19.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  tmpvar_7.xyz = (x1_20 + (unity_SHC.xyz * (
    (normal_19.x * normal_19.x)
   - 
    (normal_19.y * normal_19.y)
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
#extension GL_EXT_draw_buffers : enable
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec2 mg_2;
  mg_2.x = _Metallic;
  mg_2.y = _Glossiness;
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_1.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump float occ_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((1.0 - _OcclusionStrength) + (occ_6 * _OcclusionStrength));
  mediump vec3 tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_5;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_10);
  x_11.y = dot (unity_SHAg, tmpvar_10);
  x_11.z = dot (unity_SHAb, tmpvar_10);
  tmpvar_9 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_11)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_9 = (tmpvar_9 * tmpvar_8);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = tmpvar_4;
  tmpvar_13.w = tmpvar_8;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  tmpvar_14.w = mg_2.y;
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = ((tmpvar_5 * 0.5) + 0.5);
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = ((tmpvar_9 * tmpvar_4) + (tmpvar_12.xyz * _EmissionColor.xyz));
  gl_FragData[0] = tmpvar_13;
  gl_FragData[1] = tmpvar_14;
  gl_FragData[2] = tmpvar_15;
  gl_FragData[3] = tmpvar_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_EMISSION" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  tmpvar_7.w = 0.0;
  mediump vec3 normal_19;
  normal_19 = tmpvar_18;
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_19.xyzz * normal_19.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  tmpvar_7.xyz = (x1_20 + (unity_SHC.xyz * (
    (normal_19.x * normal_19.x)
   - 
    (normal_19.y * normal_19.y)
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
#extension GL_EXT_draw_buffers : enable
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec2 mg_2;
  mg_2.x = _Metallic;
  mg_2.y = _Glossiness;
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_1.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump float occ_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((1.0 - _OcclusionStrength) + (occ_6 * _OcclusionStrength));
  mediump vec3 tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_5;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_10);
  x_11.y = dot (unity_SHAg, tmpvar_10);
  x_11.z = dot (unity_SHAb, tmpvar_10);
  tmpvar_9 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_11)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_9 = (tmpvar_9 * tmpvar_8);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (tmpvar_9 * tmpvar_4);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_4;
  tmpvar_14.w = tmpvar_8;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  tmpvar_15.w = mg_2.y;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = ((tmpvar_5 * 0.5) + 0.5);
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = (tmpvar_12.xyz + (tmpvar_13.xyz * _EmissionColor.xyz));
  gl_FragData[0] = tmpvar_14;
  gl_FragData[1] = tmpvar_15;
  gl_FragData[2] = tmpvar_16;
  gl_FragData[3] = tmpvar_17;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_EMISSION" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  tmpvar_7.w = 0.0;
  mediump vec3 normal_19;
  normal_19 = tmpvar_18;
  mediump vec3 x1_20;
  mediump vec4 tmpvar_21;
  tmpvar_21 = (normal_19.xyzz * normal_19.yzzx);
  x1_20.x = dot (unity_SHBr, tmpvar_21);
  x1_20.y = dot (unity_SHBg, tmpvar_21);
  x1_20.z = dot (unity_SHBb, tmpvar_21);
  tmpvar_7.xyz = (x1_20 + (unity_SHC.xyz * (
    (normal_19.x * normal_19.x)
   - 
    (normal_19.y * normal_19.y)
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
#extension GL_EXT_draw_buffers : enable
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec2 mg_2;
  mg_2.x = _Metallic;
  mg_2.y = _Glossiness;
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_1.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump float occ_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_6 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((1.0 - _OcclusionStrength) + (occ_6 * _OcclusionStrength));
  mediump vec3 tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_5;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_10);
  x_11.y = dot (unity_SHAg, tmpvar_10);
  x_11.z = dot (unity_SHAb, tmpvar_10);
  tmpvar_9 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_11)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_9 = (tmpvar_9 * tmpvar_8);
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (tmpvar_9 * tmpvar_4);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_4;
  tmpvar_14.w = tmpvar_8;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  tmpvar_15.w = mg_2.y;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = ((tmpvar_5 * 0.5) + 0.5);
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = (tmpvar_12.xyz + (tmpvar_13.xyz * _EmissionColor.xyz));
  gl_FragData[0] = tmpvar_14;
  gl_FragData[1] = tmpvar_15;
  gl_FragData[2] = tmpvar_16;
  gl_FragData[3] = tmpvar_17;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_HDR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_HDR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_HDR_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_EMISSION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_EMISSION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_EMISSION" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_EMISSION" "UNITY_HDR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_EMISSION" "UNITY_HDR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_EMISSION" "UNITY_HDR_ON" }
""
}
}
}
 Pass {
  Name "META"
  LOD 300
  Tags { "LIGHTMODE" = "META" "PerformanceChecks" = "False" "RenderType" = "Opaque" }
  ZClip Off
  Cull Off
  GpuProgramID 274847
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
uniform bvec4 unity_MetaVertexControl;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  highp vec4 vertex_3;
  vertex_3 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_4;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_4 = 0.0001;
    } else {
      tmpvar_4 = 0.0;
    };
    vertex_3.z = tmpvar_4;
  };
  if (unity_MetaVertexControl.y) {
    vertex_3.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_5;
    if ((vertex_3.z > 0.0)) {
      tmpvar_5 = 0.0001;
    } else {
      tmpvar_5 = 0.0;
    };
    vertex_3.z = tmpvar_5;
  };
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = vertex_3.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 texcoord_8;
  texcoord_8.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  xlv_TEXCOORD0 = texcoord_8;
  gl_Position = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 res_4;
  mediump float tmpvar_5;
  tmpvar_5 = (1.0 - _Glossiness);
  res_4 = ((tmpvar_3 * (0.7790837 - 
    (_Metallic * 0.7790837)
  )) + ((
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic))
   * 
    (tmpvar_5 * tmpvar_5)
  ) * 0.5));
  mediump vec4 res_6;
  res_6 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_7;
    tmpvar_7.w = 1.0;
    tmpvar_7.xyz = res_4;
    res_6.w = tmpvar_7.w;
    highp vec3 tmpvar_8;
    tmpvar_8 = clamp (pow (res_4, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_6.xyz = tmpvar_8;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_9;
    if (bool(unity_UseLinearSpace)) {
      emission_9 = vec3(0.0, 0.0, 0.0);
    } else {
      emission_9 = vec3(0.0, 0.0, 0.0);
    };
    mediump vec4 tmpvar_10;
    highp float alpha_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = (emission_9 * 0.01030928);
    alpha_11 = (ceil((
      max (max (tmpvar_12.x, tmpvar_12.y), max (tmpvar_12.z, 0.02))
     * 255.0)) / 255.0);
    highp float tmpvar_13;
    tmpvar_13 = max (alpha_11, 0.02);
    alpha_11 = tmpvar_13;
    highp vec4 tmpvar_14;
    tmpvar_14.xyz = (tmpvar_12 / tmpvar_13);
    tmpvar_14.w = tmpvar_13;
    tmpvar_10 = tmpvar_14;
    res_6 = tmpvar_10;
  };
  tmpvar_1 = res_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
uniform bvec4 unity_MetaVertexControl;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  highp vec4 vertex_3;
  vertex_3 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_4;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_4 = 0.0001;
    } else {
      tmpvar_4 = 0.0;
    };
    vertex_3.z = tmpvar_4;
  };
  if (unity_MetaVertexControl.y) {
    vertex_3.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_5;
    if ((vertex_3.z > 0.0)) {
      tmpvar_5 = 0.0001;
    } else {
      tmpvar_5 = 0.0;
    };
    vertex_3.z = tmpvar_5;
  };
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = vertex_3.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 texcoord_8;
  texcoord_8.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  xlv_TEXCOORD0 = texcoord_8;
  gl_Position = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 res_4;
  mediump float tmpvar_5;
  tmpvar_5 = (1.0 - _Glossiness);
  res_4 = ((tmpvar_3 * (0.7790837 - 
    (_Metallic * 0.7790837)
  )) + ((
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic))
   * 
    (tmpvar_5 * tmpvar_5)
  ) * 0.5));
  mediump vec4 res_6;
  res_6 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_7;
    tmpvar_7.w = 1.0;
    tmpvar_7.xyz = res_4;
    res_6.w = tmpvar_7.w;
    highp vec3 tmpvar_8;
    tmpvar_8 = clamp (pow (res_4, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_6.xyz = tmpvar_8;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_9;
    if (bool(unity_UseLinearSpace)) {
      emission_9 = vec3(0.0, 0.0, 0.0);
    } else {
      emission_9 = vec3(0.0, 0.0, 0.0);
    };
    mediump vec4 tmpvar_10;
    highp float alpha_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = (emission_9 * 0.01030928);
    alpha_11 = (ceil((
      max (max (tmpvar_12.x, tmpvar_12.y), max (tmpvar_12.z, 0.02))
     * 255.0)) / 255.0);
    highp float tmpvar_13;
    tmpvar_13 = max (alpha_11, 0.02);
    alpha_11 = tmpvar_13;
    highp vec4 tmpvar_14;
    tmpvar_14.xyz = (tmpvar_12 / tmpvar_13);
    tmpvar_14.w = tmpvar_13;
    tmpvar_10 = tmpvar_14;
    res_6 = tmpvar_10;
  };
  tmpvar_1 = res_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
uniform bvec4 unity_MetaVertexControl;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  highp vec4 vertex_3;
  vertex_3 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_4;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_4 = 0.0001;
    } else {
      tmpvar_4 = 0.0;
    };
    vertex_3.z = tmpvar_4;
  };
  if (unity_MetaVertexControl.y) {
    vertex_3.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_5;
    if ((vertex_3.z > 0.0)) {
      tmpvar_5 = 0.0001;
    } else {
      tmpvar_5 = 0.0;
    };
    vertex_3.z = tmpvar_5;
  };
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = vertex_3.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 texcoord_8;
  texcoord_8.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  xlv_TEXCOORD0 = texcoord_8;
  gl_Position = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 res_4;
  mediump float tmpvar_5;
  tmpvar_5 = (1.0 - _Glossiness);
  res_4 = ((tmpvar_3 * (0.7790837 - 
    (_Metallic * 0.7790837)
  )) + ((
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic))
   * 
    (tmpvar_5 * tmpvar_5)
  ) * 0.5));
  mediump vec4 res_6;
  res_6 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_7;
    tmpvar_7.w = 1.0;
    tmpvar_7.xyz = res_4;
    res_6.w = tmpvar_7.w;
    highp vec3 tmpvar_8;
    tmpvar_8 = clamp (pow (res_4, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_6.xyz = tmpvar_8;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_9;
    if (bool(unity_UseLinearSpace)) {
      emission_9 = vec3(0.0, 0.0, 0.0);
    } else {
      emission_9 = vec3(0.0, 0.0, 0.0);
    };
    mediump vec4 tmpvar_10;
    highp float alpha_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = (emission_9 * 0.01030928);
    alpha_11 = (ceil((
      max (max (tmpvar_12.x, tmpvar_12.y), max (tmpvar_12.z, 0.02))
     * 255.0)) / 255.0);
    highp float tmpvar_13;
    tmpvar_13 = max (alpha_11, 0.02);
    alpha_11 = tmpvar_13;
    highp vec4 tmpvar_14;
    tmpvar_14.xyz = (tmpvar_12 / tmpvar_13);
    tmpvar_14.w = tmpvar_13;
    tmpvar_10 = tmpvar_14;
    res_6 = tmpvar_10;
  };
  tmpvar_1 = res_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_EMISSION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
uniform bvec4 unity_MetaVertexControl;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  highp vec4 vertex_3;
  vertex_3 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_4;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_4 = 0.0001;
    } else {
      tmpvar_4 = 0.0;
    };
    vertex_3.z = tmpvar_4;
  };
  if (unity_MetaVertexControl.y) {
    vertex_3.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_5;
    if ((vertex_3.z > 0.0)) {
      tmpvar_5 = 0.0001;
    } else {
      tmpvar_5 = 0.0;
    };
    vertex_3.z = tmpvar_5;
  };
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = vertex_3.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 texcoord_8;
  texcoord_8.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  xlv_TEXCOORD0 = texcoord_8;
  gl_Position = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 res_4;
  mediump float tmpvar_5;
  tmpvar_5 = (1.0 - _Glossiness);
  res_4 = ((tmpvar_3 * (0.7790837 - 
    (_Metallic * 0.7790837)
  )) + ((
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic))
   * 
    (tmpvar_5 * tmpvar_5)
  ) * 0.5));
  mediump vec3 tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  tmpvar_6 = (tmpvar_7.xyz * _EmissionColor.xyz);
  mediump vec4 res_8;
  res_8 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 1.0;
    tmpvar_9.xyz = res_4;
    res_8.w = tmpvar_9.w;
    highp vec3 tmpvar_10;
    tmpvar_10 = clamp (pow (res_4, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_8.xyz = tmpvar_10;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_11;
    if (bool(unity_UseLinearSpace)) {
      emission_11 = tmpvar_6;
    } else {
      emission_11 = (tmpvar_6 * ((tmpvar_6 * 
        ((tmpvar_6 * 0.305306) + 0.6821711)
      ) + 0.01252288));
    };
    mediump vec4 tmpvar_12;
    highp float alpha_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = (emission_11 * 0.01030928);
    alpha_13 = (ceil((
      max (max (tmpvar_14.x, tmpvar_14.y), max (tmpvar_14.z, 0.02))
     * 255.0)) / 255.0);
    highp float tmpvar_15;
    tmpvar_15 = max (alpha_13, 0.02);
    alpha_13 = tmpvar_15;
    highp vec4 tmpvar_16;
    tmpvar_16.xyz = (tmpvar_14 / tmpvar_15);
    tmpvar_16.w = tmpvar_15;
    tmpvar_12 = tmpvar_16;
    res_8 = tmpvar_12;
  };
  tmpvar_1 = res_8;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_EMISSION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
uniform bvec4 unity_MetaVertexControl;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  highp vec4 vertex_3;
  vertex_3 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_4;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_4 = 0.0001;
    } else {
      tmpvar_4 = 0.0;
    };
    vertex_3.z = tmpvar_4;
  };
  if (unity_MetaVertexControl.y) {
    vertex_3.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_5;
    if ((vertex_3.z > 0.0)) {
      tmpvar_5 = 0.0001;
    } else {
      tmpvar_5 = 0.0;
    };
    vertex_3.z = tmpvar_5;
  };
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = vertex_3.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 texcoord_8;
  texcoord_8.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  xlv_TEXCOORD0 = texcoord_8;
  gl_Position = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 res_4;
  mediump float tmpvar_5;
  tmpvar_5 = (1.0 - _Glossiness);
  res_4 = ((tmpvar_3 * (0.7790837 - 
    (_Metallic * 0.7790837)
  )) + ((
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic))
   * 
    (tmpvar_5 * tmpvar_5)
  ) * 0.5));
  mediump vec3 tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  tmpvar_6 = (tmpvar_7.xyz * _EmissionColor.xyz);
  mediump vec4 res_8;
  res_8 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 1.0;
    tmpvar_9.xyz = res_4;
    res_8.w = tmpvar_9.w;
    highp vec3 tmpvar_10;
    tmpvar_10 = clamp (pow (res_4, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_8.xyz = tmpvar_10;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_11;
    if (bool(unity_UseLinearSpace)) {
      emission_11 = tmpvar_6;
    } else {
      emission_11 = (tmpvar_6 * ((tmpvar_6 * 
        ((tmpvar_6 * 0.305306) + 0.6821711)
      ) + 0.01252288));
    };
    mediump vec4 tmpvar_12;
    highp float alpha_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = (emission_11 * 0.01030928);
    alpha_13 = (ceil((
      max (max (tmpvar_14.x, tmpvar_14.y), max (tmpvar_14.z, 0.02))
     * 255.0)) / 255.0);
    highp float tmpvar_15;
    tmpvar_15 = max (alpha_13, 0.02);
    alpha_13 = tmpvar_15;
    highp vec4 tmpvar_16;
    tmpvar_16.xyz = (tmpvar_14 / tmpvar_15);
    tmpvar_16.w = tmpvar_15;
    tmpvar_12 = tmpvar_16;
    res_8 = tmpvar_12;
  };
  tmpvar_1 = res_8;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_EMISSION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
uniform bvec4 unity_MetaVertexControl;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  highp vec4 vertex_3;
  vertex_3 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_4;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_4 = 0.0001;
    } else {
      tmpvar_4 = 0.0;
    };
    vertex_3.z = tmpvar_4;
  };
  if (unity_MetaVertexControl.y) {
    vertex_3.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_5;
    if ((vertex_3.z > 0.0)) {
      tmpvar_5 = 0.0001;
    } else {
      tmpvar_5 = 0.0;
    };
    vertex_3.z = tmpvar_5;
  };
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = vertex_3.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 texcoord_8;
  texcoord_8.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  xlv_TEXCOORD0 = texcoord_8;
  gl_Position = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 res_4;
  mediump float tmpvar_5;
  tmpvar_5 = (1.0 - _Glossiness);
  res_4 = ((tmpvar_3 * (0.7790837 - 
    (_Metallic * 0.7790837)
  )) + ((
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic))
   * 
    (tmpvar_5 * tmpvar_5)
  ) * 0.5));
  mediump vec3 tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  tmpvar_6 = (tmpvar_7.xyz * _EmissionColor.xyz);
  mediump vec4 res_8;
  res_8 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 1.0;
    tmpvar_9.xyz = res_4;
    res_8.w = tmpvar_9.w;
    highp vec3 tmpvar_10;
    tmpvar_10 = clamp (pow (res_4, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_8.xyz = tmpvar_10;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_11;
    if (bool(unity_UseLinearSpace)) {
      emission_11 = tmpvar_6;
    } else {
      emission_11 = (tmpvar_6 * ((tmpvar_6 * 
        ((tmpvar_6 * 0.305306) + 0.6821711)
      ) + 0.01252288));
    };
    mediump vec4 tmpvar_12;
    highp float alpha_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = (emission_11 * 0.01030928);
    alpha_13 = (ceil((
      max (max (tmpvar_14.x, tmpvar_14.y), max (tmpvar_14.z, 0.02))
     * 255.0)) / 255.0);
    highp float tmpvar_15;
    tmpvar_15 = max (alpha_13, 0.02);
    alpha_13 = tmpvar_15;
    highp vec4 tmpvar_16;
    tmpvar_16.xyz = (tmpvar_14 / tmpvar_15);
    tmpvar_16.w = tmpvar_15;
    tmpvar_12 = tmpvar_16;
    res_8 = tmpvar_12;
  };
  tmpvar_1 = res_8;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_EMISSION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_EMISSION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_EMISSION" }
""
}
}
}
}
SubShader {
 LOD 150
 Tags { "PerformanceChecks" = "False" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 150
  Tags { "LIGHTMODE" = "FORWARDBASE" "PerformanceChecks" = "False" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ZClip Off
  ZWrite Off
  GpuProgramID 360084
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  normalWorld_4 = tmpvar_17;
  tmpvar_8.xyz = normalWorld_4;
  tmpvar_6.xyz = eyeVec_5;
  mediump vec4 ambientOrLightmapUV_18;
  ambientOrLightmapUV_18.w = 0.0;
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = normalWorld_4;
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, tmpvar_19);
  x_21.y = dot (unity_SHAg, tmpvar_19);
  x_21.z = dot (unity_SHAb, tmpvar_19);
  mediump vec3 x1_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = (normalWorld_4.xyzz * normalWorld_4.yzzx);
  x1_22.x = dot (unity_SHBr, tmpvar_23);
  x1_22.y = dot (unity_SHBg, tmpvar_23);
  x1_22.z = dot (unity_SHBb, tmpvar_23);
  res_20 = (x_21 + (x1_22 + (unity_SHC.xyz * 
    ((normalWorld_4.x * normalWorld_4.x) - (normalWorld_4.y * normalWorld_4.y))
  )));
  mediump vec3 tmpvar_24;
  tmpvar_24 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_24;
  ambientOrLightmapUV_18.xyz = max (vec3(0.0, 0.0, 0.0), tmpvar_24);
  tmpvar_7.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  mediump float x_25;
  x_25 = (1.0 - clamp (dot (normalWorld_4, 
    -(eyeVec_5)
  ), 0.0, 1.0));
  tmpvar_8.w = ((x_25 * x_25) * (x_25 * x_25));
  tmpvar_6.w = clamp ((_Glossiness + (1.0 - 
    (0.7790837 - (_Metallic * 0.7790837))
  )), 0.0, 1.0);
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = ambientOrLightmapUV_18;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump float rl_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_6;
  tmpvar_6 = _LightColor0.xyz;
  mediump float tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy);
  tmpvar_7 = tmpvar_8.y;
  rl_1 = dot (xlv_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
  highp vec4 tmpvar_9;
  tmpvar_9 = unity_SpecCube0_HDR;
  mediump float tmpvar_10;
  tmpvar_10 = (1.0 - _Glossiness);
  mediump vec4 hdr_11;
  hdr_11 = tmpvar_9;
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = xlv_TEXCOORD4.yzw;
  tmpvar_12.w = ((tmpvar_10 * (1.7 - 
    (0.7 * tmpvar_10)
  )) * 6.0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = impl_low_textureCubeLodEXT (unity_SpecCube0, xlv_TEXCOORD4.yzw, tmpvar_12.w);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  mediump vec2 tmpvar_15;
  tmpvar_15.x = ((rl_1 * rl_1) * (rl_1 * rl_1));
  tmpvar_15.y = tmpvar_10;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (unity_NHxRoughness, tmpvar_15);
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = (((
    (xlv_TEXCOORD2.xyz * tmpvar_7)
   * tmpvar_4) + (
    (((hdr_11.x * (
      (hdr_11.w * (tmpvar_14.w - 1.0))
     + 1.0)) * tmpvar_14.xyz) * tmpvar_7)
   * 
    mix (tmpvar_5, xlv_TEXCOORD1.www, xlv_TEXCOORD5.www)
  )) + ((tmpvar_4 + 
    ((tmpvar_16.w * 16.0) * tmpvar_5)
  ) * (tmpvar_6 * 
    clamp (dot (xlv_TEXCOORD5.xyz, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  )));
  mediump vec4 xlat_varoutput_18;
  xlat_varoutput_18.xyz = tmpvar_17.xyz;
  xlat_varoutput_18.w = 1.0;
  gl_FragData[0] = xlat_varoutput_18;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  tmpvar_14 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = normalWorld_19;
  mediump vec3 res_22;
  mediump vec3 x_23;
  x_23.x = dot (unity_SHAr, tmpvar_21);
  x_23.y = dot (unity_SHAg, tmpvar_21);
  x_23.z = dot (unity_SHAb, tmpvar_21);
  mediump vec3 x1_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_24.x = dot (unity_SHBr, tmpvar_25);
  x1_24.y = dot (unity_SHBg, tmpvar_25);
  x1_24.z = dot (unity_SHBb, tmpvar_25);
  res_22 = (x_23 + (x1_24 + (unity_SHC.xyz * 
    ((normalWorld_19.x * normalWorld_19.x) - (normalWorld_19.y * normalWorld_19.y))
  )));
  mediump vec3 tmpvar_26;
  tmpvar_26 = max (((1.055 * 
    pow (max (res_22, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_22 = tmpvar_26;
  ambientOrLightmapUV_20.xyz = max (vec3(0.0, 0.0, 0.0), tmpvar_26);
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  mediump float tmpvar_6;
  tmpvar_6 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_4 = (tmpvar_3 * tmpvar_6);
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_8;
  tmpvar_8 = _LightColor0.xyz;
  mediump float tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy);
  tmpvar_9 = tmpvar_10.y;
  highp vec4 tmpvar_11;
  tmpvar_11 = unity_SpecCube0_HDR;
  mediump vec3 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (1.0 - _Glossiness);
  tmpvar_12 = (xlv_TEXCOORD1 - (2.0 * (
    dot (tmpvar_7, xlv_TEXCOORD1)
   * tmpvar_7)));
  mediump vec4 hdr_14;
  hdr_14 = tmpvar_11;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_12;
  tmpvar_15.w = ((tmpvar_13 * (1.7 - 
    (0.7 * tmpvar_13)
  )) * 6.0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_12, tmpvar_15.w);
  mediump vec4 tmpvar_17;
  tmpvar_17 = tmpvar_16;
  mediump vec3 viewDir_18;
  viewDir_18 = -(xlv_TEXCOORD1);
  mediump vec3 color_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = dot ((viewDir_18 - (2.0 * 
    (dot (tmpvar_7, viewDir_18) * tmpvar_7)
  )), _WorldSpaceLightPos0.xyz);
  tmpvar_20.y = (1.0 - clamp (dot (tmpvar_7, viewDir_18), 0.0, 1.0));
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 * tmpvar_20) * (tmpvar_20 * tmpvar_20));
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_13;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (unity_NHxRoughness, tmpvar_22);
  color_19 = ((tmpvar_4 + (
    (tmpvar_23.w * 16.0)
   * tmpvar_5)) * (tmpvar_8 * clamp (
    dot (tmpvar_7, _WorldSpaceLightPos0.xyz)
  , 0.0, 1.0)));
  color_19 = (color_19 + ((
    (xlv_TEXCOORD5.xyz * tmpvar_9)
   * tmpvar_4) + (
    (((hdr_14.x * (
      (hdr_14.w * (tmpvar_17.w - 1.0))
     + 1.0)) * tmpvar_17.xyz) * tmpvar_9)
   * 
    mix (tmpvar_5, vec3(clamp ((_Glossiness + (1.0 - tmpvar_6)), 0.0, 1.0)), tmpvar_21.yyy)
  )));
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = color_19;
  c_1.w = tmpvar_24.w;
  c_1.xyz = color_19;
  mediump vec4 xlat_varoutput_25;
  xlat_varoutput_25.xyz = c_1.xyz;
  xlat_varoutput_25.w = 1.0;
  gl_FragData[0] = xlat_varoutput_25;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  tmpvar_14 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = normalWorld_19;
  mediump vec3 res_22;
  mediump vec3 x_23;
  x_23.x = dot (unity_SHAr, tmpvar_21);
  x_23.y = dot (unity_SHAg, tmpvar_21);
  x_23.z = dot (unity_SHAb, tmpvar_21);
  mediump vec3 x1_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_24.x = dot (unity_SHBr, tmpvar_25);
  x1_24.y = dot (unity_SHBg, tmpvar_25);
  x1_24.z = dot (unity_SHBb, tmpvar_25);
  res_22 = (x_23 + (x1_24 + (unity_SHC.xyz * 
    ((normalWorld_19.x * normalWorld_19.x) - (normalWorld_19.y * normalWorld_19.y))
  )));
  mediump vec3 tmpvar_26;
  tmpvar_26 = max (((1.055 * 
    pow (max (res_22, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_22 = tmpvar_26;
  ambientOrLightmapUV_20.xyz = max (vec3(0.0, 0.0, 0.0), tmpvar_26);
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  mediump float tmpvar_6;
  tmpvar_6 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_4 = (tmpvar_3 * tmpvar_6);
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_8;
  tmpvar_8 = _LightColor0.xyz;
  mediump float tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy);
  tmpvar_9 = tmpvar_10.y;
  highp vec4 tmpvar_11;
  tmpvar_11 = unity_SpecCube0_HDR;
  mediump vec3 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (1.0 - _Glossiness);
  tmpvar_12 = (xlv_TEXCOORD1 - (2.0 * (
    dot (tmpvar_7, xlv_TEXCOORD1)
   * tmpvar_7)));
  mediump vec4 hdr_14;
  hdr_14 = tmpvar_11;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_12;
  tmpvar_15.w = ((tmpvar_13 * (1.7 - 
    (0.7 * tmpvar_13)
  )) * 6.0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_12, tmpvar_15.w);
  mediump vec4 tmpvar_17;
  tmpvar_17 = tmpvar_16;
  mediump vec3 viewDir_18;
  viewDir_18 = -(xlv_TEXCOORD1);
  mediump vec3 color_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = dot ((viewDir_18 - (2.0 * 
    (dot (tmpvar_7, viewDir_18) * tmpvar_7)
  )), _WorldSpaceLightPos0.xyz);
  tmpvar_20.y = (1.0 - clamp (dot (tmpvar_7, viewDir_18), 0.0, 1.0));
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 * tmpvar_20) * (tmpvar_20 * tmpvar_20));
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_13;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (unity_NHxRoughness, tmpvar_22);
  color_19 = ((tmpvar_4 + (
    (tmpvar_23.w * 16.0)
   * tmpvar_5)) * (tmpvar_8 * clamp (
    dot (tmpvar_7, _WorldSpaceLightPos0.xyz)
  , 0.0, 1.0)));
  color_19 = (color_19 + ((
    (xlv_TEXCOORD5.xyz * tmpvar_9)
   * tmpvar_4) + (
    (((hdr_14.x * (
      (hdr_14.w * (tmpvar_17.w - 1.0))
     + 1.0)) * tmpvar_17.xyz) * tmpvar_9)
   * 
    mix (tmpvar_5, vec3(clamp ((_Glossiness + (1.0 - tmpvar_6)), 0.0, 1.0)), tmpvar_21.yyy)
  )));
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = color_19;
  c_1.w = tmpvar_24.w;
  c_1.xyz = color_19;
  mediump vec4 xlat_varoutput_25;
  xlat_varoutput_25.xyz = c_1.xyz;
  xlat_varoutput_25.w = 1.0;
  gl_FragData[0] = xlat_varoutput_25;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  normalWorld_4 = tmpvar_17;
  tmpvar_8.xyz = normalWorld_4;
  tmpvar_6.xyz = eyeVec_5;
  mediump vec4 ambientOrLightmapUV_18;
  ambientOrLightmapUV_18.w = 0.0;
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = normalWorld_4;
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, tmpvar_19);
  x_21.y = dot (unity_SHAg, tmpvar_19);
  x_21.z = dot (unity_SHAb, tmpvar_19);
  mediump vec3 x1_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = (normalWorld_4.xyzz * normalWorld_4.yzzx);
  x1_22.x = dot (unity_SHBr, tmpvar_23);
  x1_22.y = dot (unity_SHBg, tmpvar_23);
  x1_22.z = dot (unity_SHBb, tmpvar_23);
  res_20 = (x_21 + (x1_22 + (unity_SHC.xyz * 
    ((normalWorld_4.x * normalWorld_4.x) - (normalWorld_4.y * normalWorld_4.y))
  )));
  mediump vec3 tmpvar_24;
  tmpvar_24 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_24;
  ambientOrLightmapUV_18.xyz = max (vec3(0.0, 0.0, 0.0), tmpvar_24);
  tmpvar_7.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  mediump float x_25;
  x_25 = (1.0 - clamp (dot (normalWorld_4, 
    -(eyeVec_5)
  ), 0.0, 1.0));
  tmpvar_8.w = ((x_25 * x_25) * (x_25 * x_25));
  tmpvar_6.w = clamp ((_Glossiness + (1.0 - 
    (0.7790837 - (_Metallic * 0.7790837))
  )), 0.0, 1.0);
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = ambientOrLightmapUV_18;
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump float rl_1;
  mediump float realtimeShadowAttenuation_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  tmpvar_5 = (tmpvar_4 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_7;
  tmpvar_7 = _LightColor0.xyz;
  lowp float tmpvar_8;
  highp float lightShadowDataX_9;
  mediump float tmpvar_10;
  tmpvar_10 = _LightShadowData.x;
  lightShadowDataX_9 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD3.xy).x > xlv_TEXCOORD3.z)), lightShadowDataX_9);
  tmpvar_8 = tmpvar_11;
  realtimeShadowAttenuation_2 = tmpvar_8;
  mediump float occ_12;
  lowp float tmpvar_13;
  tmpvar_13 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_12 = tmpvar_13;
  rl_1 = dot (xlv_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
  mediump float occlusion_14;
  occlusion_14 = ((1.0 - _OcclusionStrength) + (occ_12 * _OcclusionStrength));
  highp vec4 tmpvar_15;
  tmpvar_15 = unity_SpecCube0_HDR;
  mediump float tmpvar_16;
  tmpvar_16 = (1.0 - _Glossiness);
  mediump vec4 hdr_17;
  hdr_17 = tmpvar_15;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = xlv_TEXCOORD4.yzw;
  tmpvar_18.w = ((tmpvar_16 * (1.7 - 
    (0.7 * tmpvar_16)
  )) * 6.0);
  lowp vec4 tmpvar_19;
  tmpvar_19 = impl_low_textureCubeLodEXT (unity_SpecCube0, xlv_TEXCOORD4.yzw, tmpvar_18.w);
  mediump vec4 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  mediump vec2 tmpvar_21;
  tmpvar_21.x = ((rl_1 * rl_1) * (rl_1 * rl_1));
  tmpvar_21.y = tmpvar_16;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (unity_NHxRoughness, tmpvar_21);
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = (((
    (xlv_TEXCOORD2.xyz * occlusion_14)
   * tmpvar_5) + (
    (((hdr_17.x * (
      (hdr_17.w * (tmpvar_20.w - 1.0))
     + 1.0)) * tmpvar_20.xyz) * occlusion_14)
   * 
    mix (tmpvar_6, xlv_TEXCOORD1.www, xlv_TEXCOORD5.www)
  )) + ((tmpvar_5 + 
    ((tmpvar_22.w * 16.0) * tmpvar_6)
  ) * (
    (tmpvar_7 * realtimeShadowAttenuation_2)
   * 
    clamp (dot (xlv_TEXCOORD5.xyz, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  )));
  mediump vec4 xlat_varoutput_24;
  xlat_varoutput_24.xyz = tmpvar_23.xyz;
  xlat_varoutput_24.w = 1.0;
  gl_FragData[0] = xlat_varoutput_24;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  mediump vec3 x1_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_21.x = dot (unity_SHBr, tmpvar_22);
  x1_21.y = dot (unity_SHBg, tmpvar_22);
  x1_21.z = dot (unity_SHBb, tmpvar_22);
  ambientOrLightmapUV_20.xyz = (x1_21 + (unity_SHC.xyz * (
    (normalWorld_19.x * normalWorld_19.x)
   - 
    (normalWorld_19.y * normalWorld_19.y)
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 c_1;
  lowp float atten_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  mediump float tmpvar_7;
  tmpvar_7 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_5 = (tmpvar_4 * tmpvar_7);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_10;
  tmpvar_10 = _LightColor0.xyz;
  mediump float realtimeShadowAttenuation_11;
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].z;
  v_12.y = unity_MatrixV[1].z;
  v_12.z = unity_MatrixV[2].z;
  v_12.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD8 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD8), v_12.xyz), sqrt(dot (tmpvar_13, tmpvar_13)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = xlv_TEXCOORD8;
  lowp float tmpvar_17;
  highp vec4 shadowCoord_18;
  shadowCoord_18 = (unity_WorldToShadow[0] * tmpvar_16);
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, shadowCoord_18.xy).x > shadowCoord_18.z)), lightShadowDataX_19);
  tmpvar_17 = tmpvar_21;
  realtimeShadowAttenuation_11 = tmpvar_17;
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((realtimeShadowAttenuation_11 + tmpvar_14), 0.0, 1.0);
  atten_2 = tmpvar_22;
  mediump float occ_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_23 = tmpvar_24;
  mediump float atten_25;
  atten_25 = atten_2;
  mediump float occlusion_26;
  occlusion_26 = ((1.0 - _OcclusionStrength) + (occ_23 * _OcclusionStrength));
  highp vec4 tmpvar_27;
  tmpvar_27 = unity_SpecCube0_HDR;
  mediump vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_8;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, tmpvar_28);
  x_29.y = dot (unity_SHAg, tmpvar_28);
  x_29.z = dot (unity_SHAb, tmpvar_28);
  mediump vec3 tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = (1.0 - _Glossiness);
  tmpvar_30 = (tmpvar_9 - (2.0 * (
    dot (tmpvar_8, tmpvar_9)
   * tmpvar_8)));
  mediump vec4 hdr_32;
  hdr_32 = tmpvar_27;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = ((tmpvar_31 * (1.7 - 
    (0.7 * tmpvar_31)
  )) * 6.0);
  lowp vec4 tmpvar_34;
  tmpvar_34 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_30, tmpvar_33.w);
  mediump vec4 tmpvar_35;
  tmpvar_35 = tmpvar_34;
  mediump vec3 viewDir_36;
  viewDir_36 = -(tmpvar_9);
  mediump float specularTerm_37;
  mediump vec3 tmpvar_38;
  mediump vec3 inVec_39;
  inVec_39 = (_WorldSpaceLightPos0.xyz + viewDir_36);
  tmpvar_38 = (inVec_39 * inversesqrt(max (0.001, 
    dot (inVec_39, inVec_39)
  )));
  mediump float tmpvar_40;
  tmpvar_40 = clamp (dot (tmpvar_8, tmpvar_38), 0.0, 1.0);
  mediump float tmpvar_41;
  tmpvar_41 = (tmpvar_31 * tmpvar_31);
  specularTerm_37 = ((tmpvar_41 / (
    (max (0.32, clamp (dot (_WorldSpaceLightPos0.xyz, tmpvar_38), 0.0, 1.0)) * (1.5 + tmpvar_41))
   * 
    (((tmpvar_40 * tmpvar_40) * ((tmpvar_41 * tmpvar_41) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_42;
  tmpvar_42 = clamp (specularTerm_37, 0.0, 100.0);
  specularTerm_37 = tmpvar_42;
  mediump float x_43;
  x_43 = (1.0 - clamp (dot (tmpvar_8, viewDir_36), 0.0, 1.0));
  mediump vec3 tmpvar_44;
  tmpvar_44 = (((
    ((tmpvar_5 + (tmpvar_42 * tmpvar_6)) * (tmpvar_10 * atten_25))
   * 
    clamp (dot (tmpvar_8, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (max (((1.055 * 
      pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_29)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0)) * occlusion_26)
   * tmpvar_5)) + ((
    (1.0 - ((tmpvar_41 * tmpvar_31) * 0.28))
   * 
    (((hdr_32.x * (
      (hdr_32.w * (tmpvar_35.w - 1.0))
     + 1.0)) * tmpvar_35.xyz) * occlusion_26)
  ) * mix (tmpvar_6, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_7)), 0.0, 1.0)
  ), vec3(
    ((x_43 * x_43) * (x_43 * x_43))
  ))));
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = tmpvar_44;
  c_1.w = tmpvar_45.w;
  c_1.xyz = tmpvar_44;
  mediump vec4 xlat_varoutput_46;
  xlat_varoutput_46.xyz = c_1.xyz;
  xlat_varoutput_46.w = 1.0;
  gl_FragData[0] = xlat_varoutput_46;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  mediump vec3 x1_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_21.x = dot (unity_SHBr, tmpvar_22);
  x1_21.y = dot (unity_SHBg, tmpvar_22);
  x1_21.z = dot (unity_SHBb, tmpvar_22);
  ambientOrLightmapUV_20.xyz = (x1_21 + (unity_SHC.xyz * (
    (normalWorld_19.x * normalWorld_19.x)
   - 
    (normalWorld_19.y * normalWorld_19.y)
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 c_1;
  lowp float atten_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  mediump float tmpvar_7;
  tmpvar_7 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_5 = (tmpvar_4 * tmpvar_7);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_10;
  tmpvar_10 = _LightColor0.xyz;
  mediump float realtimeShadowAttenuation_11;
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].z;
  v_12.y = unity_MatrixV[1].z;
  v_12.z = unity_MatrixV[2].z;
  v_12.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD8 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD8), v_12.xyz), sqrt(dot (tmpvar_13, tmpvar_13)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = xlv_TEXCOORD8;
  lowp float tmpvar_17;
  highp vec4 shadowCoord_18;
  shadowCoord_18 = (unity_WorldToShadow[0] * tmpvar_16);
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, shadowCoord_18.xy).x > shadowCoord_18.z)), lightShadowDataX_19);
  tmpvar_17 = tmpvar_21;
  realtimeShadowAttenuation_11 = tmpvar_17;
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((realtimeShadowAttenuation_11 + tmpvar_14), 0.0, 1.0);
  atten_2 = tmpvar_22;
  mediump float occ_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_23 = tmpvar_24;
  mediump float atten_25;
  atten_25 = atten_2;
  mediump float occlusion_26;
  occlusion_26 = ((1.0 - _OcclusionStrength) + (occ_23 * _OcclusionStrength));
  highp vec4 tmpvar_27;
  tmpvar_27 = unity_SpecCube0_HDR;
  mediump vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_8;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, tmpvar_28);
  x_29.y = dot (unity_SHAg, tmpvar_28);
  x_29.z = dot (unity_SHAb, tmpvar_28);
  mediump vec3 tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = (1.0 - _Glossiness);
  tmpvar_30 = (tmpvar_9 - (2.0 * (
    dot (tmpvar_8, tmpvar_9)
   * tmpvar_8)));
  mediump vec4 hdr_32;
  hdr_32 = tmpvar_27;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = ((tmpvar_31 * (1.7 - 
    (0.7 * tmpvar_31)
  )) * 6.0);
  lowp vec4 tmpvar_34;
  tmpvar_34 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_30, tmpvar_33.w);
  mediump vec4 tmpvar_35;
  tmpvar_35 = tmpvar_34;
  mediump vec3 viewDir_36;
  viewDir_36 = -(tmpvar_9);
  mediump float specularTerm_37;
  mediump vec3 tmpvar_38;
  mediump vec3 inVec_39;
  inVec_39 = (_WorldSpaceLightPos0.xyz + viewDir_36);
  tmpvar_38 = (inVec_39 * inversesqrt(max (0.001, 
    dot (inVec_39, inVec_39)
  )));
  mediump float tmpvar_40;
  tmpvar_40 = clamp (dot (tmpvar_8, tmpvar_38), 0.0, 1.0);
  mediump float tmpvar_41;
  tmpvar_41 = (tmpvar_31 * tmpvar_31);
  specularTerm_37 = ((tmpvar_41 / (
    (max (0.32, clamp (dot (_WorldSpaceLightPos0.xyz, tmpvar_38), 0.0, 1.0)) * (1.5 + tmpvar_41))
   * 
    (((tmpvar_40 * tmpvar_40) * ((tmpvar_41 * tmpvar_41) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_42;
  tmpvar_42 = clamp (specularTerm_37, 0.0, 100.0);
  specularTerm_37 = tmpvar_42;
  mediump float x_43;
  x_43 = (1.0 - clamp (dot (tmpvar_8, viewDir_36), 0.0, 1.0));
  mediump vec3 tmpvar_44;
  tmpvar_44 = (((
    ((tmpvar_5 + (tmpvar_42 * tmpvar_6)) * (tmpvar_10 * atten_25))
   * 
    clamp (dot (tmpvar_8, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (max (((1.055 * 
      pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_29)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0)) * occlusion_26)
   * tmpvar_5)) + ((
    (1.0 - ((tmpvar_41 * tmpvar_31) * 0.28))
   * 
    (((hdr_32.x * (
      (hdr_32.w * (tmpvar_35.w - 1.0))
     + 1.0)) * tmpvar_35.xyz) * occlusion_26)
  ) * mix (tmpvar_6, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_7)), 0.0, 1.0)
  ), vec3(
    ((x_43 * x_43) * (x_43 * x_43))
  ))));
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = tmpvar_44;
  c_1.w = tmpvar_45.w;
  c_1.xyz = tmpvar_44;
  mediump vec4 xlat_varoutput_46;
  xlat_varoutput_46.xyz = c_1.xyz;
  xlat_varoutput_46.w = 1.0;
  gl_FragData[0] = xlat_varoutput_46;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  normalWorld_4 = tmpvar_17;
  tmpvar_8.xyz = normalWorld_4;
  tmpvar_6.xyz = eyeVec_5;
  mediump vec4 ambientOrLightmapUV_18;
  ambientOrLightmapUV_18.w = 0.0;
  highp vec3 lightColor0_19;
  lightColor0_19 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_20;
  lightColor1_20 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_21;
  lightColor2_21 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_22;
  lightColor3_22 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_23;
  lightAttenSq_23 = unity_4LightAtten0;
  highp vec3 normal_24;
  normal_24 = normalWorld_4;
  highp vec3 col_25;
  highp vec4 ndotl_26;
  highp vec4 lengthSq_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_27 = (tmpvar_28 * tmpvar_28);
  lengthSq_27 = (lengthSq_27 + (tmpvar_29 * tmpvar_29));
  lengthSq_27 = (lengthSq_27 + (tmpvar_30 * tmpvar_30));
  highp vec4 tmpvar_31;
  tmpvar_31 = max (lengthSq_27, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_27 = tmpvar_31;
  ndotl_26 = (tmpvar_28 * normal_24.x);
  ndotl_26 = (ndotl_26 + (tmpvar_29 * normal_24.y));
  ndotl_26 = (ndotl_26 + (tmpvar_30 * normal_24.z));
  highp vec4 tmpvar_32;
  tmpvar_32 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_26 * inversesqrt(tmpvar_31)));
  ndotl_26 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_32 * (1.0/((1.0 + 
    (tmpvar_31 * lightAttenSq_23)
  ))));
  col_25 = (lightColor0_19 * tmpvar_33.x);
  col_25 = (col_25 + (lightColor1_20 * tmpvar_33.y));
  col_25 = (col_25 + (lightColor2_21 * tmpvar_33.z));
  col_25 = (col_25 + (lightColor3_22 * tmpvar_33.w));
  ambientOrLightmapUV_18.xyz = col_25;
  mediump vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = normalWorld_4;
  mediump vec3 res_35;
  mediump vec3 x_36;
  x_36.x = dot (unity_SHAr, tmpvar_34);
  x_36.y = dot (unity_SHAg, tmpvar_34);
  x_36.z = dot (unity_SHAb, tmpvar_34);
  mediump vec3 x1_37;
  mediump vec4 tmpvar_38;
  tmpvar_38 = (normalWorld_4.xyzz * normalWorld_4.yzzx);
  x1_37.x = dot (unity_SHBr, tmpvar_38);
  x1_37.y = dot (unity_SHBg, tmpvar_38);
  x1_37.z = dot (unity_SHBb, tmpvar_38);
  res_35 = (x_36 + (x1_37 + (unity_SHC.xyz * 
    ((normalWorld_4.x * normalWorld_4.x) - (normalWorld_4.y * normalWorld_4.y))
  )));
  mediump vec3 tmpvar_39;
  tmpvar_39 = max (((1.055 * 
    pow (max (res_35, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_35 = tmpvar_39;
  ambientOrLightmapUV_18.xyz = (ambientOrLightmapUV_18.xyz + max (vec3(0.0, 0.0, 0.0), tmpvar_39));
  tmpvar_7.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  mediump float x_40;
  x_40 = (1.0 - clamp (dot (normalWorld_4, 
    -(eyeVec_5)
  ), 0.0, 1.0));
  tmpvar_8.w = ((x_40 * x_40) * (x_40 * x_40));
  tmpvar_6.w = clamp ((_Glossiness + (1.0 - 
    (0.7790837 - (_Metallic * 0.7790837))
  )), 0.0, 1.0);
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = ambientOrLightmapUV_18;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump float rl_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  tmpvar_4 = (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_6;
  tmpvar_6 = _LightColor0.xyz;
  mediump float tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy);
  tmpvar_7 = tmpvar_8.y;
  rl_1 = dot (xlv_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
  highp vec4 tmpvar_9;
  tmpvar_9 = unity_SpecCube0_HDR;
  mediump float tmpvar_10;
  tmpvar_10 = (1.0 - _Glossiness);
  mediump vec4 hdr_11;
  hdr_11 = tmpvar_9;
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = xlv_TEXCOORD4.yzw;
  tmpvar_12.w = ((tmpvar_10 * (1.7 - 
    (0.7 * tmpvar_10)
  )) * 6.0);
  lowp vec4 tmpvar_13;
  tmpvar_13 = impl_low_textureCubeLodEXT (unity_SpecCube0, xlv_TEXCOORD4.yzw, tmpvar_12.w);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  mediump vec2 tmpvar_15;
  tmpvar_15.x = ((rl_1 * rl_1) * (rl_1 * rl_1));
  tmpvar_15.y = tmpvar_10;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (unity_NHxRoughness, tmpvar_15);
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = (((
    (xlv_TEXCOORD2.xyz * tmpvar_7)
   * tmpvar_4) + (
    (((hdr_11.x * (
      (hdr_11.w * (tmpvar_14.w - 1.0))
     + 1.0)) * tmpvar_14.xyz) * tmpvar_7)
   * 
    mix (tmpvar_5, xlv_TEXCOORD1.www, xlv_TEXCOORD5.www)
  )) + ((tmpvar_4 + 
    ((tmpvar_16.w * 16.0) * tmpvar_5)
  ) * (tmpvar_6 * 
    clamp (dot (xlv_TEXCOORD5.xyz, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  )));
  mediump vec4 xlat_varoutput_18;
  xlat_varoutput_18.xyz = tmpvar_17.xyz;
  xlat_varoutput_18.w = 1.0;
  gl_FragData[0] = xlat_varoutput_18;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  tmpvar_14 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 normal_26;
  normal_26 = normalWorld_19;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (lengthSq_29, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_29 = tmpvar_33;
  ndotl_28 = (tmpvar_30 * normal_26.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * normal_26.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * normal_26.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(tmpvar_33)));
  ndotl_28 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (tmpvar_33 * lightAttenSq_25)
  ))));
  col_27 = (lightColor0_21 * tmpvar_35.x);
  col_27 = (col_27 + (lightColor1_22 * tmpvar_35.y));
  col_27 = (col_27 + (lightColor2_23 * tmpvar_35.z));
  col_27 = (col_27 + (lightColor3_24 * tmpvar_35.w));
  ambientOrLightmapUV_20.xyz = col_27;
  mediump vec4 tmpvar_36;
  tmpvar_36.w = 1.0;
  tmpvar_36.xyz = normalWorld_19;
  mediump vec3 res_37;
  mediump vec3 x_38;
  x_38.x = dot (unity_SHAr, tmpvar_36);
  x_38.y = dot (unity_SHAg, tmpvar_36);
  x_38.z = dot (unity_SHAb, tmpvar_36);
  mediump vec3 x1_39;
  mediump vec4 tmpvar_40;
  tmpvar_40 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_39.x = dot (unity_SHBr, tmpvar_40);
  x1_39.y = dot (unity_SHBg, tmpvar_40);
  x1_39.z = dot (unity_SHBb, tmpvar_40);
  res_37 = (x_38 + (x1_39 + (unity_SHC.xyz * 
    ((normalWorld_19.x * normalWorld_19.x) - (normalWorld_19.y * normalWorld_19.y))
  )));
  mediump vec3 tmpvar_41;
  tmpvar_41 = max (((1.055 * 
    pow (max (res_37, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_37 = tmpvar_41;
  ambientOrLightmapUV_20.xyz = (ambientOrLightmapUV_20.xyz + max (vec3(0.0, 0.0, 0.0), tmpvar_41));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  mediump float tmpvar_6;
  tmpvar_6 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_4 = (tmpvar_3 * tmpvar_6);
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_8;
  tmpvar_8 = _LightColor0.xyz;
  mediump float tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy);
  tmpvar_9 = tmpvar_10.y;
  highp vec4 tmpvar_11;
  tmpvar_11 = unity_SpecCube0_HDR;
  mediump vec3 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (1.0 - _Glossiness);
  tmpvar_12 = (xlv_TEXCOORD1 - (2.0 * (
    dot (tmpvar_7, xlv_TEXCOORD1)
   * tmpvar_7)));
  mediump vec4 hdr_14;
  hdr_14 = tmpvar_11;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_12;
  tmpvar_15.w = ((tmpvar_13 * (1.7 - 
    (0.7 * tmpvar_13)
  )) * 6.0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_12, tmpvar_15.w);
  mediump vec4 tmpvar_17;
  tmpvar_17 = tmpvar_16;
  mediump vec3 viewDir_18;
  viewDir_18 = -(xlv_TEXCOORD1);
  mediump vec3 color_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = dot ((viewDir_18 - (2.0 * 
    (dot (tmpvar_7, viewDir_18) * tmpvar_7)
  )), _WorldSpaceLightPos0.xyz);
  tmpvar_20.y = (1.0 - clamp (dot (tmpvar_7, viewDir_18), 0.0, 1.0));
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 * tmpvar_20) * (tmpvar_20 * tmpvar_20));
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_13;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (unity_NHxRoughness, tmpvar_22);
  color_19 = ((tmpvar_4 + (
    (tmpvar_23.w * 16.0)
   * tmpvar_5)) * (tmpvar_8 * clamp (
    dot (tmpvar_7, _WorldSpaceLightPos0.xyz)
  , 0.0, 1.0)));
  color_19 = (color_19 + ((
    (xlv_TEXCOORD5.xyz * tmpvar_9)
   * tmpvar_4) + (
    (((hdr_14.x * (
      (hdr_14.w * (tmpvar_17.w - 1.0))
     + 1.0)) * tmpvar_17.xyz) * tmpvar_9)
   * 
    mix (tmpvar_5, vec3(clamp ((_Glossiness + (1.0 - tmpvar_6)), 0.0, 1.0)), tmpvar_21.yyy)
  )));
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = color_19;
  c_1.w = tmpvar_24.w;
  c_1.xyz = color_19;
  mediump vec4 xlat_varoutput_25;
  xlat_varoutput_25.xyz = c_1.xyz;
  xlat_varoutput_25.w = 1.0;
  gl_FragData[0] = xlat_varoutput_25;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  tmpvar_14 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 normal_26;
  normal_26 = normalWorld_19;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (lengthSq_29, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_29 = tmpvar_33;
  ndotl_28 = (tmpvar_30 * normal_26.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * normal_26.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * normal_26.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(tmpvar_33)));
  ndotl_28 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (tmpvar_33 * lightAttenSq_25)
  ))));
  col_27 = (lightColor0_21 * tmpvar_35.x);
  col_27 = (col_27 + (lightColor1_22 * tmpvar_35.y));
  col_27 = (col_27 + (lightColor2_23 * tmpvar_35.z));
  col_27 = (col_27 + (lightColor3_24 * tmpvar_35.w));
  ambientOrLightmapUV_20.xyz = col_27;
  mediump vec4 tmpvar_36;
  tmpvar_36.w = 1.0;
  tmpvar_36.xyz = normalWorld_19;
  mediump vec3 res_37;
  mediump vec3 x_38;
  x_38.x = dot (unity_SHAr, tmpvar_36);
  x_38.y = dot (unity_SHAg, tmpvar_36);
  x_38.z = dot (unity_SHAb, tmpvar_36);
  mediump vec3 x1_39;
  mediump vec4 tmpvar_40;
  tmpvar_40 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_39.x = dot (unity_SHBr, tmpvar_40);
  x1_39.y = dot (unity_SHBg, tmpvar_40);
  x1_39.z = dot (unity_SHBb, tmpvar_40);
  res_37 = (x_38 + (x1_39 + (unity_SHC.xyz * 
    ((normalWorld_19.x * normalWorld_19.x) - (normalWorld_19.y * normalWorld_19.y))
  )));
  mediump vec3 tmpvar_41;
  tmpvar_41 = max (((1.055 * 
    pow (max (res_37, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_37 = tmpvar_41;
  ambientOrLightmapUV_20.xyz = (ambientOrLightmapUV_20.xyz + max (vec3(0.0, 0.0, 0.0), tmpvar_41));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  mediump float tmpvar_6;
  tmpvar_6 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_4 = (tmpvar_3 * tmpvar_6);
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_8;
  tmpvar_8 = _LightColor0.xyz;
  mediump float tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy);
  tmpvar_9 = tmpvar_10.y;
  highp vec4 tmpvar_11;
  tmpvar_11 = unity_SpecCube0_HDR;
  mediump vec3 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (1.0 - _Glossiness);
  tmpvar_12 = (xlv_TEXCOORD1 - (2.0 * (
    dot (tmpvar_7, xlv_TEXCOORD1)
   * tmpvar_7)));
  mediump vec4 hdr_14;
  hdr_14 = tmpvar_11;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_12;
  tmpvar_15.w = ((tmpvar_13 * (1.7 - 
    (0.7 * tmpvar_13)
  )) * 6.0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_12, tmpvar_15.w);
  mediump vec4 tmpvar_17;
  tmpvar_17 = tmpvar_16;
  mediump vec3 viewDir_18;
  viewDir_18 = -(xlv_TEXCOORD1);
  mediump vec3 color_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = dot ((viewDir_18 - (2.0 * 
    (dot (tmpvar_7, viewDir_18) * tmpvar_7)
  )), _WorldSpaceLightPos0.xyz);
  tmpvar_20.y = (1.0 - clamp (dot (tmpvar_7, viewDir_18), 0.0, 1.0));
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 * tmpvar_20) * (tmpvar_20 * tmpvar_20));
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_13;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (unity_NHxRoughness, tmpvar_22);
  color_19 = ((tmpvar_4 + (
    (tmpvar_23.w * 16.0)
   * tmpvar_5)) * (tmpvar_8 * clamp (
    dot (tmpvar_7, _WorldSpaceLightPos0.xyz)
  , 0.0, 1.0)));
  color_19 = (color_19 + ((
    (xlv_TEXCOORD5.xyz * tmpvar_9)
   * tmpvar_4) + (
    (((hdr_14.x * (
      (hdr_14.w * (tmpvar_17.w - 1.0))
     + 1.0)) * tmpvar_17.xyz) * tmpvar_9)
   * 
    mix (tmpvar_5, vec3(clamp ((_Glossiness + (1.0 - tmpvar_6)), 0.0, 1.0)), tmpvar_21.yyy)
  )));
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = color_19;
  c_1.w = tmpvar_24.w;
  c_1.xyz = color_19;
  mediump vec4 xlat_varoutput_25;
  xlat_varoutput_25.xyz = c_1.xyz;
  xlat_varoutput_25.w = 1.0;
  gl_FragData[0] = xlat_varoutput_25;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  normalWorld_4 = tmpvar_17;
  tmpvar_8.xyz = normalWorld_4;
  tmpvar_6.xyz = eyeVec_5;
  mediump vec4 ambientOrLightmapUV_18;
  ambientOrLightmapUV_18.w = 0.0;
  highp vec3 lightColor0_19;
  lightColor0_19 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_20;
  lightColor1_20 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_21;
  lightColor2_21 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_22;
  lightColor3_22 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_23;
  lightAttenSq_23 = unity_4LightAtten0;
  highp vec3 normal_24;
  normal_24 = normalWorld_4;
  highp vec3 col_25;
  highp vec4 ndotl_26;
  highp vec4 lengthSq_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_27 = (tmpvar_28 * tmpvar_28);
  lengthSq_27 = (lengthSq_27 + (tmpvar_29 * tmpvar_29));
  lengthSq_27 = (lengthSq_27 + (tmpvar_30 * tmpvar_30));
  highp vec4 tmpvar_31;
  tmpvar_31 = max (lengthSq_27, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_27 = tmpvar_31;
  ndotl_26 = (tmpvar_28 * normal_24.x);
  ndotl_26 = (ndotl_26 + (tmpvar_29 * normal_24.y));
  ndotl_26 = (ndotl_26 + (tmpvar_30 * normal_24.z));
  highp vec4 tmpvar_32;
  tmpvar_32 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_26 * inversesqrt(tmpvar_31)));
  ndotl_26 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_32 * (1.0/((1.0 + 
    (tmpvar_31 * lightAttenSq_23)
  ))));
  col_25 = (lightColor0_19 * tmpvar_33.x);
  col_25 = (col_25 + (lightColor1_20 * tmpvar_33.y));
  col_25 = (col_25 + (lightColor2_21 * tmpvar_33.z));
  col_25 = (col_25 + (lightColor3_22 * tmpvar_33.w));
  ambientOrLightmapUV_18.xyz = col_25;
  mediump vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = normalWorld_4;
  mediump vec3 res_35;
  mediump vec3 x_36;
  x_36.x = dot (unity_SHAr, tmpvar_34);
  x_36.y = dot (unity_SHAg, tmpvar_34);
  x_36.z = dot (unity_SHAb, tmpvar_34);
  mediump vec3 x1_37;
  mediump vec4 tmpvar_38;
  tmpvar_38 = (normalWorld_4.xyzz * normalWorld_4.yzzx);
  x1_37.x = dot (unity_SHBr, tmpvar_38);
  x1_37.y = dot (unity_SHBg, tmpvar_38);
  x1_37.z = dot (unity_SHBb, tmpvar_38);
  res_35 = (x_36 + (x1_37 + (unity_SHC.xyz * 
    ((normalWorld_4.x * normalWorld_4.x) - (normalWorld_4.y * normalWorld_4.y))
  )));
  mediump vec3 tmpvar_39;
  tmpvar_39 = max (((1.055 * 
    pow (max (res_35, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_35 = tmpvar_39;
  ambientOrLightmapUV_18.xyz = (ambientOrLightmapUV_18.xyz + max (vec3(0.0, 0.0, 0.0), tmpvar_39));
  tmpvar_7.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  mediump float x_40;
  x_40 = (1.0 - clamp (dot (normalWorld_4, 
    -(eyeVec_5)
  ), 0.0, 1.0));
  tmpvar_8.w = ((x_40 * x_40) * (x_40 * x_40));
  tmpvar_6.w = clamp ((_Glossiness + (1.0 - 
    (0.7790837 - (_Metallic * 0.7790837))
  )), 0.0, 1.0);
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = ambientOrLightmapUV_18;
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump float rl_1;
  mediump float realtimeShadowAttenuation_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  tmpvar_5 = (tmpvar_4 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_7;
  tmpvar_7 = _LightColor0.xyz;
  lowp float tmpvar_8;
  highp float lightShadowDataX_9;
  mediump float tmpvar_10;
  tmpvar_10 = _LightShadowData.x;
  lightShadowDataX_9 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD3.xy).x > xlv_TEXCOORD3.z)), lightShadowDataX_9);
  tmpvar_8 = tmpvar_11;
  realtimeShadowAttenuation_2 = tmpvar_8;
  mediump float occ_12;
  lowp float tmpvar_13;
  tmpvar_13 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_12 = tmpvar_13;
  rl_1 = dot (xlv_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
  mediump float occlusion_14;
  occlusion_14 = ((1.0 - _OcclusionStrength) + (occ_12 * _OcclusionStrength));
  highp vec4 tmpvar_15;
  tmpvar_15 = unity_SpecCube0_HDR;
  mediump float tmpvar_16;
  tmpvar_16 = (1.0 - _Glossiness);
  mediump vec4 hdr_17;
  hdr_17 = tmpvar_15;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = xlv_TEXCOORD4.yzw;
  tmpvar_18.w = ((tmpvar_16 * (1.7 - 
    (0.7 * tmpvar_16)
  )) * 6.0);
  lowp vec4 tmpvar_19;
  tmpvar_19 = impl_low_textureCubeLodEXT (unity_SpecCube0, xlv_TEXCOORD4.yzw, tmpvar_18.w);
  mediump vec4 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  mediump vec2 tmpvar_21;
  tmpvar_21.x = ((rl_1 * rl_1) * (rl_1 * rl_1));
  tmpvar_21.y = tmpvar_16;
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (unity_NHxRoughness, tmpvar_21);
  mediump vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = (((
    (xlv_TEXCOORD2.xyz * occlusion_14)
   * tmpvar_5) + (
    (((hdr_17.x * (
      (hdr_17.w * (tmpvar_20.w - 1.0))
     + 1.0)) * tmpvar_20.xyz) * occlusion_14)
   * 
    mix (tmpvar_6, xlv_TEXCOORD1.www, xlv_TEXCOORD5.www)
  )) + ((tmpvar_5 + 
    ((tmpvar_22.w * 16.0) * tmpvar_6)
  ) * (
    (tmpvar_7 * realtimeShadowAttenuation_2)
   * 
    clamp (dot (xlv_TEXCOORD5.xyz, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  )));
  mediump vec4 xlat_varoutput_24;
  xlat_varoutput_24.xyz = tmpvar_23.xyz;
  xlat_varoutput_24.w = 1.0;
  gl_FragData[0] = xlat_varoutput_24;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 normal_26;
  normal_26 = normalWorld_19;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (lengthSq_29, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_29 = tmpvar_33;
  ndotl_28 = (tmpvar_30 * normal_26.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * normal_26.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * normal_26.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(tmpvar_33)));
  ndotl_28 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (tmpvar_33 * lightAttenSq_25)
  ))));
  col_27 = (lightColor0_21 * tmpvar_35.x);
  col_27 = (col_27 + (lightColor1_22 * tmpvar_35.y));
  col_27 = (col_27 + (lightColor2_23 * tmpvar_35.z));
  col_27 = (col_27 + (lightColor3_24 * tmpvar_35.w));
  ambientOrLightmapUV_20.xyz = col_27;
  mediump vec3 x1_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_36.x = dot (unity_SHBr, tmpvar_37);
  x1_36.y = dot (unity_SHBg, tmpvar_37);
  x1_36.z = dot (unity_SHBb, tmpvar_37);
  ambientOrLightmapUV_20.xyz = ((ambientOrLightmapUV_20.xyz * (
    (ambientOrLightmapUV_20.xyz * ((ambientOrLightmapUV_20.xyz * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_36 + (unity_SHC.xyz * 
    ((normalWorld_19.x * normalWorld_19.x) - (normalWorld_19.y * normalWorld_19.y))
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 c_1;
  lowp float atten_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  mediump float tmpvar_7;
  tmpvar_7 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_5 = (tmpvar_4 * tmpvar_7);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_10;
  tmpvar_10 = _LightColor0.xyz;
  mediump float realtimeShadowAttenuation_11;
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].z;
  v_12.y = unity_MatrixV[1].z;
  v_12.z = unity_MatrixV[2].z;
  v_12.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD8 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD8), v_12.xyz), sqrt(dot (tmpvar_13, tmpvar_13)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = xlv_TEXCOORD8;
  lowp float tmpvar_17;
  highp vec4 shadowCoord_18;
  shadowCoord_18 = (unity_WorldToShadow[0] * tmpvar_16);
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, shadowCoord_18.xy).x > shadowCoord_18.z)), lightShadowDataX_19);
  tmpvar_17 = tmpvar_21;
  realtimeShadowAttenuation_11 = tmpvar_17;
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((realtimeShadowAttenuation_11 + tmpvar_14), 0.0, 1.0);
  atten_2 = tmpvar_22;
  mediump float occ_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_23 = tmpvar_24;
  mediump float atten_25;
  atten_25 = atten_2;
  mediump float occlusion_26;
  occlusion_26 = ((1.0 - _OcclusionStrength) + (occ_23 * _OcclusionStrength));
  highp vec4 tmpvar_27;
  tmpvar_27 = unity_SpecCube0_HDR;
  mediump vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_8;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, tmpvar_28);
  x_29.y = dot (unity_SHAg, tmpvar_28);
  x_29.z = dot (unity_SHAb, tmpvar_28);
  mediump vec3 tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = (1.0 - _Glossiness);
  tmpvar_30 = (tmpvar_9 - (2.0 * (
    dot (tmpvar_8, tmpvar_9)
   * tmpvar_8)));
  mediump vec4 hdr_32;
  hdr_32 = tmpvar_27;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = ((tmpvar_31 * (1.7 - 
    (0.7 * tmpvar_31)
  )) * 6.0);
  lowp vec4 tmpvar_34;
  tmpvar_34 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_30, tmpvar_33.w);
  mediump vec4 tmpvar_35;
  tmpvar_35 = tmpvar_34;
  mediump vec3 viewDir_36;
  viewDir_36 = -(tmpvar_9);
  mediump float specularTerm_37;
  mediump vec3 tmpvar_38;
  mediump vec3 inVec_39;
  inVec_39 = (_WorldSpaceLightPos0.xyz + viewDir_36);
  tmpvar_38 = (inVec_39 * inversesqrt(max (0.001, 
    dot (inVec_39, inVec_39)
  )));
  mediump float tmpvar_40;
  tmpvar_40 = clamp (dot (tmpvar_8, tmpvar_38), 0.0, 1.0);
  mediump float tmpvar_41;
  tmpvar_41 = (tmpvar_31 * tmpvar_31);
  specularTerm_37 = ((tmpvar_41 / (
    (max (0.32, clamp (dot (_WorldSpaceLightPos0.xyz, tmpvar_38), 0.0, 1.0)) * (1.5 + tmpvar_41))
   * 
    (((tmpvar_40 * tmpvar_40) * ((tmpvar_41 * tmpvar_41) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_42;
  tmpvar_42 = clamp (specularTerm_37, 0.0, 100.0);
  specularTerm_37 = tmpvar_42;
  mediump float x_43;
  x_43 = (1.0 - clamp (dot (tmpvar_8, viewDir_36), 0.0, 1.0));
  mediump vec3 tmpvar_44;
  tmpvar_44 = (((
    ((tmpvar_5 + (tmpvar_42 * tmpvar_6)) * (tmpvar_10 * atten_25))
   * 
    clamp (dot (tmpvar_8, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (max (((1.055 * 
      pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_29)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0)) * occlusion_26)
   * tmpvar_5)) + ((
    (1.0 - ((tmpvar_41 * tmpvar_31) * 0.28))
   * 
    (((hdr_32.x * (
      (hdr_32.w * (tmpvar_35.w - 1.0))
     + 1.0)) * tmpvar_35.xyz) * occlusion_26)
  ) * mix (tmpvar_6, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_7)), 0.0, 1.0)
  ), vec3(
    ((x_43 * x_43) * (x_43 * x_43))
  ))));
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = tmpvar_44;
  c_1.w = tmpvar_45.w;
  c_1.xyz = tmpvar_44;
  mediump vec4 xlat_varoutput_46;
  xlat_varoutput_46.xyz = c_1.xyz;
  xlat_varoutput_46.w = 1.0;
  gl_FragData[0] = xlat_varoutput_46;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 normal_26;
  normal_26 = normalWorld_19;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (lengthSq_29, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_29 = tmpvar_33;
  ndotl_28 = (tmpvar_30 * normal_26.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * normal_26.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * normal_26.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(tmpvar_33)));
  ndotl_28 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (tmpvar_33 * lightAttenSq_25)
  ))));
  col_27 = (lightColor0_21 * tmpvar_35.x);
  col_27 = (col_27 + (lightColor1_22 * tmpvar_35.y));
  col_27 = (col_27 + (lightColor2_23 * tmpvar_35.z));
  col_27 = (col_27 + (lightColor3_24 * tmpvar_35.w));
  ambientOrLightmapUV_20.xyz = col_27;
  mediump vec3 x1_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_36.x = dot (unity_SHBr, tmpvar_37);
  x1_36.y = dot (unity_SHBg, tmpvar_37);
  x1_36.z = dot (unity_SHBb, tmpvar_37);
  ambientOrLightmapUV_20.xyz = ((ambientOrLightmapUV_20.xyz * (
    (ambientOrLightmapUV_20.xyz * ((ambientOrLightmapUV_20.xyz * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_36 + (unity_SHC.xyz * 
    ((normalWorld_19.x * normalWorld_19.x) - (normalWorld_19.y * normalWorld_19.y))
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 c_1;
  lowp float atten_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  mediump float tmpvar_7;
  tmpvar_7 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_5 = (tmpvar_4 * tmpvar_7);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_10;
  tmpvar_10 = _LightColor0.xyz;
  mediump float realtimeShadowAttenuation_11;
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].z;
  v_12.y = unity_MatrixV[1].z;
  v_12.z = unity_MatrixV[2].z;
  v_12.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD8 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD8), v_12.xyz), sqrt(dot (tmpvar_13, tmpvar_13)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = xlv_TEXCOORD8;
  lowp float tmpvar_17;
  highp vec4 shadowCoord_18;
  shadowCoord_18 = (unity_WorldToShadow[0] * tmpvar_16);
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, shadowCoord_18.xy).x > shadowCoord_18.z)), lightShadowDataX_19);
  tmpvar_17 = tmpvar_21;
  realtimeShadowAttenuation_11 = tmpvar_17;
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((realtimeShadowAttenuation_11 + tmpvar_14), 0.0, 1.0);
  atten_2 = tmpvar_22;
  mediump float occ_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_23 = tmpvar_24;
  mediump float atten_25;
  atten_25 = atten_2;
  mediump float occlusion_26;
  occlusion_26 = ((1.0 - _OcclusionStrength) + (occ_23 * _OcclusionStrength));
  highp vec4 tmpvar_27;
  tmpvar_27 = unity_SpecCube0_HDR;
  mediump vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_8;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, tmpvar_28);
  x_29.y = dot (unity_SHAg, tmpvar_28);
  x_29.z = dot (unity_SHAb, tmpvar_28);
  mediump vec3 tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = (1.0 - _Glossiness);
  tmpvar_30 = (tmpvar_9 - (2.0 * (
    dot (tmpvar_8, tmpvar_9)
   * tmpvar_8)));
  mediump vec4 hdr_32;
  hdr_32 = tmpvar_27;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = ((tmpvar_31 * (1.7 - 
    (0.7 * tmpvar_31)
  )) * 6.0);
  lowp vec4 tmpvar_34;
  tmpvar_34 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_30, tmpvar_33.w);
  mediump vec4 tmpvar_35;
  tmpvar_35 = tmpvar_34;
  mediump vec3 viewDir_36;
  viewDir_36 = -(tmpvar_9);
  mediump float specularTerm_37;
  mediump vec3 tmpvar_38;
  mediump vec3 inVec_39;
  inVec_39 = (_WorldSpaceLightPos0.xyz + viewDir_36);
  tmpvar_38 = (inVec_39 * inversesqrt(max (0.001, 
    dot (inVec_39, inVec_39)
  )));
  mediump float tmpvar_40;
  tmpvar_40 = clamp (dot (tmpvar_8, tmpvar_38), 0.0, 1.0);
  mediump float tmpvar_41;
  tmpvar_41 = (tmpvar_31 * tmpvar_31);
  specularTerm_37 = ((tmpvar_41 / (
    (max (0.32, clamp (dot (_WorldSpaceLightPos0.xyz, tmpvar_38), 0.0, 1.0)) * (1.5 + tmpvar_41))
   * 
    (((tmpvar_40 * tmpvar_40) * ((tmpvar_41 * tmpvar_41) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_42;
  tmpvar_42 = clamp (specularTerm_37, 0.0, 100.0);
  specularTerm_37 = tmpvar_42;
  mediump float x_43;
  x_43 = (1.0 - clamp (dot (tmpvar_8, viewDir_36), 0.0, 1.0));
  mediump vec3 tmpvar_44;
  tmpvar_44 = (((
    ((tmpvar_5 + (tmpvar_42 * tmpvar_6)) * (tmpvar_10 * atten_25))
   * 
    clamp (dot (tmpvar_8, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (max (((1.055 * 
      pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_29)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0)) * occlusion_26)
   * tmpvar_5)) + ((
    (1.0 - ((tmpvar_41 * tmpvar_31) * 0.28))
   * 
    (((hdr_32.x * (
      (hdr_32.w * (tmpvar_35.w - 1.0))
     + 1.0)) * tmpvar_35.xyz) * occlusion_26)
  ) * mix (tmpvar_6, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_7)), 0.0, 1.0)
  ), vec3(
    ((x_43 * x_43) * (x_43 * x_43))
  ))));
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = tmpvar_44;
  c_1.w = tmpvar_45.w;
  c_1.xyz = tmpvar_44;
  mediump vec4 xlat_varoutput_46;
  xlat_varoutput_46.xyz = c_1.xyz;
  xlat_varoutput_46.w = 1.0;
  gl_FragData[0] = xlat_varoutput_46;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "_EMISSION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  normalWorld_4 = tmpvar_17;
  tmpvar_8.xyz = normalWorld_4;
  tmpvar_6.xyz = eyeVec_5;
  mediump vec4 ambientOrLightmapUV_18;
  ambientOrLightmapUV_18.w = 0.0;
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = normalWorld_4;
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, tmpvar_19);
  x_21.y = dot (unity_SHAg, tmpvar_19);
  x_21.z = dot (unity_SHAb, tmpvar_19);
  mediump vec3 x1_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = (normalWorld_4.xyzz * normalWorld_4.yzzx);
  x1_22.x = dot (unity_SHBr, tmpvar_23);
  x1_22.y = dot (unity_SHBg, tmpvar_23);
  x1_22.z = dot (unity_SHBb, tmpvar_23);
  res_20 = (x_21 + (x1_22 + (unity_SHC.xyz * 
    ((normalWorld_4.x * normalWorld_4.x) - (normalWorld_4.y * normalWorld_4.y))
  )));
  mediump vec3 tmpvar_24;
  tmpvar_24 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_24;
  ambientOrLightmapUV_18.xyz = max (vec3(0.0, 0.0, 0.0), tmpvar_24);
  tmpvar_7.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  mediump float x_25;
  x_25 = (1.0 - clamp (dot (normalWorld_4, 
    -(eyeVec_5)
  ), 0.0, 1.0));
  tmpvar_8.w = ((x_25 * x_25) * (x_25 * x_25));
  tmpvar_6.w = clamp ((_Glossiness + (1.0 - 
    (0.7790837 - (_Metallic * 0.7790837))
  )), 0.0, 1.0);
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = ambientOrLightmapUV_18;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 c_1;
  mediump float rl_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  tmpvar_5 = (tmpvar_4 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_7;
  tmpvar_7 = _LightColor0.xyz;
  mediump float tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy);
  tmpvar_8 = tmpvar_9.y;
  rl_2 = dot (xlv_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
  highp vec4 tmpvar_10;
  tmpvar_10 = unity_SpecCube0_HDR;
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - _Glossiness);
  mediump vec4 hdr_12;
  hdr_12 = tmpvar_10;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = xlv_TEXCOORD4.yzw;
  tmpvar_13.w = ((tmpvar_11 * (1.7 - 
    (0.7 * tmpvar_11)
  )) * 6.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = impl_low_textureCubeLodEXT (unity_SpecCube0, xlv_TEXCOORD4.yzw, tmpvar_13.w);
  mediump vec4 tmpvar_15;
  tmpvar_15 = tmpvar_14;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((rl_2 * rl_2) * (rl_2 * rl_2));
  tmpvar_16.y = tmpvar_11;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_NHxRoughness, tmpvar_16);
  c_1 = (((
    (xlv_TEXCOORD2.xyz * tmpvar_8)
   * tmpvar_5) + (
    (((hdr_12.x * (
      (hdr_12.w * (tmpvar_15.w - 1.0))
     + 1.0)) * tmpvar_15.xyz) * tmpvar_8)
   * 
    mix (tmpvar_6, xlv_TEXCOORD1.www, xlv_TEXCOORD5.www)
  )) + ((tmpvar_5 + 
    ((tmpvar_17.w * 16.0) * tmpvar_6)
  ) * (tmpvar_7 * 
    clamp (dot (xlv_TEXCOORD5.xyz, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  )));
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  c_1 = (c_1 + (tmpvar_18.xyz * _EmissionColor.xyz));
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = c_1;
  mediump vec4 xlat_varoutput_20;
  xlat_varoutput_20.xyz = tmpvar_19.xyz;
  xlat_varoutput_20.w = 1.0;
  gl_FragData[0] = xlat_varoutput_20;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_EMISSION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  tmpvar_14 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = normalWorld_19;
  mediump vec3 res_22;
  mediump vec3 x_23;
  x_23.x = dot (unity_SHAr, tmpvar_21);
  x_23.y = dot (unity_SHAg, tmpvar_21);
  x_23.z = dot (unity_SHAb, tmpvar_21);
  mediump vec3 x1_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_24.x = dot (unity_SHBr, tmpvar_25);
  x1_24.y = dot (unity_SHBg, tmpvar_25);
  x1_24.z = dot (unity_SHBb, tmpvar_25);
  res_22 = (x_23 + (x1_24 + (unity_SHC.xyz * 
    ((normalWorld_19.x * normalWorld_19.x) - (normalWorld_19.y * normalWorld_19.y))
  )));
  mediump vec3 tmpvar_26;
  tmpvar_26 = max (((1.055 * 
    pow (max (res_22, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_22 = tmpvar_26;
  ambientOrLightmapUV_20.xyz = max (vec3(0.0, 0.0, 0.0), tmpvar_26);
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  mediump float tmpvar_6;
  tmpvar_6 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_4 = (tmpvar_3 * tmpvar_6);
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_8;
  tmpvar_8 = _LightColor0.xyz;
  mediump float tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy);
  tmpvar_9 = tmpvar_10.y;
  highp vec4 tmpvar_11;
  tmpvar_11 = unity_SpecCube0_HDR;
  mediump vec3 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (1.0 - _Glossiness);
  tmpvar_12 = (xlv_TEXCOORD1 - (2.0 * (
    dot (tmpvar_7, xlv_TEXCOORD1)
   * tmpvar_7)));
  mediump vec4 hdr_14;
  hdr_14 = tmpvar_11;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_12;
  tmpvar_15.w = ((tmpvar_13 * (1.7 - 
    (0.7 * tmpvar_13)
  )) * 6.0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_12, tmpvar_15.w);
  mediump vec4 tmpvar_17;
  tmpvar_17 = tmpvar_16;
  mediump vec3 viewDir_18;
  viewDir_18 = -(xlv_TEXCOORD1);
  mediump vec3 color_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = dot ((viewDir_18 - (2.0 * 
    (dot (tmpvar_7, viewDir_18) * tmpvar_7)
  )), _WorldSpaceLightPos0.xyz);
  tmpvar_20.y = (1.0 - clamp (dot (tmpvar_7, viewDir_18), 0.0, 1.0));
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 * tmpvar_20) * (tmpvar_20 * tmpvar_20));
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_13;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (unity_NHxRoughness, tmpvar_22);
  color_19 = ((tmpvar_4 + (
    (tmpvar_23.w * 16.0)
   * tmpvar_5)) * (tmpvar_8 * clamp (
    dot (tmpvar_7, _WorldSpaceLightPos0.xyz)
  , 0.0, 1.0)));
  color_19 = (color_19 + ((
    (xlv_TEXCOORD5.xyz * tmpvar_9)
   * tmpvar_4) + (
    (((hdr_14.x * (
      (hdr_14.w * (tmpvar_17.w - 1.0))
     + 1.0)) * tmpvar_17.xyz) * tmpvar_9)
   * 
    mix (tmpvar_5, vec3(clamp ((_Glossiness + (1.0 - tmpvar_6)), 0.0, 1.0)), tmpvar_21.yyy)
  )));
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = color_19;
  c_1.w = tmpvar_24.w;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  c_1.xyz = (color_19 + (tmpvar_25.xyz * _EmissionColor.xyz));
  mediump vec4 xlat_varoutput_26;
  xlat_varoutput_26.xyz = c_1.xyz;
  xlat_varoutput_26.w = 1.0;
  gl_FragData[0] = xlat_varoutput_26;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_EMISSION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  tmpvar_14 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = normalWorld_19;
  mediump vec3 res_22;
  mediump vec3 x_23;
  x_23.x = dot (unity_SHAr, tmpvar_21);
  x_23.y = dot (unity_SHAg, tmpvar_21);
  x_23.z = dot (unity_SHAb, tmpvar_21);
  mediump vec3 x1_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_24.x = dot (unity_SHBr, tmpvar_25);
  x1_24.y = dot (unity_SHBg, tmpvar_25);
  x1_24.z = dot (unity_SHBb, tmpvar_25);
  res_22 = (x_23 + (x1_24 + (unity_SHC.xyz * 
    ((normalWorld_19.x * normalWorld_19.x) - (normalWorld_19.y * normalWorld_19.y))
  )));
  mediump vec3 tmpvar_26;
  tmpvar_26 = max (((1.055 * 
    pow (max (res_22, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_22 = tmpvar_26;
  ambientOrLightmapUV_20.xyz = max (vec3(0.0, 0.0, 0.0), tmpvar_26);
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  mediump float tmpvar_6;
  tmpvar_6 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_4 = (tmpvar_3 * tmpvar_6);
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_8;
  tmpvar_8 = _LightColor0.xyz;
  mediump float tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy);
  tmpvar_9 = tmpvar_10.y;
  highp vec4 tmpvar_11;
  tmpvar_11 = unity_SpecCube0_HDR;
  mediump vec3 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (1.0 - _Glossiness);
  tmpvar_12 = (xlv_TEXCOORD1 - (2.0 * (
    dot (tmpvar_7, xlv_TEXCOORD1)
   * tmpvar_7)));
  mediump vec4 hdr_14;
  hdr_14 = tmpvar_11;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_12;
  tmpvar_15.w = ((tmpvar_13 * (1.7 - 
    (0.7 * tmpvar_13)
  )) * 6.0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_12, tmpvar_15.w);
  mediump vec4 tmpvar_17;
  tmpvar_17 = tmpvar_16;
  mediump vec3 viewDir_18;
  viewDir_18 = -(xlv_TEXCOORD1);
  mediump vec3 color_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = dot ((viewDir_18 - (2.0 * 
    (dot (tmpvar_7, viewDir_18) * tmpvar_7)
  )), _WorldSpaceLightPos0.xyz);
  tmpvar_20.y = (1.0 - clamp (dot (tmpvar_7, viewDir_18), 0.0, 1.0));
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 * tmpvar_20) * (tmpvar_20 * tmpvar_20));
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_13;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (unity_NHxRoughness, tmpvar_22);
  color_19 = ((tmpvar_4 + (
    (tmpvar_23.w * 16.0)
   * tmpvar_5)) * (tmpvar_8 * clamp (
    dot (tmpvar_7, _WorldSpaceLightPos0.xyz)
  , 0.0, 1.0)));
  color_19 = (color_19 + ((
    (xlv_TEXCOORD5.xyz * tmpvar_9)
   * tmpvar_4) + (
    (((hdr_14.x * (
      (hdr_14.w * (tmpvar_17.w - 1.0))
     + 1.0)) * tmpvar_17.xyz) * tmpvar_9)
   * 
    mix (tmpvar_5, vec3(clamp ((_Glossiness + (1.0 - tmpvar_6)), 0.0, 1.0)), tmpvar_21.yyy)
  )));
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = color_19;
  c_1.w = tmpvar_24.w;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  c_1.xyz = (color_19 + (tmpvar_25.xyz * _EmissionColor.xyz));
  mediump vec4 xlat_varoutput_26;
  xlat_varoutput_26.xyz = c_1.xyz;
  xlat_varoutput_26.w = 1.0;
  gl_FragData[0] = xlat_varoutput_26;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_EMISSION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  normalWorld_4 = tmpvar_17;
  tmpvar_8.xyz = normalWorld_4;
  tmpvar_6.xyz = eyeVec_5;
  mediump vec4 ambientOrLightmapUV_18;
  ambientOrLightmapUV_18.w = 0.0;
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = normalWorld_4;
  mediump vec3 res_20;
  mediump vec3 x_21;
  x_21.x = dot (unity_SHAr, tmpvar_19);
  x_21.y = dot (unity_SHAg, tmpvar_19);
  x_21.z = dot (unity_SHAb, tmpvar_19);
  mediump vec3 x1_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = (normalWorld_4.xyzz * normalWorld_4.yzzx);
  x1_22.x = dot (unity_SHBr, tmpvar_23);
  x1_22.y = dot (unity_SHBg, tmpvar_23);
  x1_22.z = dot (unity_SHBb, tmpvar_23);
  res_20 = (x_21 + (x1_22 + (unity_SHC.xyz * 
    ((normalWorld_4.x * normalWorld_4.x) - (normalWorld_4.y * normalWorld_4.y))
  )));
  mediump vec3 tmpvar_24;
  tmpvar_24 = max (((1.055 * 
    pow (max (res_20, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_20 = tmpvar_24;
  ambientOrLightmapUV_18.xyz = max (vec3(0.0, 0.0, 0.0), tmpvar_24);
  tmpvar_7.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  mediump float x_25;
  x_25 = (1.0 - clamp (dot (normalWorld_4, 
    -(eyeVec_5)
  ), 0.0, 1.0));
  tmpvar_8.w = ((x_25 * x_25) * (x_25 * x_25));
  tmpvar_6.w = clamp ((_Glossiness + (1.0 - 
    (0.7790837 - (_Metallic * 0.7790837))
  )), 0.0, 1.0);
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = ambientOrLightmapUV_18;
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 c_1;
  mediump float rl_2;
  mediump float realtimeShadowAttenuation_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_5;
  tmpvar_5 = (_Color.xyz * tmpvar_4.xyz);
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_5, vec3(_Metallic));
  tmpvar_6 = (tmpvar_5 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_8;
  tmpvar_8 = _LightColor0.xyz;
  lowp float tmpvar_9;
  highp float lightShadowDataX_10;
  mediump float tmpvar_11;
  tmpvar_11 = _LightShadowData.x;
  lightShadowDataX_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD3.xy).x > xlv_TEXCOORD3.z)), lightShadowDataX_10);
  tmpvar_9 = tmpvar_12;
  realtimeShadowAttenuation_3 = tmpvar_9;
  mediump float occ_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_13 = tmpvar_14;
  rl_2 = dot (xlv_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
  mediump float occlusion_15;
  occlusion_15 = ((1.0 - _OcclusionStrength) + (occ_13 * _OcclusionStrength));
  highp vec4 tmpvar_16;
  tmpvar_16 = unity_SpecCube0_HDR;
  mediump float tmpvar_17;
  tmpvar_17 = (1.0 - _Glossiness);
  mediump vec4 hdr_18;
  hdr_18 = tmpvar_16;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = xlv_TEXCOORD4.yzw;
  tmpvar_19.w = ((tmpvar_17 * (1.7 - 
    (0.7 * tmpvar_17)
  )) * 6.0);
  lowp vec4 tmpvar_20;
  tmpvar_20 = impl_low_textureCubeLodEXT (unity_SpecCube0, xlv_TEXCOORD4.yzw, tmpvar_19.w);
  mediump vec4 tmpvar_21;
  tmpvar_21 = tmpvar_20;
  mediump vec2 tmpvar_22;
  tmpvar_22.x = ((rl_2 * rl_2) * (rl_2 * rl_2));
  tmpvar_22.y = tmpvar_17;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (unity_NHxRoughness, tmpvar_22);
  c_1 = (((
    (xlv_TEXCOORD2.xyz * occlusion_15)
   * tmpvar_6) + (
    (((hdr_18.x * (
      (hdr_18.w * (tmpvar_21.w - 1.0))
     + 1.0)) * tmpvar_21.xyz) * occlusion_15)
   * 
    mix (tmpvar_7, xlv_TEXCOORD1.www, xlv_TEXCOORD5.www)
  )) + ((tmpvar_6 + 
    ((tmpvar_23.w * 16.0) * tmpvar_7)
  ) * (
    (tmpvar_8 * realtimeShadowAttenuation_3)
   * 
    clamp (dot (xlv_TEXCOORD5.xyz, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  c_1 = (c_1 + (tmpvar_24.xyz * _EmissionColor.xyz));
  mediump vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = c_1;
  mediump vec4 xlat_varoutput_26;
  xlat_varoutput_26.xyz = tmpvar_25.xyz;
  xlat_varoutput_26.w = 1.0;
  gl_FragData[0] = xlat_varoutput_26;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_EMISSION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  mediump vec3 x1_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_21.x = dot (unity_SHBr, tmpvar_22);
  x1_21.y = dot (unity_SHBg, tmpvar_22);
  x1_21.z = dot (unity_SHBb, tmpvar_22);
  ambientOrLightmapUV_20.xyz = (x1_21 + (unity_SHC.xyz * (
    (normalWorld_19.x * normalWorld_19.x)
   - 
    (normalWorld_19.y * normalWorld_19.y)
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 c_1;
  lowp float atten_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  mediump float tmpvar_7;
  tmpvar_7 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_5 = (tmpvar_4 * tmpvar_7);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_10;
  tmpvar_10 = _LightColor0.xyz;
  mediump float realtimeShadowAttenuation_11;
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].z;
  v_12.y = unity_MatrixV[1].z;
  v_12.z = unity_MatrixV[2].z;
  v_12.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD8 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD8), v_12.xyz), sqrt(dot (tmpvar_13, tmpvar_13)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = xlv_TEXCOORD8;
  lowp float tmpvar_17;
  highp vec4 shadowCoord_18;
  shadowCoord_18 = (unity_WorldToShadow[0] * tmpvar_16);
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, shadowCoord_18.xy).x > shadowCoord_18.z)), lightShadowDataX_19);
  tmpvar_17 = tmpvar_21;
  realtimeShadowAttenuation_11 = tmpvar_17;
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((realtimeShadowAttenuation_11 + tmpvar_14), 0.0, 1.0);
  atten_2 = tmpvar_22;
  mediump float occ_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_23 = tmpvar_24;
  mediump float atten_25;
  atten_25 = atten_2;
  mediump float occlusion_26;
  occlusion_26 = ((1.0 - _OcclusionStrength) + (occ_23 * _OcclusionStrength));
  highp vec4 tmpvar_27;
  tmpvar_27 = unity_SpecCube0_HDR;
  mediump vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_8;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, tmpvar_28);
  x_29.y = dot (unity_SHAg, tmpvar_28);
  x_29.z = dot (unity_SHAb, tmpvar_28);
  mediump vec3 tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = (1.0 - _Glossiness);
  tmpvar_30 = (tmpvar_9 - (2.0 * (
    dot (tmpvar_8, tmpvar_9)
   * tmpvar_8)));
  mediump vec4 hdr_32;
  hdr_32 = tmpvar_27;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = ((tmpvar_31 * (1.7 - 
    (0.7 * tmpvar_31)
  )) * 6.0);
  lowp vec4 tmpvar_34;
  tmpvar_34 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_30, tmpvar_33.w);
  mediump vec4 tmpvar_35;
  tmpvar_35 = tmpvar_34;
  mediump vec3 viewDir_36;
  viewDir_36 = -(tmpvar_9);
  mediump float specularTerm_37;
  mediump vec3 tmpvar_38;
  mediump vec3 inVec_39;
  inVec_39 = (_WorldSpaceLightPos0.xyz + viewDir_36);
  tmpvar_38 = (inVec_39 * inversesqrt(max (0.001, 
    dot (inVec_39, inVec_39)
  )));
  mediump float tmpvar_40;
  tmpvar_40 = clamp (dot (tmpvar_8, tmpvar_38), 0.0, 1.0);
  mediump float tmpvar_41;
  tmpvar_41 = (tmpvar_31 * tmpvar_31);
  specularTerm_37 = ((tmpvar_41 / (
    (max (0.32, clamp (dot (_WorldSpaceLightPos0.xyz, tmpvar_38), 0.0, 1.0)) * (1.5 + tmpvar_41))
   * 
    (((tmpvar_40 * tmpvar_40) * ((tmpvar_41 * tmpvar_41) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_42;
  tmpvar_42 = clamp (specularTerm_37, 0.0, 100.0);
  specularTerm_37 = tmpvar_42;
  mediump float x_43;
  x_43 = (1.0 - clamp (dot (tmpvar_8, viewDir_36), 0.0, 1.0));
  mediump vec3 tmpvar_44;
  tmpvar_44 = (((
    ((tmpvar_5 + (tmpvar_42 * tmpvar_6)) * (tmpvar_10 * atten_25))
   * 
    clamp (dot (tmpvar_8, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (max (((1.055 * 
      pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_29)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0)) * occlusion_26)
   * tmpvar_5)) + ((
    (1.0 - ((tmpvar_41 * tmpvar_31) * 0.28))
   * 
    (((hdr_32.x * (
      (hdr_32.w * (tmpvar_35.w - 1.0))
     + 1.0)) * tmpvar_35.xyz) * occlusion_26)
  ) * mix (tmpvar_6, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_7)), 0.0, 1.0)
  ), vec3(
    ((x_43 * x_43) * (x_43 * x_43))
  ))));
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = tmpvar_44;
  c_1.w = tmpvar_45.w;
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  c_1.xyz = (tmpvar_44 + (tmpvar_46.xyz * _EmissionColor.xyz));
  mediump vec4 xlat_varoutput_47;
  xlat_varoutput_47.xyz = c_1.xyz;
  xlat_varoutput_47.w = 1.0;
  gl_FragData[0] = xlat_varoutput_47;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_EMISSION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  mediump vec3 x1_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_21.x = dot (unity_SHBr, tmpvar_22);
  x1_21.y = dot (unity_SHBg, tmpvar_22);
  x1_21.z = dot (unity_SHBb, tmpvar_22);
  ambientOrLightmapUV_20.xyz = (x1_21 + (unity_SHC.xyz * (
    (normalWorld_19.x * normalWorld_19.x)
   - 
    (normalWorld_19.y * normalWorld_19.y)
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 c_1;
  lowp float atten_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  mediump float tmpvar_7;
  tmpvar_7 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_5 = (tmpvar_4 * tmpvar_7);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_10;
  tmpvar_10 = _LightColor0.xyz;
  mediump float realtimeShadowAttenuation_11;
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].z;
  v_12.y = unity_MatrixV[1].z;
  v_12.z = unity_MatrixV[2].z;
  v_12.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD8 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD8), v_12.xyz), sqrt(dot (tmpvar_13, tmpvar_13)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = xlv_TEXCOORD8;
  lowp float tmpvar_17;
  highp vec4 shadowCoord_18;
  shadowCoord_18 = (unity_WorldToShadow[0] * tmpvar_16);
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, shadowCoord_18.xy).x > shadowCoord_18.z)), lightShadowDataX_19);
  tmpvar_17 = tmpvar_21;
  realtimeShadowAttenuation_11 = tmpvar_17;
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((realtimeShadowAttenuation_11 + tmpvar_14), 0.0, 1.0);
  atten_2 = tmpvar_22;
  mediump float occ_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_23 = tmpvar_24;
  mediump float atten_25;
  atten_25 = atten_2;
  mediump float occlusion_26;
  occlusion_26 = ((1.0 - _OcclusionStrength) + (occ_23 * _OcclusionStrength));
  highp vec4 tmpvar_27;
  tmpvar_27 = unity_SpecCube0_HDR;
  mediump vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_8;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, tmpvar_28);
  x_29.y = dot (unity_SHAg, tmpvar_28);
  x_29.z = dot (unity_SHAb, tmpvar_28);
  mediump vec3 tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = (1.0 - _Glossiness);
  tmpvar_30 = (tmpvar_9 - (2.0 * (
    dot (tmpvar_8, tmpvar_9)
   * tmpvar_8)));
  mediump vec4 hdr_32;
  hdr_32 = tmpvar_27;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = ((tmpvar_31 * (1.7 - 
    (0.7 * tmpvar_31)
  )) * 6.0);
  lowp vec4 tmpvar_34;
  tmpvar_34 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_30, tmpvar_33.w);
  mediump vec4 tmpvar_35;
  tmpvar_35 = tmpvar_34;
  mediump vec3 viewDir_36;
  viewDir_36 = -(tmpvar_9);
  mediump float specularTerm_37;
  mediump vec3 tmpvar_38;
  mediump vec3 inVec_39;
  inVec_39 = (_WorldSpaceLightPos0.xyz + viewDir_36);
  tmpvar_38 = (inVec_39 * inversesqrt(max (0.001, 
    dot (inVec_39, inVec_39)
  )));
  mediump float tmpvar_40;
  tmpvar_40 = clamp (dot (tmpvar_8, tmpvar_38), 0.0, 1.0);
  mediump float tmpvar_41;
  tmpvar_41 = (tmpvar_31 * tmpvar_31);
  specularTerm_37 = ((tmpvar_41 / (
    (max (0.32, clamp (dot (_WorldSpaceLightPos0.xyz, tmpvar_38), 0.0, 1.0)) * (1.5 + tmpvar_41))
   * 
    (((tmpvar_40 * tmpvar_40) * ((tmpvar_41 * tmpvar_41) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_42;
  tmpvar_42 = clamp (specularTerm_37, 0.0, 100.0);
  specularTerm_37 = tmpvar_42;
  mediump float x_43;
  x_43 = (1.0 - clamp (dot (tmpvar_8, viewDir_36), 0.0, 1.0));
  mediump vec3 tmpvar_44;
  tmpvar_44 = (((
    ((tmpvar_5 + (tmpvar_42 * tmpvar_6)) * (tmpvar_10 * atten_25))
   * 
    clamp (dot (tmpvar_8, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (max (((1.055 * 
      pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_29)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0)) * occlusion_26)
   * tmpvar_5)) + ((
    (1.0 - ((tmpvar_41 * tmpvar_31) * 0.28))
   * 
    (((hdr_32.x * (
      (hdr_32.w * (tmpvar_35.w - 1.0))
     + 1.0)) * tmpvar_35.xyz) * occlusion_26)
  ) * mix (tmpvar_6, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_7)), 0.0, 1.0)
  ), vec3(
    ((x_43 * x_43) * (x_43 * x_43))
  ))));
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = tmpvar_44;
  c_1.w = tmpvar_45.w;
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  c_1.xyz = (tmpvar_44 + (tmpvar_46.xyz * _EmissionColor.xyz));
  mediump vec4 xlat_varoutput_47;
  xlat_varoutput_47.xyz = c_1.xyz;
  xlat_varoutput_47.w = 1.0;
  gl_FragData[0] = xlat_varoutput_47;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "_EMISSION" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  normalWorld_4 = tmpvar_17;
  tmpvar_8.xyz = normalWorld_4;
  tmpvar_6.xyz = eyeVec_5;
  mediump vec4 ambientOrLightmapUV_18;
  ambientOrLightmapUV_18.w = 0.0;
  highp vec3 lightColor0_19;
  lightColor0_19 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_20;
  lightColor1_20 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_21;
  lightColor2_21 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_22;
  lightColor3_22 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_23;
  lightAttenSq_23 = unity_4LightAtten0;
  highp vec3 normal_24;
  normal_24 = normalWorld_4;
  highp vec3 col_25;
  highp vec4 ndotl_26;
  highp vec4 lengthSq_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_27 = (tmpvar_28 * tmpvar_28);
  lengthSq_27 = (lengthSq_27 + (tmpvar_29 * tmpvar_29));
  lengthSq_27 = (lengthSq_27 + (tmpvar_30 * tmpvar_30));
  highp vec4 tmpvar_31;
  tmpvar_31 = max (lengthSq_27, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_27 = tmpvar_31;
  ndotl_26 = (tmpvar_28 * normal_24.x);
  ndotl_26 = (ndotl_26 + (tmpvar_29 * normal_24.y));
  ndotl_26 = (ndotl_26 + (tmpvar_30 * normal_24.z));
  highp vec4 tmpvar_32;
  tmpvar_32 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_26 * inversesqrt(tmpvar_31)));
  ndotl_26 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_32 * (1.0/((1.0 + 
    (tmpvar_31 * lightAttenSq_23)
  ))));
  col_25 = (lightColor0_19 * tmpvar_33.x);
  col_25 = (col_25 + (lightColor1_20 * tmpvar_33.y));
  col_25 = (col_25 + (lightColor2_21 * tmpvar_33.z));
  col_25 = (col_25 + (lightColor3_22 * tmpvar_33.w));
  ambientOrLightmapUV_18.xyz = col_25;
  mediump vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = normalWorld_4;
  mediump vec3 res_35;
  mediump vec3 x_36;
  x_36.x = dot (unity_SHAr, tmpvar_34);
  x_36.y = dot (unity_SHAg, tmpvar_34);
  x_36.z = dot (unity_SHAb, tmpvar_34);
  mediump vec3 x1_37;
  mediump vec4 tmpvar_38;
  tmpvar_38 = (normalWorld_4.xyzz * normalWorld_4.yzzx);
  x1_37.x = dot (unity_SHBr, tmpvar_38);
  x1_37.y = dot (unity_SHBg, tmpvar_38);
  x1_37.z = dot (unity_SHBb, tmpvar_38);
  res_35 = (x_36 + (x1_37 + (unity_SHC.xyz * 
    ((normalWorld_4.x * normalWorld_4.x) - (normalWorld_4.y * normalWorld_4.y))
  )));
  mediump vec3 tmpvar_39;
  tmpvar_39 = max (((1.055 * 
    pow (max (res_35, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_35 = tmpvar_39;
  ambientOrLightmapUV_18.xyz = (ambientOrLightmapUV_18.xyz + max (vec3(0.0, 0.0, 0.0), tmpvar_39));
  tmpvar_7.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  mediump float x_40;
  x_40 = (1.0 - clamp (dot (normalWorld_4, 
    -(eyeVec_5)
  ), 0.0, 1.0));
  tmpvar_8.w = ((x_40 * x_40) * (x_40 * x_40));
  tmpvar_6.w = clamp ((_Glossiness + (1.0 - 
    (0.7790837 - (_Metallic * 0.7790837))
  )), 0.0, 1.0);
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = ambientOrLightmapUV_18;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 c_1;
  mediump float rl_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  tmpvar_5 = (tmpvar_4 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_7;
  tmpvar_7 = _LightColor0.xyz;
  mediump float tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy);
  tmpvar_8 = tmpvar_9.y;
  rl_2 = dot (xlv_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
  highp vec4 tmpvar_10;
  tmpvar_10 = unity_SpecCube0_HDR;
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - _Glossiness);
  mediump vec4 hdr_12;
  hdr_12 = tmpvar_10;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = xlv_TEXCOORD4.yzw;
  tmpvar_13.w = ((tmpvar_11 * (1.7 - 
    (0.7 * tmpvar_11)
  )) * 6.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = impl_low_textureCubeLodEXT (unity_SpecCube0, xlv_TEXCOORD4.yzw, tmpvar_13.w);
  mediump vec4 tmpvar_15;
  tmpvar_15 = tmpvar_14;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = ((rl_2 * rl_2) * (rl_2 * rl_2));
  tmpvar_16.y = tmpvar_11;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_NHxRoughness, tmpvar_16);
  c_1 = (((
    (xlv_TEXCOORD2.xyz * tmpvar_8)
   * tmpvar_5) + (
    (((hdr_12.x * (
      (hdr_12.w * (tmpvar_15.w - 1.0))
     + 1.0)) * tmpvar_15.xyz) * tmpvar_8)
   * 
    mix (tmpvar_6, xlv_TEXCOORD1.www, xlv_TEXCOORD5.www)
  )) + ((tmpvar_5 + 
    ((tmpvar_17.w * 16.0) * tmpvar_6)
  ) * (tmpvar_7 * 
    clamp (dot (xlv_TEXCOORD5.xyz, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  )));
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  c_1 = (c_1 + (tmpvar_18.xyz * _EmissionColor.xyz));
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = c_1;
  mediump vec4 xlat_varoutput_20;
  xlat_varoutput_20.xyz = tmpvar_19.xyz;
  xlat_varoutput_20.w = 1.0;
  gl_FragData[0] = xlat_varoutput_20;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_EMISSION" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  tmpvar_14 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 normal_26;
  normal_26 = normalWorld_19;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (lengthSq_29, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_29 = tmpvar_33;
  ndotl_28 = (tmpvar_30 * normal_26.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * normal_26.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * normal_26.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(tmpvar_33)));
  ndotl_28 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (tmpvar_33 * lightAttenSq_25)
  ))));
  col_27 = (lightColor0_21 * tmpvar_35.x);
  col_27 = (col_27 + (lightColor1_22 * tmpvar_35.y));
  col_27 = (col_27 + (lightColor2_23 * tmpvar_35.z));
  col_27 = (col_27 + (lightColor3_24 * tmpvar_35.w));
  ambientOrLightmapUV_20.xyz = col_27;
  mediump vec4 tmpvar_36;
  tmpvar_36.w = 1.0;
  tmpvar_36.xyz = normalWorld_19;
  mediump vec3 res_37;
  mediump vec3 x_38;
  x_38.x = dot (unity_SHAr, tmpvar_36);
  x_38.y = dot (unity_SHAg, tmpvar_36);
  x_38.z = dot (unity_SHAb, tmpvar_36);
  mediump vec3 x1_39;
  mediump vec4 tmpvar_40;
  tmpvar_40 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_39.x = dot (unity_SHBr, tmpvar_40);
  x1_39.y = dot (unity_SHBg, tmpvar_40);
  x1_39.z = dot (unity_SHBb, tmpvar_40);
  res_37 = (x_38 + (x1_39 + (unity_SHC.xyz * 
    ((normalWorld_19.x * normalWorld_19.x) - (normalWorld_19.y * normalWorld_19.y))
  )));
  mediump vec3 tmpvar_41;
  tmpvar_41 = max (((1.055 * 
    pow (max (res_37, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_37 = tmpvar_41;
  ambientOrLightmapUV_20.xyz = (ambientOrLightmapUV_20.xyz + max (vec3(0.0, 0.0, 0.0), tmpvar_41));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  mediump float tmpvar_6;
  tmpvar_6 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_4 = (tmpvar_3 * tmpvar_6);
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_8;
  tmpvar_8 = _LightColor0.xyz;
  mediump float tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy);
  tmpvar_9 = tmpvar_10.y;
  highp vec4 tmpvar_11;
  tmpvar_11 = unity_SpecCube0_HDR;
  mediump vec3 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (1.0 - _Glossiness);
  tmpvar_12 = (xlv_TEXCOORD1 - (2.0 * (
    dot (tmpvar_7, xlv_TEXCOORD1)
   * tmpvar_7)));
  mediump vec4 hdr_14;
  hdr_14 = tmpvar_11;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_12;
  tmpvar_15.w = ((tmpvar_13 * (1.7 - 
    (0.7 * tmpvar_13)
  )) * 6.0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_12, tmpvar_15.w);
  mediump vec4 tmpvar_17;
  tmpvar_17 = tmpvar_16;
  mediump vec3 viewDir_18;
  viewDir_18 = -(xlv_TEXCOORD1);
  mediump vec3 color_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = dot ((viewDir_18 - (2.0 * 
    (dot (tmpvar_7, viewDir_18) * tmpvar_7)
  )), _WorldSpaceLightPos0.xyz);
  tmpvar_20.y = (1.0 - clamp (dot (tmpvar_7, viewDir_18), 0.0, 1.0));
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 * tmpvar_20) * (tmpvar_20 * tmpvar_20));
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_13;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (unity_NHxRoughness, tmpvar_22);
  color_19 = ((tmpvar_4 + (
    (tmpvar_23.w * 16.0)
   * tmpvar_5)) * (tmpvar_8 * clamp (
    dot (tmpvar_7, _WorldSpaceLightPos0.xyz)
  , 0.0, 1.0)));
  color_19 = (color_19 + ((
    (xlv_TEXCOORD5.xyz * tmpvar_9)
   * tmpvar_4) + (
    (((hdr_14.x * (
      (hdr_14.w * (tmpvar_17.w - 1.0))
     + 1.0)) * tmpvar_17.xyz) * tmpvar_9)
   * 
    mix (tmpvar_5, vec3(clamp ((_Glossiness + (1.0 - tmpvar_6)), 0.0, 1.0)), tmpvar_21.yyy)
  )));
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = color_19;
  c_1.w = tmpvar_24.w;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  c_1.xyz = (color_19 + (tmpvar_25.xyz * _EmissionColor.xyz));
  mediump vec4 xlat_varoutput_26;
  xlat_varoutput_26.xyz = c_1.xyz;
  xlat_varoutput_26.w = 1.0;
  gl_FragData[0] = xlat_varoutput_26;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_EMISSION" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  tmpvar_14 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 normal_26;
  normal_26 = normalWorld_19;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (lengthSq_29, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_29 = tmpvar_33;
  ndotl_28 = (tmpvar_30 * normal_26.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * normal_26.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * normal_26.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(tmpvar_33)));
  ndotl_28 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (tmpvar_33 * lightAttenSq_25)
  ))));
  col_27 = (lightColor0_21 * tmpvar_35.x);
  col_27 = (col_27 + (lightColor1_22 * tmpvar_35.y));
  col_27 = (col_27 + (lightColor2_23 * tmpvar_35.z));
  col_27 = (col_27 + (lightColor3_24 * tmpvar_35.w));
  ambientOrLightmapUV_20.xyz = col_27;
  mediump vec4 tmpvar_36;
  tmpvar_36.w = 1.0;
  tmpvar_36.xyz = normalWorld_19;
  mediump vec3 res_37;
  mediump vec3 x_38;
  x_38.x = dot (unity_SHAr, tmpvar_36);
  x_38.y = dot (unity_SHAg, tmpvar_36);
  x_38.z = dot (unity_SHAb, tmpvar_36);
  mediump vec3 x1_39;
  mediump vec4 tmpvar_40;
  tmpvar_40 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_39.x = dot (unity_SHBr, tmpvar_40);
  x1_39.y = dot (unity_SHBg, tmpvar_40);
  x1_39.z = dot (unity_SHBb, tmpvar_40);
  res_37 = (x_38 + (x1_39 + (unity_SHC.xyz * 
    ((normalWorld_19.x * normalWorld_19.x) - (normalWorld_19.y * normalWorld_19.y))
  )));
  mediump vec3 tmpvar_41;
  tmpvar_41 = max (((1.055 * 
    pow (max (res_37, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_37 = tmpvar_41;
  ambientOrLightmapUV_20.xyz = (ambientOrLightmapUV_20.xyz + max (vec3(0.0, 0.0, 0.0), tmpvar_41));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic));
  mediump float tmpvar_6;
  tmpvar_6 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_4 = (tmpvar_3 * tmpvar_6);
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_8;
  tmpvar_8 = _LightColor0.xyz;
  mediump float tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy);
  tmpvar_9 = tmpvar_10.y;
  highp vec4 tmpvar_11;
  tmpvar_11 = unity_SpecCube0_HDR;
  mediump vec3 tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (1.0 - _Glossiness);
  tmpvar_12 = (xlv_TEXCOORD1 - (2.0 * (
    dot (tmpvar_7, xlv_TEXCOORD1)
   * tmpvar_7)));
  mediump vec4 hdr_14;
  hdr_14 = tmpvar_11;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_12;
  tmpvar_15.w = ((tmpvar_13 * (1.7 - 
    (0.7 * tmpvar_13)
  )) * 6.0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_12, tmpvar_15.w);
  mediump vec4 tmpvar_17;
  tmpvar_17 = tmpvar_16;
  mediump vec3 viewDir_18;
  viewDir_18 = -(xlv_TEXCOORD1);
  mediump vec3 color_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = dot ((viewDir_18 - (2.0 * 
    (dot (tmpvar_7, viewDir_18) * tmpvar_7)
  )), _WorldSpaceLightPos0.xyz);
  tmpvar_20.y = (1.0 - clamp (dot (tmpvar_7, viewDir_18), 0.0, 1.0));
  mediump vec2 tmpvar_21;
  tmpvar_21 = ((tmpvar_20 * tmpvar_20) * (tmpvar_20 * tmpvar_20));
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = tmpvar_13;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (unity_NHxRoughness, tmpvar_22);
  color_19 = ((tmpvar_4 + (
    (tmpvar_23.w * 16.0)
   * tmpvar_5)) * (tmpvar_8 * clamp (
    dot (tmpvar_7, _WorldSpaceLightPos0.xyz)
  , 0.0, 1.0)));
  color_19 = (color_19 + ((
    (xlv_TEXCOORD5.xyz * tmpvar_9)
   * tmpvar_4) + (
    (((hdr_14.x * (
      (hdr_14.w * (tmpvar_17.w - 1.0))
     + 1.0)) * tmpvar_17.xyz) * tmpvar_9)
   * 
    mix (tmpvar_5, vec3(clamp ((_Glossiness + (1.0 - tmpvar_6)), 0.0, 1.0)), tmpvar_21.yyy)
  )));
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = color_19;
  c_1.w = tmpvar_24.w;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  c_1.xyz = (color_19 + (tmpvar_25.xyz * _EmissionColor.xyz));
  mediump vec4 xlat_varoutput_26;
  xlat_varoutput_26.xyz = c_1.xyz;
  xlat_varoutput_26.w = 1.0;
  gl_FragData[0] = xlat_varoutput_26;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_EMISSION" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  normalWorld_4 = tmpvar_17;
  tmpvar_8.xyz = normalWorld_4;
  tmpvar_6.xyz = eyeVec_5;
  mediump vec4 ambientOrLightmapUV_18;
  ambientOrLightmapUV_18.w = 0.0;
  highp vec3 lightColor0_19;
  lightColor0_19 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_20;
  lightColor1_20 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_21;
  lightColor2_21 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_22;
  lightColor3_22 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_23;
  lightAttenSq_23 = unity_4LightAtten0;
  highp vec3 normal_24;
  normal_24 = normalWorld_4;
  highp vec3 col_25;
  highp vec4 ndotl_26;
  highp vec4 lengthSq_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_27 = (tmpvar_28 * tmpvar_28);
  lengthSq_27 = (lengthSq_27 + (tmpvar_29 * tmpvar_29));
  lengthSq_27 = (lengthSq_27 + (tmpvar_30 * tmpvar_30));
  highp vec4 tmpvar_31;
  tmpvar_31 = max (lengthSq_27, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_27 = tmpvar_31;
  ndotl_26 = (tmpvar_28 * normal_24.x);
  ndotl_26 = (ndotl_26 + (tmpvar_29 * normal_24.y));
  ndotl_26 = (ndotl_26 + (tmpvar_30 * normal_24.z));
  highp vec4 tmpvar_32;
  tmpvar_32 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_26 * inversesqrt(tmpvar_31)));
  ndotl_26 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33 = (tmpvar_32 * (1.0/((1.0 + 
    (tmpvar_31 * lightAttenSq_23)
  ))));
  col_25 = (lightColor0_19 * tmpvar_33.x);
  col_25 = (col_25 + (lightColor1_20 * tmpvar_33.y));
  col_25 = (col_25 + (lightColor2_21 * tmpvar_33.z));
  col_25 = (col_25 + (lightColor3_22 * tmpvar_33.w));
  ambientOrLightmapUV_18.xyz = col_25;
  mediump vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = normalWorld_4;
  mediump vec3 res_35;
  mediump vec3 x_36;
  x_36.x = dot (unity_SHAr, tmpvar_34);
  x_36.y = dot (unity_SHAg, tmpvar_34);
  x_36.z = dot (unity_SHAb, tmpvar_34);
  mediump vec3 x1_37;
  mediump vec4 tmpvar_38;
  tmpvar_38 = (normalWorld_4.xyzz * normalWorld_4.yzzx);
  x1_37.x = dot (unity_SHBr, tmpvar_38);
  x1_37.y = dot (unity_SHBg, tmpvar_38);
  x1_37.z = dot (unity_SHBb, tmpvar_38);
  res_35 = (x_36 + (x1_37 + (unity_SHC.xyz * 
    ((normalWorld_4.x * normalWorld_4.x) - (normalWorld_4.y * normalWorld_4.y))
  )));
  mediump vec3 tmpvar_39;
  tmpvar_39 = max (((1.055 * 
    pow (max (res_35, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_35 = tmpvar_39;
  ambientOrLightmapUV_18.xyz = (ambientOrLightmapUV_18.xyz + max (vec3(0.0, 0.0, 0.0), tmpvar_39));
  tmpvar_7.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  mediump float x_40;
  x_40 = (1.0 - clamp (dot (normalWorld_4, 
    -(eyeVec_5)
  ), 0.0, 1.0));
  tmpvar_8.w = ((x_40 * x_40) * (x_40 * x_40));
  tmpvar_6.w = clamp ((_Glossiness + (1.0 - 
    (0.7790837 - (_Metallic * 0.7790837))
  )), 0.0, 1.0);
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = ambientOrLightmapUV_18;
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 c_1;
  mediump float rl_2;
  mediump float realtimeShadowAttenuation_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_5;
  tmpvar_5 = (_Color.xyz * tmpvar_4.xyz);
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_5, vec3(_Metallic));
  tmpvar_6 = (tmpvar_5 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_8;
  tmpvar_8 = _LightColor0.xyz;
  lowp float tmpvar_9;
  highp float lightShadowDataX_10;
  mediump float tmpvar_11;
  tmpvar_11 = _LightShadowData.x;
  lightShadowDataX_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD3.xy).x > xlv_TEXCOORD3.z)), lightShadowDataX_10);
  tmpvar_9 = tmpvar_12;
  realtimeShadowAttenuation_3 = tmpvar_9;
  mediump float occ_13;
  lowp float tmpvar_14;
  tmpvar_14 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_13 = tmpvar_14;
  rl_2 = dot (xlv_TEXCOORD4.yzw, _WorldSpaceLightPos0.xyz);
  mediump float occlusion_15;
  occlusion_15 = ((1.0 - _OcclusionStrength) + (occ_13 * _OcclusionStrength));
  highp vec4 tmpvar_16;
  tmpvar_16 = unity_SpecCube0_HDR;
  mediump float tmpvar_17;
  tmpvar_17 = (1.0 - _Glossiness);
  mediump vec4 hdr_18;
  hdr_18 = tmpvar_16;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = xlv_TEXCOORD4.yzw;
  tmpvar_19.w = ((tmpvar_17 * (1.7 - 
    (0.7 * tmpvar_17)
  )) * 6.0);
  lowp vec4 tmpvar_20;
  tmpvar_20 = impl_low_textureCubeLodEXT (unity_SpecCube0, xlv_TEXCOORD4.yzw, tmpvar_19.w);
  mediump vec4 tmpvar_21;
  tmpvar_21 = tmpvar_20;
  mediump vec2 tmpvar_22;
  tmpvar_22.x = ((rl_2 * rl_2) * (rl_2 * rl_2));
  tmpvar_22.y = tmpvar_17;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (unity_NHxRoughness, tmpvar_22);
  c_1 = (((
    (xlv_TEXCOORD2.xyz * occlusion_15)
   * tmpvar_6) + (
    (((hdr_18.x * (
      (hdr_18.w * (tmpvar_21.w - 1.0))
     + 1.0)) * tmpvar_21.xyz) * occlusion_15)
   * 
    mix (tmpvar_7, xlv_TEXCOORD1.www, xlv_TEXCOORD5.www)
  )) + ((tmpvar_6 + 
    ((tmpvar_23.w * 16.0) * tmpvar_7)
  ) * (
    (tmpvar_8 * realtimeShadowAttenuation_3)
   * 
    clamp (dot (xlv_TEXCOORD5.xyz, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  c_1 = (c_1 + (tmpvar_24.xyz * _EmissionColor.xyz));
  mediump vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = c_1;
  mediump vec4 xlat_varoutput_26;
  xlat_varoutput_26.xyz = tmpvar_25.xyz;
  xlat_varoutput_26.w = 1.0;
  gl_FragData[0] = xlat_varoutput_26;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_EMISSION" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 normal_26;
  normal_26 = normalWorld_19;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (lengthSq_29, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_29 = tmpvar_33;
  ndotl_28 = (tmpvar_30 * normal_26.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * normal_26.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * normal_26.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(tmpvar_33)));
  ndotl_28 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (tmpvar_33 * lightAttenSq_25)
  ))));
  col_27 = (lightColor0_21 * tmpvar_35.x);
  col_27 = (col_27 + (lightColor1_22 * tmpvar_35.y));
  col_27 = (col_27 + (lightColor2_23 * tmpvar_35.z));
  col_27 = (col_27 + (lightColor3_24 * tmpvar_35.w));
  ambientOrLightmapUV_20.xyz = col_27;
  mediump vec3 x1_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_36.x = dot (unity_SHBr, tmpvar_37);
  x1_36.y = dot (unity_SHBg, tmpvar_37);
  x1_36.z = dot (unity_SHBb, tmpvar_37);
  ambientOrLightmapUV_20.xyz = ((ambientOrLightmapUV_20.xyz * (
    (ambientOrLightmapUV_20.xyz * ((ambientOrLightmapUV_20.xyz * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_36 + (unity_SHC.xyz * 
    ((normalWorld_19.x * normalWorld_19.x) - (normalWorld_19.y * normalWorld_19.y))
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 c_1;
  lowp float atten_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  mediump float tmpvar_7;
  tmpvar_7 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_5 = (tmpvar_4 * tmpvar_7);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_10;
  tmpvar_10 = _LightColor0.xyz;
  mediump float realtimeShadowAttenuation_11;
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].z;
  v_12.y = unity_MatrixV[1].z;
  v_12.z = unity_MatrixV[2].z;
  v_12.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD8 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD8), v_12.xyz), sqrt(dot (tmpvar_13, tmpvar_13)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = xlv_TEXCOORD8;
  lowp float tmpvar_17;
  highp vec4 shadowCoord_18;
  shadowCoord_18 = (unity_WorldToShadow[0] * tmpvar_16);
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, shadowCoord_18.xy).x > shadowCoord_18.z)), lightShadowDataX_19);
  tmpvar_17 = tmpvar_21;
  realtimeShadowAttenuation_11 = tmpvar_17;
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((realtimeShadowAttenuation_11 + tmpvar_14), 0.0, 1.0);
  atten_2 = tmpvar_22;
  mediump float occ_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_23 = tmpvar_24;
  mediump float atten_25;
  atten_25 = atten_2;
  mediump float occlusion_26;
  occlusion_26 = ((1.0 - _OcclusionStrength) + (occ_23 * _OcclusionStrength));
  highp vec4 tmpvar_27;
  tmpvar_27 = unity_SpecCube0_HDR;
  mediump vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_8;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, tmpvar_28);
  x_29.y = dot (unity_SHAg, tmpvar_28);
  x_29.z = dot (unity_SHAb, tmpvar_28);
  mediump vec3 tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = (1.0 - _Glossiness);
  tmpvar_30 = (tmpvar_9 - (2.0 * (
    dot (tmpvar_8, tmpvar_9)
   * tmpvar_8)));
  mediump vec4 hdr_32;
  hdr_32 = tmpvar_27;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = ((tmpvar_31 * (1.7 - 
    (0.7 * tmpvar_31)
  )) * 6.0);
  lowp vec4 tmpvar_34;
  tmpvar_34 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_30, tmpvar_33.w);
  mediump vec4 tmpvar_35;
  tmpvar_35 = tmpvar_34;
  mediump vec3 viewDir_36;
  viewDir_36 = -(tmpvar_9);
  mediump float specularTerm_37;
  mediump vec3 tmpvar_38;
  mediump vec3 inVec_39;
  inVec_39 = (_WorldSpaceLightPos0.xyz + viewDir_36);
  tmpvar_38 = (inVec_39 * inversesqrt(max (0.001, 
    dot (inVec_39, inVec_39)
  )));
  mediump float tmpvar_40;
  tmpvar_40 = clamp (dot (tmpvar_8, tmpvar_38), 0.0, 1.0);
  mediump float tmpvar_41;
  tmpvar_41 = (tmpvar_31 * tmpvar_31);
  specularTerm_37 = ((tmpvar_41 / (
    (max (0.32, clamp (dot (_WorldSpaceLightPos0.xyz, tmpvar_38), 0.0, 1.0)) * (1.5 + tmpvar_41))
   * 
    (((tmpvar_40 * tmpvar_40) * ((tmpvar_41 * tmpvar_41) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_42;
  tmpvar_42 = clamp (specularTerm_37, 0.0, 100.0);
  specularTerm_37 = tmpvar_42;
  mediump float x_43;
  x_43 = (1.0 - clamp (dot (tmpvar_8, viewDir_36), 0.0, 1.0));
  mediump vec3 tmpvar_44;
  tmpvar_44 = (((
    ((tmpvar_5 + (tmpvar_42 * tmpvar_6)) * (tmpvar_10 * atten_25))
   * 
    clamp (dot (tmpvar_8, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (max (((1.055 * 
      pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_29)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0)) * occlusion_26)
   * tmpvar_5)) + ((
    (1.0 - ((tmpvar_41 * tmpvar_31) * 0.28))
   * 
    (((hdr_32.x * (
      (hdr_32.w * (tmpvar_35.w - 1.0))
     + 1.0)) * tmpvar_35.xyz) * occlusion_26)
  ) * mix (tmpvar_6, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_7)), 0.0, 1.0)
  ), vec3(
    ((x_43 * x_43) * (x_43 * x_43))
  ))));
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = tmpvar_44;
  c_1.w = tmpvar_45.w;
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  c_1.xyz = (tmpvar_44 + (tmpvar_46.xyz * _EmissionColor.xyz));
  mediump vec4 xlat_varoutput_47;
  xlat_varoutput_47.xyz = c_1.xyz;
  xlat_varoutput_47.w = 1.0;
  gl_FragData[0] = xlat_varoutput_47;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_EMISSION" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = tmpvar_9.xyz;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 n_15;
  n_15 = (tmpvar_9.xyz - _WorldSpaceCameraPos);
  tmpvar_14 = n_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_18;
  mediump vec3 normalWorld_19;
  normalWorld_19 = tmpvar_18;
  mediump vec4 ambientOrLightmapUV_20;
  ambientOrLightmapUV_20.w = 0.0;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 normal_26;
  normal_26 = normalWorld_19;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_9.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_9.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_9.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (lengthSq_29, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_29 = tmpvar_33;
  ndotl_28 = (tmpvar_30 * normal_26.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * normal_26.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * normal_26.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(tmpvar_33)));
  ndotl_28 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (tmpvar_33 * lightAttenSq_25)
  ))));
  col_27 = (lightColor0_21 * tmpvar_35.x);
  col_27 = (col_27 + (lightColor1_22 * tmpvar_35.y));
  col_27 = (col_27 + (lightColor2_23 * tmpvar_35.z));
  col_27 = (col_27 + (lightColor3_24 * tmpvar_35.w));
  ambientOrLightmapUV_20.xyz = col_27;
  mediump vec3 x1_36;
  mediump vec4 tmpvar_37;
  tmpvar_37 = (normalWorld_19.xyzz * normalWorld_19.yzzx);
  x1_36.x = dot (unity_SHBr, tmpvar_37);
  x1_36.y = dot (unity_SHBg, tmpvar_37);
  x1_36.z = dot (unity_SHBb, tmpvar_37);
  ambientOrLightmapUV_20.xyz = ((ambientOrLightmapUV_20.xyz * (
    (ambientOrLightmapUV_20.xyz * ((ambientOrLightmapUV_20.xyz * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_36 + (unity_SHC.xyz * 
    ((normalWorld_19.x * normalWorld_19.x) - (normalWorld_19.y * normalWorld_19.y))
  )));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = ambientOrLightmapUV_20;
  xlv_TEXCOORD6 = tmpvar_7;
  xlv_TEXCOORD8 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _OcclusionMap;
uniform mediump float _OcclusionStrength;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying mediump vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD8;
void main ()
{
  mediump vec4 c_1;
  lowp float atten_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  mediump float tmpvar_7;
  tmpvar_7 = (0.7790837 - (_Metallic * 0.7790837));
  tmpvar_5 = (tmpvar_4 * tmpvar_7);
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_10;
  tmpvar_10 = _LightColor0.xyz;
  mediump float realtimeShadowAttenuation_11;
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].z;
  v_12.y = unity_MatrixV[1].z;
  v_12.z = unity_MatrixV[2].z;
  v_12.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD8 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD8), v_12.xyz), sqrt(dot (tmpvar_13, tmpvar_13)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = xlv_TEXCOORD8;
  lowp float tmpvar_17;
  highp vec4 shadowCoord_18;
  shadowCoord_18 = (unity_WorldToShadow[0] * tmpvar_16);
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, shadowCoord_18.xy).x > shadowCoord_18.z)), lightShadowDataX_19);
  tmpvar_17 = tmpvar_21;
  realtimeShadowAttenuation_11 = tmpvar_17;
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((realtimeShadowAttenuation_11 + tmpvar_14), 0.0, 1.0);
  atten_2 = tmpvar_22;
  mediump float occ_23;
  lowp float tmpvar_24;
  tmpvar_24 = texture2D (_OcclusionMap, xlv_TEXCOORD0.xy).y;
  occ_23 = tmpvar_24;
  mediump float atten_25;
  atten_25 = atten_2;
  mediump float occlusion_26;
  occlusion_26 = ((1.0 - _OcclusionStrength) + (occ_23 * _OcclusionStrength));
  highp vec4 tmpvar_27;
  tmpvar_27 = unity_SpecCube0_HDR;
  mediump vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_8;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, tmpvar_28);
  x_29.y = dot (unity_SHAg, tmpvar_28);
  x_29.z = dot (unity_SHAb, tmpvar_28);
  mediump vec3 tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = (1.0 - _Glossiness);
  tmpvar_30 = (tmpvar_9 - (2.0 * (
    dot (tmpvar_8, tmpvar_9)
   * tmpvar_8)));
  mediump vec4 hdr_32;
  hdr_32 = tmpvar_27;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = tmpvar_30;
  tmpvar_33.w = ((tmpvar_31 * (1.7 - 
    (0.7 * tmpvar_31)
  )) * 6.0);
  lowp vec4 tmpvar_34;
  tmpvar_34 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_30, tmpvar_33.w);
  mediump vec4 tmpvar_35;
  tmpvar_35 = tmpvar_34;
  mediump vec3 viewDir_36;
  viewDir_36 = -(tmpvar_9);
  mediump float specularTerm_37;
  mediump vec3 tmpvar_38;
  mediump vec3 inVec_39;
  inVec_39 = (_WorldSpaceLightPos0.xyz + viewDir_36);
  tmpvar_38 = (inVec_39 * inversesqrt(max (0.001, 
    dot (inVec_39, inVec_39)
  )));
  mediump float tmpvar_40;
  tmpvar_40 = clamp (dot (tmpvar_8, tmpvar_38), 0.0, 1.0);
  mediump float tmpvar_41;
  tmpvar_41 = (tmpvar_31 * tmpvar_31);
  specularTerm_37 = ((tmpvar_41 / (
    (max (0.32, clamp (dot (_WorldSpaceLightPos0.xyz, tmpvar_38), 0.0, 1.0)) * (1.5 + tmpvar_41))
   * 
    (((tmpvar_40 * tmpvar_40) * ((tmpvar_41 * tmpvar_41) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_42;
  tmpvar_42 = clamp (specularTerm_37, 0.0, 100.0);
  specularTerm_37 = tmpvar_42;
  mediump float x_43;
  x_43 = (1.0 - clamp (dot (tmpvar_8, viewDir_36), 0.0, 1.0));
  mediump vec3 tmpvar_44;
  tmpvar_44 = (((
    ((tmpvar_5 + (tmpvar_42 * tmpvar_6)) * (tmpvar_10 * atten_25))
   * 
    clamp (dot (tmpvar_8, _WorldSpaceLightPos0.xyz), 0.0, 1.0)
  ) + (
    (max (((1.055 * 
      pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD5.xyz + x_29)), vec3(0.4166667, 0.4166667, 0.4166667))
    ) - 0.055), vec3(0.0, 0.0, 0.0)) * occlusion_26)
   * tmpvar_5)) + ((
    (1.0 - ((tmpvar_41 * tmpvar_31) * 0.28))
   * 
    (((hdr_32.x * (
      (hdr_32.w * (tmpvar_35.w - 1.0))
     + 1.0)) * tmpvar_35.xyz) * occlusion_26)
  ) * mix (tmpvar_6, vec3(
    clamp ((_Glossiness + (1.0 - tmpvar_7)), 0.0, 1.0)
  ), vec3(
    ((x_43 * x_43) * (x_43 * x_43))
  ))));
  mediump vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = tmpvar_44;
  c_1.w = tmpvar_45.w;
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  c_1.xyz = (tmpvar_44 + (tmpvar_46.xyz * _EmissionColor.xyz));
  mediump vec4 xlat_varoutput_47;
  xlat_varoutput_47.xyz = c_1.xyz;
  xlat_varoutput_47.w = 1.0;
  gl_FragData[0] = xlat_varoutput_47;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "_EMISSION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_EMISSION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_EMISSION" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_EMISSION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_EMISSION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_EMISSION" }
""
}
}
}
 Pass {
  Name "FORWARD_DELTA"
  LOD 150
  Tags { "LIGHTMODE" = "FORWARDADD" "PerformanceChecks" = "False" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ZClip Off
  ZWrite Off
  GpuProgramID 429947
Program "vp" {
SubProgram "gles " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec3 lightDir_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  lightDir_6 = tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec3 n_16;
  n_16 = lightDir_6;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(n_16);
  tmpvar_15 = tmpvar_17;
  lightDir_6 = tmpvar_15;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_18;
  highp vec3 norm_19;
  norm_19 = tmpvar_1;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((norm_19 * tmpvar_20));
  normalWorld_4 = tmpvar_21;
  tmpvar_8.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_15;
  xlv_TEXCOORD5 = normalWorld_4;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec3 lightCoord_1;
  mediump vec3 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD3.yzw, xlv_TEXCOORD4);
  mediump vec2 tmpvar_6;
  tmpvar_6.x = ((tmpvar_5 * tmpvar_5) * (tmpvar_5 * tmpvar_5));
  tmpvar_6.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_NHxRoughness, tmpvar_6);
  c_2 = (((tmpvar_4 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_7.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic))
  )) * _LightColor0.xyz);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD1;
  lightCoord_1 = (unity_WorldToLight * tmpvar_8).xyz;
  highp float tmpvar_9;
  tmpvar_9 = dot (lightCoord_1, lightCoord_1);
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, vec2(tmpvar_9)).w;
  c_2 = (c_2 * (tmpvar_10 * clamp (
    dot (xlv_TEXCOORD5, xlv_TEXCOORD4)
  , 0.0, 1.0)));
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = c_2;
  mediump vec4 xlat_varoutput_12;
  xlat_varoutput_12.xyz = tmpvar_11.xyz;
  xlat_varoutput_12.w = 1.0;
  gl_FragData[0] = xlat_varoutput_12;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  tmpvar_14 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  mediump vec3 tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w)));
  tmpvar_19 = tmpvar_20;
  lightDir_4 = tmpvar_19;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec3 lightCoord_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD5;
  lightCoord_1 = (unity_WorldToLight * tmpvar_5).xyz;
  highp float tmpvar_6;
  tmpvar_6 = dot (lightCoord_1, lightCoord_1);
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_LightTexture0, vec2(tmpvar_6)).w;
  mediump vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD2.w;
  tmpvar_8.y = xlv_TEXCOORD2_1.w;
  tmpvar_8.z = xlv_TEXCOORD2_2.w;
  mediump float atten_9;
  atten_9 = tmpvar_7;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _LightColor0.xyz;
  tmpvar_10 = (tmpvar_10 * atten_9);
  mediump vec3 viewDir_11;
  viewDir_11 = -(xlv_TEXCOORD1);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dot ((viewDir_11 - (2.0 * 
    (dot (tmpvar_4, viewDir_11) * tmpvar_4)
  )), tmpvar_8);
  tmpvar_12.y = (1.0 - clamp (dot (tmpvar_4, viewDir_11), 0.0, 1.0));
  mediump vec2 tmpvar_13;
  tmpvar_13.x = ((tmpvar_12 * tmpvar_12) * (tmpvar_12 * tmpvar_12)).x;
  tmpvar_13.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (unity_NHxRoughness, tmpvar_13);
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = (((tmpvar_3 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_14.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic))
  )) * (tmpvar_10 * clamp (
    dot (tmpvar_4, tmpvar_8)
  , 0.0, 1.0)));
  mediump vec4 xlat_varoutput_16;
  xlat_varoutput_16.xyz = tmpvar_15.xyz;
  xlat_varoutput_16.w = 1.0;
  gl_FragData[0] = xlat_varoutput_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  tmpvar_14 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  mediump vec3 tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w)));
  tmpvar_19 = tmpvar_20;
  lightDir_4 = tmpvar_19;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec3 lightCoord_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD5;
  lightCoord_1 = (unity_WorldToLight * tmpvar_5).xyz;
  highp float tmpvar_6;
  tmpvar_6 = dot (lightCoord_1, lightCoord_1);
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_LightTexture0, vec2(tmpvar_6)).w;
  mediump vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD2.w;
  tmpvar_8.y = xlv_TEXCOORD2_1.w;
  tmpvar_8.z = xlv_TEXCOORD2_2.w;
  mediump float atten_9;
  atten_9 = tmpvar_7;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _LightColor0.xyz;
  tmpvar_10 = (tmpvar_10 * atten_9);
  mediump vec3 viewDir_11;
  viewDir_11 = -(xlv_TEXCOORD1);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dot ((viewDir_11 - (2.0 * 
    (dot (tmpvar_4, viewDir_11) * tmpvar_4)
  )), tmpvar_8);
  tmpvar_12.y = (1.0 - clamp (dot (tmpvar_4, viewDir_11), 0.0, 1.0));
  mediump vec2 tmpvar_13;
  tmpvar_13.x = ((tmpvar_12 * tmpvar_12) * (tmpvar_12 * tmpvar_12)).x;
  tmpvar_13.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (unity_NHxRoughness, tmpvar_13);
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = (((tmpvar_3 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_14.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic))
  )) * (tmpvar_10 * clamp (
    dot (tmpvar_4, tmpvar_8)
  , 0.0, 1.0)));
  mediump vec4 xlat_varoutput_16;
  xlat_varoutput_16.xyz = tmpvar_15.xyz;
  xlat_varoutput_16.w = 1.0;
  gl_FragData[0] = xlat_varoutput_16;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec3 lightDir_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  lightDir_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  normalWorld_4 = tmpvar_18;
  tmpvar_8.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = lightDir_6;
  xlv_TEXCOORD5 = normalWorld_4;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump float tmpvar_4;
  tmpvar_4 = dot (xlv_TEXCOORD3.yzw, xlv_TEXCOORD4);
  mediump vec2 tmpvar_5;
  tmpvar_5.x = ((tmpvar_4 * tmpvar_4) * (tmpvar_4 * tmpvar_4));
  tmpvar_5.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (unity_NHxRoughness, tmpvar_5);
  c_1 = (((tmpvar_3 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_6.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic))
  )) * _LightColor0.xyz);
  c_1 = (c_1 * clamp (dot (xlv_TEXCOORD5, xlv_TEXCOORD4), 0.0, 1.0));
  mediump vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = c_1;
  mediump vec4 xlat_varoutput_8;
  xlat_varoutput_8.xyz = tmpvar_7.xyz;
  xlat_varoutput_8.w = 1.0;
  gl_FragData[0] = xlat_varoutput_8;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 texcoord_11;
  texcoord_11.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_12;
  if ((_UVSec == 0.0)) {
    tmpvar_12 = tmpvar_2;
  } else {
    tmpvar_12 = tmpvar_3;
  };
  texcoord_11.zw = ((tmpvar_12 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_8.xyz - _WorldSpaceCameraPos));
  tmpvar_13 = tmpvar_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (_WorldSpaceLightPos0.xyz - (tmpvar_8.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_18.x;
  tmpvar_5.w = tmpvar_18.y;
  tmpvar_6.w = tmpvar_18.z;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = texcoord_11;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_8.xyz;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * tmpvar_1.xyz);
  mediump vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4.x = xlv_TEXCOORD2.w;
  tmpvar_4.y = xlv_TEXCOORD2_1.w;
  tmpvar_4.z = xlv_TEXCOORD2_2.w;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _LightColor0.xyz;
  mediump vec3 viewDir_6;
  viewDir_6 = -(xlv_TEXCOORD1);
  mediump vec2 tmpvar_7;
  tmpvar_7.x = dot ((viewDir_6 - (2.0 * 
    (dot (tmpvar_3, viewDir_6) * tmpvar_3)
  )), tmpvar_4);
  tmpvar_7.y = (1.0 - clamp (dot (tmpvar_3, viewDir_6), 0.0, 1.0));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((tmpvar_7 * tmpvar_7) * (tmpvar_7 * tmpvar_7)).x;
  tmpvar_8.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_NHxRoughness, tmpvar_8);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (((tmpvar_2 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_9.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_2, vec3(_Metallic))
  )) * (tmpvar_5 * clamp (
    dot (tmpvar_3, tmpvar_4)
  , 0.0, 1.0)));
  mediump vec4 xlat_varoutput_11;
  xlat_varoutput_11.xyz = tmpvar_10.xyz;
  xlat_varoutput_11.w = 1.0;
  gl_FragData[0] = xlat_varoutput_11;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 texcoord_11;
  texcoord_11.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_12;
  if ((_UVSec == 0.0)) {
    tmpvar_12 = tmpvar_2;
  } else {
    tmpvar_12 = tmpvar_3;
  };
  texcoord_11.zw = ((tmpvar_12 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_8.xyz - _WorldSpaceCameraPos));
  tmpvar_13 = tmpvar_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (_WorldSpaceLightPos0.xyz - (tmpvar_8.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_18.x;
  tmpvar_5.w = tmpvar_18.y;
  tmpvar_6.w = tmpvar_18.z;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = texcoord_11;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_8.xyz;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_2;
  tmpvar_2 = (_Color.xyz * tmpvar_1.xyz);
  mediump vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4.x = xlv_TEXCOORD2.w;
  tmpvar_4.y = xlv_TEXCOORD2_1.w;
  tmpvar_4.z = xlv_TEXCOORD2_2.w;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _LightColor0.xyz;
  mediump vec3 viewDir_6;
  viewDir_6 = -(xlv_TEXCOORD1);
  mediump vec2 tmpvar_7;
  tmpvar_7.x = dot ((viewDir_6 - (2.0 * 
    (dot (tmpvar_3, viewDir_6) * tmpvar_3)
  )), tmpvar_4);
  tmpvar_7.y = (1.0 - clamp (dot (tmpvar_3, viewDir_6), 0.0, 1.0));
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((tmpvar_7 * tmpvar_7) * (tmpvar_7 * tmpvar_7)).x;
  tmpvar_8.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_NHxRoughness, tmpvar_8);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (((tmpvar_2 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_9.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_2, vec3(_Metallic))
  )) * (tmpvar_5 * clamp (
    dot (tmpvar_3, tmpvar_4)
  , 0.0, 1.0)));
  mediump vec4 xlat_varoutput_11;
  xlat_varoutput_11.xyz = tmpvar_10.xyz;
  xlat_varoutput_11.w = 1.0;
  gl_FragData[0] = xlat_varoutput_11;
}


#endif
"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec3 lightDir_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  lightDir_6 = tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec3 n_16;
  n_16 = lightDir_6;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(n_16);
  tmpvar_15 = tmpvar_17;
  lightDir_6 = tmpvar_15;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_18;
  highp vec3 norm_19;
  norm_19 = tmpvar_1;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((norm_19 * tmpvar_20));
  normalWorld_4 = tmpvar_21;
  tmpvar_8.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_15;
  xlv_TEXCOORD5 = normalWorld_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform highp samplerCube _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float shadow_1;
  highp vec3 lightCoord_2;
  mediump vec3 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_5;
  tmpvar_5 = (_Color.xyz * tmpvar_4.xyz);
  mediump float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD3.yzw, xlv_TEXCOORD4);
  mediump vec2 tmpvar_7;
  tmpvar_7.x = ((tmpvar_6 * tmpvar_6) * (tmpvar_6 * tmpvar_6));
  tmpvar_7.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_NHxRoughness, tmpvar_7);
  c_3 = (((tmpvar_5 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_8.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_5, vec3(_Metallic))
  )) * _LightColor0.xyz);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD1;
  lightCoord_2 = (unity_WorldToLight * tmpvar_9).xyz;
  highp vec3 vec_10;
  vec_10 = (xlv_TEXCOORD1 - _LightPositionRange.xyz);
  highp float mydist_11;
  mydist_11 = ((sqrt(
    dot (vec_10, vec_10)
  ) * _LightPositionRange.w) * 0.97);
  highp float tmpvar_12;
  tmpvar_12 = dot (textureCube (_ShadowMapTexture, vec_10), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  mediump float tmpvar_13;
  if ((tmpvar_12 < mydist_11)) {
    tmpvar_13 = _LightShadowData.x;
  } else {
    tmpvar_13 = 1.0;
  };
  shadow_1 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (lightCoord_2, lightCoord_2);
  lowp float tmpvar_15;
  tmpvar_15 = ((texture2D (_LightTextureB0, vec2(tmpvar_14)).w * textureCube (_LightTexture0, lightCoord_2).w) * shadow_1);
  c_3 = (c_3 * (tmpvar_15 * clamp (
    dot (xlv_TEXCOORD5, xlv_TEXCOORD4)
  , 0.0, 1.0)));
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = c_3;
  mediump vec4 xlat_varoutput_17;
  xlat_varoutput_17.xyz = tmpvar_16.xyz;
  xlat_varoutput_17.w = 1.0;
  gl_FragData[0] = xlat_varoutput_17;
}


#endif
"
}
SubProgram "gles " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec3 lightDir_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  lightDir_6 = tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec3 n_16;
  n_16 = lightDir_6;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(n_16);
  tmpvar_15 = tmpvar_17;
  lightDir_6 = tmpvar_15;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_18;
  highp vec3 norm_19;
  norm_19 = tmpvar_1;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((norm_19 * tmpvar_20));
  normalWorld_4 = tmpvar_21;
  tmpvar_8.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_15;
  xlv_TEXCOORD5 = normalWorld_4;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float atten_1;
  highp vec4 lightCoord_2;
  mediump vec3 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_5;
  tmpvar_5 = (_Color.xyz * tmpvar_4.xyz);
  mediump float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD3.yzw, xlv_TEXCOORD4);
  mediump vec2 tmpvar_7;
  tmpvar_7.x = ((tmpvar_6 * tmpvar_6) * (tmpvar_6 * tmpvar_6));
  tmpvar_7.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_NHxRoughness, tmpvar_7);
  c_3 = (((tmpvar_5 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_8.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_5, vec3(_Metallic))
  )) * _LightColor0.xyz);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD1;
  lightCoord_2 = (unity_WorldToLight * tmpvar_9);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = ((lightCoord_2.xy / lightCoord_2.w) + 0.5);
  tmpvar_10 = texture2D (_LightTexture0, P_11);
  highp float tmpvar_12;
  tmpvar_12 = dot (lightCoord_2.xyz, lightCoord_2.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightTextureB0, vec2(tmpvar_12));
  highp float tmpvar_14;
  tmpvar_14 = ((float(
    (lightCoord_2.z > 0.0)
  ) * tmpvar_10.w) * tmpvar_13.w);
  atten_1 = tmpvar_14;
  c_3 = (c_3 * (atten_1 * clamp (
    dot (xlv_TEXCOORD5, xlv_TEXCOORD4)
  , 0.0, 1.0)));
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = c_3;
  mediump vec4 xlat_varoutput_16;
  xlat_varoutput_16.xyz = tmpvar_15.xyz;
  xlat_varoutput_16.w = 1.0;
  gl_FragData[0] = xlat_varoutput_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  tmpvar_14 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  mediump vec3 tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w)));
  tmpvar_19 = tmpvar_20;
  lightDir_4 = tmpvar_19;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float atten_1;
  highp vec4 lightCoord_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = xlv_TEXCOORD5;
  lightCoord_2 = (unity_WorldToLight * tmpvar_6);
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((lightCoord_2.xy / lightCoord_2.w) + 0.5);
  tmpvar_7 = texture2D (_LightTexture0, P_8);
  highp float tmpvar_9;
  tmpvar_9 = dot (lightCoord_2.xyz, lightCoord_2.xyz);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightTextureB0, vec2(tmpvar_9));
  highp float tmpvar_11;
  tmpvar_11 = ((float(
    (lightCoord_2.z > 0.0)
  ) * tmpvar_7.w) * tmpvar_10.w);
  atten_1 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12.x = xlv_TEXCOORD2.w;
  tmpvar_12.y = xlv_TEXCOORD2_1.w;
  tmpvar_12.z = xlv_TEXCOORD2_2.w;
  mediump float atten_13;
  atten_13 = atten_1;
  mediump vec3 tmpvar_14;
  tmpvar_14 = _LightColor0.xyz;
  tmpvar_14 = (tmpvar_14 * atten_13);
  mediump vec3 viewDir_15;
  viewDir_15 = -(xlv_TEXCOORD1);
  mediump vec2 tmpvar_16;
  tmpvar_16.x = dot ((viewDir_15 - (2.0 * 
    (dot (tmpvar_5, viewDir_15) * tmpvar_5)
  )), tmpvar_12);
  tmpvar_16.y = (1.0 - clamp (dot (tmpvar_5, viewDir_15), 0.0, 1.0));
  mediump vec2 tmpvar_17;
  tmpvar_17.x = ((tmpvar_16 * tmpvar_16) * (tmpvar_16 * tmpvar_16)).x;
  tmpvar_17.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (unity_NHxRoughness, tmpvar_17);
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = (((tmpvar_4 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_18.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic))
  )) * (tmpvar_14 * clamp (
    dot (tmpvar_5, tmpvar_12)
  , 0.0, 1.0)));
  mediump vec4 xlat_varoutput_20;
  xlat_varoutput_20.xyz = tmpvar_19.xyz;
  xlat_varoutput_20.w = 1.0;
  gl_FragData[0] = xlat_varoutput_20;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  tmpvar_14 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  mediump vec3 tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w)));
  tmpvar_19 = tmpvar_20;
  lightDir_4 = tmpvar_19;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float atten_1;
  highp vec4 lightCoord_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = xlv_TEXCOORD5;
  lightCoord_2 = (unity_WorldToLight * tmpvar_6);
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((lightCoord_2.xy / lightCoord_2.w) + 0.5);
  tmpvar_7 = texture2D (_LightTexture0, P_8);
  highp float tmpvar_9;
  tmpvar_9 = dot (lightCoord_2.xyz, lightCoord_2.xyz);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightTextureB0, vec2(tmpvar_9));
  highp float tmpvar_11;
  tmpvar_11 = ((float(
    (lightCoord_2.z > 0.0)
  ) * tmpvar_7.w) * tmpvar_10.w);
  atten_1 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12.x = xlv_TEXCOORD2.w;
  tmpvar_12.y = xlv_TEXCOORD2_1.w;
  tmpvar_12.z = xlv_TEXCOORD2_2.w;
  mediump float atten_13;
  atten_13 = atten_1;
  mediump vec3 tmpvar_14;
  tmpvar_14 = _LightColor0.xyz;
  tmpvar_14 = (tmpvar_14 * atten_13);
  mediump vec3 viewDir_15;
  viewDir_15 = -(xlv_TEXCOORD1);
  mediump vec2 tmpvar_16;
  tmpvar_16.x = dot ((viewDir_15 - (2.0 * 
    (dot (tmpvar_5, viewDir_15) * tmpvar_5)
  )), tmpvar_12);
  tmpvar_16.y = (1.0 - clamp (dot (tmpvar_5, viewDir_15), 0.0, 1.0));
  mediump vec2 tmpvar_17;
  tmpvar_17.x = ((tmpvar_16 * tmpvar_16) * (tmpvar_16 * tmpvar_16)).x;
  tmpvar_17.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (unity_NHxRoughness, tmpvar_17);
  mediump vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = (((tmpvar_4 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_18.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic))
  )) * (tmpvar_14 * clamp (
    dot (tmpvar_5, tmpvar_12)
  , 0.0, 1.0)));
  mediump vec4 xlat_varoutput_20;
  xlat_varoutput_20.xyz = tmpvar_19.xyz;
  xlat_varoutput_20.w = 1.0;
  gl_FragData[0] = xlat_varoutput_20;
}


#endif
"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec3 lightDir_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  lightDir_6 = tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec3 n_16;
  n_16 = lightDir_6;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(n_16);
  tmpvar_15 = tmpvar_17;
  lightDir_6 = tmpvar_15;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_18;
  highp vec3 norm_19;
  norm_19 = tmpvar_1;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((norm_19 * tmpvar_20));
  normalWorld_4 = tmpvar_21;
  tmpvar_8.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_15;
  xlv_TEXCOORD5 = normalWorld_4;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec3 lightCoord_1;
  mediump vec3 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD3.yzw, xlv_TEXCOORD4);
  mediump vec2 tmpvar_6;
  tmpvar_6.x = ((tmpvar_5 * tmpvar_5) * (tmpvar_5 * tmpvar_5));
  tmpvar_6.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_NHxRoughness, tmpvar_6);
  c_2 = (((tmpvar_4 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_7.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic))
  )) * _LightColor0.xyz);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD1;
  lightCoord_1 = (unity_WorldToLight * tmpvar_8).xyz;
  highp float tmpvar_9;
  tmpvar_9 = dot (lightCoord_1, lightCoord_1);
  lowp float tmpvar_10;
  tmpvar_10 = (texture2D (_LightTextureB0, vec2(tmpvar_9)).w * textureCube (_LightTexture0, lightCoord_1).w);
  c_2 = (c_2 * (tmpvar_10 * clamp (
    dot (xlv_TEXCOORD5, xlv_TEXCOORD4)
  , 0.0, 1.0)));
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = c_2;
  mediump vec4 xlat_varoutput_12;
  xlat_varoutput_12.xyz = tmpvar_11.xyz;
  xlat_varoutput_12.w = 1.0;
  gl_FragData[0] = xlat_varoutput_12;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  tmpvar_14 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  mediump vec3 tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w)));
  tmpvar_19 = tmpvar_20;
  lightDir_4 = tmpvar_19;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec3 lightCoord_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD5;
  lightCoord_1 = (unity_WorldToLight * tmpvar_5).xyz;
  highp float tmpvar_6;
  tmpvar_6 = dot (lightCoord_1, lightCoord_1);
  lowp float tmpvar_7;
  tmpvar_7 = (texture2D (_LightTextureB0, vec2(tmpvar_6)).w * textureCube (_LightTexture0, lightCoord_1).w);
  mediump vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD2.w;
  tmpvar_8.y = xlv_TEXCOORD2_1.w;
  tmpvar_8.z = xlv_TEXCOORD2_2.w;
  mediump float atten_9;
  atten_9 = tmpvar_7;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _LightColor0.xyz;
  tmpvar_10 = (tmpvar_10 * atten_9);
  mediump vec3 viewDir_11;
  viewDir_11 = -(xlv_TEXCOORD1);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dot ((viewDir_11 - (2.0 * 
    (dot (tmpvar_4, viewDir_11) * tmpvar_4)
  )), tmpvar_8);
  tmpvar_12.y = (1.0 - clamp (dot (tmpvar_4, viewDir_11), 0.0, 1.0));
  mediump vec2 tmpvar_13;
  tmpvar_13.x = ((tmpvar_12 * tmpvar_12) * (tmpvar_12 * tmpvar_12)).x;
  tmpvar_13.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (unity_NHxRoughness, tmpvar_13);
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = (((tmpvar_3 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_14.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic))
  )) * (tmpvar_10 * clamp (
    dot (tmpvar_4, tmpvar_8)
  , 0.0, 1.0)));
  mediump vec4 xlat_varoutput_16;
  xlat_varoutput_16.xyz = tmpvar_15.xyz;
  xlat_varoutput_16.w = 1.0;
  gl_FragData[0] = xlat_varoutput_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  tmpvar_14 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  mediump vec3 tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w)));
  tmpvar_19 = tmpvar_20;
  lightDir_4 = tmpvar_19;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec3 lightCoord_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD5;
  lightCoord_1 = (unity_WorldToLight * tmpvar_5).xyz;
  highp float tmpvar_6;
  tmpvar_6 = dot (lightCoord_1, lightCoord_1);
  lowp float tmpvar_7;
  tmpvar_7 = (texture2D (_LightTextureB0, vec2(tmpvar_6)).w * textureCube (_LightTexture0, lightCoord_1).w);
  mediump vec3 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD2.w;
  tmpvar_8.y = xlv_TEXCOORD2_1.w;
  tmpvar_8.z = xlv_TEXCOORD2_2.w;
  mediump float atten_9;
  atten_9 = tmpvar_7;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _LightColor0.xyz;
  tmpvar_10 = (tmpvar_10 * atten_9);
  mediump vec3 viewDir_11;
  viewDir_11 = -(xlv_TEXCOORD1);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dot ((viewDir_11 - (2.0 * 
    (dot (tmpvar_4, viewDir_11) * tmpvar_4)
  )), tmpvar_8);
  tmpvar_12.y = (1.0 - clamp (dot (tmpvar_4, viewDir_11), 0.0, 1.0));
  mediump vec2 tmpvar_13;
  tmpvar_13.x = ((tmpvar_12 * tmpvar_12) * (tmpvar_12 * tmpvar_12)).x;
  tmpvar_13.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (unity_NHxRoughness, tmpvar_13);
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = (((tmpvar_3 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_14.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic))
  )) * (tmpvar_10 * clamp (
    dot (tmpvar_4, tmpvar_8)
  , 0.0, 1.0)));
  mediump vec4 xlat_varoutput_16;
  xlat_varoutput_16.xyz = tmpvar_15.xyz;
  xlat_varoutput_16.w = 1.0;
  gl_FragData[0] = xlat_varoutput_16;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec3 lightDir_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  lightDir_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  normalWorld_4 = tmpvar_18;
  tmpvar_8.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = lightDir_6;
  xlv_TEXCOORD5 = normalWorld_4;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec2 lightCoord_1;
  mediump vec3 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD3.yzw, xlv_TEXCOORD4);
  mediump vec2 tmpvar_6;
  tmpvar_6.x = ((tmpvar_5 * tmpvar_5) * (tmpvar_5 * tmpvar_5));
  tmpvar_6.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_NHxRoughness, tmpvar_6);
  c_2 = (((tmpvar_4 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_7.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic))
  )) * _LightColor0.xyz);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD1;
  lightCoord_1 = (unity_WorldToLight * tmpvar_8).xy;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_LightTexture0, lightCoord_1).w;
  c_2 = (c_2 * (tmpvar_9 * clamp (
    dot (xlv_TEXCOORD5, xlv_TEXCOORD4)
  , 0.0, 1.0)));
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = c_2;
  mediump vec4 xlat_varoutput_11;
  xlat_varoutput_11.xyz = tmpvar_10.xyz;
  xlat_varoutput_11.w = 1.0;
  gl_FragData[0] = xlat_varoutput_11;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 texcoord_11;
  texcoord_11.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_12;
  if ((_UVSec == 0.0)) {
    tmpvar_12 = tmpvar_2;
  } else {
    tmpvar_12 = tmpvar_3;
  };
  texcoord_11.zw = ((tmpvar_12 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_8.xyz - _WorldSpaceCameraPos));
  tmpvar_13 = tmpvar_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (_WorldSpaceLightPos0.xyz - (tmpvar_8.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_18.x;
  tmpvar_5.w = tmpvar_18.y;
  tmpvar_6.w = tmpvar_18.z;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = texcoord_11;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_8.xyz;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec2 lightCoord_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD5;
  lightCoord_1 = (unity_WorldToLight * tmpvar_5).xy;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_LightTexture0, lightCoord_1).w;
  mediump vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD2.w;
  tmpvar_7.y = xlv_TEXCOORD2_1.w;
  tmpvar_7.z = xlv_TEXCOORD2_2.w;
  mediump float atten_8;
  atten_8 = tmpvar_6;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _LightColor0.xyz;
  tmpvar_9 = (tmpvar_9 * atten_8);
  mediump vec3 viewDir_10;
  viewDir_10 = -(xlv_TEXCOORD1);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = dot ((viewDir_10 - (2.0 * 
    (dot (tmpvar_4, viewDir_10) * tmpvar_4)
  )), tmpvar_7);
  tmpvar_11.y = (1.0 - clamp (dot (tmpvar_4, viewDir_10), 0.0, 1.0));
  mediump vec2 tmpvar_12;
  tmpvar_12.x = ((tmpvar_11 * tmpvar_11) * (tmpvar_11 * tmpvar_11)).x;
  tmpvar_12.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_NHxRoughness, tmpvar_12);
  mediump vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((tmpvar_3 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_13.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic))
  )) * (tmpvar_9 * clamp (
    dot (tmpvar_4, tmpvar_7)
  , 0.0, 1.0)));
  mediump vec4 xlat_varoutput_15;
  xlat_varoutput_15.xyz = tmpvar_14.xyz;
  xlat_varoutput_15.w = 1.0;
  gl_FragData[0] = xlat_varoutput_15;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 texcoord_11;
  texcoord_11.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_12;
  if ((_UVSec == 0.0)) {
    tmpvar_12 = tmpvar_2;
  } else {
    tmpvar_12 = tmpvar_3;
  };
  texcoord_11.zw = ((tmpvar_12 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_8.xyz - _WorldSpaceCameraPos));
  tmpvar_13 = tmpvar_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (_WorldSpaceLightPos0.xyz - (tmpvar_8.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_18.x;
  tmpvar_5.w = tmpvar_18.y;
  tmpvar_6.w = tmpvar_18.z;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = texcoord_11;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_8.xyz;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp vec2 lightCoord_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD5;
  lightCoord_1 = (unity_WorldToLight * tmpvar_5).xy;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_LightTexture0, lightCoord_1).w;
  mediump vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD2.w;
  tmpvar_7.y = xlv_TEXCOORD2_1.w;
  tmpvar_7.z = xlv_TEXCOORD2_2.w;
  mediump float atten_8;
  atten_8 = tmpvar_6;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _LightColor0.xyz;
  tmpvar_9 = (tmpvar_9 * atten_8);
  mediump vec3 viewDir_10;
  viewDir_10 = -(xlv_TEXCOORD1);
  mediump vec2 tmpvar_11;
  tmpvar_11.x = dot ((viewDir_10 - (2.0 * 
    (dot (tmpvar_4, viewDir_10) * tmpvar_4)
  )), tmpvar_7);
  tmpvar_11.y = (1.0 - clamp (dot (tmpvar_4, viewDir_10), 0.0, 1.0));
  mediump vec2 tmpvar_12;
  tmpvar_12.x = ((tmpvar_11 * tmpvar_11) * (tmpvar_11 * tmpvar_11)).x;
  tmpvar_12.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_NHxRoughness, tmpvar_12);
  mediump vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((tmpvar_3 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_13.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic))
  )) * (tmpvar_9 * clamp (
    dot (tmpvar_4, tmpvar_7)
  , 0.0, 1.0)));
  mediump vec4 xlat_varoutput_15;
  xlat_varoutput_15.xyz = tmpvar_14.xyz;
  xlat_varoutput_15.w = 1.0;
  gl_FragData[0] = xlat_varoutput_15;
}


#endif
"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec3 lightDir_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  lightDir_6 = tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec3 n_16;
  n_16 = lightDir_6;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(n_16);
  tmpvar_15 = tmpvar_17;
  lightDir_6 = tmpvar_15;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_18;
  highp vec3 norm_19;
  norm_19 = tmpvar_1;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((norm_19 * tmpvar_20));
  normalWorld_4 = tmpvar_21;
  tmpvar_8.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_15;
  xlv_TEXCOORD5 = normalWorld_4;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float atten_1;
  lowp float shadow_2;
  highp vec4 lightCoord_3;
  mediump vec3 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_6;
  tmpvar_6 = (_Color.xyz * tmpvar_5.xyz);
  mediump float tmpvar_7;
  tmpvar_7 = dot (xlv_TEXCOORD3.yzw, xlv_TEXCOORD4);
  mediump vec2 tmpvar_8;
  tmpvar_8.x = ((tmpvar_7 * tmpvar_7) * (tmpvar_7 * tmpvar_7));
  tmpvar_8.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_NHxRoughness, tmpvar_8);
  c_4 = (((tmpvar_6 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_9.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_6, vec3(_Metallic))
  )) * _LightColor0.xyz);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
  lightCoord_3 = (unity_WorldToLight * tmpvar_10);
  mediump float realtimeShadowAttenuation_11;
  realtimeShadowAttenuation_11 = 1.0;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = xlv_TEXCOORD1;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_WorldToShadow[0] * tmpvar_12);
  lowp float tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = texture2DProj (_ShadowMapTexture, tmpvar_13);
  mediump float tmpvar_16;
  if ((tmpvar_15.x < (tmpvar_13.z / tmpvar_13.w))) {
    tmpvar_16 = _LightShadowData.x;
  } else {
    tmpvar_16 = 1.0;
  };
  tmpvar_14 = tmpvar_16;
  realtimeShadowAttenuation_11 = tmpvar_14;
  shadow_2 = realtimeShadowAttenuation_11;
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = ((lightCoord_3.xy / lightCoord_3.w) + 0.5);
  tmpvar_17 = texture2D (_LightTexture0, P_18);
  highp float tmpvar_19;
  tmpvar_19 = dot (lightCoord_3.xyz, lightCoord_3.xyz);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_LightTextureB0, vec2(tmpvar_19));
  highp float tmpvar_21;
  tmpvar_21 = (((
    float((lightCoord_3.z > 0.0))
   * tmpvar_17.w) * tmpvar_20.w) * shadow_2);
  atten_1 = tmpvar_21;
  c_4 = (c_4 * (atten_1 * clamp (
    dot (xlv_TEXCOORD5, xlv_TEXCOORD4)
  , 0.0, 1.0)));
  mediump vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = c_4;
  mediump vec4 xlat_varoutput_23;
  xlat_varoutput_23.xyz = tmpvar_22.xyz;
  xlat_varoutput_23.w = 1.0;
  gl_FragData[0] = xlat_varoutput_23;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  tmpvar_14 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  mediump vec3 tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w)));
  tmpvar_19 = tmpvar_20;
  lightDir_4 = tmpvar_19;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float atten_1;
  lowp float shadow_2;
  highp vec4 lightCoord_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_5;
  tmpvar_5 = (_Color.xyz * tmpvar_4.xyz);
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_5, vec3(_Metallic));
  tmpvar_6 = (tmpvar_5 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD5;
  lightCoord_3 = (unity_WorldToLight * tmpvar_9);
  mediump float realtimeShadowAttenuation_10;
  realtimeShadowAttenuation_10 = 1.0;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = xlv_TEXCOORD5;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_WorldToShadow[0] * tmpvar_11);
  lowp float tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = texture2DProj (_ShadowMapTexture, tmpvar_12);
  mediump float tmpvar_15;
  if ((tmpvar_14.x < (tmpvar_12.z / tmpvar_12.w))) {
    tmpvar_15 = _LightShadowData.x;
  } else {
    tmpvar_15 = 1.0;
  };
  tmpvar_13 = tmpvar_15;
  realtimeShadowAttenuation_10 = tmpvar_13;
  shadow_2 = realtimeShadowAttenuation_10;
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((lightCoord_3.xy / lightCoord_3.w) + 0.5);
  tmpvar_16 = texture2D (_LightTexture0, P_17);
  highp float tmpvar_18;
  tmpvar_18 = dot (lightCoord_3.xyz, lightCoord_3.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_LightTextureB0, vec2(tmpvar_18));
  highp float tmpvar_20;
  tmpvar_20 = (((
    float((lightCoord_3.z > 0.0))
   * tmpvar_16.w) * tmpvar_19.w) * shadow_2);
  atten_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = xlv_TEXCOORD2.w;
  tmpvar_21.y = xlv_TEXCOORD2_1.w;
  tmpvar_21.z = xlv_TEXCOORD2_2.w;
  mediump float atten_22;
  atten_22 = atten_1;
  mediump vec3 tmpvar_23;
  tmpvar_23 = _LightColor0.xyz;
  tmpvar_23 = (tmpvar_23 * atten_22);
  mediump vec3 viewDir_24;
  viewDir_24 = -(xlv_TEXCOORD1);
  mediump vec2 tmpvar_25;
  tmpvar_25.x = dot ((viewDir_24 - (2.0 * 
    (dot (tmpvar_8, viewDir_24) * tmpvar_8)
  )), tmpvar_21);
  tmpvar_25.y = (1.0 - clamp (dot (tmpvar_8, viewDir_24), 0.0, 1.0));
  mediump vec2 tmpvar_26;
  tmpvar_26.x = ((tmpvar_25 * tmpvar_25) * (tmpvar_25 * tmpvar_25)).x;
  tmpvar_26.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (unity_NHxRoughness, tmpvar_26);
  mediump vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = ((tmpvar_6 + (
    (tmpvar_27.w * 16.0)
   * tmpvar_7)) * (tmpvar_23 * clamp (
    dot (tmpvar_8, tmpvar_21)
  , 0.0, 1.0)));
  mediump vec4 xlat_varoutput_29;
  xlat_varoutput_29.xyz = tmpvar_28.xyz;
  xlat_varoutput_29.w = 1.0;
  gl_FragData[0] = xlat_varoutput_29;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  tmpvar_14 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  mediump vec3 tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w)));
  tmpvar_19 = tmpvar_20;
  lightDir_4 = tmpvar_19;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform highp sampler2D _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float atten_1;
  lowp float shadow_2;
  highp vec4 lightCoord_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_5;
  tmpvar_5 = (_Color.xyz * tmpvar_4.xyz);
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_5, vec3(_Metallic));
  tmpvar_6 = (tmpvar_5 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD5;
  lightCoord_3 = (unity_WorldToLight * tmpvar_9);
  mediump float realtimeShadowAttenuation_10;
  realtimeShadowAttenuation_10 = 1.0;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = xlv_TEXCOORD5;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_WorldToShadow[0] * tmpvar_11);
  lowp float tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = texture2DProj (_ShadowMapTexture, tmpvar_12);
  mediump float tmpvar_15;
  if ((tmpvar_14.x < (tmpvar_12.z / tmpvar_12.w))) {
    tmpvar_15 = _LightShadowData.x;
  } else {
    tmpvar_15 = 1.0;
  };
  tmpvar_13 = tmpvar_15;
  realtimeShadowAttenuation_10 = tmpvar_13;
  shadow_2 = realtimeShadowAttenuation_10;
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((lightCoord_3.xy / lightCoord_3.w) + 0.5);
  tmpvar_16 = texture2D (_LightTexture0, P_17);
  highp float tmpvar_18;
  tmpvar_18 = dot (lightCoord_3.xyz, lightCoord_3.xyz);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_LightTextureB0, vec2(tmpvar_18));
  highp float tmpvar_20;
  tmpvar_20 = (((
    float((lightCoord_3.z > 0.0))
   * tmpvar_16.w) * tmpvar_19.w) * shadow_2);
  atten_1 = tmpvar_20;
  mediump vec3 tmpvar_21;
  tmpvar_21.x = xlv_TEXCOORD2.w;
  tmpvar_21.y = xlv_TEXCOORD2_1.w;
  tmpvar_21.z = xlv_TEXCOORD2_2.w;
  mediump float atten_22;
  atten_22 = atten_1;
  mediump vec3 tmpvar_23;
  tmpvar_23 = _LightColor0.xyz;
  tmpvar_23 = (tmpvar_23 * atten_22);
  mediump vec3 viewDir_24;
  viewDir_24 = -(xlv_TEXCOORD1);
  mediump vec2 tmpvar_25;
  tmpvar_25.x = dot ((viewDir_24 - (2.0 * 
    (dot (tmpvar_8, viewDir_24) * tmpvar_8)
  )), tmpvar_21);
  tmpvar_25.y = (1.0 - clamp (dot (tmpvar_8, viewDir_24), 0.0, 1.0));
  mediump vec2 tmpvar_26;
  tmpvar_26.x = ((tmpvar_25 * tmpvar_25) * (tmpvar_25 * tmpvar_25)).x;
  tmpvar_26.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (unity_NHxRoughness, tmpvar_26);
  mediump vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = ((tmpvar_6 + (
    (tmpvar_27.w * 16.0)
   * tmpvar_7)) * (tmpvar_23 * clamp (
    dot (tmpvar_8, tmpvar_21)
  , 0.0, 1.0)));
  mediump vec4 xlat_varoutput_29;
  xlat_varoutput_29.xyz = tmpvar_28.xyz;
  xlat_varoutput_29.w = 1.0;
  gl_FragData[0] = xlat_varoutput_29;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec3 lightDir_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  lightDir_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  normalWorld_4 = tmpvar_18;
  tmpvar_8.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = lightDir_6;
  xlv_TEXCOORD5 = normalWorld_4;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float atten_1;
  mediump vec3 c_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD3.yzw, xlv_TEXCOORD4);
  mediump vec2 tmpvar_6;
  tmpvar_6.x = ((tmpvar_5 * tmpvar_5) * (tmpvar_5 * tmpvar_5));
  tmpvar_6.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_NHxRoughness, tmpvar_6);
  c_2 = (((tmpvar_4 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_7.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic))
  )) * _LightColor0.xyz);
  mediump float realtimeShadowAttenuation_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD1;
  lowp float tmpvar_10;
  highp vec4 shadowCoord_11;
  shadowCoord_11 = (unity_WorldToShadow[0] * tmpvar_9);
  highp float lightShadowDataX_12;
  mediump float tmpvar_13;
  tmpvar_13 = _LightShadowData.x;
  lightShadowDataX_12 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = max (float((texture2D (_ShadowMapTexture, shadowCoord_11.xy).x > shadowCoord_11.z)), lightShadowDataX_12);
  tmpvar_10 = tmpvar_14;
  realtimeShadowAttenuation_8 = tmpvar_10;
  atten_1 = realtimeShadowAttenuation_8;
  c_2 = (c_2 * (atten_1 * clamp (
    dot (xlv_TEXCOORD5, xlv_TEXCOORD4)
  , 0.0, 1.0)));
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = c_2;
  mediump vec4 xlat_varoutput_16;
  xlat_varoutput_16.xyz = tmpvar_15.xyz;
  xlat_varoutput_16.w = 1.0;
  gl_FragData[0] = xlat_varoutput_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 texcoord_11;
  texcoord_11.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_12;
  if ((_UVSec == 0.0)) {
    tmpvar_12 = tmpvar_2;
  } else {
    tmpvar_12 = tmpvar_3;
  };
  texcoord_11.zw = ((tmpvar_12 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_13;
  highp vec3 n_14;
  n_14 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  tmpvar_13 = n_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (_WorldSpaceLightPos0.xyz - (tmpvar_8.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_18.x;
  tmpvar_5.w = tmpvar_18.y;
  tmpvar_6.w = tmpvar_18.z;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = texcoord_11;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_8.xyz;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float atten_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump float realtimeShadowAttenuation_5;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].z;
  v_6.y = unity_MatrixV[1].z;
  v_6.z = unity_MatrixV[2].z;
  v_6.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD5 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD5), v_6.xyz), sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD5;
  lowp float tmpvar_11;
  highp vec4 shadowCoord_12;
  shadowCoord_12 = (unity_WorldToShadow[0] * tmpvar_10);
  highp float lightShadowDataX_13;
  mediump float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((texture2D (_ShadowMapTexture, shadowCoord_12.xy).x > shadowCoord_12.z)), lightShadowDataX_13);
  tmpvar_11 = tmpvar_15;
  realtimeShadowAttenuation_5 = tmpvar_11;
  mediump float tmpvar_16;
  tmpvar_16 = clamp ((realtimeShadowAttenuation_5 + tmpvar_8), 0.0, 1.0);
  atten_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = xlv_TEXCOORD2.w;
  tmpvar_17.y = xlv_TEXCOORD2_1.w;
  tmpvar_17.z = xlv_TEXCOORD2_2.w;
  mediump float atten_18;
  atten_18 = atten_1;
  mediump vec3 tmpvar_19;
  tmpvar_19 = _LightColor0.xyz;
  tmpvar_19 = (tmpvar_19 * atten_18);
  mediump float specularTerm_20;
  mediump vec3 tmpvar_21;
  mediump vec3 inVec_22;
  inVec_22 = (tmpvar_17 - normalize(xlv_TEXCOORD1));
  tmpvar_21 = (inVec_22 * inversesqrt(max (0.001, 
    dot (inVec_22, inVec_22)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = clamp (dot (tmpvar_4, tmpvar_21), 0.0, 1.0);
  mediump float tmpvar_24;
  tmpvar_24 = (1.0 - _Glossiness);
  mediump float tmpvar_25;
  tmpvar_25 = (tmpvar_24 * tmpvar_24);
  specularTerm_20 = ((tmpvar_25 / (
    (max (0.32, clamp (dot (tmpvar_17, tmpvar_21), 0.0, 1.0)) * (1.5 + tmpvar_25))
   * 
    (((tmpvar_23 * tmpvar_23) * ((tmpvar_25 * tmpvar_25) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_26;
  tmpvar_26 = clamp (specularTerm_20, 0.0, 100.0);
  specularTerm_20 = tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = (((
    (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)))
   + 
    (tmpvar_26 * mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic)))
  ) * tmpvar_19) * clamp (dot (tmpvar_4, tmpvar_17), 0.0, 1.0));
  mediump vec4 xlat_varoutput_28;
  xlat_varoutput_28.xyz = tmpvar_27.xyz;
  xlat_varoutput_28.w = 1.0;
  gl_FragData[0] = xlat_varoutput_28;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 texcoord_11;
  texcoord_11.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_12;
  if ((_UVSec == 0.0)) {
    tmpvar_12 = tmpvar_2;
  } else {
    tmpvar_12 = tmpvar_3;
  };
  texcoord_11.zw = ((tmpvar_12 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_13;
  highp vec3 n_14;
  n_14 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  tmpvar_13 = n_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (_WorldSpaceLightPos0.xyz - (tmpvar_8.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_18.x;
  tmpvar_5.w = tmpvar_18.y;
  tmpvar_6.w = tmpvar_18.z;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = texcoord_11;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_8.xyz;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float atten_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  mediump float realtimeShadowAttenuation_5;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].z;
  v_6.y = unity_MatrixV[1].z;
  v_6.z = unity_MatrixV[2].z;
  v_6.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD5 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD5), v_6.xyz), sqrt(dot (tmpvar_7, tmpvar_7)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD5;
  lowp float tmpvar_11;
  highp vec4 shadowCoord_12;
  shadowCoord_12 = (unity_WorldToShadow[0] * tmpvar_10);
  highp float lightShadowDataX_13;
  mediump float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((texture2D (_ShadowMapTexture, shadowCoord_12.xy).x > shadowCoord_12.z)), lightShadowDataX_13);
  tmpvar_11 = tmpvar_15;
  realtimeShadowAttenuation_5 = tmpvar_11;
  mediump float tmpvar_16;
  tmpvar_16 = clamp ((realtimeShadowAttenuation_5 + tmpvar_8), 0.0, 1.0);
  atten_1 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = xlv_TEXCOORD2.w;
  tmpvar_17.y = xlv_TEXCOORD2_1.w;
  tmpvar_17.z = xlv_TEXCOORD2_2.w;
  mediump float atten_18;
  atten_18 = atten_1;
  mediump vec3 tmpvar_19;
  tmpvar_19 = _LightColor0.xyz;
  tmpvar_19 = (tmpvar_19 * atten_18);
  mediump float specularTerm_20;
  mediump vec3 tmpvar_21;
  mediump vec3 inVec_22;
  inVec_22 = (tmpvar_17 - normalize(xlv_TEXCOORD1));
  tmpvar_21 = (inVec_22 * inversesqrt(max (0.001, 
    dot (inVec_22, inVec_22)
  )));
  mediump float tmpvar_23;
  tmpvar_23 = clamp (dot (tmpvar_4, tmpvar_21), 0.0, 1.0);
  mediump float tmpvar_24;
  tmpvar_24 = (1.0 - _Glossiness);
  mediump float tmpvar_25;
  tmpvar_25 = (tmpvar_24 * tmpvar_24);
  specularTerm_20 = ((tmpvar_25 / (
    (max (0.32, clamp (dot (tmpvar_17, tmpvar_21), 0.0, 1.0)) * (1.5 + tmpvar_25))
   * 
    (((tmpvar_23 * tmpvar_23) * ((tmpvar_25 * tmpvar_25) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_26;
  tmpvar_26 = clamp (specularTerm_20, 0.0, 100.0);
  specularTerm_20 = tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = (((
    (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)))
   + 
    (tmpvar_26 * mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic)))
  ) * tmpvar_19) * clamp (dot (tmpvar_4, tmpvar_17), 0.0, 1.0));
  mediump vec4 xlat_varoutput_28;
  xlat_varoutput_28.xyz = tmpvar_27.xyz;
  xlat_varoutput_28.w = 1.0;
  gl_FragData[0] = xlat_varoutput_28;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec3 lightDir_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  lightDir_6 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  normalWorld_4 = tmpvar_18;
  tmpvar_8.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = lightDir_6;
  xlv_TEXCOORD5 = normalWorld_4;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float shadow_1;
  highp vec2 lightCoord_2;
  mediump vec3 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_5;
  tmpvar_5 = (_Color.xyz * tmpvar_4.xyz);
  mediump float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD3.yzw, xlv_TEXCOORD4);
  mediump vec2 tmpvar_7;
  tmpvar_7.x = ((tmpvar_6 * tmpvar_6) * (tmpvar_6 * tmpvar_6));
  tmpvar_7.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_NHxRoughness, tmpvar_7);
  c_3 = (((tmpvar_5 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_8.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_5, vec3(_Metallic))
  )) * _LightColor0.xyz);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD1;
  lightCoord_2 = (unity_WorldToLight * tmpvar_9).xy;
  mediump float realtimeShadowAttenuation_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = xlv_TEXCOORD1;
  lowp float tmpvar_12;
  highp vec4 shadowCoord_13;
  shadowCoord_13 = (unity_WorldToShadow[0] * tmpvar_11);
  highp float lightShadowDataX_14;
  mediump float tmpvar_15;
  tmpvar_15 = _LightShadowData.x;
  lightShadowDataX_14 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = max (float((texture2D (_ShadowMapTexture, shadowCoord_13.xy).x > shadowCoord_13.z)), lightShadowDataX_14);
  tmpvar_12 = tmpvar_16;
  realtimeShadowAttenuation_10 = tmpvar_12;
  shadow_1 = realtimeShadowAttenuation_10;
  lowp float tmpvar_17;
  tmpvar_17 = (texture2D (_LightTexture0, lightCoord_2).w * shadow_1);
  c_3 = (c_3 * (tmpvar_17 * clamp (
    dot (xlv_TEXCOORD5, xlv_TEXCOORD4)
  , 0.0, 1.0)));
  mediump vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = c_3;
  mediump vec4 xlat_varoutput_19;
  xlat_varoutput_19.xyz = tmpvar_18.xyz;
  xlat_varoutput_19.w = 1.0;
  gl_FragData[0] = xlat_varoutput_19;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 texcoord_11;
  texcoord_11.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_12;
  if ((_UVSec == 0.0)) {
    tmpvar_12 = tmpvar_2;
  } else {
    tmpvar_12 = tmpvar_3;
  };
  texcoord_11.zw = ((tmpvar_12 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_13;
  highp vec3 n_14;
  n_14 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  tmpvar_13 = n_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (_WorldSpaceLightPos0.xyz - (tmpvar_8.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_18.x;
  tmpvar_5.w = tmpvar_18.y;
  tmpvar_6.w = tmpvar_18.z;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = texcoord_11;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_8.xyz;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float shadow_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (unity_WorldToLight * tmpvar_5).xy;
  mediump float realtimeShadowAttenuation_7;
  highp vec4 v_8;
  v_8.x = unity_MatrixV[0].z;
  v_8.y = unity_MatrixV[1].z;
  v_8.z = unity_MatrixV[2].z;
  v_8.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD5 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD5), v_8.xyz), sqrt(dot (tmpvar_9, tmpvar_9)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = xlv_TEXCOORD5;
  lowp float tmpvar_13;
  highp vec4 shadowCoord_14;
  shadowCoord_14 = (unity_WorldToShadow[0] * tmpvar_12);
  highp float lightShadowDataX_15;
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((texture2D (_ShadowMapTexture, shadowCoord_14.xy).x > shadowCoord_14.z)), lightShadowDataX_15);
  tmpvar_13 = tmpvar_17;
  realtimeShadowAttenuation_7 = tmpvar_13;
  mediump float tmpvar_18;
  tmpvar_18 = clamp ((realtimeShadowAttenuation_7 + tmpvar_10), 0.0, 1.0);
  shadow_1 = tmpvar_18;
  lowp float tmpvar_19;
  tmpvar_19 = (texture2D (_LightTexture0, tmpvar_6).w * shadow_1);
  mediump vec3 tmpvar_20;
  tmpvar_20.x = xlv_TEXCOORD2.w;
  tmpvar_20.y = xlv_TEXCOORD2_1.w;
  tmpvar_20.z = xlv_TEXCOORD2_2.w;
  mediump float atten_21;
  atten_21 = tmpvar_19;
  mediump vec3 tmpvar_22;
  tmpvar_22 = _LightColor0.xyz;
  tmpvar_22 = (tmpvar_22 * atten_21);
  mediump float specularTerm_23;
  mediump vec3 tmpvar_24;
  mediump vec3 inVec_25;
  inVec_25 = (tmpvar_20 - normalize(xlv_TEXCOORD1));
  tmpvar_24 = (inVec_25 * inversesqrt(max (0.001, 
    dot (inVec_25, inVec_25)
  )));
  mediump float tmpvar_26;
  tmpvar_26 = clamp (dot (tmpvar_4, tmpvar_24), 0.0, 1.0);
  mediump float tmpvar_27;
  tmpvar_27 = (1.0 - _Glossiness);
  mediump float tmpvar_28;
  tmpvar_28 = (tmpvar_27 * tmpvar_27);
  specularTerm_23 = ((tmpvar_28 / (
    (max (0.32, clamp (dot (tmpvar_20, tmpvar_24), 0.0, 1.0)) * (1.5 + tmpvar_28))
   * 
    (((tmpvar_26 * tmpvar_26) * ((tmpvar_28 * tmpvar_28) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_29;
  tmpvar_29 = clamp (specularTerm_23, 0.0, 100.0);
  specularTerm_23 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = (((
    (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)))
   + 
    (tmpvar_29 * mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic)))
  ) * tmpvar_22) * clamp (dot (tmpvar_4, tmpvar_20), 0.0, 1.0));
  mediump vec4 xlat_varoutput_31;
  xlat_varoutput_31.xyz = tmpvar_30.xyz;
  xlat_varoutput_31.w = 1.0;
  gl_FragData[0] = xlat_varoutput_31;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp vec4 texcoord_11;
  texcoord_11.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_12;
  if ((_UVSec == 0.0)) {
    tmpvar_12 = tmpvar_2;
  } else {
    tmpvar_12 = tmpvar_3;
  };
  texcoord_11.zw = ((tmpvar_12 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_13;
  highp vec3 n_14;
  n_14 = (tmpvar_8.xyz - _WorldSpaceCameraPos);
  tmpvar_13 = n_14;
  highp vec3 norm_15;
  norm_15 = tmpvar_1;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((norm_15 * tmpvar_16));
  tmpvar_4.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (_WorldSpaceLightPos0.xyz - (tmpvar_8.xyz * _WorldSpaceLightPos0.w));
  tmpvar_4.w = tmpvar_18.x;
  tmpvar_5.w = tmpvar_18.y;
  tmpvar_6.w = tmpvar_18.z;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = texcoord_11;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD2_1 = tmpvar_5;
  xlv_TEXCOORD2_2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_8.xyz;
  xlv_TEXCOORD6 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 unity_MatrixV;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float shadow_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (unity_WorldToLight * tmpvar_5).xy;
  mediump float realtimeShadowAttenuation_7;
  highp vec4 v_8;
  v_8.x = unity_MatrixV[0].z;
  v_8.y = unity_MatrixV[1].z;
  v_8.z = unity_MatrixV[2].z;
  v_8.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD5 - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (((
    mix (dot ((_WorldSpaceCameraPos - xlv_TEXCOORD5), v_8.xyz), sqrt(dot (tmpvar_9, tmpvar_9)), unity_ShadowFadeCenterAndType.w)
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_10 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = xlv_TEXCOORD5;
  lowp float tmpvar_13;
  highp vec4 shadowCoord_14;
  shadowCoord_14 = (unity_WorldToShadow[0] * tmpvar_12);
  highp float lightShadowDataX_15;
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((texture2D (_ShadowMapTexture, shadowCoord_14.xy).x > shadowCoord_14.z)), lightShadowDataX_15);
  tmpvar_13 = tmpvar_17;
  realtimeShadowAttenuation_7 = tmpvar_13;
  mediump float tmpvar_18;
  tmpvar_18 = clamp ((realtimeShadowAttenuation_7 + tmpvar_10), 0.0, 1.0);
  shadow_1 = tmpvar_18;
  lowp float tmpvar_19;
  tmpvar_19 = (texture2D (_LightTexture0, tmpvar_6).w * shadow_1);
  mediump vec3 tmpvar_20;
  tmpvar_20.x = xlv_TEXCOORD2.w;
  tmpvar_20.y = xlv_TEXCOORD2_1.w;
  tmpvar_20.z = xlv_TEXCOORD2_2.w;
  mediump float atten_21;
  atten_21 = tmpvar_19;
  mediump vec3 tmpvar_22;
  tmpvar_22 = _LightColor0.xyz;
  tmpvar_22 = (tmpvar_22 * atten_21);
  mediump float specularTerm_23;
  mediump vec3 tmpvar_24;
  mediump vec3 inVec_25;
  inVec_25 = (tmpvar_20 - normalize(xlv_TEXCOORD1));
  tmpvar_24 = (inVec_25 * inversesqrt(max (0.001, 
    dot (inVec_25, inVec_25)
  )));
  mediump float tmpvar_26;
  tmpvar_26 = clamp (dot (tmpvar_4, tmpvar_24), 0.0, 1.0);
  mediump float tmpvar_27;
  tmpvar_27 = (1.0 - _Glossiness);
  mediump float tmpvar_28;
  tmpvar_28 = (tmpvar_27 * tmpvar_27);
  specularTerm_23 = ((tmpvar_28 / (
    (max (0.32, clamp (dot (tmpvar_20, tmpvar_24), 0.0, 1.0)) * (1.5 + tmpvar_28))
   * 
    (((tmpvar_26 * tmpvar_26) * ((tmpvar_28 * tmpvar_28) - 1.0)) + 1.00001)
  )) - 0.0001);
  mediump float tmpvar_29;
  tmpvar_29 = clamp (specularTerm_23, 0.0, 100.0);
  specularTerm_23 = tmpvar_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = (((
    (tmpvar_3 * (0.7790837 - (_Metallic * 0.7790837)))
   + 
    (tmpvar_29 * mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic)))
  ) * tmpvar_22) * clamp (dot (tmpvar_4, tmpvar_20), 0.0, 1.0));
  mediump vec4 xlat_varoutput_31;
  xlat_varoutput_31.xyz = tmpvar_30.xyz;
  xlat_varoutput_31.w = 1.0;
  gl_FragData[0] = xlat_varoutput_31;
}


#endif
"
}
SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec3 normalWorld_4;
  mediump vec3 eyeVec_5;
  mediump vec3 lightDir_6;
  highp vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w));
  lightDir_6 = tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec3 n_16;
  n_16 = lightDir_6;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(n_16);
  tmpvar_15 = tmpvar_17;
  lightDir_6 = tmpvar_15;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  eyeVec_5 = tmpvar_18;
  highp vec3 norm_19;
  norm_19 = tmpvar_1;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((norm_19 * tmpvar_20));
  normalWorld_4 = tmpvar_21;
  tmpvar_8.yzw = (eyeVec_5 - (2.0 * (
    dot (normalWorld_4, eyeVec_5)
   * normalWorld_4)));
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = tmpvar_15;
  xlv_TEXCOORD5 = normalWorld_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform highp samplerCube _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float shadow_1;
  highp vec3 lightCoord_2;
  mediump vec3 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_5;
  tmpvar_5 = (_Color.xyz * tmpvar_4.xyz);
  mediump float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD3.yzw, xlv_TEXCOORD4);
  mediump vec2 tmpvar_7;
  tmpvar_7.x = ((tmpvar_6 * tmpvar_6) * (tmpvar_6 * tmpvar_6));
  tmpvar_7.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_NHxRoughness, tmpvar_7);
  c_3 = (((tmpvar_5 * 
    (0.7790837 - (_Metallic * 0.7790837))
  ) + (
    (tmpvar_8.w * 16.0)
   * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_5, vec3(_Metallic))
  )) * _LightColor0.xyz);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD1;
  lightCoord_2 = (unity_WorldToLight * tmpvar_9).xyz;
  highp vec3 vec_10;
  vec_10 = (xlv_TEXCOORD1 - _LightPositionRange.xyz);
  highp float mydist_11;
  mydist_11 = ((sqrt(
    dot (vec_10, vec_10)
  ) * _LightPositionRange.w) * 0.97);
  highp float tmpvar_12;
  tmpvar_12 = dot (textureCube (_ShadowMapTexture, vec_10), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  mediump float tmpvar_13;
  if ((tmpvar_12 < mydist_11)) {
    tmpvar_13 = _LightShadowData.x;
  } else {
    tmpvar_13 = 1.0;
  };
  shadow_1 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (lightCoord_2, lightCoord_2);
  lowp float tmpvar_15;
  tmpvar_15 = (texture2D (_LightTexture0, vec2(tmpvar_14)).w * shadow_1);
  c_3 = (c_3 * (tmpvar_15 * clamp (
    dot (xlv_TEXCOORD5, xlv_TEXCOORD4)
  , 0.0, 1.0)));
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = c_3;
  mediump vec4 xlat_varoutput_17;
  xlat_varoutput_17.xyz = tmpvar_16.xyz;
  xlat_varoutput_17.w = 1.0;
  gl_FragData[0] = xlat_varoutput_17;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  tmpvar_14 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  mediump vec3 tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w)));
  tmpvar_19 = tmpvar_20;
  lightDir_4 = tmpvar_19;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform highp samplerCube _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float shadow_1;
  highp vec3 lightCoord_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  tmpvar_5 = (tmpvar_4 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD5;
  lightCoord_2 = (unity_WorldToLight * tmpvar_8).xyz;
  highp vec3 vec_9;
  vec_9 = (xlv_TEXCOORD5 - _LightPositionRange.xyz);
  highp float mydist_10;
  mydist_10 = ((sqrt(
    dot (vec_9, vec_9)
  ) * _LightPositionRange.w) * 0.97);
  highp float tmpvar_11;
  tmpvar_11 = dot (textureCube (_ShadowMapTexture, vec_9), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  mediump float tmpvar_12;
  if ((tmpvar_11 < mydist_10)) {
    tmpvar_12 = _LightShadowData.x;
  } else {
    tmpvar_12 = 1.0;
  };
  shadow_1 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (lightCoord_2, lightCoord_2);
  lowp float tmpvar_14;
  tmpvar_14 = (texture2D (_LightTexture0, vec2(tmpvar_13)).w * shadow_1);
  mediump vec3 tmpvar_15;
  tmpvar_15.x = xlv_TEXCOORD2.w;
  tmpvar_15.y = xlv_TEXCOORD2_1.w;
  tmpvar_15.z = xlv_TEXCOORD2_2.w;
  mediump float atten_16;
  atten_16 = tmpvar_14;
  mediump vec3 tmpvar_17;
  tmpvar_17 = _LightColor0.xyz;
  tmpvar_17 = (tmpvar_17 * atten_16);
  mediump vec3 viewDir_18;
  viewDir_18 = -(xlv_TEXCOORD1);
  mediump vec2 tmpvar_19;
  tmpvar_19.x = dot ((viewDir_18 - (2.0 * 
    (dot (tmpvar_7, viewDir_18) * tmpvar_7)
  )), tmpvar_15);
  tmpvar_19.y = (1.0 - clamp (dot (tmpvar_7, viewDir_18), 0.0, 1.0));
  mediump vec2 tmpvar_20;
  tmpvar_20.x = ((tmpvar_19 * tmpvar_19) * (tmpvar_19 * tmpvar_19)).x;
  tmpvar_20.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (unity_NHxRoughness, tmpvar_20);
  mediump vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = ((tmpvar_5 + (
    (tmpvar_21.w * 16.0)
   * tmpvar_6)) * (tmpvar_17 * clamp (
    dot (tmpvar_7, tmpvar_15)
  , 0.0, 1.0)));
  mediump vec4 xlat_varoutput_23;
  xlat_varoutput_23.xyz = tmpvar_22.xyz;
  xlat_varoutput_23.w = 1.0;
  gl_FragData[0] = xlat_varoutput_23;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  tmpvar_14 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  mediump vec3 tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w)));
  tmpvar_19 = tmpvar_20;
  lightDir_4 = tmpvar_19;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform highp samplerCube _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float shadow_1;
  highp vec3 lightCoord_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  tmpvar_5 = (tmpvar_4 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD5;
  lightCoord_2 = (unity_WorldToLight * tmpvar_8).xyz;
  highp vec3 vec_9;
  vec_9 = (xlv_TEXCOORD5 - _LightPositionRange.xyz);
  highp float mydist_10;
  mydist_10 = ((sqrt(
    dot (vec_9, vec_9)
  ) * _LightPositionRange.w) * 0.97);
  highp float tmpvar_11;
  tmpvar_11 = dot (textureCube (_ShadowMapTexture, vec_9), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  mediump float tmpvar_12;
  if ((tmpvar_11 < mydist_10)) {
    tmpvar_12 = _LightShadowData.x;
  } else {
    tmpvar_12 = 1.0;
  };
  shadow_1 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (lightCoord_2, lightCoord_2);
  lowp float tmpvar_14;
  tmpvar_14 = (texture2D (_LightTexture0, vec2(tmpvar_13)).w * shadow_1);
  mediump vec3 tmpvar_15;
  tmpvar_15.x = xlv_TEXCOORD2.w;
  tmpvar_15.y = xlv_TEXCOORD2_1.w;
  tmpvar_15.z = xlv_TEXCOORD2_2.w;
  mediump float atten_16;
  atten_16 = tmpvar_14;
  mediump vec3 tmpvar_17;
  tmpvar_17 = _LightColor0.xyz;
  tmpvar_17 = (tmpvar_17 * atten_16);
  mediump vec3 viewDir_18;
  viewDir_18 = -(xlv_TEXCOORD1);
  mediump vec2 tmpvar_19;
  tmpvar_19.x = dot ((viewDir_18 - (2.0 * 
    (dot (tmpvar_7, viewDir_18) * tmpvar_7)
  )), tmpvar_15);
  tmpvar_19.y = (1.0 - clamp (dot (tmpvar_7, viewDir_18), 0.0, 1.0));
  mediump vec2 tmpvar_20;
  tmpvar_20.x = ((tmpvar_19 * tmpvar_19) * (tmpvar_19 * tmpvar_19)).x;
  tmpvar_20.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (unity_NHxRoughness, tmpvar_20);
  mediump vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = ((tmpvar_5 + (
    (tmpvar_21.w * 16.0)
   * tmpvar_6)) * (tmpvar_17 * clamp (
    dot (tmpvar_7, tmpvar_15)
  , 0.0, 1.0)));
  mediump vec4 xlat_varoutput_23;
  xlat_varoutput_23.xyz = tmpvar_22.xyz;
  xlat_varoutput_23.w = 1.0;
  gl_FragData[0] = xlat_varoutput_23;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  tmpvar_14 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  mediump vec3 tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w)));
  tmpvar_19 = tmpvar_20;
  lightDir_4 = tmpvar_19;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform highp samplerCube _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float shadow_1;
  highp vec3 lightCoord_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  tmpvar_5 = (tmpvar_4 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD5;
  lightCoord_2 = (unity_WorldToLight * tmpvar_8).xyz;
  highp vec3 vec_9;
  vec_9 = (xlv_TEXCOORD5 - _LightPositionRange.xyz);
  highp float mydist_10;
  mydist_10 = ((sqrt(
    dot (vec_9, vec_9)
  ) * _LightPositionRange.w) * 0.97);
  highp float tmpvar_11;
  tmpvar_11 = dot (textureCube (_ShadowMapTexture, vec_9), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  mediump float tmpvar_12;
  if ((tmpvar_11 < mydist_10)) {
    tmpvar_12 = _LightShadowData.x;
  } else {
    tmpvar_12 = 1.0;
  };
  shadow_1 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (lightCoord_2, lightCoord_2);
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_LightTextureB0, vec2(tmpvar_13)).w * textureCube (_LightTexture0, lightCoord_2).w) * shadow_1);
  mediump vec3 tmpvar_15;
  tmpvar_15.x = xlv_TEXCOORD2.w;
  tmpvar_15.y = xlv_TEXCOORD2_1.w;
  tmpvar_15.z = xlv_TEXCOORD2_2.w;
  mediump float atten_16;
  atten_16 = tmpvar_14;
  mediump vec3 tmpvar_17;
  tmpvar_17 = _LightColor0.xyz;
  tmpvar_17 = (tmpvar_17 * atten_16);
  mediump vec3 viewDir_18;
  viewDir_18 = -(xlv_TEXCOORD1);
  mediump vec2 tmpvar_19;
  tmpvar_19.x = dot ((viewDir_18 - (2.0 * 
    (dot (tmpvar_7, viewDir_18) * tmpvar_7)
  )), tmpvar_15);
  tmpvar_19.y = (1.0 - clamp (dot (tmpvar_7, viewDir_18), 0.0, 1.0));
  mediump vec2 tmpvar_20;
  tmpvar_20.x = ((tmpvar_19 * tmpvar_19) * (tmpvar_19 * tmpvar_19)).x;
  tmpvar_20.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (unity_NHxRoughness, tmpvar_20);
  mediump vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = ((tmpvar_5 + (
    (tmpvar_21.w * 16.0)
   * tmpvar_6)) * (tmpvar_17 * clamp (
    dot (tmpvar_7, tmpvar_15)
  , 0.0, 1.0)));
  mediump vec4 xlat_varoutput_23;
  xlat_varoutput_23.xyz = tmpvar_22.xyz;
  xlat_varoutput_23.w = 1.0;
  gl_FragData[0] = xlat_varoutput_23;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  highp vec3 lightDir_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec4 texcoord_12;
  texcoord_12.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_13;
  if ((_UVSec == 0.0)) {
    tmpvar_13 = tmpvar_2;
  } else {
    tmpvar_13 = tmpvar_3;
  };
  texcoord_12.zw = ((tmpvar_13 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  mediump vec3 tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_9.xyz - _WorldSpaceCameraPos));
  tmpvar_14 = tmpvar_15;
  highp vec3 norm_16;
  norm_16 = tmpvar_1;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((norm_16 * tmpvar_17));
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_6.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_7.xyz = tmpvar_18;
  mediump vec3 tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_9.xyz * _WorldSpaceLightPos0.w)));
  tmpvar_19 = tmpvar_20;
  lightDir_4 = tmpvar_19;
  tmpvar_5.w = lightDir_4.x;
  tmpvar_6.w = lightDir_4.y;
  tmpvar_7.w = lightDir_4.z;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = texcoord_12;
  xlv_TEXCOORD1 = tmpvar_14;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD2_1 = tmpvar_6;
  xlv_TEXCOORD2_2 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_9.xyz;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D unity_NHxRoughness;
uniform highp samplerCube _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD2_1;
varying mediump vec4 xlv_TEXCOORD2_2;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp float shadow_1;
  highp vec3 lightCoord_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_Color.xyz * tmpvar_3.xyz);
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_4, vec3(_Metallic));
  tmpvar_5 = (tmpvar_4 * (0.7790837 - (_Metallic * 0.7790837)));
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD2_2.xyz);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD5;
  lightCoord_2 = (unity_WorldToLight * tmpvar_8).xyz;
  highp vec3 vec_9;
  vec_9 = (xlv_TEXCOORD5 - _LightPositionRange.xyz);
  highp float mydist_10;
  mydist_10 = ((sqrt(
    dot (vec_9, vec_9)
  ) * _LightPositionRange.w) * 0.97);
  highp float tmpvar_11;
  tmpvar_11 = dot (textureCube (_ShadowMapTexture, vec_9), vec4(1.0, 0.003921569, 1.53787e-05, 6.030863e-08));
  mediump float tmpvar_12;
  if ((tmpvar_11 < mydist_10)) {
    tmpvar_12 = _LightShadowData.x;
  } else {
    tmpvar_12 = 1.0;
  };
  shadow_1 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (lightCoord_2, lightCoord_2);
  lowp float tmpvar_14;
  tmpvar_14 = ((texture2D (_LightTextureB0, vec2(tmpvar_13)).w * textureCube (_LightTexture0, lightCoord_2).w) * shadow_1);
  mediump vec3 tmpvar_15;
  tmpvar_15.x = xlv_TEXCOORD2.w;
  tmpvar_15.y = xlv_TEXCOORD2_1.w;
  tmpvar_15.z = xlv_TEXCOORD2_2.w;
  mediump float atten_16;
  atten_16 = tmpvar_14;
  mediump vec3 tmpvar_17;
  tmpvar_17 = _LightColor0.xyz;
  tmpvar_17 = (tmpvar_17 * atten_16);
  mediump vec3 viewDir_18;
  viewDir_18 = -(xlv_TEXCOORD1);
  mediump vec2 tmpvar_19;
  tmpvar_19.x = dot ((viewDir_18 - (2.0 * 
    (dot (tmpvar_7, viewDir_18) * tmpvar_7)
  )), tmpvar_15);
  tmpvar_19.y = (1.0 - clamp (dot (tmpvar_7, viewDir_18), 0.0, 1.0));
  mediump vec2 tmpvar_20;
  tmpvar_20.x = ((tmpvar_19 * tmpvar_19) * (tmpvar_19 * tmpvar_19)).x;
  tmpvar_20.y = (1.0 - _Glossiness);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (unity_NHxRoughness, tmpvar_20);
  mediump vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = ((tmpvar_5 + (
    (tmpvar_21.w * 16.0)
   * tmpvar_6)) * (tmpvar_17 * clamp (
    dot (tmpvar_7, tmpvar_15)
  , 0.0, 1.0)));
  mediump vec4 xlat_varoutput_23;
  xlat_varoutput_23.xyz = tmpvar_22.xyz;
  xlat_varoutput_23.w = 1.0;
  gl_FragData[0] = xlat_varoutput_23;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
""
}
}
}
 Pass {
  Name "SHADOWCASTER"
  LOD 150
  Tags { "LIGHTMODE" = "SHADOWCASTER" "PerformanceChecks" = "False" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ZClip Off
  GpuProgramID 502921
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 wPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  wPos_2 = tmpvar_3;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp mat3 tmpvar_4;
    tmpvar_4[0] = unity_WorldToObject[0].xyz;
    tmpvar_4[1] = unity_WorldToObject[1].xyz;
    tmpvar_4[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_5;
    tmpvar_5 = normalize((_glesNormal * tmpvar_4));
    highp float tmpvar_6;
    tmpvar_6 = dot (tmpvar_5, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_3.xyz * _WorldSpaceLightPos0.w)
    )));
    wPos_2.xyz = (tmpvar_3.xyz - (tmpvar_5 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_6 * tmpvar_6)))
    )));
  };
  tmpvar_1 = (unity_MatrixVP * wPos_2);
  highp vec4 clipPos_7;
  clipPos_7.xyw = tmpvar_1.xyw;
  clipPos_7.z = (tmpvar_1.z + clamp ((unity_LightShadowBias.x / tmpvar_1.w), 0.0, 1.0));
  clipPos_7.z = mix (clipPos_7.z, max (clipPos_7.z, -(tmpvar_1.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_7;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 wPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  wPos_2 = tmpvar_3;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp mat3 tmpvar_4;
    tmpvar_4[0] = unity_WorldToObject[0].xyz;
    tmpvar_4[1] = unity_WorldToObject[1].xyz;
    tmpvar_4[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_5;
    tmpvar_5 = normalize((_glesNormal * tmpvar_4));
    highp float tmpvar_6;
    tmpvar_6 = dot (tmpvar_5, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_3.xyz * _WorldSpaceLightPos0.w)
    )));
    wPos_2.xyz = (tmpvar_3.xyz - (tmpvar_5 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_6 * tmpvar_6)))
    )));
  };
  tmpvar_1 = (unity_MatrixVP * wPos_2);
  highp vec4 clipPos_7;
  clipPos_7.xyw = tmpvar_1.xyw;
  clipPos_7.z = (tmpvar_1.z + clamp ((unity_LightShadowBias.x / tmpvar_1.w), 0.0, 1.0));
  clipPos_7.z = mix (clipPos_7.z, max (clipPos_7.z, -(tmpvar_1.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_7;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 wPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  wPos_2 = tmpvar_3;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp mat3 tmpvar_4;
    tmpvar_4[0] = unity_WorldToObject[0].xyz;
    tmpvar_4[1] = unity_WorldToObject[1].xyz;
    tmpvar_4[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_5;
    tmpvar_5 = normalize((_glesNormal * tmpvar_4));
    highp float tmpvar_6;
    tmpvar_6 = dot (tmpvar_5, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_3.xyz * _WorldSpaceLightPos0.w)
    )));
    wPos_2.xyz = (tmpvar_3.xyz - (tmpvar_5 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_6 * tmpvar_6)))
    )));
  };
  tmpvar_1 = (unity_MatrixVP * wPos_2);
  highp vec4 clipPos_7;
  clipPos_7.xyw = tmpvar_1.xyw;
  clipPos_7.z = (tmpvar_1.z + clamp ((unity_LightShadowBias.x / tmpvar_1.w), 0.0, 1.0));
  clipPos_7.z = mix (clipPos_7.z, max (clipPos_7.z, -(tmpvar_1.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_7;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_2 = (tmpvar_3 - (tmpvar_3.yzww * 0.003921569));
  tmpvar_1 = enc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_2 = (tmpvar_3 - (tmpvar_3.yzww * 0.003921569));
  tmpvar_1 = enc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_2 = (tmpvar_3 - (tmpvar_3.yzww * 0.003921569));
  tmpvar_1 = enc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
""
}
}
}
 Pass {
  Name "META"
  LOD 150
  Tags { "LIGHTMODE" = "META" "PerformanceChecks" = "False" "RenderType" = "Opaque" }
  ZClip Off
  Cull Off
  GpuProgramID 535281
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
uniform bvec4 unity_MetaVertexControl;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  highp vec4 vertex_3;
  vertex_3 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_4;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_4 = 0.0001;
    } else {
      tmpvar_4 = 0.0;
    };
    vertex_3.z = tmpvar_4;
  };
  if (unity_MetaVertexControl.y) {
    vertex_3.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_5;
    if ((vertex_3.z > 0.0)) {
      tmpvar_5 = 0.0001;
    } else {
      tmpvar_5 = 0.0;
    };
    vertex_3.z = tmpvar_5;
  };
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = vertex_3.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 texcoord_8;
  texcoord_8.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  xlv_TEXCOORD0 = texcoord_8;
  gl_Position = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 res_4;
  mediump float tmpvar_5;
  tmpvar_5 = (1.0 - _Glossiness);
  res_4 = ((tmpvar_3 * (0.7790837 - 
    (_Metallic * 0.7790837)
  )) + ((
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic))
   * 
    (tmpvar_5 * tmpvar_5)
  ) * 0.5));
  mediump vec4 res_6;
  res_6 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_7;
    tmpvar_7.w = 1.0;
    tmpvar_7.xyz = res_4;
    res_6.w = tmpvar_7.w;
    highp vec3 tmpvar_8;
    tmpvar_8 = clamp (pow (res_4, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_6.xyz = tmpvar_8;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_9;
    if (bool(unity_UseLinearSpace)) {
      emission_9 = vec3(0.0, 0.0, 0.0);
    } else {
      emission_9 = vec3(0.0, 0.0, 0.0);
    };
    mediump vec4 tmpvar_10;
    highp float alpha_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = (emission_9 * 0.01030928);
    alpha_11 = (ceil((
      max (max (tmpvar_12.x, tmpvar_12.y), max (tmpvar_12.z, 0.02))
     * 255.0)) / 255.0);
    highp float tmpvar_13;
    tmpvar_13 = max (alpha_11, 0.02);
    alpha_11 = tmpvar_13;
    highp vec4 tmpvar_14;
    tmpvar_14.xyz = (tmpvar_12 / tmpvar_13);
    tmpvar_14.w = tmpvar_13;
    tmpvar_10 = tmpvar_14;
    res_6 = tmpvar_10;
  };
  tmpvar_1 = res_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
uniform bvec4 unity_MetaVertexControl;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  highp vec4 vertex_3;
  vertex_3 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_4;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_4 = 0.0001;
    } else {
      tmpvar_4 = 0.0;
    };
    vertex_3.z = tmpvar_4;
  };
  if (unity_MetaVertexControl.y) {
    vertex_3.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_5;
    if ((vertex_3.z > 0.0)) {
      tmpvar_5 = 0.0001;
    } else {
      tmpvar_5 = 0.0;
    };
    vertex_3.z = tmpvar_5;
  };
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = vertex_3.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 texcoord_8;
  texcoord_8.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  xlv_TEXCOORD0 = texcoord_8;
  gl_Position = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 res_4;
  mediump float tmpvar_5;
  tmpvar_5 = (1.0 - _Glossiness);
  res_4 = ((tmpvar_3 * (0.7790837 - 
    (_Metallic * 0.7790837)
  )) + ((
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic))
   * 
    (tmpvar_5 * tmpvar_5)
  ) * 0.5));
  mediump vec4 res_6;
  res_6 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_7;
    tmpvar_7.w = 1.0;
    tmpvar_7.xyz = res_4;
    res_6.w = tmpvar_7.w;
    highp vec3 tmpvar_8;
    tmpvar_8 = clamp (pow (res_4, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_6.xyz = tmpvar_8;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_9;
    if (bool(unity_UseLinearSpace)) {
      emission_9 = vec3(0.0, 0.0, 0.0);
    } else {
      emission_9 = vec3(0.0, 0.0, 0.0);
    };
    mediump vec4 tmpvar_10;
    highp float alpha_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = (emission_9 * 0.01030928);
    alpha_11 = (ceil((
      max (max (tmpvar_12.x, tmpvar_12.y), max (tmpvar_12.z, 0.02))
     * 255.0)) / 255.0);
    highp float tmpvar_13;
    tmpvar_13 = max (alpha_11, 0.02);
    alpha_11 = tmpvar_13;
    highp vec4 tmpvar_14;
    tmpvar_14.xyz = (tmpvar_12 / tmpvar_13);
    tmpvar_14.w = tmpvar_13;
    tmpvar_10 = tmpvar_14;
    res_6 = tmpvar_10;
  };
  tmpvar_1 = res_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
uniform bvec4 unity_MetaVertexControl;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  highp vec4 vertex_3;
  vertex_3 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_4;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_4 = 0.0001;
    } else {
      tmpvar_4 = 0.0;
    };
    vertex_3.z = tmpvar_4;
  };
  if (unity_MetaVertexControl.y) {
    vertex_3.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_5;
    if ((vertex_3.z > 0.0)) {
      tmpvar_5 = 0.0001;
    } else {
      tmpvar_5 = 0.0;
    };
    vertex_3.z = tmpvar_5;
  };
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = vertex_3.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 texcoord_8;
  texcoord_8.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  xlv_TEXCOORD0 = texcoord_8;
  gl_Position = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 res_4;
  mediump float tmpvar_5;
  tmpvar_5 = (1.0 - _Glossiness);
  res_4 = ((tmpvar_3 * (0.7790837 - 
    (_Metallic * 0.7790837)
  )) + ((
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic))
   * 
    (tmpvar_5 * tmpvar_5)
  ) * 0.5));
  mediump vec4 res_6;
  res_6 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_7;
    tmpvar_7.w = 1.0;
    tmpvar_7.xyz = res_4;
    res_6.w = tmpvar_7.w;
    highp vec3 tmpvar_8;
    tmpvar_8 = clamp (pow (res_4, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_6.xyz = tmpvar_8;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_9;
    if (bool(unity_UseLinearSpace)) {
      emission_9 = vec3(0.0, 0.0, 0.0);
    } else {
      emission_9 = vec3(0.0, 0.0, 0.0);
    };
    mediump vec4 tmpvar_10;
    highp float alpha_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = (emission_9 * 0.01030928);
    alpha_11 = (ceil((
      max (max (tmpvar_12.x, tmpvar_12.y), max (tmpvar_12.z, 0.02))
     * 255.0)) / 255.0);
    highp float tmpvar_13;
    tmpvar_13 = max (alpha_11, 0.02);
    alpha_11 = tmpvar_13;
    highp vec4 tmpvar_14;
    tmpvar_14.xyz = (tmpvar_12 / tmpvar_13);
    tmpvar_14.w = tmpvar_13;
    tmpvar_10 = tmpvar_14;
    res_6 = tmpvar_10;
  };
  tmpvar_1 = res_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_EMISSION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
uniform bvec4 unity_MetaVertexControl;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  highp vec4 vertex_3;
  vertex_3 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_4;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_4 = 0.0001;
    } else {
      tmpvar_4 = 0.0;
    };
    vertex_3.z = tmpvar_4;
  };
  if (unity_MetaVertexControl.y) {
    vertex_3.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_5;
    if ((vertex_3.z > 0.0)) {
      tmpvar_5 = 0.0001;
    } else {
      tmpvar_5 = 0.0;
    };
    vertex_3.z = tmpvar_5;
  };
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = vertex_3.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 texcoord_8;
  texcoord_8.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  xlv_TEXCOORD0 = texcoord_8;
  gl_Position = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 res_4;
  mediump float tmpvar_5;
  tmpvar_5 = (1.0 - _Glossiness);
  res_4 = ((tmpvar_3 * (0.7790837 - 
    (_Metallic * 0.7790837)
  )) + ((
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic))
   * 
    (tmpvar_5 * tmpvar_5)
  ) * 0.5));
  mediump vec3 tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  tmpvar_6 = (tmpvar_7.xyz * _EmissionColor.xyz);
  mediump vec4 res_8;
  res_8 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 1.0;
    tmpvar_9.xyz = res_4;
    res_8.w = tmpvar_9.w;
    highp vec3 tmpvar_10;
    tmpvar_10 = clamp (pow (res_4, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_8.xyz = tmpvar_10;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_11;
    if (bool(unity_UseLinearSpace)) {
      emission_11 = tmpvar_6;
    } else {
      emission_11 = (tmpvar_6 * ((tmpvar_6 * 
        ((tmpvar_6 * 0.305306) + 0.6821711)
      ) + 0.01252288));
    };
    mediump vec4 tmpvar_12;
    highp float alpha_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = (emission_11 * 0.01030928);
    alpha_13 = (ceil((
      max (max (tmpvar_14.x, tmpvar_14.y), max (tmpvar_14.z, 0.02))
     * 255.0)) / 255.0);
    highp float tmpvar_15;
    tmpvar_15 = max (alpha_13, 0.02);
    alpha_13 = tmpvar_15;
    highp vec4 tmpvar_16;
    tmpvar_16.xyz = (tmpvar_14 / tmpvar_15);
    tmpvar_16.w = tmpvar_15;
    tmpvar_12 = tmpvar_16;
    res_8 = tmpvar_12;
  };
  tmpvar_1 = res_8;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_EMISSION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
uniform bvec4 unity_MetaVertexControl;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  highp vec4 vertex_3;
  vertex_3 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_4;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_4 = 0.0001;
    } else {
      tmpvar_4 = 0.0;
    };
    vertex_3.z = tmpvar_4;
  };
  if (unity_MetaVertexControl.y) {
    vertex_3.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_5;
    if ((vertex_3.z > 0.0)) {
      tmpvar_5 = 0.0001;
    } else {
      tmpvar_5 = 0.0;
    };
    vertex_3.z = tmpvar_5;
  };
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = vertex_3.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 texcoord_8;
  texcoord_8.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  xlv_TEXCOORD0 = texcoord_8;
  gl_Position = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 res_4;
  mediump float tmpvar_5;
  tmpvar_5 = (1.0 - _Glossiness);
  res_4 = ((tmpvar_3 * (0.7790837 - 
    (_Metallic * 0.7790837)
  )) + ((
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic))
   * 
    (tmpvar_5 * tmpvar_5)
  ) * 0.5));
  mediump vec3 tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  tmpvar_6 = (tmpvar_7.xyz * _EmissionColor.xyz);
  mediump vec4 res_8;
  res_8 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 1.0;
    tmpvar_9.xyz = res_4;
    res_8.w = tmpvar_9.w;
    highp vec3 tmpvar_10;
    tmpvar_10 = clamp (pow (res_4, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_8.xyz = tmpvar_10;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_11;
    if (bool(unity_UseLinearSpace)) {
      emission_11 = tmpvar_6;
    } else {
      emission_11 = (tmpvar_6 * ((tmpvar_6 * 
        ((tmpvar_6 * 0.305306) + 0.6821711)
      ) + 0.01252288));
    };
    mediump vec4 tmpvar_12;
    highp float alpha_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = (emission_11 * 0.01030928);
    alpha_13 = (ceil((
      max (max (tmpvar_14.x, tmpvar_14.y), max (tmpvar_14.z, 0.02))
     * 255.0)) / 255.0);
    highp float tmpvar_15;
    tmpvar_15 = max (alpha_13, 0.02);
    alpha_13 = tmpvar_15;
    highp vec4 tmpvar_16;
    tmpvar_16.xyz = (tmpvar_14 / tmpvar_15);
    tmpvar_16.w = tmpvar_15;
    tmpvar_12 = tmpvar_16;
    res_8 = tmpvar_12;
  };
  tmpvar_1 = res_8;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_EMISSION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailAlbedoMap_ST;
uniform mediump float _UVSec;
uniform bvec4 unity_MetaVertexControl;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  highp vec4 vertex_3;
  vertex_3 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_4;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_4 = 0.0001;
    } else {
      tmpvar_4 = 0.0;
    };
    vertex_3.z = tmpvar_4;
  };
  if (unity_MetaVertexControl.y) {
    vertex_3.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_5;
    if ((vertex_3.z > 0.0)) {
      tmpvar_5 = 0.0001;
    } else {
      tmpvar_5 = 0.0;
    };
    vertex_3.z = tmpvar_5;
  };
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = vertex_3.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 texcoord_8;
  texcoord_8.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_9;
  if ((_UVSec == 0.0)) {
    tmpvar_9 = tmpvar_1;
  } else {
    tmpvar_9 = tmpvar_2;
  };
  texcoord_8.zw = ((tmpvar_9 * _DetailAlbedoMap_ST.xy) + _DetailAlbedoMap_ST.zw);
  xlv_TEXCOORD0 = texcoord_8;
  gl_Position = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform mediump float _Metallic;
uniform mediump float _Glossiness;
uniform mediump vec4 _EmissionColor;
uniform sampler2D _EmissionMap;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (_Color.xyz * tmpvar_2.xyz);
  mediump vec3 res_4;
  mediump float tmpvar_5;
  tmpvar_5 = (1.0 - _Glossiness);
  res_4 = ((tmpvar_3 * (0.7790837 - 
    (_Metallic * 0.7790837)
  )) + ((
    mix (vec3(0.2209163, 0.2209163, 0.2209163), tmpvar_3, vec3(_Metallic))
   * 
    (tmpvar_5 * tmpvar_5)
  ) * 0.5));
  mediump vec3 tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_EmissionMap, xlv_TEXCOORD0.xy);
  tmpvar_6 = (tmpvar_7.xyz * _EmissionColor.xyz);
  mediump vec4 res_8;
  res_8 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 1.0;
    tmpvar_9.xyz = res_4;
    res_8.w = tmpvar_9.w;
    highp vec3 tmpvar_10;
    tmpvar_10 = clamp (pow (res_4, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_8.xyz = tmpvar_10;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_11;
    if (bool(unity_UseLinearSpace)) {
      emission_11 = tmpvar_6;
    } else {
      emission_11 = (tmpvar_6 * ((tmpvar_6 * 
        ((tmpvar_6 * 0.305306) + 0.6821711)
      ) + 0.01252288));
    };
    mediump vec4 tmpvar_12;
    highp float alpha_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = (emission_11 * 0.01030928);
    alpha_13 = (ceil((
      max (max (tmpvar_14.x, tmpvar_14.y), max (tmpvar_14.z, 0.02))
     * 255.0)) / 255.0);
    highp float tmpvar_15;
    tmpvar_15 = max (alpha_13, 0.02);
    alpha_13 = tmpvar_15;
    highp vec4 tmpvar_16;
    tmpvar_16.xyz = (tmpvar_14 / tmpvar_15);
    tmpvar_16.w = tmpvar_15;
    tmpvar_12 = tmpvar_16;
    res_8 = tmpvar_12;
  };
  tmpvar_1 = res_8;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_EMISSION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_EMISSION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_EMISSION" }
""
}
}
}
}
Fallback "VertexLit"
CustomEditor "StandardShaderGUI"
}