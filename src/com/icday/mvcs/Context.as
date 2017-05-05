package com.icday.mvcs
{
	import flash.events.EventDispatcher;

	public class Context extends EventDispatcher
	{
		public static const instance:Context = new Context();
		public function Context()
		{
			list = new Vector.<IModule>;
		}
		
		private var list:Vector.<IModule>;
		
		public function setup(module:IModule):void{
			list.push(module);
		}
		
		public function start():void{
			for each(var ele:IModule in list){
				ele.startup();
			}
		}
		
		public function dispatch(type:String,data:String = null):void{
			dispatchEvent(new DataEvent(type,data));
		}
	}
}