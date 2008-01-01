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
 * Mediator for the Boss Sprite 
 */
class balloonatroid.view.BossSpriteMediator 
extends AbstractSpriteMediator implements IMediator
{
	
	/**
	 * Constructor. 
	 */
	public function BossSpriteMediator( viewComponent:Object ) 
	{
		// pass the MovieClip and the Sprite type
		super( viewComponent, GameSprite.BOSS );

		// initialize sprite state
		boss.inertia = GameSprite.EASE_IN;
		boss.active = false;
		
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
					GameFacade.SHOW_BOSS,
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
			// bring the boss onto the playfield
			case GameFacade.SHOW_BOSS:
				boss.showSprite();
				boss.adjustDrift( 0, .5 );
				boss.active = true;
				break;					

			// handle collision detect messages
			case GameSprite.DETECT_COLLISION:
				if (!boss.active) break; // ignore message if sprite not active
				var targetSprite:GameSprite = GameSprite( note.getBody() );
				switch ( note.getType() ) 
				{
					// ignore boss and defenders
					case GameSprite.BOSS:
					case GameSprite.DEFENDER:
						break;
						
					// handle shield collision detect
					case GameSprite.SHIELD:
						if ( targetSprite.hitDetect( boss )  ) 
						{
							trace('Boss crashes into shield and dies');
							boss.active = false;
							boss.hideSprite();
						}
						break;
						
					// handle volley collision detect
					case GameSprite.VOLLEY:
						if ( targetSprite.hitDetect( boss )   ) 
						{
							trace('Boss takes hit from volley!');
							boss.active = false;
							boss.hideSprite();
						}
						break;
				}
				break;					
		}
	}

	function get boss():GameSprite{
		return sprite;
	}
}