﻿/*
 PureMVC AS2 FlashLite Demo - Balloonatroid
 Copyright (c) 2007, 2008 by
 Cliff Hall <clifford.hall@puremvc.org> and 
 Chandima Cumaranatunge <chandima.cumaranatunge@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
import org.puremvc.as2.interfaces.ICommand;
import org.puremvc.as2.interfaces.INotification;
import org.puremvc.as2.patterns.command.SimpleCommand;

class balloonatroid.controller.QuitCommand 
extends SimpleCommand implements ICommand
{
	/**
	 * Quit the game
	 */
	public function execute( note:INotification ) : Void    
	{
		_root.txtStatus.text = "Quit"; // debug
		fscommand2("ResetSoftKeys");
		fscommand2("Quit");
	}
}
