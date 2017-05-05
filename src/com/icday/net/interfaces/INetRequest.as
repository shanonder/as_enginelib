package com.icday.net.interfaces
{
	import flash.utils.ByteArray;

	public interface INetRequest
	{
		function get cmd():int;
		function encode():ByteArray;
		function dispose():void;
	}
}