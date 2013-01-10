package  
{
	import Box2D.Collision.Shapes.b2CircleDef;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import com.greensock.easing.Quart;
	import com.greensock.TweenLite;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	

	public class MouseBall extends Sprite
	{
		
		private var _radius:Number= 60;
		private var _body:b2Body;
		private var _parent:DisplayObjectContainer;
		private var _tweening:Boolean;
		private var _onstage:Boolean;
		public var radiusTween:Number = 0;
		private var _body_SD:b2CircleDef;
		public function MouseBall(parent:DisplayObjectContainer ) 
		{
			_parent = parent;
			
			
			
		}
		
		public function onStage(on:Boolean):void
		{
			_onstage = on;
			if (_onstage)
			{
				_body = CreateB2Body(new Point(_parent.stage.mouseX, _parent.stage.mouseY));
				_parent.addEventListener(Event.ENTER_FRAME , onef );
				_parent.stage.addEventListener(MouseEvent.CLICK , onclick);
			} else {
				PhysiVals.world.DestroyBody(_body);
				_parent.removeEventListener(Event.ENTER_FRAME , onef );
				_parent.stage.removeEventListener(MouseEvent.CLICK , onclick);
			}
		}
		
		private function onclick(e:MouseEvent):void 
		{
			TweenBody();
		}
		
		
	

	
		private function CreateB2Body(location:Point ):b2Body
		{
			_body_SD = new b2CircleDef();
			_body_SD.radius = _radius / PhysiVals.RATIO;
			_body_SD.density = 1;
			_body_SD.friction = 0.9;
			_body_SD.restitution = 0.4;
			var body_BD:b2BodyDef = new b2BodyDef();
			body_BD.position.Set( location.x / PhysiVals.RATIO , location.y / PhysiVals.RATIO );
			var body:b2Body = PhysiVals.world.CreateBody(body_BD);
			body.CreateShape(_body_SD);
			body.SetMassFromShapes();
			return body;
		}
		private function  onef (e:Event):void
		{
			
			var IdealLocation:b2Vec2 = new b2Vec2( _parent.stage.mouseX / PhysiVals.RATIO, _parent.stage.mouseY / PhysiVals.RATIO);
			var direction:b2Vec2 = new b2Vec2(IdealLocation.x - _body.GetPosition().x , IdealLocation.y - _body.GetPosition().y );
			direction.Multiply(PhysiVals.FRAME_RATE);
			_body.SetLinearVelocity(direction);
			//trace(" _body.GetPosition().x  " + (_body.GetPosition().x * PhysiVals.RATIO) + "    " + (_body.GetPosition().y * PhysiVals.RATIO));
			
		}
		private function TweenBody():void
		{
			_parent.removeEventListener(Event.ENTER_FRAME , onef );
			_tweening = true;
			radiusTween = _radius;
			TweenLite.to(this, 0.3 , { 		radiusTween:200, 
											ease:Quart.easeOut,
											onUpdate:onTweenChange,
											onComplete:onTweenComplete } );
			
		}
		private function onTweenChange():void
		{
			var shape:b2CircleShape = _body.GetShapeList() as b2CircleShape;
			_body.DestroyShape(shape);
			_body_SD.radius = radiusTween / PhysiVals.RATIO;
			_body.CreateShape(_body_SD);
			_body.SetMassFromShapes();
			
			var IdealLocation:b2Vec2 = new b2Vec2( _parent.stage.stage.mouseX / PhysiVals.RATIO, _parent.stage.mouseY  / PhysiVals.RATIO);
			var direction:b2Vec2 = new b2Vec2(IdealLocation.x - _body.GetPosition().x , IdealLocation.y - _body.GetPosition().y );
			direction.Multiply(PhysiVals.FRAME_RATE);
			_body.SetLinearVelocity(direction);
		}
		private function onTweenComplete():void
		{
			PhysiVals.world.DestroyBody(_body);
			if (_onstage)
			{
				_body = CreateB2Body(new Point(_parent.stage.mouseX, _parent.stage.mouseY));
				_parent.addEventListener(Event.ENTER_FRAME , onef );
			} else {
				_body = null;
			}
		
			_tweening = false;
		}
		
		
		
		
	}
	
}