package com.icday.utils
{
	import flash.net.getClassByAlias;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	
	
	public class ObjectUtil
	{
		
		
		// 对象深度复制  将实例及子实例的所有成员(属性和方法, 静态的
		// 除外)都复制一遍, (引用要重新分配空间!)
		
		// 局限性 
		// 1. 不能对显示对象进行复制
		// 2. obj必须有默认构造函数(参数个数为0,或都有默认值)
		// 3. obj 里有obj类型 之外 的非内置数据类型时, 返回类型将不//确定
		
		
		//  @param  obj  strong      strong 深复制的对象
		//   @return
		
		static public function deepClone(obj):*
		{
			var aliasClass:Class;
			var classDefinition:Class = Object(obj).constructor as Class;
			var className:String = getQualifiedClassName(obj);
			
			// 获取已注册 obj的类名的类型
			try {
				aliasClass = getClassByAlias(className);
			}catch (errError) { }
			
			// 没有注册 AliasName
			if (!aliasClass)
			{
				registerClassAlias(className, classDefinition);
			}
				// 已经注册了 AliasName ,且不是它的全类名,要重新注册个
			else if (aliasClass != classDefinition)
			{
				registerClassAlias(className + '.' + className, classDefinition);
			}
				
			var byteArray:ByteArray = new ByteArray();
			byteArray.writeObject(obj);
			byteArray.position = 0;
			return byteArray.readObject();

			return null;
		}
	}
}
