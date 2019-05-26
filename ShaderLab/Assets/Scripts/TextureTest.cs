using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

public class TextureTest : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        OnUserSave();
//        Material mat=new Material(Shader.Find("Transparent/Diffuse"));
//        mat.color = Color.white;
//        StartCoroutine(_GenerationNoiseTexture(512,mat));
    }

    // Update is called once per frame
    public IEnumerator _GenerationNoiseTexture(int textureWidth,Material mat)
    {
        Texture2D procedureTexture = new Texture2D(textureWidth, textureWidth);
        float f = 0f;
        Color pixel=Color.white;
        int seed = System.DateTime.Now.Millisecond;
        for (int w = 0; w < textureWidth; w++)
        {
            for (int h = 0; h < textureWidth; h++)
            {
                float noise = SimplexNoise.SeamlessNoise(  (float) w  / textureWidth,
                    (float) h  / textureWidth,
                    10.0f, 10.0f, (float)seed );
                pixel=new Color(noise,noise,noise,1.0f);
//                procedureTexture.SetPixel(w,h,pixel);
                procedureTexture.SetPixel(w,h,pixel);

            }
        }
        procedureTexture.Apply();
        yield return new WaitForSeconds(5f);
//        Texture2DToPNG(procedureTexture, textureWidth, Application.dataPath + "/NoiseTexture", "Noise1.png");
    }
    
    public RenderTexture target;

    int index = 0;

    public void OnUserSave()
    {
        var prePath = Application.dataPath.Substring(0, Application.dataPath.LastIndexOf("/"));
        string path = prePath + string.Format("/NoiseTex/EFX{0}.png",index);
        Save(path, CreateFrom(target));
        index++;
    }

    public void Save(string path, Texture2D texture2D)
    {
        Debug.Log("Save Path:" + path);
        var bytes = texture2D.EncodeToPNG();
        //var bytes = texture2D.EncodeToJPG();
        System.IO.File.WriteAllBytes(path, bytes);
    }

    public Texture2D CreateFrom(RenderTexture renderTexture)
    {
        Texture2D texture2D = new Texture2D(renderTexture.width, renderTexture.height, TextureFormat.ARGB32, false);
        var previous = RenderTexture.active;
        RenderTexture.active = renderTexture;

        texture2D.ReadPixels(new Rect(0, 0, renderTexture.width, renderTexture.height), 0, 0);

        RenderTexture.active = previous;

        texture2D.Apply();

        return texture2D;
    }
}
