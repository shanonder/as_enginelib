package morn.core.plugins
{
	public class RichTextFieldBuilder
	{
		public function RichTextFieldBuilder()
		{
		}
		private static var map:Object = {};
		public static function registCell(type:String,clazz:Class):void{
			map[type] = clazz;
		}
		
		public static function getClass(type:String):Class{
			return map[type];
		}
	}
}