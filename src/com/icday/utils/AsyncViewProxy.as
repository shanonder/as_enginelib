package com.icday.utils
{
	import com.icday.LayoutManager;
	
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;
	
	import morn.core.components.Dialog;
	import morn.core.components.View;
	import morn.core.handlers.Handler;
	
	public class AsyncViewProxy
	{
		private static var _resMap:Dictionary = new Dictionary();
		public static var loadProgressHandler:Handler;
		public function AsyncViewProxy()
		{
		}
		
		public static function regist(key:*,...params:Array):void{
			_resMap[key] = params;
		}
		
		/**
		 * 
		 * @param key
		 * @param type 0 自动 1 开 2关
		 * @param closeOther
		 * @param data
		 * @param closure 回调
		 * 
		 */
		public static function toggleDialog(key:*,type:int = 0,closeOther:Boolean = false,data:* = null,callback:* = null):void{
			if(type == -1){
				if(Singleton.hasInstance(key)){
					App.dialog.close(Singleton.getInstance(key));
				}
				return;
			}
			var closure:Function = function():void{
				var view:Dialog = Singleton.getInstance(key);
				if(type == 1){
					App.dialog.show(view,closeOther);
					if(data){
						view.dataSource = data;
					}
				}
				if(type == 0){
					if(view.isPopup){
						view.close();
					}
					else{
						view.show(closeOther);
						if(callback as Function){
							callback(data);
						}
						else if(callback is String){
							if(view.hasOwnProperty(callback)){
								var func:Function = view[callback] as Function;
								if(func.length == 0){
									func();
								}else{
									func(data);
								}
							}
						}
						else if(data){
							view.dataSource = data;
						}
					}
				}
				
			};
			if(!Singleton.hasInstance(key)){
				if(_resMap[key]){
					App.loader.loadAssets(_resMap[key], new Handler(closure), loadProgressHandler);
					return;
				}
			}
			closure();
		}
		
		
		/**
		 * 
		 * @param key
		 * @param type 0 自动 1 开 2关
		 * @param closeOther
		 * @param data
		 * @param closure 回调
		 * 
		 */
		public static function toggleView(key:*,container:DisplayObjectContainer,type:int = 0,closeOther:Boolean = false,data:* = null,callback:* = null):void{
			if(type == -1){
				if(Singleton.hasInstance(key)){
					var view:View = Singleton.getInstance(key);
					if(view){
						view.remove();
					}
				}
				return;
			}
			var closure:Function = function():void{
				var view:View = Singleton.getInstance(key);
				if(type == 1){
					container.addChild(view);
					if(data){
						view.dataSource = data;
					}
				}
				if(type == 0){
					if(view.stage){
						view.remove();
					}
					else{
						container.addChild(view);
						if(callback as Function){
							callback(data);
						}
						else if(callback is String){
							if(view.hasOwnProperty(callback)){
								var func:Function = view[callback] as Function;
								if(func.length == 0){
									func();
								}else{
									func(data);
								}
							}
						}
						else if(data){
							view.dataSource = data;
						}
					}
				}
				
			};
			if(!Singleton.hasInstance(key)){
				if(_resMap[key]){
					App.loader.loadAssets(_resMap[key], new Handler(closure), loadProgressHandler);
					return;
				}
			}
			closure();
		}
	}
}