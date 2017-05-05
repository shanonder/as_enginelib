package com.icday.pathing
{
	/**
	 * 
	 * @author shanonder
	 * 
	 */
	public class ANode
	{
		public var x:int;
		public var y:int;
		public var f:Number;
		public var g:Number;
		public var h:Number;
		public var walkable:Boolean = true;
		public var parent:ANode;
		public var costMultiplier:Number = 1.0;
		public var vision:int = 1;
		public var links:Array;
		public var index:int;
		public function ANode(x:int, y:int)
		{
			this.x = x;
			this.y = y;
		}
	}
}