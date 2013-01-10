package  
{
	import Box2D.Collision.Shapes.b2CircleDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	

	public class BallActor extends Actor
	{
		public static const WHITE_BALL:String = "white ball";
		public static const BLACK_BALL:String = "black ball";
		public const FACE:String = "Face";
		private var _radius:Number;
		public function BallActor(parent:DisplayObjectContainer,location:Point , type:String , face:Sprite = null) 
		{
			var costume:Sprite = createCustume(parent, type, face);
			var body:b2Body = CreateB2Body(location );
			
			super( body , costume );
		}
		public function getYPos():Number
		{
			return _costume.y;
		}
		public function getBody():b2Body
		{
			return _body;
		}
		
	
		private function createCustume(parent:DisplayObjectContainer, type:String , face:Sprite = null):Sprite
		{
			var costume:Sprite;
			if      ( type == WHITE_BALL) { _radius = 10 ; costume = makeCustume(_radius , 0xFFFFFF, true ) }
			else if ( type == BLACK_BALL) { _radius = 20 ; costume = makeCustume(_radius , 0x000000, false ) }
			else if ( type == FACE) { _radius = 20 ; costume = applyCustome(_radius ,  face) }
			else { throw new Error("type not reconised") };
			parent.addChild(costume);
			return costume;
		}
		
		private function makeCustume(raduis:Number , colour:uint , stroke:Boolean):Sprite
		{
			var s:Sprite = new Sprite();
			if (stroke)
			{
				var strokeColour:uint = (colour == 0xFFFFFF)? 0x000000 : 0xFFFFFF ;
				s.graphics.lineStyle( 1, strokeColour );
			}
			s.graphics.beginFill(colour, 1);
			s.graphics.drawCircle(0, 0, raduis);
		
			s.graphics.endFill();
			return s;
		}
		
		
		private function applyCustome(raduis:Number, face:Sprite):Sprite
		{
			// face reg must be at center
			face.width = raduis * 2;
			face.height = raduis * 2;
			return face;
			
		}
	
		private function CreateB2Body(location:Point ):b2Body
		{
			var body_SD:b2CircleDef = new b2CircleDef();
			body_SD.radius = _radius / PhysiVals.RATIO;
			body_SD.density = 0.1;
			body_SD.friction = 0.3;
			body_SD.restitution = 0.3;
			var body_BD:b2BodyDef = new b2BodyDef();
			body_BD.position.Set( location.x / PhysiVals.RATIO , location.y / PhysiVals.RATIO );
			var body:b2Body = PhysiVals.world.CreateBody(body_BD);
			body.CreateShape(body_SD);
			body.SetMassFromShapes();
			return body;
		}
		override protected function  childSpecificUpdating():void
		{
			/*
			if (_costume.y > 1400)
			{
				var curentPos:b2Vec2 = _body.GetPosition();
				var pos:b2Vec2 = new b2Vec2(curentPos.x , (curentPos.y - 1400) / PhysiVals.RATIO);
				var angle:Number = _body.GetAngle();
				_body.SetXForm(pos, angle);
			}
			*/
			
		}
		
		
		
	}
	
}