package com.icday
{
	import flash.utils.Dictionary;

	public class CsvParser
	{
		public function CsvParser()
		{
		}
		public static const CSV_Data:int = 6;
//		public static const CSV_LIST:int = 7;
		public static const CSV_PROPS:int = 7;
		
		private static var classMap:Dictionary = new Dictionary();
		public static function registClass(url:String, tb:Class):void{
			classMap[url] = tb;
		}
		
		public static function ParserData(url:String, data:Object):Object{
			var dic:Object = new Object();
			dic.map = {};
			dic.list = [];
			var clazz:Class = classMap[url];
			var resultStr:String = data.toString();
			var tempArr:Array=resultStr.split("\n");
			
			var props:Array = (tempArr[0] as String).split(",");
			
			for(var i:int = 3 ; i < tempArr.length ; ++i){
				var lins:Array = (tempArr[i] as String).split(",");
				var insEle:Object = clazz? new clazz : {};
				if(!lins[0] || lins[0] == "null"){
					continue;
				}
				for(var j:int = 0 ; j < props.length ; ++j){
					insEle[props[j]] = lins[j];
				}
				dic.map[insEle[props[0]]] = insEle;
				dic.list.push(insEle);
			}
			return dic;
		}
		
//		public static function ParserList(url:String, data:Object):Array{
//			var arr:Array = [];
//			var clazz:Class = classMap[url];
//			var resultStr:String = data.toString();
//			var tempArr:Array=resultStr.split("\n");
//			
//			var props:Array = (tempArr[0] as String).split(",");
//			
//			for(var i:int = 3 ; i < tempArr.length ; ++i){
//				var insEle:Object = clazz? new clazz : {};
//				var lins:Array = (tempArr[i] as String).split(",");
//				for(var j:int = 0 ; j < props.length ; ++j){
//					insEle[props[j]] = lins[j];
//				}
//				arr.push(insEle);
//			}
//			return arr;
//		}
		
		public static function ParserProps(url:String, data:Object):Object{
			var dic:Object = new Object();
			var resultStr:String = data.toString();
			var tempArr:Array=resultStr.split("\n");
			for(var i:int = 0 ; i < tempArr.length ; ++i){
				var arr:Array = (tempArr[i] as String).split(",");
				var key:String = (arr[0] as String).replace(" ","");
				if(key == "" || key == "null" || key == "undefine"){
					continue;
				}
				dic[arr[0]] = arr[1];
			}
			return dic;
		}
	}
}