package com.icday.shan3d
{
	import com.adobe.utils.PerspectiveMatrix3D;

	public class Camera3D
	{
		private var perspective:PerspectiveMatrix3D;
		
		private var len:Number;
		public function Camera3D()
		{
			perspective = new PerspectiveMatrix3D();
		}
		
		
	}
}