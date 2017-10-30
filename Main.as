package 
{
	import away3d.cameras.Camera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.*;
	import away3d.primitives.Cube;
	import away3d.primitives.RoundedCube;
	import away3d.primitives.data.CubeMaterialsData;
	import away3d.materials.BitmapFileMaterial;
	import pl.pawelnielepkowicz.*
	import away3d.primitives.GridPlane;
	
	public class Main extends Sprite
	{
		protected var scene:Scene3D;
		protected var camera:Camera3D;
		protected var view:View3D;
		
		var cubesArray:Array = new Array();
		
		var currentPrimitive;
		
		var roundedCube;
		var cubeMaterialsData:CubeMaterialsData;
		var myHeroProvider:MyHeroProvider = new MyHeroProvider;
		var myHero:RoundedCube
		
		public function Main():void
		{
			initEngine();
			initScene();
			initListeners();
			
		}
		
		protected function initEngine():void
		{
			view = new View3D();
			scene = view.scene;
			camera = view.camera;
			
			
			addChild(view);
			
			view.x = stage.stageWidth / 2;
			view.y = stage.stageHeight / 2;
			var myInterval:uint = setInterval (intervalAction, 500);

		}
		
		protected function initListeners():void
		{
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function onEnterFrame(event:Event):void
		{
			view.render();
			cubesArray[0].yaw(1.5);
			myHero.yaw(1.5);
			

		}
		
		function intervalAction():void {
			for(var i:int = 0; i<10; i++){
				if(cubesArray[i].z > myHero.z){
				cubesArray[i].z =  cubesArray[i].z - 200;
				}else{
					cubesArray[i].z=1000;
				}
			}
		}

		protected function initScene():void {
			initCustomCubes();
			initMesh();
			initCamera();
			initHero();

		}
		
		protected function initHero():void {
				myHero = myHeroProvider.provide();
				
				myHero.x = -350;
				myHero.z =  -900;
				scene.addChild(myHero);
		}
		
		
		protected function initCustomCubes():void {
			
			for(var i:int = 0; i<10; i++){
				var myCube:MyCubeProvider = new MyCubeProvider;
				var roundedCube:RoundedCube = myCube.provide();
				cubesArray.push(roundedCube);
				roundedCube.x = 120* i - 500;
				roundedCube.z =  1000;
				scene.addChild(cubesArray[i]);
			}
		}
		
		
		protected function initMesh():void {
			
			var gridPlane:GridPlane = new GridPlane({
											        height: 3000,
													width: 3000,
													segments:20
													});
			gridPlane.y = -50;
			scene.addChild(gridPlane);

		}

		protected function initCamera():void {
			camera.x= 0;
			camera.y= 200;
			camera.z= -1700;
			/*camera.focus=0.8;*/
			camera.rotationX= -20;
			
			trace(camera.fov);
			
		}
			
		
		
		

	}
}