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
import balloonatroid.model.vo.*;

/**
 * Mediator for the Volley Sprite 
 */
class balloonatroid.view.VolleySpriteMediator 
extends AbstractSpriteMediator implements IMediator
{

	/**
	 * Constructor. 
	 */
	public function VolleySpriteMediator( viewComponent:Object ) 
	{
		// pass the MovieClip and the Sprite type
		super( viewComponent, GameSprite.VOLLEY );
		
		// initialize sprite state
		volley.inertia = GameSprite.EASE_IN;
		volley.active = false;
		
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
					GameFacade.AIM_RIGHT,
					GameFacade.AIM_LEFT,
					GameFacade.VOLLEY,
					GameFacade.GO_PLAY,
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
			// Aim or steer the balloon right
			case GameFacade.AIM_RIGHT:
			
				switch ( gameState.current ) 
				{
					// Balloon has not been vollied and we are aiming
					case GameStateVO.PLAY:
						if ( ( ( volley.targetX + GameStateVO.VOLLEY_WIDTH ) + GameStateVO.AIM_AMOUNT ) < GameStateVO.GAME_WIDTH ) {
							volley.adjustTarget( GameStateVO.AIM_AMOUNT, 0 );
						} else {
							volley.setTarget( GameStateVO.GAME_WIDTH - GameStateVO.VOLLEY_WIDTH, volley.targetY );
						}
						break;
						
					// Balloon has been vollied and we are steering
					case GameStateVO.VOLLEY:
						volley.adjustTarget( GameStateVO.STEER_AMOUNT, 0 );
						volley.adjustDrift ( GameStateVO.STEER_AMOUNT/2, 0 );
						break;
				}
				break;
				
			// Aim or steer the balloon left
			case GameFacade.AIM_LEFT:
	
				switch ( gameState.current ) 
				{
					// Balloon has not been vollied and we are aiming
					case GameStateVO.PLAY:
						if ( volley.targetX >= GameStateVO.AIM_AMOUNT ) {
							volley.adjustTarget( -( GameStateVO.AIM_AMOUNT ), 0 );
						} else {
							volley.setTarget( 0, volley.targetY );
						}
						break;
						
					// Balloon has been vollied and we are steering
					case GameStateVO.VOLLEY:
						volley.adjustTarget( -( GameStateVO.STEER_AMOUNT ), 0 );
						volley.adjustDrift( -( GameStateVO.STEER_AMOUNT/2 ), 0 );
						break;
				}
			
				break;
	
			// volley the balloon 
			case GameFacade.VOLLEY:
				// show the volley balloon
				volley.active = true;
				volley.clip.gotoAndPlay('volley');
				break;
				
			// go back to the play mode (volley balloon at the ready)
			case GameFacade.GO_PLAY:
				// show the volley balloon
				volley.setPosition((GameStateVO.GAME_WIDTH/2)-(GameStateVO.VOLLEY_WIDTH/2),volley.positionY);
				volley.clearTarget();
				volley.setDrift( 0, 0 );
				volley.showSprite();
				volley.active = false;
				volley.clip.gotoAndPlay('newBalloon');
				break;				
			
			// go back to the splash screen
			case GameFacade.GO_SPLASH:
				volley.hideSprite();
				volley.active = false;
				break;

			// handle sprite collision detect requests
			case GameSprite.DETECT_COLLISION:
				if ( !volley.active ) break; // ignore message if sprite not active
				var targetSprite:GameSprite = GameSprite( note.getBody() );
				switch ( note.getType() ) 
				{
					// ignore user's sprites
					case GameSprite.VOLLEY:
					case GameSprite.SHIELD:
						break;
						
					// handle boss collision detect
					case GameSprite.BOSS:
						if ( volley.hitDetect( targetSprite ) ) 
						{
							trace('Volley bounces off Boss');
						}
						break;
						
					// handle defender collision detect
					case GameSprite.DEFENDER:
						if ( volley.hitDetect( targetSprite ) ) 
						{
							trace('Volley bounces off Defender');
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
	 * @return stage the viewComponent cast to MovieClip
	 */
	function get volley():GameSprite{
		return sprite;
	}
}