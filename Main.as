package 
{
	import away3d.cameras.Camera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	
	
	import flash.display.Sprite;
	import flash.display.*;
	import flash.events.Event;
	import flash.utils.*;
	import flash.events.*;
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
		var lifebar_mc:LifeBar = new LifeBar();
		var gameOver_mc:GameOver = new GameOver();

		
		//camera ritation

		public function Main():void
		{
			initEngine();
			initListeners();
			initMesh();
			initCamera();
			initHero();
			initSkyBox()
			initUi()

		}
		
		public function initEngine():void
		{
			view = new View3D();
			scene = view.scene;
			camera = view.camera;
			addChild(view);
			view.x = stage.stageWidth / 2;
			view.y = stage.stageHeight / 2;
			var myInterval:uint = setInterval (generateCubes, 900);
		}
		
		public function initUi():void{
			stage.addChild(lifebar_mc);
			lifebar_mc.testText.text=String(scores);
			lifebar_mc.x=0;


		}
		
		public function updateUi():void{
			
			if(this.lifeBarWidth<=300){
			lifebar_mc.pparent_mc.width=lifeBarWidth;
			}else{
				lifebar_mc.pparent_mc.width=lifeBarWidth=300;
			}
			lifebar_mc.testText.text=String(scores);


			if(lifeBarWidth<=0 || scores<=0){
				gameOver();
			}
			trace("updateUi");
		}
		
		public function initListeners():void{
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrameS);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress);
            stage.addEventListener(KeyboardEvent.KEY_UP, keyRelease);
			gameOver_mc.restart_mc.addEventListener(MouseEvent.CLICK, restartBtnClicked);
		}
		
		 private function keyPress(e:KeyboardEvent):void {
            var key:uint = e.keyCode;
			
            if (key == 37 || key == 65) {moveLeft = true;
						trace("moveLeft!!!!!!!!!!!!!!!!!!");
						}
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
		
		private function restartBtnClicked(e:MouseEvent):void {
			restartGame();
          trace("restartBtnClicked");
        }
		

   		
		
		protected function onEnterFrameS(event:Event):void
		{
			if(!gamePaused){
			
				view.render();
				myHero.yaw(1.5);
				
				if (moveLeft && myHero.x > limitLeft )  {myHero.x -= step;} 
			
				if (moveRight && myHero.x < limitRight ) {myHero.x += step;}
				
				for(var j:int = 0; j<cubesArray.length; j++){
					if(AABBTest(cubesArray[j].getRoundedCube())){
						trace("hit! " + scores);
						if(cubesArray[j].getMood()==yourMood){
							scores+=10;
							lifeBarWidth+=10;
							updateUi();
							trace("Score scores: " + this.scores);
							trace("Score lifeBarWidth: " + this.lifeBarWidth);	
							scene.removeChild(cubesArray[j].getRoundedCube());
							cubesArray[i]=null;
							cubesArray.splice(i,1);
						
							}else{
							scores-=100;
							lifeBarWidth-=100;
							updateUi();
	
							scene.removeChild(cubesArray[j].getRoundedCube());
							cubesArray[j]=null;
							cubesArray.splice(j,1);
							trace("Lost scores: " + this.scores);
							trace("Lost lifeBarWidth: " + this.lifeBarWidth);
						}
					}
				}
			
			
			if(cubesArray.length>0){
					for(var i:int = 0; i<cubesArray.length; i++){
						if(cubesArray[i].getRoundedCube().z > myHero.z){
						cubesArray[i].getRoundedCube().z =  cubesArray[i].getRoundedCube().z - 10;
						}else{
						scene.removeChild(cubesArray[i].getRoundedCube());
						cubesArray[i]=null;
						cubesArray.splice(i,1)
						}
					}
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
		
		protected function generateCubes():void {
			if(!gamePaused){
				var cubeHolder:CubeHolder= new CubeHolder();
			
				cubesArray.push(cubeHolder);
				cubeHolder.getRoundedCube().x = gameUtils.getRandomPosition(this.limitRight, true);
				cubeHolder.getRoundedCube().z =  1000;
				scene.addChild(cubeHolder.getRoundedCube());
			}
			
		}
		
		protected function initHero():void {
			myHero = object3DFactory.get3DObjectType("Hero").provide();
			myHero.x = -350;
			myHero.z =  -1300;
			scene.addChild(myHero);
		}

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
		
		protected function restartGame():void {
			trace("RestartGame!!!!!!!!!!!!!!!!!!");
			scores = 0;
			lifeBarWidth = 300;
		
			for(var i:int = 0; i<cubesArray.length; i++){
				scene.removeChild(cubesArray[i].getRoundedCube());
				cubesArray.splice(i,1);
			}
			lifebar_mc.testText.text=String(0);
			lifebar_mc.pparent_mc.width=300;
			stage.removeChild(gameOver_mc)

			resumeGame()
					
		}
			
		protected function pauseGame():void {
			gamePaused=true;
			trace("pauseGame!!!!!!!!!!!!!!!!!!");
		}
		
		protected function resumeGame():void {
			gamePaused=false
			trace("resumeGame!!!!!!!!!!!!!!!!!!");
		}
		
		protected function gameOver():void {
			pauseGame();
				
			/*stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPress);
            stage.removeEventListener(KeyboardEvent.KEY_UP, keyRelease);*/
			
			gameOver_mc.x = stage.stageWidth/2 - gameOver_mc.width/2;
			gameOver_mc.y = stage.stageHeight/2 - gameOver_mc.height/2;
			stage.addChild(gameOver_mc);
			gameOver_mc.punktyTotal_mc.text=String(scores);
			
			trace("gameOver!!!!!!!!!!!!!!!!!!");
		}



		

		
		

	}
}