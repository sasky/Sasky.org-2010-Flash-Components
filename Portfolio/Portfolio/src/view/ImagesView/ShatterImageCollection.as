package   view.ImagesView 
{
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	import com.leebrimelow.utils.Math2;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import view.ImagesView.ImagesLoadedVO;
	
	
	/**
	 * ...
	 * @author sasky.org
	 */
	public class ShatterImageCollection extends Sprite
	{
		private var _worlds:Array;
		private var _images:Array;
		private var _ticking:Boolean = false;
		private var _currentImage:Bitmap;
		private var _mouseOverShape:Sprite;
		private var _mOCount:int = 0;
		
		public static const IMAGE_SET_CHANGED:String = "image set changed";
		
		
		public function ShatterImageCollection(images:Array) 
		{
			_images = images;
			//_images = sortImagesAry(images);
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			this.addEventListener(MouseEvent.CLICK , onClick);
			this.addEventListener(MouseEvent.ROLL_OVER , onRollOver,false,0,true);
			this.addEventListener(MouseEvent.ROLL_OUT , onRollOut,false,0,true);
			// set up first image
			_worlds = [];
			_currentImage = getNextImage();
			graphics.beginFill(0xE42E8B);
			graphics.drawRect(0, 0, 750, 360);
			graphics.endFill();
			buttonMode = true;
			this.addChild(_currentImage);
			createMouseOverShape();
		}
		
		private function createMouseOverShape():void 
		{
			//create the Mouse over shape
			_mouseOverShape = new Sprite();
			_mouseOverShape.graphics.beginFill(0x2fe4ff);
			_mouseOverShape.graphics.drawRect(0, 0, 200, 25);
			var t:TextField = new TextField();
			t.defaultTextFormat = new TextFormat("Corbel2", 18, 0xffffff);
			t.text = "CLICK FOR NEXT IMAGE";
			t.selectable = false;
			t.width = 200;
			t.embedFonts = true;
			
			t.x = 1; t.y = 1;
			_mouseOverShape.addChild(t);
			this.addChild(_mouseOverShape);
			_mouseOverShape.scaleX = 0;
			
			TweenLite.to(_mouseOverShape , 0.5 , {scaleX:1 ,ease:Elastic.easeIn } );
		}
		
		private function onRollOver(e:MouseEvent):void 
		{
			
			_mouseOverShape.visible = true;
			_mouseOverShape.x = mouseX - 100;
			_mouseOverShape.y = mouseY + 40;
			_mouseOverShape.startDrag();
		}
		
		private function onRollOut(e:MouseEvent):void 
		{
			trace("Roll out");
			if (_mouseOverShape)
			{
				_mouseOverShape.stopDrag();
				_mouseOverShape.visible = false;
			}
		}
		
		private function sortImagesAry(imagesAry:Array):Array
		{
			var a:Array = imagesAry;
			a.sort(sortImages);
			return a
		}
		private function sortImages(a:ImagesLoadedVO, b:ImagesLoadedVO):Number 
		{
			var aSet:int = a.worksId;
			var bSet:int = b.worksId;

			if (aSet > bSet) 
			{
				return 1;
			}
			else if (aSet < bSet) 
			{
				return -1;
			} 
			else  
			{
				//aSet == bSet
				return 0;
			}
		}
		
		private function onClick(e:MouseEvent):void 
		{
			if (_worlds.length < 8)
			{
				this.removeChild(_currentImage);
				_worlds.push(createWorld(_currentImage));
				_currentImage = getNextImage();
				
				this.addChildAt(_currentImage,0);
				if (!_ticking)
				{
					this.addEventListener(Event.ENTER_FRAME , onef, false,0,true);
				}
			}
			
			if (_mOCount < 2 )
			{
				_mOCount ++;
			} 
			if (_mOCount == 2 )
			{
				TweenLite.to(_mouseOverShape , 0.8 , { scaleX:0 , ease:Elastic.easeOut , onComplete:destoryMO } );
				_mOCount = 3;
			}
			
		}
		
		private function destoryMO():void 
		{
			this.removeChild(_mouseOverShape);
			_mouseOverShape = null;
			this.removeEventListener(MouseEvent.ROLL_OVER , onRollOver);
			this.removeEventListener(MouseEvent.ROLL_OUT , onRollOut);
		}
		
		private function createWorld(image:Bitmap):box2dFacade
		{
			//tempSquares(26.5 , 54 , 748.5 , 355, 0xffffff);
			var world:box2dFacade = new box2dFacade(new Point(0, 9.8), 30, 748, 355, this);
			setupImageForWorld(world, image);
			world.MouseExplode(this.mouseX , this.mouseY);
			return world;
		}
		
		private var imageCount:int = 0;
		private var lastImageSet:int;
		private function getNextImage():Bitmap
		{
			var i:Bitmap;
			//TODO dispatch event when a new set is added
			if ( imageCount < _images.length )
			{
				dispatchEventIfDif(ImagesLoadedVO(_images[imageCount]).worksId);
				i = ImagesLoadedVO(_images[imageCount]).image;
				lastImageSet = ImagesLoadedVO(_images[imageCount]).worksId;
				imageCount++;
			} else {
				dispatchEventIfDif(ImagesLoadedVO(_images[0]).worksId);
				i = ImagesLoadedVO(_images[0]).image;
				lastImageSet = ImagesLoadedVO(_images[0]).worksId;
				imageCount = 1;
			}
			return i
		}
		
		private function dispatchEventIfDif(thisImageSet:int):void
		{
			if (lastImageSet)
			{
				if (thisImageSet != lastImageSet)
				{
					//trace(thisImageSet);
					dispatchEvent(new DataEvent(IMAGE_SET_CHANGED,true, false,thisImageSet.toString()));
				}
			}
		}
		
		private function setupImageForWorld(world:box2dFacade,image:Bitmap,divideX:Number = 10,divideY:Number = 6,imageWidth:Number = 749 , imageHeight:Number = 355):void
		{
			var gapx:Number = imageWidth / divideX,
				gapy:Number = imageHeight / divideY,
				xOffset:Number = gapx /2,
				yOffset:Number = gapy / 2,
				rect:Rectangle = new Rectangle(xOffset, yOffset, imageWidth, imageHeight),
				localRect:Rectangle = new Rectangle(),
				p:Point = new Point(0, 0),
				m:Matrix = new Matrix();
				
			m.translate(-gapx / 2, -gapy / 2);
			
			for ( var Ypos:Number = rect.top ; Ypos < rect.bottom ; Ypos += gapy)
			{
				for ( var Xpos:Number = rect.left ; Xpos < rect.right ; Xpos += gapx)
				{
					var bmd:BitmapData = new BitmapData(gapx,gapy),
					s:Sprite = new Sprite();
					localRect.x = Xpos - xOffset;
					localRect.y = Ypos - yOffset;
					localRect.width = gapx * 2;
					localRect.height = gapy * 2;
					bmd.copyPixels(image.bitmapData, localRect , p);
					s.graphics.beginBitmapFill(bmd,m,false, true);
					s.graphics.drawRect( -gapx / 2, -gapy / 2 , gapx, gapy );
					s.graphics.endFill();
					s.x = Xpos;
					s.y = Ypos;
					addChildAt(s,0);
					world.addBox(s, 2, 0.5, 1);
					
				}
			}
		
			var ls:Sprite = new Sprite();
			ls.graphics.beginFill(0xff0000);
			ls.graphics.drawRect( -20 / 2, -400 / 2, 2, 400);
			ls.graphics.endFill();
			ls.x = -100;
			ls.y = 355 / 2;
			ls.name = "ls";
			this.addChildAt(ls,0);
			world.addStaticBox(ls,0.5,1);
			var Rs:Sprite = new Sprite();
			Rs.graphics.beginFill(0xff0000);
			Rs.graphics.drawRect( -20 / 2, -400 / 2, 2, 400);
			Rs.graphics.endFill();
			Rs.x = 859;
			Rs.y = 355 / 2;
			Rs.name = "Rs"
			addChildAt(Rs,0);
			world.addStaticBox(Rs,0.5,1);
		}
		
		private function onef(e:Event):void 
		{
			if (_worlds.length == 0)
			{
				this.removeEventListener(Event.ENTER_FRAME , onef);
			} else {
				for each(var world:box2dFacade in _worlds)
				{
					world.b2Step();
					if (world.markToDestory)
					{
						var indx:int = _worlds.indexOf(world);
						if (indx > -1)
						{
							_worlds.splice(indx, 1);
						}
					}
				}
				
			}
			
		}
		
		
		
	}

}
