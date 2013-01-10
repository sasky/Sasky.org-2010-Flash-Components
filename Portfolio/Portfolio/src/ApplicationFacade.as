package  
{
	import controller.StartupCommand;
	import controller.LoadImagesCommand;
	import flash.display.Sprite;
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	import org.puremvc.as3.patterns.observer.Notification;
	
	/**
	 * ...
	 * @author 
	 */
	public class ApplicationFacade extends Facade implements IFacade
	{
		// Notifications
		public static const WORKS_DB_LOADED_M:String = "works database loaded model";
		public static const IMAGES_DB_LOADED_M:String = "images database loaded model";
		public static const IMAGES_LOADING_C:String = "Images loading";
		public static const IMAGES_LOADED_C:String = "Images Loaded";
		// public vars
		public static const NAME:String =  "ApplicationFacade ";
		public static const STAGE_WIDTH:Number = 800;
		public static const STAGE_HEIGHT:Number = 720;
		// CHANGE THIS WHEN PUBLISHING
		//public static var gateway:String = "http://localhost/Projects/splashpage/stage%203/Portfolio/Portfolio/bin/gateway.php";
		public static var gateway:String = "../gateway.php";
		// commands 
		public static const STARTUP:String = NAME + "Startup";
		public static const LOAD_IMAGES:String = "Load Images Command";
		
		public static function getInstance():ApplicationFacade 
		{
			return(instance ? instance : new ApplicationFacade()) as ApplicationFacade;
			//return(instance ? instance : new ApplicationFacade()) as ApplicationFacade;
		}
		override protected function initializeController():void 
		{
			super.initializeController();
			registerCommand( STARTUP , StartupCommand );
			registerCommand( LOAD_IMAGES , LoadImagesCommand);
		}
		public function startup(stage:Sprite):void
		{
			sendNotification( STARTUP , stage);
		}
		override public function sendNotification(notificationName:String, body:Object=null, type:String=null):void  
        {  
            trace( notificationName );  
  
            notifyObservers( new Notification( notificationName, body, type ) );  
        } 
		
		
		
	}

}