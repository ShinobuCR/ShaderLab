using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;

public class CreateAssetBundle : MonoBehaviour
{
    [MenuItem("AssetsBundle/Build AssetBundles")]
    
    static void BuildAllAssetBundles()
    {
        string dir = "AssetBundles";
        if (Directory.Exists(dir)==false)
        {
            Directory.CreateDirectory(dir);
        }
        /// 参数1 打包到哪个路径，  参数2，压缩方式，  参数3  平台的目标
        /// BuildAssetBundleOptions.None  为LZMA算法压缩
        BuildPipeline.BuildAssetBundles(dir, BuildAssetBundleOptions.None, BuildTarget.iOS);
    }
}
