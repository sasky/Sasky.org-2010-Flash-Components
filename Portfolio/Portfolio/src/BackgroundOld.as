package  
{
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	/**
	 * ...
	 * hot pink 0xe42e8b
	 * 
	 * colours [ 0xf9f361 , ]
	 */
	public class BackgroundOld extends Sprite
	{
		
		public function BackgroundOld():void
		{
			setupBG();
			tempSquares(26.5 , 54 , 748.5 , 355, 0xffffff);
			tempSquares(26.5 , 415 , 748.5 , 235 , 0xf9f361);
		}
		
		private function setupBG():void
		{
			var l1:Loader = new Loader();
			l1.load( new URLRequest("assets/header.gif"));
			this.addChild(l1);
			var l2:Loader = new Loader();
			l2.load( new URLRequest("assets/tab.png"));
			this.addChild(l2); 
			l2.x = 565; l2.y = 13;
			
		}
		private function tempSquares(xPos:Number, yPos:Number , widthPos:Number , heightPos:Number , color:uint):void
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill(color);
			shape.graphics.drawRect(xPos, yPos , widthPos , heightPos);
			shape.graphics.endFill();
			this.addChild(shape);
		}
		
	}

}