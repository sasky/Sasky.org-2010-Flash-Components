package  
{
	import Box2D.Dynamics.b2Body;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	
	
	
	
	/**
	 * ...
	 * @author 
	 */
	public class Actor extends EventDispatcher
	{
		protected var _body:b2Body;
		protected var _costume:Sprite;
		
		public function Actor(myBody:b2Body, myCostume:Sprite)
		{
			_body = myBody ; _costume = myCostume;
			_body.SetUserData(this);
			updateMyLook();
		}
		public function updateNow():void
		{
			updateMyLook();
			childSpecificUpdating();
		}
		
		public function destroy():void
		{
			//1. Remove Event Listeners
			cleanUpBeforeRemoving();
			//2. Remove the custume sprite
			_costume.parent.removeChild(_costume);
			//3. Destory the body
			PhysiVals.world.DestroyBody(_body);
			
			
		}
		
		protected function cleanUpBeforeRemoving():void
		{
			// Abstract function
			// overiden by my children
		}
		
		protected function childSpecificUpdating():void
		{
			//this function does nothing
			// I expect it to be called by my children
		}
		
		
		private function updateMyLook():void
		{
			_costume.x = _body.GetPosition().x * PhysiVals.RATIO;
			_costume.y = _body.GetPosition().y * PhysiVals.RATIO;
			_costume.rotation = _body.GetAngle() * 180 / Math.PI;
		}
		
	}
	
}