package com.icday.net.interfaces
{
	import flash.utils.ByteArray;

	public interface ISocketData
	{
		function decode(bytes:ByteArray):ISocketData;
		function encode(data:ISocketData):ByteArray;
		function dispose():void;
	}
}