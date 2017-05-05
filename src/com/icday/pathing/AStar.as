package com.icday.pathing
{
	/**
	 * 
	 * @author shanonder
	 * 
	 */
	public class AStar
	{
		//private var _open:Array;
		private var _open:BinaryHeap;
		private var _grid:AGrid;
		private var _endNode:ANode;
		private var _startNode:ANode;
		private var _path:Array;
		private var _heuristic:Function;
		private var _straightCost:Number = 1.0;
		private var _diagCost:Number = Math.SQRT2;
		private var nowVision:int = 1;
		public function AStar()
		{
			
			_heuristic = manhattan2;
			
		}
		
		private function justMin(x:Object, y:Object):Boolean {
			return x.f < y.f;
		}
		
		public function findPath(grid:AGrid):Boolean
		{
			this._grid = grid;
			_endNode = _grid.endNode;
			nowVision++;
			_startNode = _grid.startNode;
			//_open = [];
			_open = new BinaryHeap(justMin);
			_startNode.g = 0;
			return search();
		}
		
		public function search():Boolean
		{
			var node:ANode = _startNode;
			node.vision = nowVision;
			while(node != _endNode)
			{
				var len:int = node.links.length;
				for (var i:int = 0; i < len;i++ ) {
					var test:ANode = node.links[i].node;
					if (test.vision == nowVision)
					{
						continue;
					}
					var cost:Number = node.links[i].cost;
					var g:Number = node.g + cost;
					var h:Number = _heuristic(test);
					var f:Number = g + h;
					test.f = f;// Math.round(f);
					test.g = g;
					test.h = h;
					test.parent = node;
					/*var flag:Boolean = false;
					for (var j:int = 0; j<_open.length;j++ ) {
						if (test.f<=_open[j].f) {
							flag = true;
							_open.splice(j, 0, test);
							break;
						}
					}
					trace(_open.length);
					if (!flag) {
						_open.push(test);
					}*/
					_open.ins(test);
					test.vision = nowVision;
				}
				if(_open.length == 1)
				{
					return false;
				}
				node = _open.pop() as ANode;
			}
			buildPath();
			return true;
		}
		
		private function buildPath():void
		{
			_path = [];
			var node:ANode = _endNode;
			_path.push(node);
			while(node != _startNode)
			{
				node = node.parent;
				_path.unshift(node);
			}
		}
		
		public function get path():Array
		{
			return _path;
		}
		
		private function manhattan(node:ANode):Number
		{
			return Math.abs(node.x - _endNode.x) + Math.abs(node.y - _endNode.y);
		}
		
		private function manhattan2(node:ANode):Number
		{
			var dx:Number = Math.abs(node.x - _endNode.x);
			var dy:Number = Math.abs(node.y - _endNode.y);
			return dx+dy+Math.abs(dx-dy)/1000;
		}
		
		private function euclidian(node:ANode):Number
		{
			var dx:Number = node.x - _endNode.x;
			var dy:Number = node.y - _endNode.y;
			return Math.sqrt(dx * dx + dy * dy) * _straightCost;
		}
		
		private function diagonal(node:ANode):Number
		{
			var dx:Number = Math.abs(node.x - _endNode.x);
			var dy:Number = Math.abs(node.y - _endNode.y);
			var diag:Number = Math.min(dx, dy);
			var straight:Number = dx + dy;
			return _diagCost * diag + _straightCost * (straight - 2 * diag);
		}
	}
}
