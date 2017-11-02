package 
{
	import away3d.cameras.Camera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	
	import flash.display.Sprite;
	import flash.display.*;
	import flash.events.Event;
	import flash.utils.*;
	import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
	import away3d.primitives.*;
	import away3d.primitives.data.CubeMaterialsData;
	import away3d.materials.BitmapFileMaterial;
	import pl.pawelnielepkowicz.*
	import pl.pawelnielepkowicz.factory.*;
	import pl.pawelnielepkowicz.utils.*;
	import away3d.primitives.GridPlane;
	import away3d.cameras.lenses.*
	
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
        private var limitRight:int = 500;
		private var limitLeft:int = -500;
		private var step:uint = 45;

		var object3DFactory: Object3DFactory = new Object3DFactory;
		var gameUtils: GameUtils = new GameUtils;
		
		var scores:int = 0;
		var lifeBarWidth:int = 300;
		var yourMood:String = "sad"
		var gamePaused:Boolean = false;
;
		public function Main():void
		{
			initEngine();
			initListeners();
			initMesh();
			initCamera();
			initHero();
			initSkyBox()
		}
		
		public function initEngine():void
		{
			view = new View3D();
			scene = view.scene;
			camera = view.camera;
			addChild(view);
			view.x = stage.stageWidth / 2;
			view.y = stage.stageHeight / 2;
			var myInterval:uint = setInterval (intervalAction, 500);
		}
		
		public function initListeners():void
		{
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress);
            stage.addEventListener(KeyboardEvent.KEY_UP, keyRelease);
		}
		
		 private function keyPress(e:KeyboardEvent):void {
            var key:uint = e.keyCode;
			
            if (key == 37 || key == 65) {moveLeft = true;}
            if (key == 39 || key == 68) {moveRight = true;}
			
			if (key == 35) {restartGame();} //End
       		if (key == 19) {pauseGame();} // Pause
			if (key == 36) {resumeGame();} // Home

        }
		
		 private function keyRelease(e:KeyboardEvent):void {
            var key:uint = e.keyCode;
            if (key == 37 || key == 65) {moveLeft = false;}
            if (key == 39 || key == 68) {moveRight = false;}
        }

   		
		
		protected function onEnterFrame(event:Event):void
		{
			view.render();
			myHero.yaw(1.5);
			
			if (moveLeft && myHero.x > limitLeft )  {myHero.x -= step;} 
		
            if (moveRight && myHero.x < limitRight ) {myHero.x += step;}
			
			for(var i:int = 0; i<cubesArray.length; i++){
				if(AABBTest(cubesArray[i].getRoundedCube())){
					trace("hit! " + scores);
					if(cubesArray[i].getMood()==yourMood){
						scores+=10;
						lifeBarWidth+=5;
						trace("Score scores: " + this.scores);
						trace("Score lifeBarWidth: " + this.lifeBarWidth);	
						}else{
						scores+=1;
						lifeBarWidth-=5;
						trace("Lost scores: " + this.scores);
						trace("Lost lifeBarWidth: " + this.lifeBarWidth);

					}
					scene.removeChild(cubesArray[i].getRoundedCube());
					cubesArray[i]=null;
					cubesArray.splice(i,1);
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
		
		protected function intervalAction():void {
			if(!gamePaused){
				var cubeHolder:CubeHolder= new CubeHolder();
			
				cubesArray.push(cubeHolder);
				cubeHolder.getRoundedCube().x = gameUtils.getRandomPosition(this.limitRight, true);
				cubeHolder.getRoundedCube().z =  1000;
				scene.addChild(cubeHolder.getRoundedCube());
			
				if(cubesArray.length>0){
					for(var i:int = 0; i<cubesArray.length; i++){
						if(cubesArray[i].getRoundedCube().z > myHero.z){
						cubesArray[i].getRoundedCube().z =  cubesArray[i].getRoundedCube().z - 200;
						}else{
						cubesArray[i].getRoundedCube().z=1000;
						}
					}
				}
			}
			
		}
		
		protected function initHero():void {
			myHero = object3DFactory.get3DObjectType("Hero").provide();
			myHero.x = -350;
			myHero.z =  -1300;
			scene.addChild(myHero);
		}
		
		/**
		 * Creates a new <code>Skybox</code> object.
		 *
		 * @param	front		The material to use for the skybox front.
		 * @param	left		The material to use for the skybox left.
		 * @param	back		The material to use for the skybox back.
		 * @param	right		The material to use for the skybox right.
		 * @param	up			The material to use for the skybox up.
		 * @param	down		The material to use for the skybox down.
		 * 
		 */
		
		protected function initSkyBox():void {
			var skyBox:Skybox = new Skybox(
										   new BitmapFileMaterial("textures/skyBox/TropicalSunnyDayFront2048.png"),
										   new BitmapFileMaterial("textures/skyBox/TropicalSunnyDayLeft2048.png"),
										   new BitmapFileMaterial("textures/skyBox/TropicalSunnyDayBack2048.png"),
										   new BitmapFileMaterial("textures/skyBox/TropicalSunnyDayRight2048.png"),
										   new BitmapFileMaterial("textures/skyBox/TropicalSunnyDayUb2048.png"),
										   new BitmapFileMaterial("textures/skyBox/TropicalSunnyDayDown2048.png")  
										   );
			scene.addChild(skyBox);
			
			
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
			
			view.camera.focus=55;		
			camera.rotationX= -20;
			trace(camera.fov);
		}
			
		protected function pauseGame():void {
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			gamePaused=true;
			trace("pauseGame!!!!!!!!!!!!!!!!!!");
		}
		
		protected function resumeGame():void {
			gamePaused=false
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			trace("resumeGame!!!!!!!!!!!!!!!!!!");
		}



		protected function restartGame():void {
			trace("RestartGame!!!!!!!!!!!!!!!!!!");
			
			for(var i:int = 0; i<cubesArray.length; i++){
				scene.removeChild(cubesArray[i].getRoundedCube());
			}
			cubesArray.splice(0);
			scores = 0;
			lifeBarWidth=300;
					
		}

		
		

	}
}