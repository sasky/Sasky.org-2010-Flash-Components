package view 
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import view.ImagesView.WaitingforBD;
	
	/**
	 * ...
	 * @author sasky.org
	 */
	public class ApplicationMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ApplicationMediator";
		// View Notifications 
		public static const NEXT_IMAGE_SET:String = "next image set";
		private var _bd:WaitingforBD;
		
		public function ApplicationMediator(viewComponent:Object = null) 
		{
			super(NAME, viewComponent);
			
		}
		override public function onRegister():void
		{
			waaitngforDB(true);
		}
		
		private function waaitngforDB(active:Boolean):void 
		{
			if(!_bd){_bd = new WaitingforBD};
			if (active)
			{
				Main(viewComponent).addChild(_bd);
			} else {
				_bd.destroy();
				Main(viewComponent).removeChild(_bd);
			}
			
		}
		override public function listNotificationInterests():Array 
		{
			return [
				ApplicationFacade.WORKS_DB_LOADED_M,
				ApplicationFacade.IMAGES_DB_LOADED_M
			];
		}
		override public function handleNotification(notification:INotification):void 
		{
			var name:String = notification.getName();  
            var body:Object = notification.getBody();  
			
			switch (name)
			{
				case ApplicationFacade.WORKS_DB_LOADED_M :
					
					loadViews();
					break
				
				case ApplicationFacade.IMAGES_DB_LOADED_M :
					
					loadViews();
					break
			}
			
		}
		private var i:int = 0;
		
		// will load the views once both Images and Works DB's are loaded
		private function loadViews():void
		{
			i++;
			if ( i >= 2)
			{
				waaitngforDB(false);
				facade.registerMediator( new textfeildsViewMediator(viewComponent));
				facade.registerMediator( new ImagesViewMediator(viewComponent));
				
				
			}
				
		}
		
	
		
	
		
	}

}