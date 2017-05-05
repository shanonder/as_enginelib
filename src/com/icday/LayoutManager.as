package com.icday
{
	import com.icday.utils.Singleton;
	
	import morn.core.components.Component;

	public class LayoutManager
	{
		public static function get instance():LayoutManager{
			return Singleton.getInstance(LayoutManager);
		}
		public function LayoutManager()
		{
		}
		public function onAdd(view:Component,id:int):void{
			
		}
		
		public function onRemove(view:Component,id:int):void{
			
		}
	}
}