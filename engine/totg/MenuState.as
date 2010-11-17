package engine.totg {
	import engine.flixel.*;

	public class MenuState extends FlxState
	{
		override public function create():void
		{
			var t:FlxText;
			t = new FlxText(0,FlxG.height/2-10,FlxG.width,"Template");
			t.size = 16;
			t.alignment = "center";
			add(t);
			t = new FlxText(FlxG.width/2-50,FlxG.height-20,100,"click to play");
			t.alignment = "center";
			add(t);
		}

		override public function update():void
		{
			if(FlxG.mouse.justPressed())
				FlxG.state = new PlayState();
				//FlxG.switchState(PlayState);
		}
	}
}
