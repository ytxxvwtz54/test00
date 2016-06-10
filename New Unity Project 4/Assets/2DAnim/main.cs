using UnityEngine;
using System.Collections;

public class main : MonoBehaviour {

	public GameObject go01 = null;
	private Material material;

	// Use this for initialization
	void Start () {

	//	this.material = go01.GetComponent<Renderer>().material;
	//	Debug.Log (" " + (this.material != null));
	}
	
	// Update is called once per frame
	void Update () {
		/*
		// 経過時間に応じて値が変わるよう適当な値を入れる
		float r = Mathf.Sin(Time.time);
		float g = Mathf.Sin(Time.time) + Mathf.Cos(Time.time);
		float b = Mathf.Cos(Time.time);
		
		// Materialクラスの`Set****`メソッドを使ってシェーダに値を送信
		this.material.SetColor("_Color", new Color(r, g, b, 1.0f));
		this.material.SetFloat("_V0", r);
		*/
	}

}
