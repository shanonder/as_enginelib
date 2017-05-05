package com.icday.layouts
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;

	public class LayoutBase
	{
		protected var sourceArr:Array;
		protected var layoutRect:Rectangle;
		protected var container:DisplayObjectContainer;
		public function LayoutBase(container:DisplayObjectContainer)
		{
			sourceArr = [];
			layoutRect = new Rectangle();
			this.container = container;
		}
		
		public function layout():void
		{
			
		}
		
		public function setSize(w:Number, h:Number,x:Number = 0 , y:Number = 0):void
		{
			layoutRect.width = w;
			layoutRect.height = h;
			layoutRect.x = x;
			layoutRect.y = y;
			App.timer.doFrameOnce(1,layout);
		}
		
		public function addElement(display:DisplayObject,params:Object):void{
			var index:int = sourceArr.indexOf(display);
			if(index >-1){
				sourceArr.splice(index , 2);
			}
			sourceArr.push(display,params);
		}
		
		public function removeElement(display:DisplayObject):void{
			
		}
	}
}