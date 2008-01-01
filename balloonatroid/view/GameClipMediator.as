/*
 PureMVC AS2 FlashLite Demo - Balloonatroid
 Copyright (c) 2007, 2008 by
 Cliff Hall <clifford.hall@puremvc.org> and 
 Chandima Cumaranatunge <chandima.cumaranatunge@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
import org.puremvc.as2.interfaces.*;
import org.puremvc.as2.patterns.mediator.Mediator;

import balloonatroid.*;
import balloonatroid.model.*;
import balloonatroid.view.*;

/**
 * A Mediator for interacting with the game's main MovieClip,
 * and processing the user's input via the phone's navigation 
 * and soft keys.
 */
class balloonatroid.view.GameClipMediator 
extends AbstractClipMediator implements IMediator
{
	// Cannonical name of the Mediator
	public static var NAME:String = 'GameMediator';
	
	/**
	 * Constructor. 
	 */
	public function GameClipMediator( viewComponent:Object ) 
	{
		// pass the viewComponent to the superclass where 
		// it will be stored in the inherited viewComponent property
		super( viewComponent );
		
		// register clips with their mediators
		facade.registerMediator( new LevelClipMediator( gameClip.level_mc ) );
		facade.registerMediator( new VolleySpriteMediator( gameClip.volley_mc ) );
		facade.registerMediator( new ShieldSpriteMediator( gameClip.shield_mc ) );
		
		// disable focus rectangle and tab
		gameClip._focusRect=false;
		
		// turn off tabs for button navigation
		gameClip.btnLeft.tabEnabled = false;
		gameClip.btnRight.tabEnabled = false;
		gameClip.btnVolley.tabEnabled = false;
		gameClip.btnQuit.tabEnabled = false;
		gameClip.btnPlay.tabEnabled = false;
		
		// listen for user input
		Key.addListener( this );		
	}

	/**
	 * Get the Mediator name
	 * <P>
	 * Called by the framework to get the name of this
	 * mediator. If there is only one instance, we may
	 * define it in a constant and return it here. If
	 * there are multiple instances, this method must
	 * return the unique name of this instance.</P>
	 * 
	 * @return String the Mediator name
	 */
	public function getMediatorName():String
	{
		return GameClipMediator.NAME;
	}

	/**
	 * Handle phone's navigation and soft key presses
	 */
	public function onKeyDown():Void 
	{
		// Key press interpretations differ by game state
		if ( gameState.current == GameStateVO.SPLASH ) {
			
			// Handle SPLASH mode key presses
			switch ( Key.getCode() ) 
			{
				// Handle left soft keypress event.
				case Key.LEFT:
				case ExtendedKey.SOFT1:
					sendNotification( GameFacade.QUIT );
					break;
					
				// Handle right soft keypress event.
				case Key.RIGHT:
				case ExtendedKey.SOFT2:
					sendNotification( GameFacade.PLAY_GAME );
					break;
			}
			
		} else if ( gameState.current == GameStateVO.PLAY ) {
			
			// Handle PLAY mode key presses
			switch ( Key.getCode() ) 
			{
				// Handle left soft keypress event.
				case ExtendedKey.SOFT1:
					sendNotification( GameFacade.GO_SPLASH );
					break;
				
				// Handle left soft keypress event.
				case ExtendedKey.SOFT2:
					sendNotification( GameFacade.GO_CHOOSE );
					break;

				// Handle left arrow keypress event.
				case Key.LEFT:
					sendNotification( GameFacade.AIM_LEFT );
					break;

				// Handle right arrow keypress event.
				case Key.RIGHT:
					sendNotification( GameFacade.AIM_RIGHT );
					break;
				
				// Handle enter keypress
				case Key.ENTER:
					sendNotification( GameFacade.VOLLEY );
					break;
			}
		} else if ( gameState.current == GameStateVO.TRANSITION ) {
			// don't listen to any keys during transition
			break
			
		} else if ( gameState.current == GameStateVO.VOLLEY ) {
			// don't allow another volley, but allow steering
			
			// Handle PLAY mode key presses only
			switch ( Key.getCode() ) 
			{
				// Handle left arrow keypress event.
				case Key.LEFT:
					sendNotification( GameFacade.AIM_LEFT );
					break;
					
				// Handle right soft arrow event.
				case Key.RIGHT:
					sendNotification( GameFacade.AIM_RIGHT );
					break;
			}
		}
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
					GameFacade.GO_PLAY,
					GameFacade.GO_SPLASH,
					GameFacade.VOLLEY
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
					// enable/disable buttons
					gameClip.btnQuit._visible = false;
					gameClip.btnPlay._visible = false;
					
					// set soft key descriptions
					fscommand2("SetSoftKeys", "Quit", "Level");
					
					break;
					
				case GameFacade.GO_SPLASH:
					// hide the play buttons
					gameClip.btnLeft._visible = false;
					gameClip.btnRight._visible = false;
					gameClip.btnVolley._visible = false;
					
					// show the Splash buttons
					gameClip.btnQuit._visible = true;
					gameClip.btnPlay._visible = true;
					
					// show and play the splash movie
					gameClip.splash_mc._visible = true;
					gameClip.splash_mc.gotoAndPlay('opening');
			
					// Set SoftKeys to splash labels
					fscommand2("SetSoftKeys", "Quit", "Play");

					// Set the game status
					gameState.current = GameStateVO.SPLASH;
					break;					

				case GameFacade.GO_PLAY:
					// stop and hide the splash movie
					gameClip.splash_mc.stop();
					gameClip.splash_mc._visible = false;
					
					// enable/disable buttons
					gameClip.btnLeft._visible = true;
					gameClip.btnRight._visible = true;
					gameClip.btnVolley._visible = true;

					// set game status to PLAY
					gameState.current = GameStateVO.PLAY;
                    break;
					
				case GameFacade.VOLLEY:
					// enable/disable buttons
					gameClip.btnVolley._visible = false;
					
					// set game status to VOLLEY
					gameState.current = GameStateVO.VOLLEY;
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
	function get gameClip():MovieClip{
		return MovieClip( viewComponent );
	}
	
}