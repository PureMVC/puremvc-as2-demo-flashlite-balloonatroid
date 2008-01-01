/*
 PureMVC AS2 FlashLite Demo - Balloonatroid
 Copyright (c) 2007, 2008 by
 Cliff Hall <clifford.hall@puremvc.org> and 
 Chandima Cumaranatunge <chandima.cumaranatunge@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
import org.puremvc.as2.interfaces.IFacade;
import org.puremvc.as2.patterns.facade.Facade;
import org.puremvc.as2.patterns.observer.Notification;
import balloonatroid.controller.*;
import balloonatroid.view.*;

/**
 * The concrete Facade instance, defines notification
 * constants, initializes controller, provides global
 * convenience methods 
 */
class balloonatroid.GameFacade 
extends Facade implements IFacade
{
	// Notification name constants
	public static var REGISTER_SPRITE:String 	= "registerSprite";	// create and register sprite's appropriate mediator
	public static var GO_CHOOSE:String  		= "goChoose";		// go to the choose level state
	public static var GO_SPLASH:String  		= "goSplash";		// go to the splash screen state
	public static var GO_PLAY:String  			= "goPlay";			// go to the play state (balloon at ready)
	public static var PLAY_GAME:String  		= "playGame";		// start the game on the current level
	public static var VOLLEY:String  			= "volley";			// volley the balloon (sets volly state)
	public static var AIM_LEFT:String  			= "aimLeft";		// aim or steer left
	public static var AIM_RIGHT:String  		= "aimRight";		// aim or steer right
	public static var SHOW_BOSS:String  		= "showBoss";		// show boss
	public static var STARTUP:String  			= "startup";		// prepare model and view at startup
	public static var QUIT:String  				= "quit";			// quit the game

	/**
	 * Singleton GameFacade Factory Method
	 */
	public static function getInstance() : GameFacade {
		if ( instance == null ) instance = new GameFacade( );
		return GameFacade( instance );
	}

	/**
	 * Register Commands with the Controller 
	 */
	public function initializeController( ) : Void 
	{
		super.initializeController();            
		registerCommand( REGISTER_SPRITE, new RegisterSpriteCommand() );
		registerCommand( STARTUP, 	new StartupCommand() );
		registerCommand( QUIT, 		new QuitCommand() );
	}
	
	/**
	 * Convenience method for starting the application. Called
	 * from frame 1 of the main MovieClip, which passes a
	 * reference to itself as the 'game' parameter. The GameMediator
	 * will tend this reference
	 *
	 * @ param game the reference to the main MovieClip
	 */
	public function startup( game:MovieClip ):Void 
	{
		sendNotification( STARTUP, game );
	}

	/**
	 * Convenience method for using the visual button to 
	 * quit the game or soft keys on phone.
	 */
	public function quit( ):Void
	{
		sendNotification( QUIT );
	}

	/**
	 * Convenience method for using the visual button to 
	 * start the game or soft keys on phone.
	 *
	 * @ param game the reference to the main MovieClip
	 */
	public function playGame( ):Void
	{
		sendNotification( PLAY_GAME );
	}
	
	/**
	 * Convenience method for using the visual button to 
	 * go to the splash screen or soft keys on phone.
	 */
	public function goSplash( ):Void
	{
		sendNotification( GO_SPLASH );
	}

	/**
	 * Convenience method for using the visual button to 
	 * choose a level or soft keys on phone.
	 */
	public function goChoose( ):Void
	{
		sendNotification( GO_CHOOSE );
	}

	/**
	 * Convenience method for using the visual button to 
	 * aim left the game or soft keys on phone.
	 */
	public function aimLeft( ):Void
	{
		sendNotification( AIM_LEFT );
	}
	
	/**
	 * Convenience method for using the visual button to 
	 * aim left or soft keys on phone.
	 */
	public function aimRight():Void
	{
		sendNotification( AIM_RIGHT );
	}

	/**
	 * Convenience method for using the visual button to 
	 * volly or soft keys on phone.
	 */
	public function volley( ):Void
	{
		sendNotification( VOLLEY );
	}

	/**
	 * Convenience method for going to the PLAY state
	 * Shield balloon animation has played 
	 */
	public function goPlay( ):Void
	{
		sendNotification( GO_PLAY );
	}
	
	/**
	 * Convenience method for showing the boss
	 */
	public function showBoss( ):Void
	{
		sendNotification( SHOW_BOSS );
	}

	/**
	 * Convenience method for registering a sprite 
	 */
	public function registerSprite( sprite:MovieClip  ):Void
	{
		sendNotification( REGISTER_SPRITE, sprite );
	}
	
	/**
	 * Sends the named notification along with the reference to the game MC
	 *
	 * @ param noteName the name of the Notification to send
	 * @ param mc optional reference to the MovieClip
	 */
	private function sendNotification( noteName:String, mc:MovieClip ):Void
	{
		var note:Notification = new Notification( noteName, mc );
		_root.txtStatus.text = noteName; // for debug
		notifyObservers( note );
	}
	
}