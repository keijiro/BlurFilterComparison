#include "UnityCG.cginc"

sampler2D _MainTex;
float4 _MainTex_TexelSize;

half4 frag(v2f_img i) : SV_Target
{
    const float epsilon = 0.001;

#if defined(_ENABLE_SCROLL)
    float t = _Time.x;
#else
    float t = 0;
#endif

    float2 p1 = floor((i.uv.xy + float2(t,  0.0))* _MainTex_TexelSize.zw + epsilon);
    float2 p2 = floor((i.uv.yx + float2(t, -0.5))* _MainTex_TexelSize.wz + epsilon);

    float2 pc = i.uv.x < 0.5 ? p1 : p2;

    float w = floor(pc.y * 10 / _MainTex_TexelSize.w + 2);
    float c = step(0.5 - epsilon, frac(pc.x / w));

    return c;
}
