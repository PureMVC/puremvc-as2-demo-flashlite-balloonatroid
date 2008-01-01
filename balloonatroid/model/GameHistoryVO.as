/*
 PureMVC AS2 FlashLite Demo - Balloonatroid
 Copyright (c) 2007, 2008 by
 Cliff Hall <clifford.hall@puremvc.org> and 
 Chandima Cumaranatunge <chandima.cumaranatunge@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
class balloonatroid.model.GameHistoryVO
{
	
	public function GameHistoryVO ( )
	{
		highScores = new Array();
	} 

	public var highestLevel:Number;
	public var highScores:Array;
	public var lastLevel:Number;
	public var lastScore:Number;
}