/*
 PureMVC AS2 FlashLite Demo - Balloonatroid
 Copyright (c) 2007, 2008 by
 Cliff Hall <clifford.hall@puremvc.org> and 
 Chandima Cumaranatunge <chandima.cumaranatunge@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
class balloonatroid.model.GameStateVO
{
	// valid states of the game
	public static var SPLASH:String 		= 'splash'; // splash screen
	public static var TRANSITION:String 	= 'trans';	// transistion between splash and play
	public static var PLAY:String 			= 'play';	// game play, prepared to volley
	public static var VOLLEY:String 		= 'volley';	// balloon has been vollied
	public static var CHOOSE:String 		= 'choose';	// level chooser

	// game elements
	public static var GAME_WIDTH:Number 	= 240;	// width of playfield
	public static var GAME_HEIGHT:Number 	= 320;	// height of playfield
	public static var VOLLEY_WIDTH:Number 	= 38;	// width of volley balloon
	public static var AIM_AMOUNT:Number 	= 50;	// amount to move when aiming
	public static var STEER_AMOUNT:Number 	= 5;	// amount to move when steering

	public function GameStateVO ( )
	{
	} 
	
	public var current:String = SPLASH;
	public var score:Number = 0;
	public var level:Number = 13;
	
	public function get gameFile():String
	{
		return 'Level'+level+".swf";
	}
}