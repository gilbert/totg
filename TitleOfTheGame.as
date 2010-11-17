package {
	import engine.flixel.*;
	import engine.totg.*;
	
	[SWF(width="640", height="480", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	public class TitleOfTheGame extends FlxGame
	{
		public function TitleOfTheGame()
		{
			super(640,480,MenuState,1);
			//showLogo = false;
		}
	}
}
