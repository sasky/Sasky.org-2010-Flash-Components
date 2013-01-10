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
	
	
	public class circlePulseControl extends Sprite
	{
		
		private var _shader:Shader;
		private var _urlLoader:URLLoader;
		private var Freg:Number = 0;
		private var _v:Number = 0;
		private var _a:Number = 0.001;
		
		private var _displayObject:MovieClip;
		private var _f:ShaderFilter;
		private var inc:Number = 1.2;
		private var _loaded:Boolean = false;
		
		
		public function circlePulseControl(pb_to_load:String, displayObject:MovieClip) 
		{
			_displayObject = displayObject;
			_urlLoader = new URLLoader();
			_urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			_urlLoader.addEventListener(Event.COMPLETE , loaded);
			_urlLoader.load(new URLRequest(pb_to_load));
		}
		public function start():void
		{
			if (_loaded)
			{
				this.addEventListener(Event.ENTER_FRAME , onef);
				_v = 0;
			}
		}
		
		public function stop():void
		{
			if (_loaded)
			{
				this.removeEventListener(Event.ENTER_FRAME , onef);
			}
		}
		
		
		private function loaded(e:Event):void 
		{
			_urlLoader.removeEventListener(Event.COMPLETE , loaded);
			_shader = new Shader(ByteArray(_urlLoader.data));
			init();
			_loaded  = true;
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
			
			//var T:Timer = new Timer(1000 * 120);
			//T.addEventListener(TimerEvent.TIMER , onTimer);
			//T.start();
			//onTimer(null);
		
			
		}
		
		
		private function onef(e:Event):void 
		{
			
			_v += _a;
			Freg += _v;
			_shader.data.speed.value = [Freg];
			_displayObject.filters = [_f];
			//trace("ef called");
		}
		
		/*
		private function onTimer(e:TimerEvent):void 
		{
			gt = new GTweenTimeline();
			var t:GTween = new GTween(this , 10 , { Freg:2 + _incPlaceHolder} , Equations.easeInQuad );
			gt.addTween(0, t);
			t = new GTween(this , 20 , { Freg:15 + _incPlaceHolder} , Equations.easeOutQuad );
			gt.addTween(10, t);
			t = new GTween(this , 20 , { Freg:50 + _incPlaceHolder} , Equations.easeOutQuad );
			gt.addTween(30, t);
			t = new GTween(this , 10 , { Freg:55 + _incPlaceHolder} , Equations.easeOutExpo );
			gt.addTween(50, t);
			gt.calculateDuration();
			gt.autoPlay = true;
			gt.addEventListener(Event.CHANGE , onTchange);
			gt.addEventListener(Event.COMPLETE , onTcomplete);
		}
		
		private function onTcomplete(e:Event):void 
		{
			_incPlaceHolder = Freg;
			gt.removeEventListener(Event.CHANGE , onTchange);
			gt.removeEventListener(Event.COMPLETE , onTcomplete);
		}
		
		private function onTchange(e:Event):void 
		{
			_shader.data.speed.value = [Freg];
			_displayObject.filters = [_f];
		
		}
		*/
		
			
	}
	
}