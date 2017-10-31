package 
{
	import away3d.cameras.Camera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.*;
	import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
	import away3d.primitives.Cube;
	import away3d.primitives.RoundedCube;
	import away3d.primitives.data.CubeMaterialsData;
	import away3d.materials.BitmapFileMaterial;
	import pl.pawelnielepkowicz.*
	import pl.pawelnielepkowicz.factory.*;
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
		var myHero:RoundedCube
		
		// poruszanie sie myHero
        private var moveLeft:Boolean;
        private var moveRight:Boolean;
        private var limitRight:int = 600;
		private var limitLeft:int = -600;
		private var step:uint = 45;

		var object3DFactory: Object3DFactory = new Object3DFactory;

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
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress);
            stage.addEventListener(KeyboardEvent.KEY_UP, keyRelease);
		}
		
		 private function keyPress(e:KeyboardEvent):void {
            var key:uint = e.keyCode;
			
            if (key == 37 || key == 65) {moveLeft = true;}
            if (key == 39 || key == 68) {moveRight = true;}
       
        }
		
		 private function keyRelease(e:KeyboardEvent):void {
            var key:uint = e.keyCode;
            if (key == 37 || key == 65) {moveLeft = false;}
            if (key == 39 || key == 68) {moveRight = false;}
        }

   		private function keyReleased(e:KeyboardEvent):void 
 	    {
   		    trace("keyReleased");
 	    }
		
		protected function onEnterFrame(event:Event):void
		{
			view.render();
			cubesArray[0].yaw(1.5);
			myHero.yaw(1.5);
			
			if (moveLeft && myHero.x > limitLeft )  {myHero.x -= step;} 
		
            if (moveRight && myHero.x < limitRight ) {myHero.x += step;}
			
			for(var i:int = 0; i<10; i++){
				if(AABBTest(cubesArray[i])){
					scene.removeChild(cubesArray[i]);
				trace("hit!" + cubesArray[i]);
				}
			}
		}
		
		private function AABBTest(testObject: RoundedCube):Boolean{
			if(testObject.parentMinX>myHero.parentMaxX||myHero.parentMinX>testObject.
			parentMaxX){
			return false;
			}
			if(testObject.parentMinY>myHero.parentMaxY||myHero.parentMinY>testObject.
			parentMaxY){
			return false;
			}
			if(testObject.parentMinZ>myHero.parentMaxZ||myHero.parentMinZ>testObject.
			parentMaxZ){
			return false;
			}
			return true;
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
			myHero = object3DFactory.get3DObjectType("Hero").provide();
			
				//myHero = myHeroProvider.provide();
				
				myHero.x = -350;
				myHero.z =  -900;
				scene.addChild(myHero);
				
		}
		


		protected function initCustomCubes():void {
			
			for(var i:int = 0; i<10; i++){
				var roundedCube:RoundedCube = object3DFactory.get3DObjectType("Cube").provide();
				
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