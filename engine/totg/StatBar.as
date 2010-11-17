package engine.totg
{
	import engine.flixel.*;

	public class StatBar extends FlxGroup
	{
	  
	  public function StatBar(x:int, y:int, color:uint){
	    var frame:FlxSprite = new FlxSprite(x,y);
      frame.createGraphic(50,10); //White frame for the health bar
      frame.scrollFactor.x = frame.scrollFactor.y = 0;
      add(frame);

      var inside:FlxSprite = new FlxSprite(x+1,y+1);
      inside.createGraphic(48,8,0xff000000); //Black interior, 48 pixels wide
      inside.scrollFactor.x = inside.scrollFactor.y = 0;
      add(inside);

      var bar:FlxSprite = new FlxSprite(x+1,y+1);
      bar.createGraphic(1,8,color); //The red bar itself
      bar.scrollFactor.x = bar.scrollFactor.y = 0;
      bar.origin.x = bar.origin.y = 0; //Zero out the origin
      bar.scale.x = 48; //Fill up the health bar all the way
      add(bar);
	  }
	}
}