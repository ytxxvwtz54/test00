Shader "custom/GeoTest002" {
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

			[maxvertexcount(3)]
		   	void geom (triangle v2g input[3], inout TriangleStream<v2g> outStream)
		   	{
		     	v2g output0 = input[0];
		     	output0.vertex = mul(UNITY_MATRIX_MVP, output0.vertex);
		     	outStream.Append (output0);

		     	float xs = input[1].vertex.x - input[0].vertex.x;
		     	float ys = input[1].vertex.y - input[0].vertex.y;
		     	float zs = input[1].vertex.z - input[0].vertex.z;

		     	v2g output1 = input[1];
				output1.vertex.x = input[0].vertex.x + xs * 0.5;
				output1.vertex.y = input[0].vertex.y + ys * 0.5;
				output1.vertex.z = input[0].vertex.z + zs * 0.5;
		     	output1.vertex = mul(UNITY_MATRIX_MVP, output1.vertex);
		     	outStream.Append (output1);


		     	v2g output2 = input[2];
		     	output2.vertex = mul(UNITY_MATRIX_MVP, output2.vertex);
		     	outStream.Append (output2);

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