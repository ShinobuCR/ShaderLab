using UnityEngine;

public class LightMap : MonoBehaviour
{

    //烘培烘培贴图1
    public Texture2D greenLightMap;

    void OnGUI()
    {
        if (GUILayout.Button("green"))
        {
            LightmapData data = new LightmapData();
            data.lightmapColor = greenLightMap;
            LightmapSettings.lightmaps = new LightmapData[1] {data};
        }
    }
}