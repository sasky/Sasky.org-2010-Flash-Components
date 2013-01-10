package  
{
	import Box2D.Collision.b2AABB;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite
	{
		private var _actors:Array;
		private var _actorsToRemove:Array;
		private var _triggerActors:Array;
		private var _gravity:b2Vec2
		private var _ratio:Number;
		private var _interacting:Boolean;
		private var _mouseball:MouseBall;
		private var _flip:Boolean = false;
		private var _engine:Timer;
		import flash.ui.ContextMenu;
		
		
		public function Main() 
		{
			init();
			//1 Set up World
			world();
			//2 Set Up Objects
			objects();
			//3 Interact with objects
			interact();
			// update
			this.addEventListener(Event.ENTER_FRAME , onef);
		}
		

		private function init():void
		{
			 var Menu:ContextMenu = new ContextMenu();
			Menu.hideBuiltInItems();
			this.contextMenu = Menu;
			
			_actors = []; _actorsToRemove = []; _triggerActors = [];
			_gravity = new b2Vec2(0 , 3.6);
			_ratio = PhysiVals.RATIO;
		}
		
		private function world():void
		{
			var worldBounds:b2AABB = new b2AABB();
			worldBounds.lowerBound.Set( -5000 / _ratio , -5000 / _ratio);
			worldBounds.upperBound.Set(  5000 / _ratio , 5000 / _ratio);
			var sleep:Boolean = true;
			PhysiVals.world =  new b2World( worldBounds , _gravity , sleep);
			
		}
		
		private function objects():void
		{
			staticObjects();
			IntialObjects();
			objectEngine();
		}
		
		private function staticObjects():void
		{
			makeStaticWall( -50 , 0 , 5, PhysiVals.STAGE_HEIGHT);
			makeStaticWall(PhysiVals.STAGE_WIDTH + 50 , 0 , 5 , PhysiVals.STAGE_HEIGHT);
		}
		// helper functions for making static Actors
		private function makeStaticWall(x:Number,y:Number,width:Number,height:Number):void
		{
			  new ArbiStaticActor(this , new Point(x,y ), create_PArray(width,height));
		}
		private function create_PArray(width:Number , height:Number):Array
		{
			var a:Array = [[new Point(0, 0), new Point(width, 0), new Point(width, height), new Point(0, height)]];
			return a
		}
		
		private function objectEngine():void
		{
			_engine = new Timer(1000 * 0.35, 0);
			_engine.addEventListener(TimerEvent.TIMER , createAnotherRow);
			//_engine.start();
			
		}
		
		private function IntialObjects():void
		{
			var start:Point = new Point( -18 , 20 );
			var currentPos:Point = new Point(start.x , start.y);
			var rowOffset:Point = new Point(61.15 , -30);
			var ColOffset:Number = 60;
			var flip:Boolean = false;
			var rows:int = 4 , colums:int = 50, type:String;
			for (var i:int = 0 ; i < colums ; i++)
			{
				
				type = (flip )? BallActor.BLACK_BALL : BallActor.WHITE_BALL; 
				flip = ! flip;
				for (var k:int = 0 ; k < rows ; k++)
				{
					var b:BallActor = new BallActor(this , currentPos, type);
					currentPos.x  += rowOffset.x;
					currentPos.y  += rowOffset.y;
					_actors.push(b);
					
				}
				currentPos.x = start.x;
				start.y += ColOffset;
				currentPos.y = start.y; 
			}
			
		}
		
		
		private function createAnotherRow(e:TimerEvent):void
		{
			var start:Point = new Point( -18 , 20 );
			var currentPos:Point = new Point(start.x , start.y);
			var rowOffset:Point = new Point(61.15 , -30);
			
			
			var rows:int = 4; 
			var type:String = (_flip )? BallActor.BLACK_BALL : BallActor.WHITE_BALL; 
			
			for (var k:int = 0 ; k < rows ; k++)
			{
				var b:BallActor = new BallActor(this , currentPos, type);
				currentPos.x  += rowOffset.x;
				currentPos.y  += rowOffset.y;
				b.getBody().SetLinearVelocity(new b2Vec2(0 , 4));
				_actors.push(b);
				
			}
			currentPos.x = start.x;
			currentPos.y = start.y;
			_flip =! _flip;
		}
		
		private function interact():void
		{
			_mouseball = new MouseBall(this);
			//_mouseball.onStage(true);
			stage.addEventListener(Event.MOUSE_LEAVE , onMouseLeave);
			stage.addEventListener(MouseEvent.MOUSE_MOVE , onMouseMove);
		}
		
		private function onMouseLeave(e:Event):void 
		{
			if (_interacting) 
			{
				_mouseball.onStage(false);
				_engine.stop();
				_interacting = false;
			}
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			if (!_interacting)
			{
				
				_engine.start();
				_interacting = true;	
				_mouseball.onStage(true);
			}
		}
	
		private function onef(e:Event):void 
		{
			if (_interacting){  b2Step()  } 
		}
		private function b2Step():void
		{
			PhysiVals.world.Step( 1 / PhysiVals.FRAME_RATE , 10);

			for each (var actor:Actor in _actors)
			{
				actor.updateNow();
				if ( BallActor(actor).getYPos() > PhysiVals.STAGE_HEIGHT + 20)
				{
					actor.destroy();
					// remove from _actors array
					var index2:int = _actors.indexOf(actor);
					if (index2 > -1)
					{
						_actors.splice(index2, 1);
					}
					
				}
			}
			//trace("triger " + _triggerActors.length );
			//trace("_allActors " + _actors.length );
			
		}
		
		
		
	}
	
}