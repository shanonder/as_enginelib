package com.icday.structs
{
	import flash.utils.Dictionary;
	
	public class HashMapList
	{
		private var hashMap:Dictionary;
		private var _firstNode:ListNode;
		private var _lastNode:ListNode;
		private var _count:int = 0;
		public function HashMapList()
		{
			hashMap = new Dictionary();
		}
		
		public function get lastNode():HashMapListNode
		{
			return _lastNode as HashMapListNode;
		}
		
		public function get firstNode():HashMapListNode
		{
			return _firstNode as HashMapListNode;
		}
		
		public function get count():int
		{
			return _count;
		}
		
		public function addNode(data:*,key:* = null):ListNode{
			key ||= data;
			removeNode(key);
			var cnode:HashMapListNode = new HashMapListNode();
			cnode.key = key;
			cnode.data = data;
			if(!_firstNode){
				_firstNode = _lastNode = cnode;
			}
			else{
				_lastNode.next = cnode;
				cnode.prev = _lastNode;
				_lastNode = cnode;
			}
			
			hashMap[key] = cnode;
			_count ++;
			return cnode;
		}
		
		public function removeNode(key:*):Boolean
		{
			var node:ListNode = hashMap[key];
			if(!node){
				return false;
			}
			if(_firstNode === node && _lastNode === node){
				_firstNode = _lastNode = null;
			}
			else if(_firstNode === node){
				_firstNode = node.next;
				node.next.prev = null;
			}
			else if(_lastNode === node){
				_lastNode = node.prev;
				node.prev.next = null;
			}
			else{
				if(node.prev){
					node.prev.next = node.next;
				}
				if(node.next){
					node.next.prev = node.prev;
				}
			}
			hashMap[key] = null;
			delete(hashMap[key]);
			_count --;
			return true;
		}
		
		
		public function foreach(closure:Function,...params:Array):void{
			var cnode:ListNode = _firstNode;
			while(cnode){
				if(params.length){
					closure.apply(null,[cnode.data].concat(params));
				}
				else{
					closure(cnode.data)
				}
				cnode = cnode.next;
			}
		}
		
		public function getNode(key:*):HashMapListNode{
			return hashMap[key];
		}
	}
}