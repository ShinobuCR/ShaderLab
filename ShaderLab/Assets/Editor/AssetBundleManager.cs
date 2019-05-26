using UnityEngine;
using System;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEditor.Build.Content;
using UnityEngine.Experimental.UIElements;
using UnityEngine.UI;
using Object = System.Object;

public class AssetBundleManager : MonoBehaviour
{
    static Dictionary<string,ABInfo> assetInfoDict=new Dictionary<string, ABInfo>();
    private static string curRootAsset = string.Empty;
    private static float curProgress = 0.0f;
    
    /// <summary>
    /// 自动化设置AB
    /// </summary>
    /// <returns></returns>
    [MenuItem("AssetBundleMgr/SetAssetBundleName")]

    static void SetABNames()
    {
        string path = GetSelectedAssetPath();
        if (path == null)
        {
//            Debug.LogWarning("请先选择目标文件夹");
            return;
        }
        GetAllAssets(path);
    }

    /// <summary>
    /// 清理Assetbundlename
    /// </summary>
    [MenuItem("AssetBundleMgr/ClearAllAssetBundleName")]

    static void ClearAllNames()
    {
        string[] abnames = AssetDatabase.GetAllAssetBundleNames();
        foreach (var n in abnames)
        {
            AssetDatabase.RemoveAssetBundleName(n, true);
        }
    }
    /// <summary>
    /// 获得Asset
    /// </summary>
    /// <param name="rootDir"></param>
    static void GetAllAssets(string rootDir)
    {
        assetInfoDict.Clear();
        
        DirectoryInfo dirinfo=new DirectoryInfo(rootDir);
        FileInfo[] fs=dirinfo.GetFiles(".",SearchOption.AllDirectories);
        int ind = 0;
        foreach (var n in fs)
        {
            curProgress = (float) ind / (float) fs.Length;

//            curRootAsset = "正在分析依赖" + n.Name;

            EditorUtility.DisplayProgressBar(curRootAsset, curRootAsset, curProgress);
            ind++;
            int index = n.FullName.IndexOf("Assets");
            if (index != -1)
            {
                string assetPath = n.FullName.Substring(index);
                UnityEngine.Object asset = AssetDatabase.LoadMainAssetAtPath(assetPath);
                string upath = AssetDatabase.GetAssetPath(asset);
                if (assetInfoDict.ContainsKey(assetPath) == false
                    && assetPath.StartsWith("Assets")
                    && !(asset is MonoScript)
                    && !(asset is LightingDataAsset)
                    && asset != null
                )
                {
                    ABInfo info = new ABInfo(upath, true);
                    //标记以下是文件夹根资源
                    CreateDeps(info);

                }
                EditorUtility.UnloadUnusedAssetsImmediate();
            }
            EditorUtility.UnloadUnusedAssetsImmediate();
        }
        EditorUtility.ClearProgressBar();

        int setIndex = 0;
        foreach (KeyValuePair<string,ABInfo> kv in assetInfoDict)
        {
            EditorUtility.DisplayProgressBar("正在设置ABName",kv.Key,(float)setIndex/(float)assetInfoDict.Count);
            setIndex++;
            ABInfo a = kv.Value;
            a.SetAssetBundleName(2);
        }
        EditorUtility.ClearProgressBar();
        EditorUtility.UnloadUnusedAssetsImmediate();
        AssetDatabase.SaveAssets();
    }

    /// <summary>
    /// 递归分析每个依赖所被依赖到的资源
    /// </summary>
    /// <param name="self"></param>
    /// <param name="parent"></param>
    static void CreateDeps(ABInfo self, ABInfo parent = null)
    {
        if (self.HasParent(parent))
        {
            return;
        }

        if (assetInfoDict.ContainsKey(self.assetPath) == false)
        {
            assetInfoDict.Add(self.assetPath,self);
        }
        self.AddParent(parent);

        UnityEngine.Object[] deps = EditorUtility.CollectDependencies(new UnityEngine.Object[] {self.GetAsset()});
        
        Debug.LogWarning(self.assetPath+"    "+deps.Length);
        
        

        for (int i = 0; i < deps.Length; i++)
        {
            UnityEngine.Object o = deps[i];
//            Debug.LogWarning(self.assetPath+"      "+deps[i].name);
            if(o is MonoScript || o is LightingDataAsset)
                continue;
            string path = AssetDatabase.GetAssetPath(o);
            if(path==self.assetPath)
                continue;
            if (path.StartsWith("Assets") == false)
            {
                continue;
            }

            ABInfo info = null;

            if (assetInfoDict.ContainsKey(path))
            {
                info = assetInfoDict[path];
            }
            else
            {
                info=new ABInfo(path);
                assetInfoDict.Add(path,info);
            }

            EditorUtility.DisplayProgressBar(curRootAsset, path, curProgress);
            CreateDeps(info,self);
        }
        EditorUtility.UnloadUnusedAssetsImmediate();
    }
    
    /// <summary>
    /// 获取选择到的文件夹
    /// </summary>
    /// <returns></returns>
    static string GetSelectedAssetPath()
    {
        var selected = Selection.activeObject;
        if (selected == null)
        {
            return null;
        }
        Debug.LogWarning(selected.GetType());
        if (selected is DefaultAsset)
        {
            string path = AssetDatabase.GetAssetPath(selected);
            Debug.LogWarning("选中路径"+path);
            return path;
        }
        else
        {
            return null;
        }
    }
}