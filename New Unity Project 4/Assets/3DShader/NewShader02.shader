Shader "Custom/NewShader02" {
	Properties {
		_Color ("Main Color", Color) = (1,0.5,0.5,1)
	}
	SubShader {
		Pass {
	        Material {
		        Diffuse [_Color]
	            Ambient (1,1,1,0)
	        }
			Lighting On
		}
	}
}
