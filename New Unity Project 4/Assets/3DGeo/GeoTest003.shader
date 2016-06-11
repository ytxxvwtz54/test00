Shader "custom/GeoTest003" {
	Properties
	{
		_MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
	}

	SubShader
	{
        Tags { "RenderType"="Opaque" }

		Cull Off
		Lighting Off
		ZWrite  On
		Fog { Mode Off }
		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma geometry geom
			#pragma fragment frag
			#include "UnityCG.cginc"
			
			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
			};

	        struct v2g {
	            float4 vertex : SV_POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
			};
	        struct g2f {
	            float4 vertex : SV_POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
			};
			
			fixed4 _Color;

			v2g vert(appdata_t IN)
			{
				v2g OUT;
				//OUT.vertex = mul(UNITY_MATRIX_MVP, IN.vertex);
				OUT.vertex = IN.vertex;
				OUT.texcoord = IN.texcoord;
				OUT.color = IN.color * _Color;
				return OUT;
			}

			[maxvertexcount(6)]
		   	void geom (triangle v2g input[3], inout TriangleStream<v2g> outStream)
		   	{
		   		v2g output;
		   		for (int i = 0 ; i < 3 ; i++) {
			     	output = input[i];
			     	output.vertex = mul(UNITY_MATRIX_MVP, output.vertex);
			     	output.color.a *= 0.2;
			     	outStream.Append (output);
		   		}
		      	outStream.RestartStrip();
		   		for (int i = 0 ; i < 3 ; i++) {
			     	output = input[i];
			     	output.vertex.x += 1.5;
			     	output.vertex = mul(UNITY_MATRIX_MVP, output.vertex);
			     	//output.color.a *= 0.2;
			     	outStream.Append (output);
		   		}

		      	outStream.RestartStrip();
		   	}

			sampler2D _MainTex;

			fixed4 frag(v2g IN) : COLOR
			{
				half4 tex = tex2D(_MainTex, IN.texcoord) * IN.color;
				return tex;
				//return float4(1, 1, 0, 1.0); 
			}
			ENDCG
		}
	}

        //FallBack "Diffuse"
}