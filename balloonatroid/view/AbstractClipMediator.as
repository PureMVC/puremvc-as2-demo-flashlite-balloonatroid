/*
 PureMVC AS2 FlashLite Demo - Balloonatroid
 Copyright (c) 2007, 2008 by
 Cliff Hall <clifford.hall@puremvc.org> and 
 Chandima Cumaranatunge <chandima.cumaranatunge@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
import org.puremvc.as2.interfaces.*;
import org.puremvc.as2.patterns.mediator.*;
import org.puremvc.as2.patterns.observer.*;

import balloonatroid.*;
import balloonatroid.view.*;
import balloonatroid.model.*;


/**
 * 'Abstract' Mediator for a MovieClip that doesn't
 * have to move. 
 */
class balloonatroid.view.AbstractClipMediator 
extends Mediator implements IMediator
{

	/**
	 * Constructor. 
	 */
	public function AbstractClipMediator( viewComponent:Object ) 
	{
		// pass the viewComponent to the superclass where 
		// it will be stored in the inherited viewComponent property
		super( viewComponent );
		
		// get local reference to the GameStateProxy
		gameStateProxy = GameStateProxy( facade.retrieveProxy( GameStateProxy.NAME ) );

	}

	/**
	 * Get the Mediator name
	 * <P>
	 * Set by the _name property of the MovieClip  
	 * 
	 * @return String the Mediator name
	 */
	public function getMediatorName():String
	{
		return clip._name;
	}

	
	/**
	 * Cast the viewComponent to its actual type.
	 * 
	 * <P>
	 * This is a useful idiom for mediators. The
	 * PureMVC Mediator class defines a viewComponent
	 * property of type Object. </P>
	 * 
	 * <P>
	 * Here, we cast the generic viewComponent to 
	 * its actual type in a protected mode. This 
	 * retains encapsulation, while allowing the instance
	 * (and subclassed instance) access to a 
	 * strongly typed reference with a meaningful
	 * name.</P>
	 * 
	 * @return stage the viewComponent cast to MovieClip
	 */
	public function get clip():MovieClip{
		return MovieClip(viewComponent);
	}
	
	private var gameStateProxy:GameStateProxy;
	
	public function get gameState():GameStateVO
	{
		return gameStateProxy.gameState;
	}
}