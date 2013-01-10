package classes 
{
	import com.gskinner.motion.GTween;
	import com.gskinner.motion.GTweenTimeline;
	import com.gskinner.motion.Equations;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.filters.ShaderFilter;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	
	//public class circlePulseControl extends Sprite
	{
		
		private var _shader:Shader;
		private var _urlLoader:URLLoader;
		public var Freg:Number = 0;
		private var _tl:GTweenTimeline;
		private var _displayObject:MovieClip;
		private var _f:ShaderFilter;
		//public function circlePulseControl(pb_to_load:String, displayObject:MovieClip) 
		{
			_displayObject = displayObject;
			_urlLoader = new URLLoader();
			_urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			_urlLoader.addEventListener(Event.COMPLETE , loaded);
			_urlLoader.load(new URLRequest(pb_to_load));
		}
		
		private function loaded(e:Event):void 
		{
			_urlLoader.removeEventListener(Event.COMPLETE , loaded);
			_shader = new Shader(ByteArray(_urlLoader.data));
			
			
			init();
		}
		
		private function init():void
		{
			
			_shader.data.center.value = [0.95, 0.56];
			_shader.data.frequency.value = [120];
			_shader.data.progress.value = [0.68];
			_shader.data.rect.value = [850,400];
			_shader.data.speed.value = [0];
			
			_f = new ShaderFilter(_shader);
			
			_displayObject.filters = [_f];
			
			_tl = new GTweenTimeline();
			_tl.autoPlay = false;
			_tl.addTween(0 , new GTween(this , 1 , { Freg:0.68 }, Equations.easeInBack));
			_tl.addTween(8 , new GTween(this , 1 , { Freg:0 }, Equations.easeOutBack));
			_tl.calculateDuration();
			_tl.addEventListener(Event.COMPLETE , onTComplete);
			_tl.addEventListener(Event.CHANGE , onTChange);
			
			var T:Timer = new Timer(10000);
			T.addEventListener(TimerEvent.TIMER , onTimer);
			T.start();
			
			
			
		}
		
		
		
		private function onTimer(e:TimerEvent):void 
		{
			this.addEventListener(Event.ENTER_FRAME , onef);
			
			_tl.gotoAndPlay(0);
			
			
			
		}
		
		private function onTChange(e:Event):void 
		{
			trace(Freg);
			_shader.data.progress.value = [Freg];
			_displayObject.filters = [_f];
		}
		
		private function onTComplete(e:Event):void 
		{
			this.removeEventListener(Event.ENTER_FRAME , onef);
		}
		private var inc:Number = 0;
		
		private function onef(e:Event):void 
		{
			inc += 0.1;
			_shader.data.speed.value = [inc];
			_displayObject.filters = [_f];
		}
			
	}
	
}