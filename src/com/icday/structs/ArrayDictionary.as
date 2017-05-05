package com.icday.structs
{
	import flash.utils.Dictionary;

	public class ArrayDictionary
	{
		private var map:Dictionary;
		private var arr:Array;
		public function ArrayDictionary()
		{
			map = new Dictionary();
			arr = [];
		}
		
		public function addElememt(ele:*,key:*):void{
			if(!ele || !key){
				return;
			}
			if(map.hasOwnProperty(key)){
				var oe:* = map[key];
				if(oe){
					if(ele === ele){
						var index:int = arr.indexOf(key);
						arr.splice(index,1);
					}
				}
			}else{
				map[key] = ele;
			}
			arr.push(key);			
		}
		
		public function removeElement(key:*):void{
			if(map.hasOwnProperty(key)){
				var v:* = map[key];
				var index:int = arr.indexOf(key);
				if(index>-1){
					arr.splice(index,1);
				}
			}
		}
		
		public function removeByIndex(index:int):void{
			var ele:* = arr[index];
			
		}
		
		public function get length():int{
			return arr.length;
		}
		
		public function getEleByKey(key:*):*{
			if(map.hasOwnProperty(key)){
				return map[key];
			}
			return null;
		}
		
		public function getEleByIndex(index:int):*{
			return map[arr[index]];
		}
	}
}