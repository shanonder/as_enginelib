package com.icday.utils
{
	import flash.filters.ColorMatrixFilter;

	public class FilterUtil
	{
		public function FilterUtil()
		{
		}
	
		public static const NONE_FILTER:Array = [];
		public static const GRAY_FILTER:Array = [new ColorMatrixFilter(
			[0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0]
		)]
	}
}