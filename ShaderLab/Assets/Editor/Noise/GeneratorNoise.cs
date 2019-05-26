using System;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class GeneratorNoise : EditorWindow
{
    public SimplexNoise noiseGen;
    private string width;
    private string height;
    private string x;
    private string y;
    private string z;
    private string fm;
    
    
    [MenuItem("2D天气/生成平铺噪声贴图")]
    private static void OpenNoiseGeneratorWindow()
    {        
        Rect rec=new Rect(0,0,512,512);
        GeneratorNoise generatorWindow =
            GetWindowWithRect<GeneratorNoise>(rec, true, "噪声贴图生成器");
        generatorWindow.Show();
    }

    private void Awake()
    {

    }

    private void OnGUI()
    {
        Material mat=new Material(Shader.Find("Custom/Default"));
        mat.color = Color.white;
        
        GUILayout.Label("为动态云生成四张可平铺的噪声贴图","Box");
        GUILayout.BeginHorizontal("Box");
        GUILayout.Label("宽度:");
//        GUILayout.Space(15);
        width = GUILayout.TextField(width);
        GUILayout.EndHorizontal();

        GUILayout.BeginHorizontal("Box");
        GUILayout.Label("频率:");
//        GUILayout.Space(15);
        fm = GUILayout.TextField(fm);
        GUILayout.EndHorizontal();
        
//        GUILayout.BeginVertical();
        GUILayout.Label("太阳光方向");
        GUILayout.BeginHorizontal("Box");
        GUILayout.Label("x:");
//        GUILayout.Space(2);
        x = GUILayout.TextField(x);
        
        GUILayout.Label("y:");
//        GUILayout.Space(1);
        y = GUILayout.TextField(y);
        
        GUILayout.Label("z:");
//        GUILayout.Space(1);
        z = GUILayout.TextField(z);
        GUILayout.EndHorizontal();

        GUILayout.Space(10);
        if (GUILayout.Button("生成"))
        {
            ProcedureTextureGeneration._GenerationNoiseTexture(Int32.Parse(width),mat,Int32.Parse(fm));
            Debug.LogWarning("gen!!");
        }

    }
}
