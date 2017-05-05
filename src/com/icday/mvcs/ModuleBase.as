package com.icday.mvcs
{
	import lib.Lib;

	public class ModuleBase implements IModule
	{
		public function ModuleBase()
		{
		}
		
		public function startup():void
		{
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
		
		final protected function addCommand(cmd:int , clazz:Class):void{
			Lib.net.registCmd(cmd,clazz);
		}
	}
}