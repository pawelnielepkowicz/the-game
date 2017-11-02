package pl.pawelnielepkowicz.factory
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import away3d.primitives.Cube;
	import away3d.primitives.RoundedCube;
	import away3d.primitives.data.CubeMaterialsData;
	import away3d.materials.BitmapFileMaterial;
	
	public class CubeProvider extends Sprite implements Object3DInterface
	{
		
		var roundedCube;
		var cubeMaterialsData:CubeMaterialsData;
		
		var mood:String = new String;
		
		
		var texturesArray:Array = new Array("zero.jpg", "one.jpg", "two.jpg", "three.jpg", "four.jpg", "five.jpg", "six.jpg", "seven.jpg", "eight.jpg", "nine.jpg");

		
		public function CubeProvider():void
		{
			
		}
		
		public function getMood():String{
			return this.mood;
		}
		
			
		public function provide():RoundedCube {
			var bitmapFile;
			
			var randomNumber:Number = Math.floor(Math.random()*10);
			
			if(randomNumber>5){
				bitmapFile = texturesArray[randomNumber];
				this.mood="happy";
			}else{
				bitmapFile = texturesArray[randomNumber];
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
			 
			 var bfm_top:BitmapFileMaterial = new BitmapFileMaterial("top.jpg");
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