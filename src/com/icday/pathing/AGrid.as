package com.icday.pathing
{

	/**
	 * 
	 * @author shanonder
	 * 
	 */
	public class AGrid
	{
		
		private var _startNode:ANode;
		private var _endNode:ANode;
		private var _nodes:Array;
		private var _numCols:int;
		private var _numRows:int;
		
		private var type:int;
		
		private var _straightCost:Number = 1.0;
		private var _diagCost:Number = Math.SQRT2;
		public function AGrid(numCols:int, numRows:int)
		{
			_numCols = numCols;
			_numRows = numRows;
			_nodes = new Array();
			
			for(var i:int = 0; i < _numCols; i++)
			{
				_nodes[i] = new Array();
				for(var j:int = 0; j < _numRows; j++)
				{
					_nodes[i][j] = new ANode(i, j);
				}
			}
		}
		
		/**
		 * 
		 * @param	type	0四方向 1八方向
		 */
		public function calculateLinks(type:int = 0):void {
			this.type = type;
			for(var i:int = 0; i < _numCols; i++)
			{
				for(var j:int = 0; j < _numRows; j++)
				{
					initNodeLink(_nodes[i][j],type);
				}
			}
		}
		
		public function getType():int {
			return type;
		}
		
		/**
		 * 
		 * @param	node
		 * @param	type	0八方向 1四方向
		 */
		private function initNodeLink(node:ANode,type:int):void {
			var startX:int = Math.max(0, node.x - 1);
			var endX:int = Math.min(numCols - 1, node.x + 1);
			var startY:int = Math.max(0, node.y - 1);
			var endY:int = Math.min(numRows - 1, node.y + 1);
			node.links = [];
			for(var i:int = startX; i <= endX; i++)
			{
				for(var j:int = startY; j <= endY; j++)
				{
					var test:ANode = getNode(i, j);
					if (test==node||!test.walkable) {
						continue;
					}
					if (i!=node.x&&j!=node.y) {
						var test2:ANode = getNode(node.x, j);
						if (!test2.walkable) {
							continue;
						}
						test2 = getNode(i, node.y);
						if (!test2.walkable) {
							continue;
						}
					}
					var cost:Number = _straightCost;
					if(!((node.x == test.x) || (node.y == test.y)))
					{
						if (type==1) {
							continue;
						}
						cost = _diagCost;
					}
					node.links.push(new ALink(test,cost));
				}
			}
		}
		
		public function getNode(x:int, y:int):ANode
		{
			return _nodes[x][y];
		}
		
		public function setEndNode(x:int, y:int):void
		{
			_endNode = _nodes[x][y];
		}
		
		public function setStartNode(x:int, y:int):void
		{
			_startNode = _nodes[x][y];
		}
		
		public function setWalkable(x:int, y:int, value:Boolean):void
		{
			_nodes[x][y].walkable = value;
		}
		
		public function get endNode():ANode
		{
			return _endNode;
		}
		
		public function get numCols():int
		{
			return _numCols;
		}
		
		public function get numRows():int
		{
			return _numRows;
		}
		
		public function get startNode():ANode
		{
			return _startNode;
		}
		
	}
}