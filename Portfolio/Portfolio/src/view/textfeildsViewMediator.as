package view 
{
	import flash.display.Sprite;
	
	import Model.WorksProxy;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.textfeilds.TextFeildsView;
	
	/**
	 * ...
	 * @author sasky.org
	 */
	public class textfeildsViewMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "text feilds View Mediator";
		
		private var _textFeildView:TextFeildsView;
		private var _textObjs:Array;
		
		public function textfeildsViewMediator( viewComponent:Object = null) 
		{
			super(NAME, viewComponent);
		}
		override public function onRegister():void 
		{
			var p:WorksProxy = WorksProxy(facade.retrieveProxy(WorksProxy.NAME));
			_textObjs = p.getData() as Array 
			
			
			
		}
		
		private function getOb(id:int):Object
		{
			var worksobj:Object;
			for each (var works:Object in _textObjs)
			{
				if (works.id == id)
				{
					worksobj = works;
					break
				}
			}
			return worksobj;
		}
		override public function listNotificationInterests():Array 
		{
			return [ ApplicationMediator.NEXT_IMAGE_SET,
					ApplicationFacade.IMAGES_LOADED_C]
		}
		override public function handleNotification(notification:INotification):void 
		{
			var name:String  = notification.getName(), body:Object = notification.getBody();
			switch(name)
			{
				case ApplicationFacade.IMAGES_LOADED_C :
				
					_textFeildView = new TextFeildsView();
					Main(viewComponent).addChild(_textFeildView);
					_textFeildView.changeText(getOb(1));
				
				break
					
				case ApplicationMediator.NEXT_IMAGE_SET :
				
					 _textFeildView.changeText(getOb(int(body)));
					 
				break
			}
		}

		
	}

}