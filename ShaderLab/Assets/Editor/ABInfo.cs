using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEditor;
using UnityEditor.Build.Content;
using UnityEngine;
using Object = System.Object;

public class ABInfo
{
    //是不是打包文件夹下的直接资源
    private bool isRootAsset = false;

    public string assetPath { get; private set; }
    
    private HashSet<ABInfo> childSet=new HashSet<ABInfo>();
    
    private HashSet<ABInfo> parentSet=new HashSet<ABInfo>();

    public ABInfo(string assetPath, bool isRootAsset = false)
    {
        this.assetPath = assetPath;
        
    }

    public UnityEngine.Object GetAsset()
    {
        UnityEngine.Object asset = AssetDatabase.LoadMainAssetAtPath(assetPath);
        return asset;
    }
    /// <summary>
    /// 开始分析构建资源依赖树
    /// </summary>
    /// <param name="parent"></param>

    public void AddParent(ABInfo parent)
    {
        if (parent == this || parent == null)
        {
            return;
        }
        parentSet.Add(parent);
        parent.AddChild(this);
        parent.RemoveRepeatChildDep(this);
        RemoveReapetParentDep(parent);
    }

    /// <summary>
    /// 清除我父节点对子节点的重复引用，保证树形结构
    /// </summary>
    /// <param name="targetChild"></param>
    private void RemoveRepeatChildDep(ABInfo targetChild)
    {
        List<ABInfo> infolist=new List<ABInfo>(parentSet);
        for (int i = 0; i < infolist.Count; i++)
        {
            ABInfo pinfo = infolist[i];
            
        }
    }

    private void RemoveReapetParentDep(ABInfo targetChild)
    {
        childSet.Remove(targetChild);
        targetChild.parentSet.Remove(this);
    }

    private void RemoveParent(ABInfo parent)
    {
        parent.childSet.Remove(this);
        parentSet.Remove(parent);
    }

    private void AddChild(ABInfo child)
    {
        childSet.Add(child);
    }

    /// <summary>
    /// 如果父节点已经是这个节点的父节点
    /// </summary>
    /// <param name="targetParent"></param>
    /// <returns></returns>
    private bool IsParentEarlyDep(ABInfo targetParent)
    {
        if (parentSet.Contains(targetParent))
        {
            return true;
        }

        var e = parentSet.GetEnumerator();
        while (e.MoveNext())
        {
            if (e.Current.IsParentEarlyDep(targetParent))
                return true;
        }
        return false;
    }

    public bool HasParent(ABInfo p)
    {
        if (parentSet.Contains(p))
            return true;
        return false;
    }

    /// <summary>
    /// 打包碎片粒度
    /// </summary>
    /// <param name="pieceThreshold"></param>
    public void SetAssetBundleName(int pieceThreshold)
    {
        AssetImporter ai=AssetImporter.GetAtPath(assetPath);
        //针对UGUI图集的处理
        if (ai is TextureImporter)
        {
            TextureImporter tai = ai as TextureImporter;
            if (!string.IsNullOrEmpty(tai.spritePackingTag))
            {
                tai.SetAssetBundleNameAndVariant(tai.spritePackingTag+".ab",null);
                
            }
        }
        else
        {
            string abname = this.assetPath.Replace("/", ".")+".ab";
            //不是图集，而且大于阀值
            if (this.parentSet.Count >= pieceThreshold)
            {
                ai.SetAssetBundleNameAndVariant(abname,string.Empty);
            }
            else if (this.parentSet.Count == 0)
            {
                ai.SetAssetBundleNameAndVariant(abname,string.Empty);
                
            }
            else if(this.isRootAsset)
            {
                ai.SetAssetBundleNameAndVariant(abname, string.Empty);
            }
            else
            {
                ai.SetAssetBundleNameAndVariant(abname,string.Empty);
            }
        }
        Debug.LogWarning(ai.name);
    }
    
}
