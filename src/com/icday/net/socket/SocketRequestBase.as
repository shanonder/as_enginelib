package com.icday.net.socket
{
	import com.icday.net.interfaces.INetRequest;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class SocketRequestBase implements INetRequest
	{
		protected var bytes:ByteArray;
		protected var _cmd:int;
		public function SocketRequestBase(cmd:int)
		{
			this._cmd = cmd;
			bytes = new ByteArray();
			bytes.endian = Endian.BIG_ENDIAN;
			
		}
		
		public function get cmd():int
		{
			return _cmd;
		}
		
		
		public function encode():ByteArray
		{
			return bytes;
		}
		
		public function dispose():void
		{
			if(bytes){
				bytes.clear();
				bytes = null;
			}
		}
	}
}