using System;
using UnityEditor;
using UnityEngine;

public class GrayGUI: ShaderGUI {
 
    private static bool Gray = false;
    private static bool No_Gray = false;
 
 
    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
    {
        // render the default gui
        base.OnGUI(materialEditor, properties);
 
        Material targetMat = materialEditor.target as Material;
 
        Gray = Array.IndexOf(targetMat.shaderKeywords, "GRAY") != -1;
        No_Gray = Array.IndexOf(targetMat.shaderKeywords, "NO_GRAY") != -1;
 
        EditorGUI.BeginChangeCheck();
 
        Gray = EditorGUILayout.Toggle("变灰", Gray);
        No_Gray = EditorGUILayout.Toggle("恢复", No_Gray);
 
        if (EditorGUI.EndChangeCheck())
        {
            if (Gray)
                targetMat.EnableKeyword("GRAY");
            else
                targetMat.DisableKeyword("NO_GRAY");
            if (No_Gray)
                targetMat.EnableKeyword("NO_GRAY");
            else
                targetMat.DisableKeyword("GRAY");
        }
    }
}