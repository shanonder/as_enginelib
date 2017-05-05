package com.icday.net.socket
{
	

	public class Pack
	{
		public function Pack()
		{
		}
		
		public var hmark:int = 0xFFFF;
		public var version:int = 0x0001;
		public var length:int;
		public var command:int;
		public var status:int;
		public var testid:int;
		public var reserved:int;
		
//		public var data:Object;
		
		
//		public static function encode(pack:Pack):ByteArray
//		{
//			var bytes:ByteArray = new ByteArray();
//			bytes.writeShort(pack.hmark);
//			bytes.writeShort(pack.version);
//			bytes.writeInt(0);
//			bytes.writeInt(pack.command);
//			bytes.writeShort(pack.status);
//			bytes.writeInt(pack.testid);
//			bytes.writeInt(pack.reserved);
//			if(pack.data){
//				bytes.writeObject(pack.data);
//				bytes.position = 4;
//				bytes.writeInt(bytes.length);
//			}
//			return bytes;
//		}
		
//		public static function read(bytes:ByteArray):Pack{
//			var pack:Pack = new Pack;
//			pack.hmark = bytes.readUnsignedShort();
//			pack.version = bytes.readUnsignedShort();
//			pack.length = bytes.readInt();
//			pack.command = bytes.readInt();
//			pack.status = bytes.readUnsignedShort();
//			pack.testid = bytes.readInt();
//			pack.reserved = bytes.readInt();
//			var bt:ByteArray = new ByteArray();
//			bt.endian = Endian.LITTLE_ENDIAN;
//			bytes.readBytes(bt,0,pack.length);
//			pack.data = bt.readObject();
//			return pack;
//		}
	}
}