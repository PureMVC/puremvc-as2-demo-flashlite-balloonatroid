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
 * Mediator for a Level MovieClip 
 */
class balloonatroid.view.LevelClipMediator 
extends AbstractClipMediator implements IMediator
{
	// MovieClipLoader to load levels 
	private var levelLoader:MovieClipLoader;

	/**
	 * Constructor. 
	 */
	public function LevelClipMediator( viewComponent:Object ) 
	{
		// pass the viewComponent to the superclass where 
		// it will be stored in the inherited viewComponent property
		super( viewComponent );

		// prepare the level loader
		levelLoader = new MovieClipLoader();
		levelLoader.addListener( this );
		
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
					GameFacade.GO_SPLASH
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
			
				// Set the game status
				gameState.current = GameStateVO.TRANSITION;
				
				// load the level and display
				levelLoader.loadClip( gameState.gameFile, levelClip );
				levelClip._visible = true;
				break;					

			case GameFacade.GO_SPLASH:
				// stop and hide the game
				levelClip.stop();
				levelClip._visible = false;
				break;
		}
	}


	/** 
	 * Handle load error
	 */
	public function onLoadError( target_mc:MovieClip, errorCode:String, httpStatus:Number ):Void
	{
		// need a better debugging method. this goes into the txtStatus text box on the 
		// debug layer of the movie if it's rendered in.
		_root.txtStatus.text = "Load Error!";
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
	function get levelClip():MovieClip{
		return MovieClip( viewComponent );
	}

}