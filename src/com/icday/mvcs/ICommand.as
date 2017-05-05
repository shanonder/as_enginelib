package com.icday.mvcs
{
	import flash.utils.ByteArray;

	public interface ICommand
	{
		function excute(cmd:int, status:int ,data:ByteArray):void;
	}
}