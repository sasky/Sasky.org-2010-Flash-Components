package view.ImagesView 
{
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author sasky.org
	 */
	public class ImagesView extends Sprite
	{
		private var _state:String;
		public static const PROGRESS_STATE:String = "progress state";
		public static const READY_STATE:String = "readystate";
		public static const NEW_SET:String = "new set";
		
		public function ImagesView(state:String) 
		{
			testSquare();
		}
		
		private function testSquare():void
		{
			var testSquare =  (tempSquares(26.5 , 54 , 748.5 , 355, 0xffffff);
			this.addChild( testSquare );
			this.addEventListener(MouseEvent.CLICK , onClick, false , 0 , true);
			
			
		}
		private var num:int = 1;
		private function onClick(e:MouseEvent):void 
		{
			
			if ( Math.floor(Math.round * 10) == 5)
			{
				this.dispatchEvent(new DataEvent(NEW_SET , false , false , num as String);
				num == 6? num = 1 : num++;
				
			}
		}
		private function tempSquares(xPos:Number, yPos:Number , widthPos:Number , heightPos:Number , color:uint):Sprite
		{
			var shape:Sprite = new Sprite();
			shape.graphics.beginFill(color);
			shape.graphics.drawRect(xPos, yPos , widthPos , heightPos);
			shape.graphics.endFill();
			return Sprite
		}
		
		}
		public function pogressViewupdate(progress:int):void
		{
			
		}
		public function ChangeToImagesState(ImagesObj:Object):void
		{
			
		}
		
	}

}