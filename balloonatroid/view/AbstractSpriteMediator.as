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
 * Treated as an 'Abstract' Mediator for interacting with 
 * a MovieClip and affecting its motion and detecting 
 * collisions with other objects.
 */
class balloonatroid.view.AbstractSpriteMediator 
extends Mediator implements IMediator
{
	/**
	 * Constructor. 
	 */
	public function AbstractSpriteMediator( viewComponent:Object, spriteType:String ) 
	{
		// wrap the viewComponent which is a plain MovieClip
		// in a GameSprite instance, then pass the it to 
		// the superclass where it will be stored in the 
		// inherited viewComponent property
		super( new GameSprite( MovieClip( viewComponent ), spriteType ) );
		
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
		return sprite.spriteName;
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
	 * @return the viewComponent cast to Sprite
	 */
	public function get sprite():GameSprite
	{
		return GameSprite( viewComponent );
	}
	
	private var gameStateProxy:GameStateProxy;
	
	public function get gameState():GameStateVO
	{
		return gameStateProxy.gameState;
	}
}