package com.icday.net.socket
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import com.icday.net.interfaces.INetRequest;
	
	public class SocketProxy
	{

		private var socket:Socket;
		
		private var adapter:SocketAdapter;
		/**
		 * 缓存池 
		 */
		private var bytesPool:ByteArray;
		private var isDecodeBody:Boolean;
		
		private var respPack:Pack = new Pack;
		
		private var host:String;
		private var port:int;
		
		public function connect(host:String, port:int):void{
			this.host = host;
			this.port = port;
			socket.connect(host,port);
		}
		
		public function close():void{
			socket.close();
		}
		
		public function init(adapter:SocketAdapter):void{
			this.adapter = adapter;
			socket.addEventListener(Event.CONNECT,onHandler);
			socket.addEventListener(Event.CLOSE,onHandler);
			socket.addEventListener(IOErrorEvent.IO_ERROR,onHandler);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onHandler);
			socket.addEventListener(ProgressEvent.SOCKET_DATA,onData);
		}
		
		public function SocketProxy()
		{
			bytesPool = new ByteArray();
			bytesPool.endian = Endian.BIG_ENDIAN;
			socket = new Socket();
			socket.endian = Endian.BIG_ENDIAN;
		}

		protected function onData(event:ProgressEvent):void
		{
			socket.readBytes(bytesPool,bytesPool.position,socket.bytesAvailable);
			readData();
		}
		
		private function readData():void
		{
			if(!isDecodeBody){
				if(bytesPool.bytesAvailable < SocketConst.HEAD_LENGTH){
					return;
				}else{
					respPack.hmark = bytesPool.readUnsignedShort();
					respPack.version = bytesPool.readUnsignedShort();
					respPack.length = bytesPool.readInt();
					respPack.command = bytesPool.readInt();
					respPack.status = bytesPool.readUnsignedShort();
					respPack.testid = bytesPool.readInt();
					respPack.reserved = bytesPool.readInt();
					if(respPack.length === SocketConst.HEAD_LENGTH){
						onMessage(respPack.command,respPack.status,null);
					}else{
						isDecodeBody = true;
					}
				}
			}else{
				if(bytesPool.bytesAvailable < respPack.length - SocketConst.HEAD_LENGTH){
					return;
				}else{
					var bt:ByteArray = new ByteArray();
					bt.endian = Endian.BIG_ENDIAN;
					bytesPool.readBytes(bt,bt.position,respPack.length - SocketConst.HEAD_LENGTH);
//					var data:Object = bt.readObject();
//					bt.clear();
//					bt = null;
				}
				isDecodeBody = false;
				onMessage(respPack.command,respPack.status, bt);
			}
			readData();
		}
		
		private function onMessage(cmd:int,status:int , bytes:ByteArray):void
		{
			adapter.onMsg(cmd,status, bytes);
			if(bytes){
				bytes.clear();
				bytes = null;
			}
		}
		protected function onHandler(event:Event):void
		{
			switch(event.type){
				case Event.CONNECT:
					adapter.connectHandler.executeWith([host,port]);
					break;
				case IOErrorEvent.IO_ERROR:
				case SecurityErrorEvent.SECURITY_ERROR:
					var eevt:ErrorEvent = event as ErrorEvent;
					adapter.errorHandler.executeWith([ eevt.type, eevt.errorID ,eevt.text]);
					break;
				case Event.CLOSE:
					adapter.closeHandler.executeWith([host,port]);
					break;
				
			}
		}
		
		public function sendRequest(request:INetRequest):void{
			if(!socket.connected){
				return;
			}
			var bytes:ByteArray = new ByteArray();
			bytes.writeShort(SocketConst.HEAD_MARK);
			bytes.writeShort(SocketConst.version);
			bytes.writeInt(SocketConst.HEAD_LENGTH);
			bytes.writeInt(request.cmd);
			bytes.writeShort(SocketConst.COMMON_STATE);
			bytes.writeInt(SocketConst.TESTID);
			bytes.writeInt(SocketConst.RESERVED);
			bytes.writeBytes(request.encode());
			bytes.position = 4;
			bytes.writeInt(bytes.length);
			request.dispose();
			socket.writeBytes(bytes);
			socket.flush();	
			bytes.clear();
			bytes = null;	
		}
		
		
		public function sendBytes(cmd:int,data:ByteArray):void{
			var bytes:ByteArray = new ByteArray();
			bytes.writeShort(SocketConst.HEAD_MARK);
			bytes.writeShort(SocketConst.version);
			bytes.writeInt(SocketConst.HEAD_LENGTH);
			bytes.writeInt(cmd);
			bytes.writeShort(SocketConst.COMMON_STATE);
			bytes.writeInt(SocketConst.TESTID);
			bytes.writeInt(SocketConst.RESERVED);
			if(data){
				bytes.writeBytes(data);
				bytes.position = 4;
				bytes.writeInt(bytes.length);
			}
			socket.writeBytes(bytes);
			socket.flush();	
			bytes.clear();
			bytes = null;
		}
		
		public function sendObject(cmd:int,data:Object):void
		{
			if(!socket.connected){
				App.log.warn("socket error: not connected","0x"+ cmd.toString(16));
				return;
			}
			var bytes:ByteArray = new ByteArray();
			bytes.writeShort(SocketConst.HEAD_MARK);
			bytes.writeShort(SocketConst.version);
			bytes.writeInt(SocketConst.HEAD_LENGTH);
			bytes.writeInt(cmd);
			bytes.writeShort(SocketConst.COMMON_STATE);
			bytes.writeInt(SocketConst.TESTID);
			bytes.writeInt(SocketConst.RESERVED);
			if(data){
				bytes.writeObject(data);
				bytes.position = 4;
				bytes.writeInt(bytes.length);
			}

			socket.writeBytes(bytes);
			socket.flush();	
			bytes.clear();
			bytes = null;
		}
	}
}