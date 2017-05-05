package com.icday.net.socket
{
	import morn.core.handlers.Handler;
	
	public class ErrorHandler extends Handler
	{
		public function ErrorHandler()
		{
			super(errorHandler);
		}
		
		protected function errorHandler(type:String,errId:int,text:String):void{
			trace(type,errId,text);
		}
	}
}