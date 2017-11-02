package pl.pawelnielepkowicz.utils
{
	import away3d.primitives.RoundedCube;

	import pl.pawelnielepkowicz.factory.*;
	import flash.display.Sprite;
	import flash.events.Event;
	import away3d.primitives.Cube;
	
	public class CubeHolder extends Sprite
	{
		var mood:String = new String;

		
		private var cubeProvider:CubeProvider = new CubeProvider();
		private var roundedCube:RoundedCube = new RoundedCube();
		
		
		public function CubeHolder():void
		{
			this.roundedCube = cubeProvider.provide();
			this.mood = cubeProvider.getMood();
		}

		public function getRoundedCube():RoundedCube{
			return this.roundedCube;
			
		}
		
		public function getMood():String{
			return this.mood;
		}
		
	

	}
}
