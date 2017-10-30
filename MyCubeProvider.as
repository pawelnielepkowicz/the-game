package 
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import away3d.primitives.Cube;
	import away3d.primitives.RoundedCube;
	import away3d.primitives.data.CubeMaterialsData;
	import away3d.materials.BitmapFileMaterial;
	
	public class MyCubeProvider extends Sprite
	{
		
		var roundedCube;
		var cubeMaterialsData:CubeMaterialsData;
		
		var mood:String = new String;
		
		
		var texturesArray:Array = new Array("one.jpg", "one.jpg", "one.jpg", "one.jpg", "one.jpg", "six.jpg", "six.jpg", "six.jpg", "six.jpg", "six.jpg");

		
		public function MyCubeProvider():void
		{
			
		}
		
			
		public function provide():RoundedCube {
			var bitmapFile;
			
			var randomNumber:Number = Math.floor(Math.random()*10);
			
			if(randomNumber>5){
				bitmapFile = "one.jpg";
				this.mood="happy";
			}else{
				bitmapFile = "two.jpg";
				this.mood="sad";
			}

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
			//roundedCube.cubeMaterials = cubeMaterialsData;
			
			
			
	
			roundedCube = new RoundedCube({
														  width:100,
														  height:100,
														  depth: 100,
														  radius:13,
														  subdivision:2,
														  cubicmapping:true,
														  faces:cubeMaterialsData
														  });
			
			return roundedCube;
			}
			
	}
}