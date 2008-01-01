/*
 PureMVC AS2 FlashLite Demo - Balloonatroid
 Copyright (c) 2007, 2008 by
 Cliff Hall <clifford.hall@puremvc.org> and 
 Chandima Cumaranatunge <chandima.cumaranatunge@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
import org.puremvc.as2.patterns.observer.*;

import balloonatroid.view.*;
import balloonatroid.*;

class balloonatroid.view.GameSprite extends Notifier
{
	
	// notification constants
	public static var DETECT_COLLISION:String  	= "collDetect";// a collision detect request
	
	// sprite types
	public static var BOSS:String 			= "boss" 		// a level boss
	public static var DEFENDER:String 		= "defender"	// a level defender
	public static var SHIELD:String 		= "shield"		// the user's shield balloon
	public static var VOLLEY:String 		= "volley"		// the user's volley balloon

	// values for inertia
	public static var BOUNCEY:Number 		= 0.7	// rapidly overshoot target and bounce back a few times
	public static var FLAT:Number 			= 1.0	// move direct to target.
	public static var EASE_IN:Number 		= 1.8	// approach target more slowly each frame

	// the MovieClip for this sprite
	public var clip:MovieClip;
	
	// Sprite type
	public var spriteType:String;
	
	// inertia must be >=.5 <=2, constants are defined for good values
	public var inertia:Number = FLAT;
	
	// If not active, no collision detect notifications are sent 
	// and mediator should ignore incoming notifications
	public var active:Boolean = true;

	// target toward which clip is moved
	public var targetX:Number;
	public var targetY:Number;

	// horizontal and vertical drift 
	public var driftX:Number = 0;
	public var driftY:Number = 0;
	
	// optionally constrain clip position to within given bounds
	public var hasBoundsX:Boolean = false;
	public var hasBoundsY:Boolean = false;
	public var lowerBoundX:Number;
	public var lowerBoundY:Number;
	public var upperBoundX:Number;
	public var upperBoundY:Number;

	public function GameSprite( clip:MovieClip, spriteType:String )
	{
		super();
		this.clip = clip;
		this.spriteType = spriteType;
		
		// initialize the target to the clip's current position
		clearTarget();
		
		// Place listeners on the movie clip
		clip.onEnterFrame = MovieClipDelegate.create( this, onEnterFrame );
	} 

	/**
	 * EnterFrame handler for clip
	 */
	private function onEnterFrame():Void 
	{
		// Move the sprite toward the target
		moveTowardTarget();
		
		// send collision detection notification
		sendNotification( DETECT_COLLISION, this, this.spriteType );
	}
		
	/**
	 * Hide the sprite
	 */
	public function hideSprite():Void
	{
		clip._visible = false;
	}
	
	/**
	 * Show the sprite
	 */
	public function showSprite():Void
	{
		clip._visible = true;
	}
	
	/**
	 * Set the target position for this sprite to its own position
	 */
	public function clearTarget():Void
	{
		setTarget( positionX, positionY );
	}
	
	/**
	 * Move the sprite toward the current target, applying
	 * drift, inertia and optionally bounds checking both axes
	 */
	private function moveTowardTarget():Void
	{
		// Apply drift to target
		applyDrift();

		// get distance
		var distX = targetX - positionX;
		var distY = targetY - positionY;
		
		// apply inertia
		var newX = Math.round( positionX + ( distX / inertia ) );
		var newY = Math.round( positionY + ( distY / inertia ) );
		
		// move with optional bounds checking in either direction
		positionX = ( hasBoundsX ) ? constrainX( newX ) : newX;
		positionY = ( hasBoundsY ) ? constrainY( newY ) : newY;
	}

	/**
	 * Determine if the hotspot of the target sprite has
	 * collided with this sprite.
	 */
	public function hitDetect( target:GameSprite ):Boolean
	{
		var collision:Boolean = clip.hitTest( target.hotSpotX, target.hotSpotY, true );
		if ( collision )
		{
			trace ( this.spriteName + " collided with hotspot ("+target.hotSpotX +", "+target.hotSpotY+") of " +target.spriteName);
		}
		return collision;
	}
	
	private function constrainX( newX:Number ):Number
	{
		// apply bounds check for X axis
		// ...
		return newX;
	}
	
	private function constrainY( newY:Number ):Number
	{
		// apply bounds check for Y axis
		// ...
		return newY;
	}

	/**
	 * Adjust the drift for the sprite
	 *
	 * @param offsetX the amount of offset for the x axis
	 * @param offsetY the amount of offset for the y axis
	 */
	public function adjustDrift( offsetX:Number, offsetY:Number ):Void
	{
		driftX += offsetX;
		driftY += offsetY;
	}

	/**
	 * Set the target position for the sprite
	 *
	 * @param newTargetX the new target for the x axis
	 * @param newTargetY the new target for the y axis
	 */
	public function setDrift( newTargetX:Number, newTargetY:Number ):Void
	{
		driftX = newTargetX;
		driftY = newTargetY;
	}

	/**
	 * Set the target position for the sprite
	 *
	 * @param newTargetX the new target for the x axis
	 * @param newTargetY the new target for the y axis
	 */
	public function applyDrift( ):Void
	{
		adjustTarget( driftX, driftY );
	}

	/**
	 * Adjust the target position for the sprite
	 *
	 * @param offsetX the amount of offset for the x axis
	 * @param offsetY the amount of offset for the y axis
	 */
	public function adjustTarget( offsetX:Number, offsetY:Number ):Void
	{
		targetX += offsetX;
		targetY += offsetY;
	}

	/**
	 * Set the target position for the sprite
	 *
	 * @param newTargetX the new target for the x axis
	 * @param newTargetY the new target for the y axis
	 */
	public function setTarget( newTargetX:Number, newTargetY:Number ):Void
	{
		targetX = newTargetX;
		targetY = newTargetY;
	}

	/**
	 * Adjust the target position for the sprite
	 *
	 * @param offsetX the amount of offset for the x axis
	 * @param offsetY the amount of offset for the y axis
	 */
	public function adjustPosition( offsetX:Number, offsetY:Number ):Void
	{
		positionX += offsetX;
		positionY += offsetY;
	}

	/**
	 * Set the target position for the sprite
	 *
	 * @param newPositionX the new target for the x axis
	 * @param newPositionY the new target for the y axis
	 */
	public function setPosition( newPositionX:Number, newPositionY:Number ):Void
	{
		positionX = newPositionX;
		positionY = newPositionY;
	}
	
	public function get hotSpotX():Number
	{
		return positionX + clip.hotspot._x;
	}
	
	public function get hotSpotY():Number
	{
		return positionY + clip.hotspot._y;
	}
	
	public function get positionX():Number
	{
		return clip._x;
	}
	
	public function get positionY():Number
	{
		return clip._y;
	}
	
	public function set positionX( newX:Number ):Void
	{
		clip._x = newX;
	}
	
	public function set positionY( newY:Number ):Void
	{
		clip._y = newY;
	}
	
	public function set spriteName( newName:String ):Void
	{
		clip._name = newName;
	}
	
	public function get spriteName( ):String
	{
		return clip._name;
	}
	
}