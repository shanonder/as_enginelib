package com.icday.pathing
{
	/**
	 * 
	 * @author shanonder
	 * 
	 */
	public class ALink
	{
		public var node:ANode;
		public var cost:Number;
		public function ALink(node:ANode,cost:Number) 
		{
			this.node = node;
			this.cost = cost;
		}
		
	}

}