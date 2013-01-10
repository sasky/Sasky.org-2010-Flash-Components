package 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.Font;
	/**
	 * ...
	 * @author sasky.org
	 */
	[SWF( width = '800', height = '720', frameRate = '30', backgroundColor = '#E42E8B' )]  
	
	public class Main extends Sprite 
	{
		/*
		[Embed ( source=  "../lib/CORBEL.TTF",fontName = "corbel2",mimeType = "application/x-font")]
		public static var  corbel2:Class;
		*/
		[Embed ( source=  "../lib/CORBEL.TTF",fontName = "Corbel2",embedAsCFF='false',mimeType = "application/x-font")]
		public static var  Corbel2:Class;
		// main text font
		[Embed( source=  "../lib/Dungeon.TTF", fontName = "dungeon", mimeType = "application/x-font",embedAsCFF='false')]
		public static var dungeon:Class;
	
		
		// for numbers in loader
		[Embed(source='../lib/tab.png')]
		public static var TabC:Class;
		
		[Embed(source='../lib/header.gif')]
		private var HeaderC:Class;
		
		
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
		
			Font.registerFont(Corbel2);
			Font.registerFont(dungeon);
			var l1:Bitmap = new HeaderC();
			this.addChild(l1);
			
			ApplicationFacade.getInstance().startup(this);
			
		}
	}
	
}