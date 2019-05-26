using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using System.IO;
using UnityEditor.ProjectWindowCallback;
using System.Text.RegularExpressions;
using System;
using System.Reflection;
using System.Text;
 
//这是一个编辑器类，如果想使用它你需要把它放到工程目录下的Assets/Editor文件夹下。
//编辑器类在UnityEditor命名空间下。所以当使用C#脚本时，你需要在脚本前面加上 
//"using UnityEditor"引用
 
public class CreateTemplate {
    //菜单路径，是否为验证方法，菜单项优先级
    [MenuItem("Assets/Create/Lua", false, 80)]
    //方法必须为静态方法
    public static void CreateLua()
    {
        //将设置焦点到某文件并进入重命名
        ProjectWindowUtil.StartNameEditingIfProjectWindowExists(0,
            ScriptableObject.CreateInstance<CreateLuaScriptAsset>(),
            GetSelectPathOrFallback() + "/New lua.lua.txt", null,
            @"Assets/Resources/Template/Lua/LuaTemplate.lua.txt");
    }
    
    [MenuItem("Assets/Create/ShaderToy", false, 80)]
    //方法必须为静态方法
    public static void CreateShaderToy()
    {
        //将设置焦点到某文件并进入重命名
        ProjectWindowUtil.StartNameEditingIfProjectWindowExists(0,
            ScriptableObject.CreateInstance<CreateLuaScriptAsset>(),
            GetSelectPathOrFallback() + "/New Shader.shader", null,
            @"Assets/Resources/Templates/Shader/ShaderToyTemplate.shader");
    }
    
        
    [MenuItem("Assets/Create/Unity Shader", false, 80)]
    //方法必须为静态方法
    public static void CreateUnityShader()
    {
        //将设置焦点到某文件并进入重命名
        ProjectWindowUtil.StartNameEditingIfProjectWindowExists(0,
            ScriptableObject.CreateInstance<CreateLuaScriptAsset>(),
            GetSelectPathOrFallback() + "/New Shader.shader", null,
            @"Assets/Resources/Templates/Shader/UnityShaderTemplate.shader");
    }
 
    //取得要创建文件的路径
    public static string GetSelectPathOrFallback()
    {
        string path = "Assets";
        //遍历选中的资源以获得路径
        //Selection.GetFiltered是过滤选择文件或文件夹下的物体，assets表示只返回选择对象本身
        foreach (UnityEngine.Object obj in Selection.GetFiltered(typeof(UnityEngine.Object), SelectionMode.Assets))
        {
            path = AssetDatabase.GetAssetPath(obj);
            if (!string.IsNullOrEmpty(path) && File.Exists(path))
            {
                path = Path.GetDirectoryName(path);
                break;
            }
        }
        return path;
    }
}
 
//要创建模板文件必须继承EndNameEditAction，重写action方法
class CreateLuaScriptAsset : EndNameEditAction
{
    public override void Action(int instanceId, string pathName, string resourceFile)
    {
        UnityEngine.Object obj = CreateScriptAssetFromTemplate(pathName, resourceFile);
        ProjectWindowUtil.ShowCreatedAsset(obj);
    }

    internal static UnityEngine.Object CreateScriptAssetFromTemplate(string pathName, string resourceFile)
    {
        string fullPath = Path.GetFullPath(pathName);
        StreamReader streamReader = new StreamReader(resourceFile);
        string text = streamReader.ReadToEnd();
        streamReader.Close();
        string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(pathName);
        Debug.Log("text===" + text);
        text = Regex.Replace(text, "LuaClass", fileNameWithoutExtension);
        bool encoderShouldEmitUTF8Identifier = true;
        bool throwOnInvalidBytes = false;
        UTF8Encoding encoding = new UTF8Encoding(encoderShouldEmitUTF8Identifier, throwOnInvalidBytes);
        bool append = false;
        StreamWriter streamWriter = new StreamWriter(fullPath, append, encoding);
        streamWriter.Write(text);
        streamWriter.Close();
        AssetDatabase.ImportAsset(pathName); //导入指定路径下的资源
        return AssetDatabase.LoadAssetAtPath(pathName, typeof(UnityEngine.Object)); //返回指定路径下的所有Object对象
    }
}