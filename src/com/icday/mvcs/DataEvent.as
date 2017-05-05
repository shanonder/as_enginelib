package com.icday.mvcs
{
	import flash.events.Event;
	
	public class DataEvent extends Event
	{
		public var data:*;
		public function DataEvent(type:String,data:* = null)
		{
			super(type);
			this.data = data;
		}
		
		override public function clone():Event
		{
			return new DataEvent(type,data);
		}
		
		
	}
}