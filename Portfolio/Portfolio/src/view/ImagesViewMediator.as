package view 
{
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import view.ImagesView.LoadingView;
	import view.ImagesView.ShatterImageCollection;
	
	/**
	 * ...
	 * @author sasky.org
	 */
	public class ImagesViewMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "Images View Mediator";
		private var _loadingView:LoadingView;
		private var _shatImgColec:ShatterImageCollection;
		private var _imgStage:Sprite;
		public function ImagesViewMediator( viewComponent:Object = null) 
		{
			super(NAME, viewComponent);
		
			
		}
		override public function onRegister():void 
		{
			
			_imgStage = new Sprite();
			_imgStage.x = 26.5 ; 
			_imgStage.y = 54;
			//_imgStage.width = 748;
			//_imgStage.height = 355;
			var m:Shape = new Shape();
			m.graphics.beginFill(0xff0000);
			m.graphics.drawRect(26.5, 54, 747 , 350);
			m.graphics.endFill();
			m.cacheAsBitmap = true;
			Main(viewComponent).addChild(m); 
			Main(viewComponent).addChildAt(_imgStage, 0);
			_imgStage.mask = m;
			_loadingView = new LoadingView();
			_imgStage.addChild(_loadingView);
			
		}
	
		override public function listNotificationInterests():Array 
		{
			return [ ApplicationFacade.IMAGES_LOADING_C,
					ApplicationFacade.IMAGES_LOADED_C];
		}
		override public function handleNotification(notification:INotification):void 
		{
			var name:String = notification.getName();
			var body:Object = notification.getBody();
			switch(name)
			{
				case ApplicationFacade.IMAGES_LOADING_C:
					
					var p:int = body.p; 
					_loadingView.update(p); 
					
					break
				case ApplicationFacade.IMAGES_LOADED_C:
					
					if (_loadingView)
					{
						_loadingView.destory();
						_imgStage.removeChild(_loadingView);
						_loadingView = null;
					}
					_shatImgColec = new ShatterImageCollection(body as Array);
					_imgStage.addChild(_shatImgColec);
					_shatImgColec.addEventListener(ShatterImageCollection.IMAGE_SET_CHANGED, onImageSetChanged);
					_imgStage.width = 748;
					_imgStage.height = 355;		
					break
					
					//
					
				
			}
		}
		private function onImageSetChanged(e:DataEvent):void 
		{
			sendNotification(ApplicationMediator.NEXT_IMAGE_SET , e.data );
		}
		
	}

}