package  
{
	
	import classes.circlePulseControl;
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import com.greensock.TweenMax;
	import flash.ui.ContextMenu;

	import flash.display.MovieClip;
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.BlendMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	

	import flash.filters.ShaderFilter;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import com.leebrimelow.utils.Math2;
	
	
	
	public class Main extends Sprite
	{
		private var _shader:Shader;
		private var _urlLoader:URLLoader;
		private var _f:ShaderFilter;
		private var _c:circlePulseControl;
		private var bounds:Rectangle;
		private var _shapes:Array ;
		private var _blendModes:Array ;
		private var _tweens:Array;
		private var _interacting:Boolean = false;
		public function Main() 
		{
			var Menu:ContextMenu = new ContextMenu();
			Menu.hideBuiltInItems();
			this.contextMenu = Menu;
			
			_shapes = [];
			_blendModes = [   BlendMode.DARKEN , BlendMode.DIFFERENCE ,  
						   BlendMode.HARDLIGHT , BlendMode.INVERT   , BlendMode.MULTIPLY,
						     BlendMode.SUBTRACT];
			this.addEventListener(Event.ADDED_TO_STAGE , onadded);
			_c = new circlePulseControl("swf/circlePulse.pbj", bg);
			
		}
		
		private function onadded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onadded);
			
			stage.addEventListener(Event.MOUSE_LEAVE , onMouseLeave);
			stage.addEventListener(MouseEvent.MOUSE_MOVE , onMouseMove);
			
		}
		
		
				
		private function onMouseLeave(e:Event):void 
		{
			if (_interacting) 
			{
				// Pause Everthing, memory clean up
				
				for each (var t:TweenMax in _tweens)
				{
					t.pause();
					
				}
				
				this.removeEventListener(Event.ENTER_FRAME , onef);
				_c.stop();
				_interacting = false;
			}
		}
				
		private function onMouseMove(e:MouseEvent):void 
		{
			if (!_interacting)
			{
				// resume everything
				if (_tweens == null)
				{
					textLines();
				} else {
					for each (var t:TweenMax in _tweens)
					{
						t.resume();
					}
				}
					
				
				this.addEventListener(Event.ENTER_FRAME , onef);
				_c.start();
				_interacting = true;	
			}
		}

		private  function rand(min:Number,max:Number):int 
		{
			var r:int = Math.floor(Math.random() * (max - min) + min);
			return r;
		}

		
		private function textLines():void
		{
			bounds = new Rectangle(8, 34, 574, 150);
			var lines:Sprite = new Sprite();
			this.addChild(lines);
			lines.cacheAsBitmap = true;
			t.cacheAsBitmap = true;
			lines.mask = t;
			_tweens = [];
			
			for (var i:int = 0; i < 20 ; i++)
			{
				var s:Shape = new Shape();
				var xx:Number = rand(bounds.left/2, bounds.right/2);
				s.graphics.beginFill( 247 << 16 | 0 << rand(0,150) | rand(111, 255),0.9);
				s.graphics.drawRect(xx, bounds.top, rand(5,200), bounds.height);
				s.graphics.endFill();
				_shapes.push(s);
				lines.addChild(s);
				var twn:TweenMax = new TweenMax(s, rand(1, 10) , { x:rand( -200, 300), ease:Back.easeIn ,repeat:-1 ,  yoyo:true} );
				twn.play();
				_tweens.push(twn);
			}
			lines.buttonMode = true;
			t.buttonMode = true;
			t.addEventListener(MouseEvent.CLICK , onClick);
			lines.addEventListener(MouseEvent.CLICK , onClick);
		
		}
		
		private var x_offset:Number = 689.95 ;//+ face.leftEye.width/2;
		private var ratioY:Number = (200) / (16.20 - -1.30);
		
		private function onef(e:Event):void 
		{
			// left eye
			if (stage.mouseX >= 548 && stage.mouseX <= 698.95)
			{
				var r:Number = (face.leftEye.x  < 664.10)? (664.10 - 587) / ( -33.90 - -45.90) : (698.95 - 664.10) / ( -27.65 - -33.90);
				face.leftEye.x = ((stage.mouseX - x_offset) / r) -27.65;	
			}
			else if (stage.mouseX < 548){face.leftEye.x =-49.7 }
			else if (stage.mouseX > 698.95) { face.leftEye.x = -26.75 };
			face.leftEye.y = ((stage.mouseY ) / ratioY) ;
			// right eye
			if (stage.mouseX >= 689.95 && stage.mouseX <= 800)
			{
				var r2:Number =  (800 - 698.95 ) / (38 - 15);
				face.rightEye.x = ((stage.mouseX - x_offset) / r2) + 15;	
			}
			else if (stage.mouseX < 698.95){face.rightEye.x =15 }
			face.rightEye.y = ((stage.mouseY ) / ratioY) ;
		}
		
		private function onClick(e:MouseEvent):void 
		{
			var b:String = _blendModes[ rand(0, _blendModes.length - 1)];
			trace(b);
			for each ( var s:Shape in _shapes)
			{
				s.blendMode = b;
				
			}
		}
		
	

	
		
	}
	
}
