package engine.totg
{
	import engine.flixel.*;

	public class Attack
	{
    public static function create(type:String,owner:Actor,hooks:Object = null):Attack
    {
      switch(type){
        case 'slash': return new Slash(owner,hooks);
        default: FlxG.log('Error: bad attack type');
      }
      return null;
    }
    
    public var owner:Actor;
    // cooldown is expressed in frames
    public var cooldown:int, overheat:int;
    public var hpCost:int, mpCost:int, apCost:int;
    public var hooks:Object;
    // if false, this attack is not available for use
    public var active:Boolean;
    
    public var projectiles:FlxGroup;
    
    public function Attack(owner:Actor,hooks:Object)
    {
      overheat = 0;
      cooldown = 60;
      active = true;
      
      projectiles = new FlxGroup();
      this.owner = owner;
      this.hooks = hooks || {};
    }
    
    public function launch():void
    {
      // override me
      FlxG.log("Error: you're not supposed to be here");
    }
    
    public function calcLaunchPoint():FlxPoint
    {
      // calculate launch point
      var bXVel:int = 0;
  		var bYVel:int = 0;
  		var bX:int = owner.x;
  		var bY:int = owner.y;
  		if(owner.facing == FlxSprite.UP)
  		{
  			bY -= 0;
  		}
  		else if(owner.facing == FlxSprite.DOWN)
  		{
  			bY += owner.height;
  		}
  		else if(owner.facing == FlxSprite.RIGHT)
  		{
  			bX += owner.width;
  		}
  		else if(owner.facing == FlxSprite.LEFT)
  		{
  			bX -= 0;
  		}
  		return new FlxPoint(bX,bY);
    }
    
    public function update():void
    {
      if(overheat > 0) overheat -= 1;
    }
    
    public function makeKillHook():Function {
		  var self:Attack = this;
		  return function(p:Projectile):void {
		    self.doneWithProjectile(p);
		  }
		}
		
		private function doneWithProjectile(p:Projectile):void {
		  this.projectiles.remove(p,true);
		  owner.projectiles.remove(p,true);
		}
  }
}

import engine.totg.*;
import engine.flixel.*;

class Slash extends Attack
{
  
  public function Slash(owner:Actor,hooks:Object)
  {
    super(owner,hooks);
    cooldown = 10;
  }
  
  override public function launch():void
  {
    if(overheat > 0) return;
    FlxG.log('launched a slash attack!');
    // OPTIMIZE: instead of creating a new projectile
    // every time, store and use the same ones over and
    // over again
    var p:Projectile = Projectile.create('slash',{
      kill: makeKillHook()
    });
    // added before firing because who knows, the fire method
    // might instantly remove the projectile from the group
    this.projectiles.add(p);
    owner.projectiles.add(p);
    
    var point:FlxPoint = calcLaunchPoint();
    p.fire(point.x,point.y,owner.facing);
    
    overheat += cooldown;
  }
  
}