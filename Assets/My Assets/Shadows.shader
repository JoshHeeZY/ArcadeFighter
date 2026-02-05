Shader "Custom/Transparent Shadow Receiver"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Cutoff ("Alpha Cutoff", Range(0,1)) = 0.5
    }

    SubShader
    {
        Tags { "Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout" }
        LOD 200

        ZWrite Off
        Blend Zero SrcColor

        CGPROGRAM
        #pragma surface surf ShadowOnly alphatest:_Cutoff

        sampler2D _MainTex;
        fixed4 _Color;

        struct Input
        {
            float2 uv_MainTex;
        };

        inline fixed4 LightingShadowOnly (SurfaceOutput s, fixed3 lightDir, fixed atten)
        {
            fixed4 c;
            c.rgb = s.Albedo * atten;
            c.a = s.Alpha;
            return c;
        }

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = 1;
            o.Alpha = tex.a;
        }
        ENDCG
    }

    Fallback "Transparent/Cutout/VertexLit"
}
