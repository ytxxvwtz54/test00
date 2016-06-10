using UnityEngine;
using System.Collections;

[ExecuteInEditMode()]
public class CMask : MonoBehaviour {
	
	[SerializeField]
	Material material;
	
	[SerializeField]
	[Range(0, 1)]
	float noiseX;
	public float NoiseX { get { return noiseX; } set { noiseX = value; } }
	
	[SerializeField]
	[Range(0, 1)]
	float rgbNoise;
	public float RGBNoise { get { return rgbNoise; } set { rgbNoise = value; } }

	//private RenderTexture RT0;

	void Awake()
	{
		//RT0 = new RenderTexture(Screen.width, Screen.height, 24, RenderTextureFormat.ARGBHalf);
		//var camera0 = gameObject.GetComponent<Camera>();
		//RT0 = camera0.targetTexture;
	}

	// Use this for initialization
	void OnRenderImage(RenderTexture src, RenderTexture dest) {
		material.SetFloat("_NoiseX", noiseX);
		material.SetFloat("_RGBNoise", rgbNoise);
		//Shader.SetGlobalTexture("_ABuffer", RT0);
		Graphics.Blit(src, dest, material);
	}
}
