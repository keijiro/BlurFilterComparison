using UnityEngine;

[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
class Test : MonoBehaviour
{
    enum FilterType { None, Tent4Tap, Tent9Tap }

    [SerializeField] FilterType _filterType;
    [SerializeField] bool _motion;

    [SerializeField, HideInInspector] Shader _shader;

    Material _material;

    void OnDestroy()
    {
        if (_material != null)
            if (Application.isPlaying)
                Destroy(_material);
            else
                DestroyImmediate(_material);
    }

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (_material == null)
        {
            _material = new Material(_shader);
            _material.hideFlags = HideFlags.DontSave;
        }

        if (_motion)
            _material.EnableKeyword("_ENABLE_SCROLL");
        else
            _material.DisableKeyword("_ENABLE_SCROLL");

        var rt = RenderTexture.GetTemporary(source.width, source.height);

        Graphics.Blit(source, rt, _material, 0);
        Graphics.Blit(rt, destination, _material, 1 + (int)_filterType);

        RenderTexture.ReleaseTemporary(rt);
    }
}
