package com.icday.shan3d
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Vector3D;
	
	public class Object3D extends EventDispatcher
	{
		private var _x:Number;
		private var _y:Number;
		private var _z:Number;
		private var _rotate:Vector3D;
		public function Object3D(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function addChild(child:Object3D):Object3D{
			return child;
		}
		
		public function get x():Number{
			return _x;
		}
		public function get y():Number{
			return _y;
		}
		public function get z():Number{
			return _z;
		}
		
		public function set x(value:Number):void{
			_x = value;
			updateMatrix();
		}
		public function set y(value:Number):void{
			_y = value;
			updateMatrix();
		}
		public function set z(value:Number):void{
			_z = value;
			updateMatrix();
		}
		
		public function get rotate():Vector3D{
			return _rotate;
		}
		
		public function updateMatrix():void{
			
		}
	}
}