package 
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import away3d.primitives.Cube;
	import away3d.primitives.RoundedCube;
	import away3d.primitives.data.CubeMaterialsData;
	import away3d.materials.BitmapFileMaterial;
	
	public class MyHeroProvider extends Sprite
	{
		
		var roundedCube;
		var cubeMaterialsData:CubeMaterialsData;
		
		public function MyHeroProvider():void
		{
			
		}
		
			
		public function provide():RoundedCube {
			var bitmapFile = "ja.jpg";

			 cubeMaterialsData = new CubeMaterialsData();
			 var bfm_back:BitmapFileMaterial = new BitmapFileMaterial("textures/" + bitmapFile);
			 bfm_back.smooth=true;
 			 cubeMaterialsData.back = bfm_back;
			 
			 var bfm_bottom:BitmapFileMaterial = new BitmapFileMaterial("textures/" + bitmapFile);
			 bfm_bottom.smooth=true;
 			 cubeMaterialsData.bottom = bfm_bottom;
			 
			 var bfm_front:BitmapFileMaterial = new BitmapFileMaterial("textures/" + bitmapFile);
			 bfm_front.smooth=true;
 			 cubeMaterialsData.front = bfm_front;
			 
			 var bfm_left:BitmapFileMaterial = new BitmapFileMaterial("textures/" + bitmapFile);
			 bfm_left.smooth=true;
 			 cubeMaterialsData.left = bfm_left;
			 
			 var bfm_right:BitmapFileMaterial = new BitmapFileMaterial("textures/" + bitmapFile);
			 bfm_right.smooth=true;
 			 cubeMaterialsData.right = bfm_right;
			 
			 var bfm_top:BitmapFileMaterial = new BitmapFileMaterial("textures/" + bitmapFile);
			 bfm_top.smooth=true;
 			 cubeMaterialsData.top = bfm_top;

			roundedCube = new RoundedCube;

			roundedCube = new RoundedCube({
														  width:128,
														  height:128,
														  depth: 128,
														  radius:13,
														  subdivision:2,
														  cubicmapping:true,
														  faces:cubeMaterialsData
														  });
			
			return roundedCube;
			}
			
	}
}