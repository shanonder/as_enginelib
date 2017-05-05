package morn.core.plugins
{
	import flash.display.DisplayObject;

	public interface IRichTextFieldCell
	{
		function getDisplay():DisplayObject;
		function get index():int;
		function get cache():IRichTextFieldCell;
		function exportXml(off:int):XML;
		function importXml(node:XML,isHtml:Boolean):void;
		
		
	}
}