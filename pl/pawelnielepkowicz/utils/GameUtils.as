package pl.pawelnielepkowicz.utils
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class GameUtils extends Sprite
	{
		
		public function GameUtils():void
		{
			
		}
		
		public function getRandomPosition(range:int, negative:Boolean):int{
			var _negative = negative;
			var rangeResult = null;

			var negativeIndicator:Number = Math.floor(Math.random()*10);
			var rangeIndicator:Number = Math.floor(Math.random()*range);
			
			if(negativeIndicator>5){
				_negative=false
				rangeResult = rangeIndicator;
				trace("positive" + _negative);
				trace("rangeResult" + rangeResult);
				return rangeResult
			}else{
				_negative=true
				rangeResult = rangeIndicator *(-1);
				trace("negative" + _negative);
				trace("rangeResult" + rangeResult);
				return rangeResult
			}
			return -1;
		}
	

	}
}
