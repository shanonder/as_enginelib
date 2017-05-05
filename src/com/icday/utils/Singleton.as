package com.icday.utils
{
	

	public class Singleton
	{
		private static const _singletonMap:Object = new Object;
		public function Singleton()
		{
		}
		
		public static function getInstance(clazz:Class,asName:String = null):*{
			var key:String = asName;
			key ||= String(clazz);
			return _singletonMap[key] ||= new clazz;
		}
		
		public static function hasInstance(key:*):Boolean{
			key = String(key);
			return _singletonMap[key] != null;
		}
		
		public static function removeInstance(key:*):void{
			key = String(key);
			delete(_singletonMap[key]);
		}
	}
}