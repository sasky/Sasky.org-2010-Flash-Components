package Model 
{
	import flash.net.NetConnection;
	import flash.net.Responder;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * ...
	 * @author sasky.org
	 */
	public class WorksProxy extends Proxy implements IProxy
	{
		private var _numTries:Number;
		public static const NAME:String = "worksProxy";
		public function WorksProxy() 
		{
			super(NAME);
			populateData();
		}
		
		private function populateData():void
		{
			
			var connection:NetConnection = new NetConnection();
			var retrieveResponder:Responder = new Responder(retrieveonResult, retrieveonFault);
			connection.connect(ApplicationFacade.gateway);
			
			connection.call("WorksService.retrieve", retrieveResponder);
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
			sendNotification(ApplicationFacade.WORKS_DB_LOADED_M, result, "Array");
		}
		
		
	
		
	}

}