package  view.ImagesView 
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	
	/**
	 * ...
	 * @author sasky.org
	 */
	public class LoadingView extends Sprite
	{
		
		
		private var _bmd:BitmapData;
		private var _stageWidth:Number = 748;
		private var _stageHeight:Number = 355;
		private var _tf:TextField;
		private var _bf:BlurFilter;
		private var _tfprogree:TextFormat;
		
		public function LoadingView() 
		{
			_bmd = new BitmapData(_stageWidth, _stageHeight, false, 0xe42e8b);
			this.addChild(new Bitmap(_bmd));
			_bf = new BlurFilter(2, 2, 1);
			
			_tf = new TextField();
			_tf.alpha = 1;
			_tf.scaleX = 3;
			_tf.scaleY = 2;
			_tfprogree = new TextFormat("dungeon", 100, 0x000000, true,null,null,null,null,TextFormatAlign.CENTER);
			_tf.defaultTextFormat =  _tfprogree;
			_tf.x =  210; _tf.y = 30;
			_tf.selectable = false;
			this.addChild(_tf);
			addEventListener(Event.ENTER_FRAME , onef,false,0,true);
		}
		
		private function onef(e:Event):void 
		{
			_bmd.draw(this);
			_bmd.applyFilter(_bmd, _bmd.rect, new Point(0, 0), _bf);
			
			if(_tf.visible) {_tf.visible = false}
		}
		
		
		
		
		
		public function destory():void
		{
			this.removeEventListener(Event.ENTER_FRAME , onef);
			this.removeChild(_tf);
			_tf = null;  _bmd = null;
		}
		
		public function update(progress:int):void
		{
			
			
			//if (progress % 10 == 5  && progress <= 100 )
			//{
				showTf(progress);
			//}
			
		}
		
		
		
		private function showTf(progress:int):void
		{
			
			_tf.visible = true;
			_tf.textColor = getGrey();
			//_tfprogree.color = getGrey();
			//_tf.setTextFormat(_tfprogree);
			_tf.text = String(progress);
			getGrey();
		}
		/*0xFF55F3.
		 *var color24:Number = 0xFF << 16 | 0x55 << 8 | 0xF3;
			Or, if you are working with decimal values, you could use this form:
			var color24:Number = 255 << 16 | 85 << 8 | 243; 
		 * 
		 * 
		*/
		//private var curentCol:Number = 0;
		private var inc:Number = 255 / 100;
		
		private function getGrey():uint
		{
			
			var col:Number =   inc << 16 | inc << 8 | inc; 
			inc++;
			return col
		}
	
	}

}