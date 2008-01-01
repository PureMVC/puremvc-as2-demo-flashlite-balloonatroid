/*
 PureMVC AS2 FlashLite Demo - Balloonatroid
 Copyright (c) 2007, 2008 by
 Cliff Hall <clifford.hall@puremvc.org> and 
 Chandima Cumaranatunge <chandima.cumaranatunge@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
import org.puremvc.as2.interfaces.IProxy;
import org.puremvc.as2.patterns.proxy.Proxy;
import balloonatroid.model.GameHistoryVO;

class balloonatroid.model.GameHistoryProxy extends 
	org.puremvc.as2.patterns.proxy.Proxy implements IProxy
{
	public static var NAME:String = 'GameHistoryProxy';

	public function GameHistoryProxy( )
	{
		super( NAME );
		
		SharedObject.addListener( "History", loadCompleteHistory );
		var History:SharedObject = SharedObject.getLocal("History");
		
	}
	
	/**
	 * Called when the history SharedObject is loaded.
	 */
	public function loadCompleteHistory ( mySO:SharedObject ) {

		if (0 == mySO.getSize() )
		{ 
			mySO.data.history = new GameHistoryVO();
			data = mySO.data.history;
		}
		else
		{ 
			data = mySO.data.history;
		}
	}


	public function get gameHistory():GameHistoryVO
	{
		return GameHistoryVO( data );
	}
	
}
