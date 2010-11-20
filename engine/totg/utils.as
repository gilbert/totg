package engine.totg
{
	import engine.flixel.*;

	public class utils extends FlxSprite
	{
	  
	  public static function deepTrace( obj : *, level : int = 0 ) : void{
      var tabs : String = "";
      for ( var i : int = 0 ; i < level ; i++, tabs += "\t" ){}

      for ( var prop : String in obj ){
          FlxG.log( tabs + "[" + prop + "] -> " + obj[ prop ] );
          deepTrace( obj[ prop ], level + 1 );
      }
    }
    
	}
}