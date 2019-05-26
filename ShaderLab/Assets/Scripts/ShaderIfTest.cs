using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShaderIfTest : MonoBehaviour
{
    void Start()
    {
        GameObject window = Resources.Load<GameObject>("wood");
//        for (int i = 0; i < 5000; i++)
//        {
//            GameObject windowins=Instantiate(window);
//            windowins.transform.position=new Vector3(1,i,0);
//            windowins.GetComponent<Renderer>().material.EnableKeyword("GRAY");
//        }
//
//        for (int i = 0; i < 5000; i++)
//        {
//            GameObject windowins=Instantiate(window);
//            windowins.transform.position=new Vector3(i,i,0);
//            windowins.GetComponent<Renderer>().material.EnableKeyword("NO_GRAY");
//        }
        for (int i = 0; i < 1000; i++)
        {
            GameObject windowins=Instantiate(window);
            windowins.transform.position=new Vector3(1,i,0);
            windowins.GetComponent<Renderer>().material.SetInt("_isGray",1);
        }

        for (int i = 0; i < 10000; i++)
        {
            GameObject windowins=Instantiate(window);
            windowins.transform.position=new Vector3(i,i,0);
            windowins.GetComponent<Renderer>().material.SetInt("_isGray",0);

        }
    }


}
