// http://gamedev.stackexchange.com/questions/97009/geometry-shader-not-generating-geometry-for-some-vertices
Shader "Custom/Sprite-Default" {
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
	}

	SubShader
	{
		Tags
		{ 
			"Queue"="Transparent" 
			"IgnoreProjector"="True" 
			"RenderType"="Transparent" 
			"PreviewType"="Plane"
			"CanUseSpriteAtlas"="True"
		}

		Cull Off
		Lighting Off
		ZWrite  On
		Fog { Mode Off }
		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
		CGPROGRAM
			#pragma vertex vert
			//#pragma geometry geom
			#pragma fragment frag
			#pragma multi_compile DUMMY PIXELSNAP_ON
			#include "UnityCG.cginc"
			
			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
			};

	        struct v2f {
	            float4 vertex : SV_POSITION;
	            float4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};
	        struct g2f {
	            float4 vertex : SV_POSITION;
	            float4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};
			
			fixed4 _Color;

			v2f vert(appdata_t IN)
			{
				v2f OUT;
				OUT.vertex = mul(UNITY_MATRIX_MVP, IN.vertex);
				OUT.texcoord = IN.texcoord;
				OUT.color = IN.color * _Color;
				return OUT;
			}
/*
			[maxvertexcount(1)]
		   	void geom (point v2f input[1], inout TriangleStream<g2f> outStream)
		   	{
		     	g2f output;

		     	output.vertex = input[0].vertex;
		     	output.color = input[0].color;
		     	output.texcoord = input[0].texcoord;
		     	outStream.Append (output);
		      	outStream.RestartStrip();

		   	}
*/
			sampler2D _MainTex;

			fixed4 frag(g2f IN) : COLOR
			{
				half4 tex = tex2D(_MainTex, IN.texcoord) * IN.color;
				return tex;
			}
		ENDCG
		}
	}
}