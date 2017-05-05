package com.icday.net.socket
{
	public class SocketConst
	{
		/**
		 * 包头长度
		 */
		public static const HEAD_LENGTH:int = 22;
		public static var version:int = 12;
		public static const HEAD_MARK:int = 0xFFFF;
		public static const COMMON_STATE:int = 200;
		public static const TESTID:int = 1;
		public static const RESERVED:int = 0;
		public function SocketConst()
		{
		}
	}
}