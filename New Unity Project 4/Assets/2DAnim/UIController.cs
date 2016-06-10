using UnityEngine;
using System.Collections;

public class UIController : MonoBehaviour
{
	[SerializeField]
	Animator animator;
	
	void Update ()
	{
		if( Input.GetKeyDown(KeyCode.UpArrow))
			animator.SetBool("IsCenter", true);
		if( Input.GetKeyDown(KeyCode.DownArrow))
			animator.SetBool("IsCenter", false);
	}

	public void Test000 ()
	{
	}
}
