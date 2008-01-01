/*
 PureMVC AS2 FlashLite Demo - Balloonatroid
 Copyright (c) 2007, 2008 by
 Cliff Hall <clifford.hall@puremvc.org> and 
 Chandima Cumaranatunge <chandima.cumaranatunge@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
import org.puremvc.as2.interfaces.IProxy;
import org.puremvc.as2.patterns.proxy.Proxy;

import balloonatroid.model.*;

class balloonatroid.model.GameStateProxy extends 
	org.puremvc.as2.patterns.proxy.Proxy implements IProxy
{
	public static var NAME:String = 'GameStateProxy';

	public function GameStateProxy( vo:GameStateVO )
	{
		super( NAME, new GameStateVO() );
	}

	public function get current():String
	{
		return gameState.current;
	}
	
	public function set current( newState:String ):Void
	{
		gameState.current = newState;
	}
	
	public function get gameState():GameStateVO
	{
		return GameStateVO( data );
	}
	
}
