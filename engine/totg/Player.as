package engine.totg
{
	import engine.flixel.*;

	public class Player extends FlxSprite
	{
		[Embed(source="../../content/textures/actors/hat-walk.png")]
		private var ImgHatWalk:Class;

		//private var _bullets:Array;
		//private var _up:Boolean;
		public var runSpeed:uint;
		public var hp:int;
		public var hpMax:int;
		public var hpBar:StatBar;
	  public var mp:int;
		public var mpMax:int;
		public var mpBar:StatBar;
		
		public var attacks:FlxGroup;
		
		public function Player(X:int,Y:int)
		{
			super(X,Y);
			loadGraphic(ImgHatWalk,true,false,30);
			facing = DOWN;
			
			//bounding box tweaks
			width = 19;
			height = 25;
			offset.x = 5;
			offset.y = 2;
			/**/
			
			//player stats
			hpMax = 17;
			hp = hpMax;
			mpMax = 7;
			mp = mpMax;
			runSpeed = 80;
			/**/
			
			//player stats HUD
			hpBar = new StatBar(4,4,0xffff0000);
			mpBar = new StatBar(4,16,0xff0000ff);
			
			addAnimation("idle-down", [0,1], 2);
			addAnimation("idle-right", [2,3], 2);
			addAnimation("idle-left", [4,5], 2);
			addAnimation("idle-up", [6,7], 2);
			
			addAnimation("walk-down", [0,1], 8);
			addAnimation("walk-right", [2,3], 8);
			addAnimation("walk-left", [4,5], 8);
			addAnimation("walk-up", [6,7], 8);
			
			/*/Gibs emitted upon death
			_gibs = Gibs;
			/**/
			attacks = new FlxGroup();
		}
		
		override public function update():void
		{
			/*/game restart timer
			if(dead)
			{
				_restart += FlxG.elapsed;
				if(_restart > 2)
					(FlxG.state as PlayState).reload = true;
				return;
			}
			/**/
			
			//MOVEMENT
			velocity.x = 0;
			velocity.y = 0;
      if(FlxG.keys.UP){
        facing = UP;
        /*_flipped = false;*/
        
        if(!FlxG.keys.LEFT && !FlxG.keys.RIGHT) play("walk-up");
        velocity.y = -runSpeed;
      }
      else if(FlxG.keys.DOWN){
        facing = DOWN;
        /*_flipped = false;*/
        
        if(!FlxG.keys.LEFT && !FlxG.keys.RIGHT) play("walk-down");
        velocity.y = runSpeed;
      }
      
      if(FlxG.keys.LEFT){
				facing = LEFT;
        /*_flipped = false;*/
				
				play("walk-left");
				velocity.x = -runSpeed;
			}
			else if(FlxG.keys.RIGHT){
				facing = RIGHT;
        /*_flipped = true;*/
				
				play("walk-right");
				velocity.x = runSpeed;
			}
			
			if(!FlxG.keys.LEFT && !FlxG.keys.RIGHT && !FlxG.keys.UP && !FlxG.keys.DOWN){
			  if(facing == LEFT) play('idle-left');
			  else if(facing == RIGHT) play('idle-right');
			  else if(facing == UP) play('idle-up');
			  else play('idle-down');
      }
      
      if(!flickering() && FlxG.keys.justPressed("C")){
        
      }
			
			//SHOOTING
			if(!flickering() && FlxG.keys.justPressed("A"))
			{
				// action stuff goes here
				var bXVel:int = 0;
				var bYVel:int = 0;
				var bX:int = x;
				var bY:int = y;
				if(facing == UP)
				{
					bY -= 0;
				}
				else if(facing == DOWN)
				{
					bY += height;
				}
				else if(facing == RIGHT)
				{
					bX += width;
				}
				else if(facing == LEFT)
				{
				  // we subtract here because of weird stuff with sprite flipping
					bX -= 0;
				}
				
        var attack:Projectile = Projectile.create('slash',{
          kill: makeKillHook()
        });
        attack.fire(bX,bY,facing);
        attacks.add(attack);
			}
				
			//UPDATE POSITION AND ANIMATION
			super.update();
			
      // update current attacks
      attacks.update();
		}
		
		override public function render():void
		{
		  // render current attacks
	    super.render();
	    attacks.render();
		}
		
		override public function hitBottom(Contact:FlxObject,Velocity:Number):void
		{
			
		}
		
		override public function hurt(Damage:Number):void
		{
			/*Damage = 0;
			     if(flickering())
			       return;
			     FlxG.play(SndHurt);
			     flicker(1.3);
			     if(FlxG.score > 1000) FlxG.score -= 1000;
			     if(velocity.x > 0)
			       velocity.x = -maxVelocity.x;
			     else
			       velocity.x = maxVelocity.x;
			     super.hurt(Damage);*/
		}
		
		override public function kill():void
		{
			
		}
		
		public function makeKillHook():Function {
		  var self:Player = this;
		  return function(attack:Projectile):void {
		    self.doneWithAttack(attack);
		  }
		}
		
		private function doneWithAttack(a:Projectile):void {
		  attacks.remove(a,true);
		}
	}
}