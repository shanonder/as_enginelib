package com.icday.mvcs
{
	import flash.events.EventDispatcher;
	
	import lib.Lib;
	
	
	public class ModelBase extends EventDispatcher
	{
		public function ModelBase()
		{
			init();
		}
		
		protected function init():void{
			
		}
		
		public function dispatch(cmd:String,data = null):void{
			dispatchEvent(new DataEvent(cmd,data));
		}
		
		
		/**
		 * 
		 * @param cmd
		 * @param closure function(cmd:int,status:int,bytes:ByteArray):void
		 * 
		 */
		final protected function addClosure(cmd:int, closure: Function):void{
			Lib.net.registClosure(cmd, closure);
		}
	}
}