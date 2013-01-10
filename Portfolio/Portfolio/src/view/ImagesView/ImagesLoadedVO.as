package view.ImagesView 
{
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author sasky.org
	 */
	public class ImagesLoadedVO
	{
		private var _worksId:int;
		private var _image:Bitmap;
		public function ImagesLoadedVO(image:Bitmap , worksId:int) 
		{
			_image = image;
			_worksId = worksId;
		}
		
		public function get image():Bitmap { return _image; }
		
		public function get worksId():int { return _worksId; }
		
	}

}