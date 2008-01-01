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
import balloonatroid.model.*;

class balloonatroid.controller.StartupCommand 
extends SimpleCommand implements ICommand
{
	/**
	 * Prepare the Model and View at startup time
	 */
	public function execute( note:INotification ) : Void    
	{
		// Prepare the Model				
		facade.registerProxy( new GameStateProxy( ) );
		facade.registerProxy( new GameHistoryProxy( ) );
		
		// Prepare the View
		var game:MovieClip = MovieClip( note.getBody() );
		facade.registerMediator( new GameClipMediator( game ) );

		// Send the SPLASH notification to show splash screen
		sendNotification( GameFacade.GO_SPLASH );
	}
}
