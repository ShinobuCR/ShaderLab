using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


public class SetGray : MonoBehaviour
{
    private int _stats=1;
    public void Gray()
    {
        Vector3Int b=new Vector3Int(1,1,1);
        if (_stats == 1)
        {
            Debug.LogWarning("变灰");
            //if分支的做法
            this.GetComponent<Renderer>().material.SetInt("_isGray",1);
            
            //多变体的做法
//            this.GetComponent<Renderer>().material.EnableKeyword("GRAY");
//            this.GetComponent<Renderer>().material.DisableKeyword("NO_GRAY");
            

            _stats = 0;
        }
        else
        {
            Debug.LogWarning("恢复");
            this.GetComponent<Renderer>().material.SetInt("_isGray",0);
//            this.GetComponent<Renderer>().material.DisableKeyword("GRAY");
//            this.GetComponent<Renderer>().material.EnableKeyword("NO_GRAY");
            _stats = 1;
        }

    }
}
