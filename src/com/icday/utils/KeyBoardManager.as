package com.icday.utils
{
	import com.icday.structs.HashMapList;
	import com.icday.structs.HashMapListNode;
	import com.icday.utils.Singleton;
	
	import flash.display.Stage;
	import flash.events.KeyboardEvent;

	public class KeyBoardManager
	{
		public static function get instance():KeyBoardManager{
			return Singleton.getInstance(KeyBoardManager);
		}
		
		private var closureMap:HashMapList;
		public function KeyBoardManager()
		{
			closureMap = new HashMapList();
		}
		
		
		public function addDownListener(closure:Function, keyCode:int,ctrlKey:Boolean = false, altKey:Boolean = false,key:* = null):void
		{
			key ||= closure;
			closureMap.addNode([closure,keyCode,ctrlKey,altKey],key);
		}
		
		public function removeDownListener(key:* ):void{
			closureMap.removeNode(key);
		}
		
		public function startup(stage:Stage):void{
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			var node:HashMapListNode = closureMap.firstNode;
			while(node){
				var i:int = 0 ;
				var params:Array = node.data;
				var closure:Function = params[i++];
				var keyCode:uint = params[i++];
				var ctrlKey:uint = params[i++];
				var altKey:uint = params[i++];
				if(event.keyCode == keyCode && event.ctrlKey == ctrlKey && event.altKey == altKey){
					closure(event);
				}
				node = node.next as HashMapListNode;
			}
		}
	}
}