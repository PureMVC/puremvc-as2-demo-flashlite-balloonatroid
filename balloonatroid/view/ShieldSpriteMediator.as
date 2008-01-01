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
 * Mediator for the Volley MovieClip 
 */
class balloonatroid.view.ShieldSpriteMediator 
extends AbstractSpriteMediator implements IMediator
{

	/**
	 * Constructor. 
	 */
	public function ShieldSpriteMediator( viewComponent:Object ) 
	{
		// pass the MovieClip and the Sprite type
		super( viewComponent, GameSprite.SHIELD );

		// initialize sprite state
		shield.inertia = GameSprite.FLAT;
		shield.showSprite();
		shield.active = false;
		
	}

	/**
	 * List all notifications this Mediator is interested in.
	 * <P>
	 * Automatically called by the framework when the mediator
	 * is registered with the view.</P>
	 * 
	 * @return Array the list of Nofitication names
	 */
	public function listNotificationInterests():Array 
	{
		return [ 
					GameFacade.PLAY_GAME,
					GameFacade.GO_SPLASH,
					GameSprite.DETECT_COLLISION					
			   ];
	}

	/**
	 * Handle all notifications this Mediator is interested in.
	 * <P>
	 * Called by the framework when a notification is sent that
	 * this mediator expressed an interest in when registered
	 * (see <code>listNotificationInterests</code>.</P>
	 * 
	 * @param INotification a notification 
	 */
	public function handleNotification( note:INotification ):Void 
	{
		switch ( note.getName() ) 
		{
			case GameFacade.PLAY_GAME:
				shield.showSprite();
				shield.clip.play();
				shield.active = true;
				break;
				
			case GameFacade.GO_SPLASH:
				shield.active = false;
				break;
				
			// handle collision detect messages
			case GameSprite.DETECT_COLLISION:
				if (!shield.active) break; // ignore message if sprite not active
				var targetSprite:GameSprite = GameSprite( note.getBody() );
				switch ( note.getType() ) 
				{
					// ignore user's sprites
					case GameSprite.VOLLEY:
					case GameSprite.SHIELD:
						break;
						
					// handle boss collision detect
					case GameSprite.BOSS:
						if ( shield.hitDetect( targetSprite ) ) 
						{
							trace('Loose lots of Shield to Boss hit');
						}
						break;
						
					// handle defender collision detect
					case GameSprite.DEFENDER:
						if ( shield.hitDetect( targetSprite ) ) 
						{
							trace('Loose a little Shield to Defender hit');
						}
						break;
				}
				break;					
		}
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
	 * @return stage the viewComponent cast to GameSprite
	 */
	function get shield():GameSprite
	{
		return sprite;
	}

}