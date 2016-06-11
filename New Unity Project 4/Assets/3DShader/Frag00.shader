Shader "Custom/Frag00" {
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
		[Toggle] PixelSnap2 ("Pixel snap2", Float) = 0
		[Enum(One,1,SrcAlpha,5)] _Blend2 ("Blend mode subset", Float) = 1
		[Header(A group of things)] _Prop1 ("Prop1", Float) = 0
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
			#pragma fragment frag
			#pragma multi_compile DUMMY PIXELSNAP_ON
			#include "UnityCG.cginc"
			
			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color    : COLOR;
				half2 texcoord  : TEXCOORD0;
				//fixed4 vertex_local   : COLOR;
				float4 vertexl    : POSITION1;
			};
			
			fixed4 _Color;

			v2f vert(appdata_t IN)
			{
				v2f OUT;
				OUT.vertex = mul(UNITY_MATRIX_MVP, IN.vertex);
				OUT.texcoord = IN.texcoord;
				OUT.color = IN.color * _Color;
				OUT.vertexl = IN.vertex;
				return OUT;
			}

			sampler2D _MainTex;

			fixed4 frag(v2f IN) : COLOR
			{
				half4 tex = tex2D(_MainTex, IN.texcoord) * IN.color;
				tex.r = IN.vertexl.y;
				tex.g = 0;
				tex.b = 0;
				return tex;
			}
		ENDCG
		}
	}
}