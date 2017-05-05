package com.icday.net.socket
{
	import morn.core.handlers.Handler;

	public class ConnectHandler extends Handler
	{
		public function ConnectHandler()
		{
			super(onConnect);
		}
		
		protected function onConnect(host:String,port:int):void{
			
		}
	}
}