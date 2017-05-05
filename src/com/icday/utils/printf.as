//------------------------------------------------------------------------------
//
// classname: printf
// version: 0.1.0
// author: 小兵( aosnow@yeah.net )
// created: 2013-3-22
// copyright (c) 2013 小兵( aosnow@yeah.net )
// ...
//
//------------------------------------------------------------------------------

package com.icday.utils
{

	/**
	 *  使用传入的各个参数替换指定的字符串内的 <code>{n}</code> 标记。
	 *
	 *  @param str					- 用来进行替换的源字符串。
	 *  @param rest					- 可在 str 参数中的每个 <code>{n}</code> 位置被替换的值。
	 *  如果第一个参数是一个数组，则该数组将用作参数列表。若第一个参数为数据对象，则会进行全局替换，否则为顺序替换。
	 *
	 *  <p>源字符串可包含 <code>{n}</code> 形式的特殊标记，其中 n 为任意标识符（由字母、数字、下划线组成），
	 *  它将被替换成具体的值。</p>
	 *  <p>因为允许 rest 第一个参数为数组，因此允许在其它想要使用... rest 参数的方法中重复使用此例程。例如:
	 * 	<table><tr><td style="padding:10px;color:#334455"><code>
	 *     public function myTracer(str:String, ... rest):void<br>
	 *     {<br>
	 *     		label.text += printf(str, rest) + "\n";<br>
	 *     }
	 * 	</code></td></tr></table><p>
	 *
	 *  @return 使用指定的各个参数替换了所有 <code>{n}</code> 标记的新字符串。
	 *
	 *  <table><tr><td style="padding:10px;color:#334455"><code>
	 *  var str:String = "here is some info {number} and {boolean}";<br>
	 *  trace(printf(str, 15.4, true));<br>
	 *  <br>
	 *  // this will output the following string:<br>
	 *  // "here is some info 15.4 and true"<br>
	 *	</code></td></tr></table>
	 */
	public function printf( str:String, ... rest ):String
	{
		if( str == null || str == "" )
			return "";

		var lng:int; // 最终需要计算替换的次数
		var args:Array; // 最终需要替换的数据
		var i:int;

		switch( typeof( rest[ 0 ]))
		{
			case "number":
			case "boolean":
			case "string":
			{
				lng = rest.length;
				args = rest;

				for( i = 0; i < lng; i++ )
				{
					str = str.replace( PATTERN_PRINTF, args[ i ]);
				}
				break;
			}
			case "object":
			{
				if( rest[ 0 ] is Array )
				{
					args = rest[ 0 ] as Array;
					lng = args.length;

					for( i = 0; i < lng; i++ )
					{
						str = str.replace( PATTERN_PRINTF, args[ i ]);
					}
				}
				else
				{
					var reg:RegExp;

					for( var prop:String in rest[ 0 ])
					{
						reg = new RegExp( "\{" + prop + "\}", "ig" );
						str = str.replace( reg, rest[ 0 ][ prop ]);
					}
				}
				break;
			}
		}

		return str;
	}
}

const PATTERN_PRINTF:RegExp = /\{[a-z0-9_]+\}/i;
