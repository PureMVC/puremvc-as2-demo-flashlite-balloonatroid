/*
 PureMVC AS2 FlashLite Demo - Balloonatroid
 Copyright (c) 2007, 2008 by
 Cliff Hall <clifford.hall@puremvc.org> and 
 Chandima Cumaranatunge <chandima.cumaranatunge@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
class balloonatroid.view.MovieClipDelegate extends Object
{
	private var func:Function;

	function MovieClipDelegate(f:Function)
	{
		func = f;
	}

	static function create(obj:Object, func:Function):Function
	{
		var f = function()
		{
			var target = arguments.callee.target;
			var func = arguments.callee.func;
			var args = arguments.callee.args;
			return func.apply(target, arguments.concat(args));
		};
		f.target = obj;
		f.func = func;
		f.args = (arguments.length>2) ? arguments.slice(2) : [];
		return f;
	}

	function createDelegate(obj:Object):Function
	{
		return create(obj, func);
	}
}