package  view.ImagesView 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	import org.sasky.box2d.Actors.Actor;
	import org.sasky.box2d.Actors.MovingBoxActor;
	import org.sasky.box2d.Actors.StaticBoxActor;
	import org.sasky.box2d.saskysBox2dFacade;
	import org.sasky.box2d.special.ExplodingMouseClick;
	
	/**
	 * ...
	 * @author sasky.org
	 */
	public class box2dFacade extends saskysBox2dFacade
	{
		
		private var _expMouseClick:ExplodingMouseClick;
		
		public function box2dFacade(gravity:Point, frameRate:Number, StageWidth:Number, StageHeight:Number, parent:DisplayObjectContainer) 
		{
			super(gravity, frameRate, StageWidth, StageHeight, parent);
			
		}
		private var destryedOnce:Boolean = false;
		private var counter:Number = 0;
		override protected function onRender():void 
		{
			//trace("_movingActors.length " + _movingActors.length );
			//trace("_allActors.length " + _allActors.length);
			if (!destryedOnce)
			{
				if (_movingActors.length == 0 )
				{
					for each(var a:Actor in _allActors)
					{
						a.destroy();
					}
					//trace("destroy from length");
					destoryAllRefs();
					destryedOnce = true;
					_markToDestory = true;
				}
			}
			counter += 1 / _frameRate;
			//trace(counter);
			if (!destryedOnce)
			{
				if (counter >= 6 )
				{
					//trace("destroy from counter");
					for each(var a2:Actor in _allActors)
					{
						a2.destroy();
					}
					destoryAllRefs();
					destryedOnce = true;
					_markToDestory = true;
				}
			}
			
			
		}
		override protected function destoryAllRefs():void 
		{
			_expMouseClick = null;
			super.destoryAllRefs();
		}
	
		public function addBox(boxSprite:Sprite,density:Number = 1, friction:Number = 0.3, restitution:Number = 0.3):void
		{
			var mba:MovingBoxActor = new MovingBoxActor(boxSprite, density, friction, restitution,this)
			_allActors.push( mba);
			_movingActors.push(mba);
		}
		public function addStaticBox(boxSprite:Sprite , friction:Number = 0.3, restitution:Number = 0.3):void
		{
			
			var wall:StaticBoxActor = new StaticBoxActor(boxSprite, friction, restitution,this);
			_allActors.push(wall);
		}
	
		public function MouseExplode(x:Number, y:Number):void
		{
			if (_expMouseClick == null)
			{
				_expMouseClick = new ExplodingMouseClick(this);
				_expMouseClick.explode(x, y);
			}
			
		}
		
	}

}