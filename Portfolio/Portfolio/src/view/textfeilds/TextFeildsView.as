package view.textfeilds 
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.GridFitType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import Model.VO.WorksVO;
	import org.sasky.colour.colourChange;
	
	
	/**
	 * ...
	 * @author sasky.org
	 */
	
	public class TextFeildsView extends Sprite
	{
		
		private var _tab:Bitmap;
		private var _colours:Vector.<uint> =  Vector.<uint>([	0xe42e8b, 0x2fe4ff , 0xeeff2f, 0xb600e4, 0x3e6de4, 
																0xff4f25, 0xfff75d, 0x4ff7a1, 0x18f549, 0xfc96ca, 0xb30085]);
		
		public function TextFeildsView() 
		{
			bg();
			trace(_colours[3] );
		}
		
		
		private function bg():void
		{
			_tab = new Main.TabC;
			_tab.x = 565; _tab.y = 13;
			this.addChild(_tab);
			square(26.5 , 415 , 748.5 ,300 , 0xf9f361);
		}
		private function square(xPos:Number, yPos:Number , widthPos:Number , heightPos:Number , color:uint):void
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill(color);
			shape.graphics.drawRect(xPos, yPos , widthPos , heightPos);
			shape.graphics.endFill();
			this.addChild(shape);
		}
		
		public function changeText(textObj:Object):void
		{
		
			setupText(textObj);
		}
		//private var _textFeilds:Vector.<TextField> = Vector.<TextField>([]);
		private var _textFeilds:Array = [];
		private var f:Array;
		private function setupText(textObj:Object):void
		{
			//1.) remove previous text feilds
			for each(var tf:TextField in _textFeilds)
			{
				this.removeChild(tf);
				if (tf.name == "tab")
				{
					tf.removeEventListener(MouseEvent.ROLL_OVER , onUrlOver);
					tf.removeEventListener(MouseEvent.ROLL_OUT,  onUrlOut);
				}
			}
			//2.) add new text feilds
			var BodyMargin:Number = 43,
				HeadMargin:Number = 30,
				HeadGap:Number = 10,
				BodyGap:Number = 5,
				paraLength:Number = 720,
				HeadCol:uint = 0xb5b5b5 ,
				BodyCol:uint = 0x000000,
				HeadSize:int = 10,
				BodySize:int = 16;
				
				
			_textFeilds = [];
			_textFeilds.push(textFeild("open this site in a new tab" , 14 , 0x6a6a6a , 610 , 26, 140 , 0, false, false , textObj.url ));
			_textFeilds.push(textFeild("Client :" , HeadSize, HeadCol, HeadMargin, 424, 100, 200, false, false));
			_textFeilds.push(textFeild(textObj.title , BodySize , BodyCol, BodyMargin , TextField(_textFeilds[1]).y +  TextField(_textFeilds[1]).height + BodyGap, 400));//437
			_textFeilds.push(textFeild("Ramble :" , HeadSize , HeadCol, HeadMargin , TextField(_textFeilds[2]).y +  TextField(_textFeilds[2]).height + HeadGap, 100, 200, false, false));
			_textFeilds.push(textFeild(textObj.blurb , BodySize , BodyCol , BodyMargin , TextField(_textFeilds[3]).y +  TextField(_textFeilds[3]).height + BodyGap , paraLength, 0, true));
			_textFeilds.push(textFeild("technologies used " , HeadSize , HeadCol , HeadMargin , TextField(_textFeilds[4]).y +  TextField(_textFeilds[4]).height + HeadGap, 100, 100 , false, false));
			_textFeilds.push(textFeild(textObj.tech , BodySize , BodyCol , BodyMargin , TextField(_textFeilds[5]).y +  TextField(_textFeilds[5]).height + BodyGap, paraLength, 0, true));
			}
		
		private function textFeild(	text:String, size:int , colour:uint, xPos:Number , yPos:Number ,
									length:int , tickness:int = 0, multiline:Boolean = false, selectable:Boolean = true,
									url:String = null):TextField
		{
			var tf:TextField = new TextField();
			tf.width = length;
			
			
			tf.autoSize = TextFieldAutoSize.LEFT;
			//tf.antiAliasType = AntiAliasType.ADVANCED;
			//tf.gridFitType = GridFitType.PIXEL;
			//tf.thickness = tickness;
			
			
			f = [Font.enumerateFonts(true)];
			
			var tfor:TextFormat = new TextFormat("Corbel2", size, colour, null , null, url ? true :false , url ? url : null , url ? "_blank" : null );
			
			if (multiline)
			{
			   tf.multiline = multiline;
			   tf.wordWrap = true;
			   tfor.leading = 6;
			   tf.scrollV = 0;
			   tf.addEventListener(Event.SCROLL, onScroll);			}
			
			tf.selectable = selectable;
			tf.selectable = false;
			tf.defaultTextFormat = tfor;
			tf.text = text;

			
			tf.x = xPos;
			tf.y = yPos;
			this.addChild(tf);
			if (url)
			{
				tf.name = "tab";
				tf.addEventListener(MouseEvent.ROLL_OVER , onUrlOver, false , 0 , true);
				tf.addEventListener(MouseEvent.ROLL_OUT,  onUrlOut,   false , 0 , true);
			}
			tf.embedFonts = true;
			return tf;
		}
		

		private function onScroll(e:Event):void
		{
			e.currentTarget.scrollV = 0;
		}

		private function onUrlOver(e:MouseEvent):void 
		{
			colourChange.ChangeColour( _tab  ,0xf9f361 , 0x2fe4ff);
		}
		
		private function onUrlOut(e:MouseEvent):void 
		{
			colourChange.ChangeColour( _tab , 0x2fe4ff, 0xf9f361 );
		}
		
		
	}

}