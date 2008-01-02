----------------------------------------------------------------------------
Package Space
----------------------------------------------------------------------------
Note that the ordinary package scheme that should be applied to this demo is 
org.puremvc.as2.demos.flashlite.balloonatroid.*

However the long pathname can cause some Flash CS3 installations to have 
difficulty building the ASO files. The file name must be less than 255
characters. For instance on my machine, I had the following filename
which is 262 characters:

C:\Documents and Settings\Owner.CapricornOne\Local Settings\Application Data\Adobe\Flash CS3\en\Configuration\Classes\aso\org\puremvc\as2\demos\flashlite\balloonatroid\controller\org.puremvc.as2.demos.flashlite.balloonatroid.controller.RegisterSpriteCommand.aso

And this caused the Flash compiler to crash, prompting me to shorten the
filename. I tried to find a way to make Flash store its ASO files somewhere
else, but was unable to. So, the package space for the demo is now shortened:

balloonatroid.*

----------------------------------------------------------------------------
Workaround for Poor Clip to Mediator Communications
----------------------------------------------------------------------------
Sadly with FlashLite 2.0, Events are poorly supported. Only the built in
events as far as I can tell. So I have the temporary expedient of having
various clips getting the GameFacade and calling a method on it. 

his is just not the right way to do it, and when I converted the package space 
over some things began acting weirdly. That's because some movie clips were 
importing and using the GameFacade. 

So we need a way for these clips to communicate with their Mediators even if 
the mediator sets a reference to itself onto the clip. 

Notably to be fixed:
 * The ShieldTrack MC on the Shield layer of Balloonatroid.fla has code
   on frame 60 that gets the GameFacade, entering gameplay when it reaches 
   the end of its track. (when the shield transitions to the top of the 
   screen and before it pops out on the bottom.)
   
 * The VolleyTrack MC on the Volley Balloon layer has code at the end that
   does the same thing. 
   
 * The button labels (Quit, <<, Volley, >>, Play) have on(keyPress) code that
   gets the Facade and calls a method to send notification.
  
I hated having to do it that way, but just hadn't found a better answer to
refactor to. Short of having custom named events that we can listen for, I 
think the clips need to extend something that can send notifications perhaps. 

Or have a Notifier instance attached that it uses.

You might want to talk with Pedr Browne, the AS2 project owner. He's really
getting a lot of good experience, but I don't know if it extends to this 
problem with FlashLite 2.0.

-=Cliff>

----------------------------------------------------------------------------
AS2 Classpath in Flash CS3
----------------------------------------------------------------------------
The PureMVC AS2 classes can be downloaded from from the SVN Repository: 

http://svn.puremvc.org/PureMVC_AS2

The AS2 classpath in Flash needs to include the PureMVC AS2 classes.
Set the AS2 classpath as documented in livedocs:

http://livedocs.adobe.com/flash/9.0/UsingFlash/WS3e7c64e37a1d85e1e229110db38dec34-7fa2.html