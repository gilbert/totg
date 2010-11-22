package engine.totg
{
	import engine.flixel.*;

	public class AI
	{
	  
	  public static var tempVector:Object = {x:0,y:0};
	  
    public static function movement(type:String = null):Function
    {
      switch(type){
        case 'chase': return chase();
        default: return chill();
      }
    }
    
    private static function chill():Function
    {
      var player:Player = PlayState.player;
      return function():void {
        return;
      }
    }
    
    private static function chase():Function
    {
      var player:Player = PlayState.player;
      return function():void {
        var tempForce:Object = tempVector;
        
        tempForce.x = (player.x + (player.width>>1)) - (this.x + (this.width>>1));
      	tempForce.y = (player.y + (player.height>>1)) - (this.y + (this.height>>1));
      	
      	VMath.normalize(tempForce);
      	this.velocity.x = tempForce.x * this.speed;
      	this.velocity.y = tempForce.y * this.speed;
      }
    }
  }
}
