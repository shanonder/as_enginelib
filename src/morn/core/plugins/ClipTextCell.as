package morn.core.plugins
{
	import flash.display.DisplayObject;
	
	import morn.core.components.Clip;
	
	
	public class ClipTextCell implements IRichTextFieldCell
	{
		public static const NAME:String = "ClipTextCell";
		private var _index:int;
		public var clipX:int;
		public var clipY:int;
		public var url:String;
		
		public function exportXml(off:int):XML
		{
			var xml:XML = <image url={url} index={index + off} type={NAME} clipX={clipX} clipY={clipY} />;
			return xml;
		}
		
		public function importXml(node:XML, isHtml:Boolean):void{
			var i:int = int(node.@index);
			this._index = isHtml? i+1 : i;
			this.clipX = node.@clipX;
			this.clipY = node.@clipY;
			this.url = node.@url;
		}
		
		public var shortcut:String;
		public function ClipTextCell(index:int = 0,url:String = null ,clipX:int = 0,clipY:int = 0,shortcut:String = null)
		{
			this._index = index;
			this.url = url;
			this.clipX = clipX;
			this.clipY = clipY;
			this.shortcut = shortcut;
		}
		
		public function getDisplay():DisplayObject
		{
			var clip:Clip = new Clip(url,clipX,clipY);
			clip.play();
			return clip;
		}
		
		public function get index():int
		{
			return _index;
		}
		
		public function get cache():IRichTextFieldCell
		{
			return null;
		}
		
	}
}