/**
import com.peter.Csv;
import com.peter.CsvEvent;
import flash.events.Event;
var csv:Csv=new Csv();
csv.loadURL("online3.csv");
csv.addEventListener(Event.COMPLETE,onLoadCompleteHandler);
csv.addEventListener(IOErrorEvent.IO_ERROR,onLoadIOError);
csv.addEventListener(CsvEvent.EOF_ERROR,onReadFileError);
function onLoadCompleteHandler(event:Event):void {
	var arr:Array=csv.getRandomRecords(10);
	for (var i:uint=0; i<arr.length; i++) {
		trace("q:"+arr[i]["question"]+"__A:"+arr[i]["a"]);//question,a為csv第一行相應列對應記錄字段
	}
}
function onLoadIOError(event:IOErrorEvent):void{
	trace('url error');
}
function onReadFileError(event:CsvEvent):void{
	trace('read csv file error');
}
*******************************************************/
package utils.csvs{
	import flash.errors.EOFError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;

	public class Csv extends EventDispatcher {
		private var _records:Array=new Array  ;
		private const DQUOTES:String="#100";
		private const SEMICOLON:String="#101";
		private var _currentIndex:uint=0;
		private var _encoding:String="utf8";
		public function Csv() {
		}
		public function loadURL(url:String):void {
			_records=new Array  ;
			var loader:URLLoader=new URLLoader  ;
			var link:URLRequest=new URLRequest(url);
			loader.addEventListener(Event.COMPLETE,onLoadCompleteHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR,onLoadErrorHandler);
			loader.dataFormat= URLLoaderDataFormat.BINARY;
			loader.load(link);
		}
		private function onLoadCompleteHandler(event:Event):void {
			var resultStr:String="";
			try {
				resultStr = (event.target.data as ByteArray).toString();
			} catch (e:EOFError) {
				dispatchEvent(new CsvEvent(CsvEvent.EOF_ERROR));
			}
			var tempArr:Array=resultStr.split("\n");
			for(var i:int = 0 ; i < tempArr.length ; ++i){
				_records.push((tempArr[i] as String).split(",").map(trim));
			}
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function trim(data:String,index:int ,arr:Array):String
		{
			return data.substr(1,data.length-2);
		}

		
		public function setEnCoding(code:String):void {
			_encoding=code;
		}
		private function onLoadErrorHandler(event:IOErrorEvent):void {
			dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
		}
	}
}