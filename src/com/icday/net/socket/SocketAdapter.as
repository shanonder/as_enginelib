package com.icday.net.socket
{
	import com.icday.mvcs.ICommand;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import morn.core.handlers.Handler;
	
	import com.icday.net.interfaces.INetRequest;
	
	public class SocketAdapter
	{
		private var sm:SocketProxy;
		private var handlerMap:Dictionary;
		private var msgHander:Handler;
		
		public var connectHandler:Handler;
		public var errorHandler:ErrorHandler;
		public var closeHandler:Handler;
		private var msgHandler:Handler;
		private var commandMap:Dictionary;
		
		
		/**
		 * 
		 * @param cmd
		 * @param Clazz implements ICommand
		 * 
		 */
		public function registCmd(cmd:int, Clazz: Class):void{
			commandMap[cmd] = Clazz;
		}
		
		
		public function registClosure(cmd:int, closure: Function):void{
			handlerMap[cmd] = closure;
		}
		
		
		
		public function onMsg(cmd:int, status:int ,data:ByteArray):void
		{
			var Clazz:Class = commandMap[cmd];
			if(Clazz){
				var ins:ICommand = new Clazz();
				ins.excute(cmd,status,data);
			}else{
				var func:Function = handlerMap[cmd];
				if(func){
					func(cmd,status,data);
				}
				else{
					App.log.warn("unResigst CMD:" + "0x"+ cmd.toString(16));
				}
			}
		}
		
		function SocketAdapter(socket:SocketProxy)
		{
			this.sm = socket;
			connectHandler = new ConnectHandler();
			errorHandler = new ErrorHandler();
			closeHandler = new CloseHandler();
			msgHandler = new Handler(onMsg);
			commandMap = new Dictionary();
			handlerMap = new Dictionary();
		}
		
		public function connect(host:String,port:int):void{
			sm.connect(host,port);
		}
		
		public function sendObect(cmd:int, data:Object):void
		{
			sm.sendObject(cmd,data);
		}
		
		public function sendRequest(request:INetRequest):void{
			sm.sendRequest(request);
		}
		
		public function sendBytes(cmd:int,bytes:ByteArray):void{
			sm.sendBytes(cmd,bytes);
		}
		
		public function close():void
		{
			sm.close();
		}
		
		public static function build():SocketAdapter{
			var sp:SocketProxy = new SocketProxy();
			var sa:SocketAdapter = new SocketAdapter(sp);
			sp.init(sa);
			return sa;
		}
	}
}