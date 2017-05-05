package com.icday.structs
{
	import flash.utils.Dictionary;

	public class NodeList
	{
		private var lists:Dictionary;
		public function NodeList()
		{
			lists = new Dictionary();
			nodeArr = [];
		}
		
		public var nodeArr:Array;
		
		public function push(ele:*,node:*):void{
			if(nodeArr.indexOf(node)<0){
				nodeArr.push(ele);
			}
			lists[node] ||= [];
			(lists[node] as Array).push(ele);
		}
	}
}