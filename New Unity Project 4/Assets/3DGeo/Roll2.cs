using UnityEngine;
using System.Collections;

public class Roll2 : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		Vector3 roll = transform.localEulerAngles;
		roll.y += Time.deltaTime * 90.0f;
		transform.localEulerAngles = roll;
	}
}
