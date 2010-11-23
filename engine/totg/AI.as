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
    
    public static function attack(type:String = null):Function
    {
      switch(type){
        case 'melee': return melee();
        default: return peaceful();
      }
    }
    
    /* Movement AI functions */
    
    private static function chill():Function
    {
      var player:Player = PlayState.player;
      return function():void {
        var tempForce:Object = tempVector;
        
        tempForce.x = 0;
      	tempForce.y = 0;
      	
        VMath.subtract(tempForce,this.velocity);
      	this.velocity.x += Math.max( Math.min(tempForce.x,this.speed), -this.speed );
      	this.velocity.y += Math.max( Math.min(tempForce.y,this.speed), -this.speed );
      }
    }
    
    private static function chase():Function
    {
      var player:Player = PlayState.player;
      return function():void {
        var tempForce:Object = tempVector;
        
        tempForce.x = (player.x + (player.width>>1)) - (this.x + (this.width>>1)); // desired velocity
      	tempForce.y = (player.y + (player.height>>1)) - (this.y + (this.height>>1));
      	
      	VMath.normalize(tempForce);
      	tempForce.x *= this.speed;
      	tempForce.y *= this.speed;
        VMath.subtract(tempForce,this.velocity);
      	this.velocity.x += Math.max( Math.min(tempForce.x,this.speed), -this.speed );
      	this.velocity.y += Math.max( Math.min(tempForce.y,this.speed), -this.speed );
      	
      	// set appropriate facing
      	var X:Number = Math.abs(this.velocity.x),
      	    Y:Number = Math.abs(this.velocity.y);
      	
      	if(X > Y && this.velocity.x > 0)
      	  this.facing = FlxSprite.RIGHT;
      	else if(X > Y)
      	  this.facing = FlxSprite.LEFT;
      	else if(X < Y && this.velocity.y > 0)
      	  this.facing = FlxSprite.DOWN;
      	else
      	  this.facing = FlxSprite.UP;
      	/**/
      }
    }
    
    /* Attack AI functions */
    private static function peaceful():Function
    {
      var player:Player = PlayState.player;
      return function():void {
        return;
      }
    }
    
    private static function melee():Function
    {
      var player:Player = PlayState.player;
      return function(projectileType:String):void {
        
        var d2:Number = Math.pow(player.x - this.x,2) + Math.pow(player.y - this.y,2);
        if(d2 < Math.pow(100,2)){
          this.attacks[projectileType].launch();
        }
      }
    }
  }
}
