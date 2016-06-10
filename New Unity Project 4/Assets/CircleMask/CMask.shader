Shader "PostEffects/CMask"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_NoiseX("NoiseX", Range(0, 1)) = 0
		_Offset("Offset", Vector) = (0, 0, 0, 0)
		_RGBNoise("RGBNoise", Range(0, 1)) = 0
	}
	SubShader
	{
		Tags {"Queue"="Transparent"} // "IgnoreProjector"="True" "RenderType"="Transparent"}
		// No culling or depth
		Cull Off ZWrite Off ZTest Always
		Blend  OneMinusSrcAlpha SrcAlpha

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;
				return o;
			}

			sampler2D _MainTex;
			sampler2D _ABuffer;
			float _NoiseX;
			float2 _Offset;
			float _RGBNoise;

			// SV_Target  = COLOR
			fixed4 frag (v2f i) : SV_Target
			{
				float3 col = tex2D(_MainTex, i.uv);
				//float3 ab = tex2D(_ABuffer,i. uv);
				float xsub = i.uv.x - 0.5;
				float ysub = i.uv.y - 0.5;
				float len = sqrt(xsub * xsub + ysub * ysub);
				float alpha = 0.9;
				if (len > 0.1) {
					alpha = 0.3; //col = (col.r, col.g, col.b); //col *= 0.9; //(0.5,0.5,0.5); //ab * 0.5 + col * 0.3;
				}
				return float4(col * 0.3, alpha);
			}
			ENDCG
		}
	}
}
