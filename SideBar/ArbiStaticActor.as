package  
{
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Collision.Shapes.b2ShapeDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	

	public class ArbiStaticActor extends Actor
	{
		
		public function ArbiStaticActor(parent:DisplayObjectContainer,location:Point, arrayOfCoords:Array) 
		{
			var myBody:b2Body = CreateBodyFromCoords(arrayOfCoords, location);
			var mySprite:Sprite = createSpriteFromCoords(arrayOfCoords, location, parent);
			
			super(myBody, mySprite);
		}
		
		private function createSpriteFromCoords( arrayOfCoords:Array,location:Point,parent:DisplayObjectContainer ):Sprite
		{
			var newSprite:Sprite = new Sprite();
			newSprite.graphics.lineStyle(2, 0x008000);
			for each ( var listofPoints:Array in arrayOfCoords)
			{
				var firstpoint:Point = listofPoints[0];
				newSprite.graphics.moveTo(firstpoint.x , firstpoint.y);
				newSprite.graphics.beginFill(0x004000, 0.6);
				for each ( var newPoint:Point in listofPoints)
				{
					newSprite.graphics.lineTo(newPoint.x , newPoint.y );
				}
				newSprite.graphics.lineTo(firstpoint.x , firstpoint.y);
				newSprite.graphics.endFill();
			}
			newSprite.x = location.x;
			newSprite.y = location.y;
			//parent.addChild(newSprite);
			return newSprite;
			
		}
		
		private function CreateBodyFromCoords(arrayOfCoords:Array, location:Point):b2Body
		
		{
			// 1. Define shapes
			var allShapeDefs:Array = [];
			
			for each(var listofPoints:Array in arrayOfCoords)
			{
				var newShapeDef:b2PolygonDef = new b2PolygonDef();
				newShapeDef.vertexCount = listofPoints.length;
				for ( var i:int = 0; i < listofPoints.length; i++)
				{
					var nextPoint:Point = listofPoints[i];
					b2Vec2(newShapeDef.vertices[i]).Set(nextPoint.x / PhysiVals.RATIO , nextPoint.y / PhysiVals.RATIO);
				}
				newShapeDef.density = 0;
				newShapeDef.friction = 0.2;
				newShapeDef.restitution = 0.3;
				allShapeDefs.push(newShapeDef);
			}
			// 2. Define a body
			var arbi_DB:b2BodyDef = new b2BodyDef();
			arbi_DB.position.Set(location.x / PhysiVals.RATIO , location.y / PhysiVals.RATIO);
			// 3. create the body
			var arbi_B:b2Body = PhysiVals.world.CreateBody(arbi_DB);
			// 4. create the shapes
			for each(var newShapeDefToAdd:b2ShapeDef in allShapeDefs)
			{
				arbi_B.CreateShape(newShapeDefToAdd);
			}
			arbi_B.SetMassFromShapes();
			return arbi_B;
		}
		
	}
	
}