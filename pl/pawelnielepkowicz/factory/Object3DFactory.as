package pl.pawelnielepkowicz.factory
{
	
	import flash.display.Sprite;

	
	public class Object3DFactory extends Sprite
	{
		
		public function get3DObjectType(type: String):Object3DInterface
		{
			switch (type)
			{
			case "Cube":
			return new CubeProvider();
			case "Hero":
			return new HeroProvider();
			default: return null;
			}
		}
		
	

	}
}
