package 
{
	import away3d.cameras.Camera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import away3d.primitives.Cube;
	import away3d.primitives.RoundedCube;
	import away3d.primitives.data.CubeMaterialsData;
	import away3d.materials.BitmapFileMaterial;
	
	public class Main extends Sprite
	{
		protected var scene:Scene3D;
		protected var camera:Camera3D;
		protected var view:View3D;
		
		var currentPrimitive;
		
		var roundedCube;
		var cubeMaterialsData:CubeMaterialsData;
		
		public function Main():void
		{
			initEngine();
			initScene();
			initListeners();
			initCubes();
		}
		
		protected function initEngine():void
		{
			view = new View3D();
			scene = view.scene;
			camera = view.camera;
			
			addChild(view);
			
			view.x = stage.stageWidth / 2;
			view.y = stage.stageHeight / 2;
		}
		
		protected function initListeners():void
		{
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function onEnterFrame(event:Event):void
		{
			view.render();
			currentPrimitive.yaw(1.5);
		}
		
		protected function initScene():void {
			currentPrimitive = new Cube;
			scene.addChild(currentPrimitive);
			
			currentPrimitive.yaw(1.5);
			
			}
			
			
			
			
			
			
			
			
			
			
		protected function initCubes():void {
			
			
			 cubeMaterialsData = new CubeMaterialsData();
			 var bfm_back:BitmapFileMaterial = new BitmapFileMaterial("textures/one.jpg");
			 bfm_back.smooth=true;
 			 cubeMaterialsData.back = bfm_back;
			 
			 var bfm_bottom:BitmapFileMaterial = new BitmapFileMaterial("textures/two.jpg");
			 bfm_bottom.smooth=true;
 			 cubeMaterialsData.bottom = bfm_bottom;
			 
			 var bfm_front:BitmapFileMaterial = new BitmapFileMaterial("textures/three.jpg");
			 bfm_front.smooth=true;
 			 cubeMaterialsData.front = bfm_front;
			 
			 var bfm_left:BitmapFileMaterial = new BitmapFileMaterial("textures/four.jpg");
			 bfm_left.smooth=true;
 			 cubeMaterialsData.left = bfm_left;
			 
			 var bfm_right:BitmapFileMaterial = new BitmapFileMaterial("textures/five.jpg");
			 bfm_right.smooth=true;
 			 cubeMaterialsData.right = bfm_right;
			 
			 var bfm_top:BitmapFileMaterial = new BitmapFileMaterial("textures/six.jpg");
			 bfm_top.smooth=true;
 			 cubeMaterialsData.top = bfm_top;


			roundedCube = new RoundedCube;
			//roundedCube.cubeMaterials = cubeMaterialsData;
			
			
			
	
			roundedCube = new RoundedCube({
														  width:300,
														  height:300,
														  depth: 300,
														  radius:6,
														  subdivision:2,
														  cubicmapping:false,
														  faces:cubeMaterialsData
														  });
			scene.addChild(roundedCube);
			
			}
			
	}
}