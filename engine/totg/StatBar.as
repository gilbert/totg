package engine.totg
{
	import engine.flixel.*;

	public class StatBar extends FlxGroup
	{
	  
	  public var barLength:int;
	  
	  private var frame:FlxSprite;
	  private var bg:FlxSprite;
	  private var juice:FlxSprite;
	  
	  public function StatBar(x:int, y:int, color:uint)
	  {
	    barLength = 50;
	    
	    frame = new FlxSprite(x,y);
      frame.createGraphic(barLength+2,10); //White frame for the health bar
      frame.scrollFactor.x = frame.scrollFactor.y = 0;
      add(frame);

      bg = new FlxSprite(x+1,y+1);
      bg.createGraphic(barLength,8,0xff000000); //Black interior, 48 pixels wide
      bg.scrollFactor.x = bg.scrollFactor.y = 0;
      add(bg);

      juice = new FlxSprite(x+1,y+1);
      juice.createGraphic(1,8,color); //The red bar itself
      juice.scrollFactor.x = juice.scrollFactor.y = 0;
      juice.origin.x = juice.origin.y = 0; //Zero out the origin
      juice.scale.x = barLength; //Fill up the health bar all the way
      add(juice);
	  }
	  
	  public function setScale(percentRemaining:Number):void
	  {
	    juice.scale.x = Math.ceil(barLength * percentRemaining);
	  }
	}
}