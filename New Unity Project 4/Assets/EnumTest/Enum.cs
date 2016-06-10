using UnityEngine;
using System;
using System.Collections;

public class Enum : MonoBehaviour {
	/*
	public static T ToObject00<T>(object value)
		where T : struct , IComparable, IFormattable, IConvertible
	{
		return (T)Enum.ToObject(typeof(T), value);
	}
	*/
	enum A00
	{
		E0, E1, E2
	}

	// Use this for initialization
	void Start () {
		int n = 0;
		//A00 a00 = ToObject00<A00>(n);
		//A00 a01 = (A00)Enum.ToObject(typeof(A00), n);
		//A00 dow = (A00)Enum.Parse(typeof(A00), "aaa");
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
