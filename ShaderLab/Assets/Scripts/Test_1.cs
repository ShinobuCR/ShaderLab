using UnityEngine;

public class Test_1:MonoBehaviour
{
    public  Rect mRectValue;
    [HideInInspector] [SerializeField] private Rect pRectValue;
    public Rect MRectValue
    {
        get => mRectValue;
        set => mRectValue = value;
        
}

    [HideInInspector] [SerializeField] private Texture pTexture;
    public Texture myTexture;

    public Texture MyTexture
    {
        get => myTexture;
        set => myTexture = value;
    }
}