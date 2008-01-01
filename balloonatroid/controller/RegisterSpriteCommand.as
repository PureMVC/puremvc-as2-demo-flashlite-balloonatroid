/*
 PureMVC AS2 FlashLite Demo - Balloonatroid
 Copyright (c) 2007, 2008 by
 Cliff Hall <clifford.hall@puremvc.org> and 
 Chandima Cumaranatunge <chandima.cumaranatunge@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
import org.puremvc.as2.interfaces.ICommand;
import org.puremvc.as2.interfaces.INotification;
import org.puremvc.as2.patterns.command.SimpleCommand;

import balloonatroid.*;
import balloonatroid.view.*;

class balloonatroid.controller.RegisterSpriteCommand 
extends SimpleCommand implements ICommand
{
	// Sprite name constants 
	public var MC_BOSS:String		= "boss_mc";
	public var MC_VOLLEY:String		= "volley_mc";
	public var MC_SHIELD:String		= "shield_mc";
	public var MC_DEFENDER:String	= "defender_mc";
	
	/**
	 * Create and register the appropriate Mediator for a given 
	 */
	public function execute( note:INotification ) : Void    
	{
		var mc:MovieClip = MovieClip( note.getBody() );

		switch ( mc._name ) {
			
			case MC_BOSS:
				var bossSpriteMediator:BossSpriteMediator = new BossSpriteMediator( mc );
				facade.registerMediator( bossSpriteMediator ); 
				break;
			
			case MC_VOLLEY:
				var volleySpriteMediator:VolleySpriteMediator = new VolleySpriteMediator( mc );
				facade.registerMediator( volleySpriteMediator ); 
				break;

			case MC_SHIELD:
				var shieldSpriteMediator:ShieldSpriteMediator = new ShieldSpriteMediator( mc );
				facade.registerMediator( shieldSpriteMediator ); 
				break;

		}
	}	
}
