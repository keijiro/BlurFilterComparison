#include "UnityCG.cginc"

sampler2D _MainTex;
float4 _MainTex_TexelSize;

#if defined(TENT_TAP4)

half4 frag(v2f_img i) : SV_Target
{
    float4 duv = _MainTex_TexelSize.xyxy * float4(0.5, 0.5, -0.5, 0);

    float3 acc;
    acc  = tex2D(_MainTex, i.uv - duv.xy).rgb;
    acc += tex2D(_MainTex, i.uv - duv.zy).rgb;
    acc += tex2D(_MainTex, i.uv + duv.zy).rgb;
    acc += tex2D(_MainTex, i.uv + duv.xy).rgb;

    acc /= 4;
    return half4(acc, 1);
}

#elif defined(TENT_TAP9)

half4 frag(v2f_img i) : SV_Target
{
    float4 duv = _MainTex_TexelSize.xyxy * float4(1, 1, -1, 0);

    float3 acc;
    acc  = tex2D(_MainTex, i.uv - duv.xy).rgb;
    acc += tex2D(_MainTex, i.uv - duv.wy).rgb * 2;
    acc += tex2D(_MainTex, i.uv - duv.zy).rgb;
    acc += tex2D(_MainTex, i.uv + duv.zw).rgb * 2;
    acc += tex2D(_MainTex, i.uv + duv.ww).rgb * 4;
    acc += tex2D(_MainTex, i.uv + duv.xw).rgb * 2;
    acc += tex2D(_MainTex, i.uv + duv.zy).rgb;
    acc += tex2D(_MainTex, i.uv + duv.wy).rgb * 2;
    acc += tex2D(_MainTex, i.uv + duv.xy).rgb;

    acc /= 16;
    return half4(acc, 1);
}

#else

half4 frag(v2f_img i) : SV_Target
{
    return tex2D(_MainTex, i.uv);
}

#endif
