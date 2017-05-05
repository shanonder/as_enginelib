package com.icday.layouts
{
	public interface ILayout
	{
		function layout():void;
		function setSize(w:Number,h:Number,x:Number = 0 , y:Number = 0):void;
	}
}