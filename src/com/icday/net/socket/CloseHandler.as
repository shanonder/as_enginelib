package com.icday.net.socket
{
	import morn.core.handlers.Handler;
	
	public class CloseHandler extends Handler
	{
		public function CloseHandler()
		{
			super(onClose);
		}
		
		protected function onClose(host:String, port:int):void{
			
		}
	}
}