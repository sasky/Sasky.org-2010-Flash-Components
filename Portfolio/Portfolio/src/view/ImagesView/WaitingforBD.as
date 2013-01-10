package view.ImagesView 
{
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author sasky
	 */
	public class WaitingforBD extends Sprite 
	{
		private var _coords:Array;
		private var _tf:TextField;
		private var _cirs:Array;
		private var _timer:Timer;
		public function WaitingforBD() 
		{
			_coords = populateCoords();
			_tf = text();
			_cirs = createCircs();
			_timer = new Timer(100);
			_timer.addEventListener(TimerEvent.TIMER , tick);
			_timer.start();
			
		}
		
		
		
		private function createCircs():Array
		{
			var Tcircs:Array = [];
			for each (var p:Point in _coords)
			{
				//ouline
				var ol:Shape = new Shape();
				ol.graphics.lineStyle(1, 0xffffff);
				ol.graphics.drawCircle(p.x , p.y , 16);
				ol.graphics.endFill();
				this.addChild(ol);
				//
				var c:Shape = new Shape();
				c.graphics.beginFill(0x000000);
				c.graphics.drawCircle(p.x , p.y , 13);
				c.graphics.endFill();
				c.alpha = 0;
				this.addChild(c);
				Tcircs.push(c);
				trace(p.x);
			}
			return Tcircs;
		}
		public function destroy():void
		{
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER , tick);
			_timer = null;
			while (numChildren > 0)
			{
				removeChildAt(numChildren - 1);
			}
			
		}
		
		private function text():TextField
		{
			var t:TextField = new TextField();
			t.defaultTextFormat = new TextFormat("Corbel2", 18, 0x000000);
			t.text = "GATHERING INFORMATION ";
			t.selectable = false;
			t.width = 300;
			t.embedFonts = true;
			t.x = ApplicationFacade.STAGE_WIDTH / 2 - 110;
			t.y = ApplicationFacade.STAGE_HEIGHT / 2 - 50;
			this.addChild(t);
			return t
			
		}
		
		private function populateCoords():Array 
		{
			var inc:Number = 60; 
			var xpos:Number = ApplicationFacade.STAGE_WIDTH / 2 - (inc * 4);
			trace("xpos " + ApplicationFacade.STAGE_WIDTH );
			
			var a:Array = [];
			for (var i:int = 0 ; i < 9 ; i++)
			{
				a.push(new Point(xpos, 370));
				xpos += inc;
			}
			return a
		}
		private var cur:Shape;
		private var sec:Shape;
		private var thr:Shape;
		private var foth:Shape;
		private var place:int = 0;
		private var forward:Boolean;
		private function tick(e:TimerEvent):void 
		{
			for each (var s:Shape in _cirs)
			{
				s.alpha = 0
			}
			if (thr != null) 
			{
				foth = thr;
				foth.alpha = 0.3;
			}
			if (sec != null) 
			{
				thr = sec;
				thr.alpha = 0.5;
			}
			if (cur != null) 
			{
				sec = cur;
				sec.alpha = 0.8;
			}
			
			
			
			
			if (place >= _cirs.length-1)
			{
				forward = false;
			} else if (place <= 0) 
			{
				forward = true;
			}
			forward ? place++ : place--;
			trace(place);
			cur = _cirs[place];
			cur.alpha = 1;
		}
		
	}

}