using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEditor.ShaderGraph;
using UnityEngine;

[ExecuteInEditMode]
public class ProcedureTextureGeneration : MonoBehaviour
{
    public Material material = null;

    #region  Material properties

    [SerializeField] private int m_textureWidth = 512;

    public int textureWidth
    {
        get { return m_textureWidth; }
        set
        {
            m_textureWidth = value;
            _UpdateMaterial();
        }
    }

    [SerializeField] private Color m_backgroundColor = Color.white;

    public Color MBackgroundColor
    {
        get => m_backgroundColor;
        set
        {
            m_backgroundColor = value;
            _UpdateMaterial();
        }
    }

    [SerializeField] private float m_blurFactor = 2.0f;

    public float MBlurFactor
    {
        get => m_blurFactor;
        set
        {
            m_blurFactor = value;
            _UpdateMaterial();
        }
    }

    [SerializeField] private Color m_circleColor = Color.yellow;

    public Color circleColor
    {
        get { return m_circleColor; }
        set
        {
            m_circleColor = value;
            _UpdateMaterial();
        }
    }

    #endregion

    private Texture2D m_generateTexture = null;

    private void Start()
    {
        if (material == null)
        {
            Renderer renderer = gameObject.GetComponent<Renderer>();
            if (renderer == null)
            {
                Debug.LogWarning(("baibai"));
            }

            material = renderer.sharedMaterial;
        }

        _UpdateMaterial();
    }


    private void Update()
    {
//        _UpdateMaterial();
    }

    private void _UpdateMaterial()
    {
        if (material != null)
        {
//            m_generateTexture = _GenerationNoiseTexture(256);
            material.SetTexture("_MainTex", m_generateTexture);
        }
    }

    /// <summary>
    /// 生成圆程序纹理
    /// </summary>
    /// <returns></returns>

    private Texture2D _GenerationTexture()
    {
        Texture2D procedureTexture = new Texture2D(textureWidth, textureWidth);
        ///定义圆与圆之间的间距
        float circleInterval = textureWidth / 4.0f;
        ///定义圆的半径
        float radius = textureWidth / 10.0f;
        ///定义模糊系数
        float edeBlur = 1.0f / m_blurFactor;

        for (int w = 0; w < textureWidth; w++)
        {
            for (int h = 0; h < textureWidth; h++)
            {
                ///使用背景颜色进行初始化
                Color pixel = m_backgroundColor;
                ///依次画9个圆
                for (int i = 0; i < 3; i++)
                {
                    for (int j = 0; j < 3; j++)
                    {
                        Vector2 circleCenter = new Vector2(circleInterval * (i + 1), circleInterval * (j + 1));
                        ///与圆心的距离
                        float dist = Vector2.Distance(new Vector2(w, h), circleCenter) - radius;
                        ///模糊圆的边界
                        Color color = _MixColor(circleColor, new Color(pixel.r, pixel.g, pixel.b, 0.0f)
                            , Mathf.SmoothStep(0f, 1f, dist * edeBlur));
                        pixel = _MixColor(pixel, color, color.a);
                    }
                }

                procedureTexture.SetPixel(w, h, pixel);
            }
        }

        procedureTexture.Apply();
        return procedureTexture;
    }

    /// <summary>
    /// 生成可平铺的噪声纹理
    /// </summary>
    /// <returns></returns>
    private static int index = 1;
    public static Texture2D _GenerationNoiseTexture(int textureWidth,Material mat,int fm)
    {
        Texture2D procedureTexture = new Texture2D(textureWidth, textureWidth);
        float f = 0f;
        Color pixel=Color.white;
        int seed = System.DateTime.Now.Millisecond;
        for (int w = 0; w < textureWidth; w++)
        {
            for (int h = 0; h < textureWidth; h++)
            {
                float noise = SimplexNoise.SeamlessNoise(  (float) w  /fm,
                     (float) h  / fm,
                    10.0f, 10.0f, (float)seed );
                pixel=new Color(noise,noise,noise,1.0f);
//                procedureTexture.SetPixel(w,h,pixel);
                procedureTexture.SetPixel(w,h,pixel);

            }
        }
        procedureTexture.Apply();
        SaveRenderTextureToPNG(procedureTexture, mat, Application.dataPath + "/NoiseTexture", "Noise"+index+".png");
//        Texture2DToPNG(procedureTexture, textureWidth, Application.dataPath + "/NoiseTexture", "Noise1.png");
        index++;
        return procedureTexture;
    }
    private Color _MixColor(Color color0, Color color1, float mixFactor) {
        Color mixColor = Color.white;
        mixColor.r = Mathf.Lerp(color0.r, color1.r, mixFactor);
        mixColor.g = Mathf.Lerp(color0.g, color1.g, mixFactor);
        mixColor.b = Mathf.Lerp(color0.b, color1.b, mixFactor);
        mixColor.a = Mathf.Lerp(color0.a, color1.a, mixFactor);
        return mixColor;
    }
    
    
    public static bool SaveRenderTextureToPNG(Texture2D inputTex,Material mat, string contents, string pngName)
    {
        RenderTexture temp = RenderTexture.GetTemporary(inputTex.width, inputTex.height, 0, RenderTextureFormat.ARGB32);
        Graphics.Blit(inputTex, temp, mat);
        bool ret = SaveRenderTextureToPNG(temp, contents,pngName);
        RenderTexture.ReleaseTemporary(temp);
        return ret;
    } 
 
    //将RenderTexture保存成一张png图片
    public static bool SaveRenderTextureToPNG(RenderTexture rt,string contents, string pngName)
    {
        RenderTexture prev = RenderTexture.active;
        RenderTexture.active = rt;
        
        Texture2D png = new Texture2D(rt.width, rt.height, TextureFormat.RGB24, false);
        png.ReadPixels(new Rect(0, 0, rt.width, rt.height), 0, 0);
        png.Apply();
        byte[] bytes = png.EncodeToPNG();
        if (!Directory.Exists(contents))
            Directory.CreateDirectory(contents);
        FileStream file = File.Open(contents + "/" + pngName + ".png", FileMode.Create);

        BinaryWriter writer = new BinaryWriter(file);
        
        file.Write(bytes,0, bytes.Length);
//        writer.Write(bytes);
        file.Close();
        Texture2D.DestroyImmediate(png);
        png = null;
        RenderTexture.active = prev;
        return true;
 
    }

//    public static void Texture2DToPNG(Texture2D input,int width,string path, string name)
//    {
//        Texture2D png = new Texture2D(width, width, TextureFormat.ARGB32, false);
//        png.ReadPixels(new Rect(0, 0, input.width,input.width), 0, 0);
//        byte[] bytes = png.EncodeToPNG();
//        if (!Directory.Exists(path))
//            Directory.CreateDirectory(path);
//        FileStream file = File.Open(path + "/" + name + ".png", FileMode.Create);
//        Debug.LogWarning(file.Name+"1111");
//        BinaryWriter writer = new BinaryWriter(file);
//        writer.Write(bytes);
//        file.Close();
//        Texture2D.DestroyImmediate(png);
//        png = null;
//    }
}

