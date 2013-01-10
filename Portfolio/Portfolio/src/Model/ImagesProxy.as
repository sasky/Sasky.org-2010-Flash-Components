package Model 
{
	
	import flash.net.NetConnection;
	import flash.net.Responder;
	import Model.VO.ImagesVO;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * ...
	 * @author sasky.org
	 */
	public class ImagesProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "Images PRoxy";
		private var _numTries:int = 0;
		
		public function ImagesProxy() 
		{
			super(NAME);
			populateData();
			
		}
		private function populateData():void
		{
			
			var connection:NetConnection = new NetConnection();
			var retrieveResponder:Responder = new Responder(retrieveonResult, retrieveonFault);
			connection.connect(ApplicationFacade.gateway);
			
			connection.call("ImagesService.retrieve", retrieveResponder);
			
		}
		
		private function retrieveonFault(result:Object):void
		{
			if (_numTries < 10)
			{
				populateData();
				_numTries++;
			}
		}
		
		private function retrieveonResult(result:Object):void 
		{
			
			data = result;
			sendNotification(ApplicationFacade.IMAGES_DB_LOADED_M);
			sendNotification(ApplicationFacade.LOAD_IMAGES, data);
		}
		
	
		

	}

}