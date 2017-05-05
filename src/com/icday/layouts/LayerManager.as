package com.icday.layouts
{
	import flash.display.Stage;
	
	import morn.core.components.LayerBase;

	public class LayerManager
	{
		public var dialog:LayerBase;
		public var tip:LayerBase;
		public var log:LayerBase;
		public function LayerManager()
		{
		}
		
		public function init(stage:Stage):void
		{
			stage.addChild(dialog);
			stage.addChild(tip);
			stage.addChild(log);
		}
	}
}