package controller 
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import flash.display.Bitmap;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import Model.VO.ImagesVO;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import view.ImagesView.ImagesLoadedVO;
	
	/**
	 * ...
	 * @author sasky.org
	 */
	public class LoadImagesCommand extends SimpleCommand implements ICommand
	{
		private var _bl:BulkLoader;
		private var _images:Array;
		/* INTERFACE org.puremvc.as3.interfaces.ICommand */
		
		override public function execute(notification:INotification):void
		{
			_bl = new BulkLoader("bl");
			_images = notification.getBody() as Array;
			for each(var imageV0:Object in _images)
			{
				_bl.add(imageV0.url);
			}
			_bl.addEventListener(BulkProgressEvent.PROGRESS, onProgress);
			_bl.addEventListener(BulkProgressEvent.COMPLETE , onComplete);
			_bl.start();
			//var t:Timer = new Timer(100, 100);
			//t.addEventListener(TimerEvent.TIMER, ont);
			//t.start();
		}
		/*
		private var count:int = 0
		private function ont(e:TimerEvent):void 
		{
			var percent:int = Math.ceil(count++);
			var o:Object = {p:percent}
			sendNotification(ApplicationFacade.IMAGES_LOADING_C , o );
			
		}
		*/
		
		
		private function onProgress(e:BulkProgressEvent):void 
		{
			var percent:int = Math.ceil((e.bytesLoaded / e.bytesTotal) * 100);
			var o:Object = {p:percent}
			sendNotification(ApplicationFacade.IMAGES_LOADING_C , o );
		}
		
		private function onComplete(e:BulkProgressEvent):void 
		{
			var imagesLoaded:Array = [];
			for each(var imageV0:Object in _images)
			{
				imagesLoaded.push(new ImagesLoadedVO(Bitmap(_bl.getBitmap(imageV0.url)), imageV0.works_id));
			}
			sendNotification(ApplicationFacade.IMAGES_LOADED_C , imagesLoaded , "Array");
			_bl.removeEventListener(BulkProgressEvent.COMPLETE , onComplete);
			_bl.removeEventListener(BulkProgressEvent.PROGRESS, onProgress);
			_bl.clear();
		}
		
	}

}