package com.icday.utils
{
	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	public class BitmapDataUtil
	{
		public function BitmapDataUtil()
		{
		}
		
		public static function encode(bitmapData:BitmapData,bytes:ByteArray = null):ByteArray{
			bytes ||= new ByteArray(); //创建二进制存储
			bytes.writeUnsignedInt(bitmapData.width);
			bytes.writeUnsignedInt(bitmapData.height);
			bytes.writeBoolean(bitmapData.transparent);
			var bytesData:ByteArray = bitmapData.getPixels(bitmapData.rect);
			bytes.writeUnsignedInt(bytesData.bytesAvailable);
			bytes.writeBytes(bytesData);
			return bytes;
		}
		
		public static function decode(bytes:ByteArray):BitmapData{
			var w:uint = bytes.readUnsignedInt();
			var h:uint = bytes.readUnsignedInt();
			var t:Boolean = bytes.readBoolean();
			var bmpd:BitmapData = new BitmapData(w,h,t);
			var length:uint = bytes.readUnsignedInt();
			var bytesData:ByteArray = new ByteArray;
			bytes.readBytes(bytesData,0,length);
			bmpd.setPixels(bmpd.rect,bytesData);
			return bmpd;
		}
	}
}