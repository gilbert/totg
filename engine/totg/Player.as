package engine.totg
{
	import engine.flixel.*;

	public class Player extends FlxSprite
	{
		[Embed(source="../../content/textures/actors/hat-walk.png")]
		private var ImgHatWalk:Class;
		[Embed(source="../../content/textures/effects/attack.png")]
		private var ImgAttack:Class;

		//private var _bullets:Array;
		//private var _up:Boolean;
		public var runSpeed:uint;
		public var hp:uint;
		public var hpMax:uint;
		public var hpBar:StatBar;
	  public var mp:uint;
		public var mpMax:uint;
		public var mpBar:StatBar;
		
		public function Player(X:int,Y:int)
		{
			super(X,Y);
			loadGraphic(ImgHatWalk,true,true,30);
			facing = DOWN;
			
			//bounding box tweaks
			width = 30;
			height = 30;
			offset.x = 0;
			offset.y = 0;
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
			
			addAnimation("idle", [0,1], 2);
			addAnimation("walk-down", [0,1], 8);
			addAnimation("walk-side", [2,3], 8);
			addAnimation("walk-up", [4,5], 8);
			
			/*/animations
			addAnimation("idle", [0]);
			addAnimation("run", [1, 2, 3, 0], 12);
			addAnimation("jump", [4]);
			addAnimation("idle_up", [5]);
			addAnimation("run_up", [6, 7, 8, 5], 12);
			addAnimation("jump_up", [9]);
			addAnimation("jump_down", [10]);
			/**/
			
			/*/Gibs emitted upon death
			_gibs = Gibs;
			/**/
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
				
				play("walk-side");
				velocity.x = -runSpeed;
			}
			else if(FlxG.keys.RIGHT){
				facing = RIGHT;
        /*_flipped = true;*/
				
				play("walk-side");
				velocity.x = runSpeed;
			}
			
			if(!FlxG.keys.LEFT && !FlxG.keys.RIGHT && !FlxG.keys.UP && !FlxG.keys.DOWN){
        play("idle");
        facing = DOWN;
      }
			/**/
			
			/*/ANIMATION
			if(velocity.y != 0)
			{
				if(_up) play("jump_up");
				else if(_down) play("jump_down");
				else play("jump");
			}
			else if(velocity.x == 0)
			{
				if(_up) play("idle_up");
				else play("idle");
			}
			else
			{
				if(_up) play("run_up");
				else play("run");
			}
			/**/
			
			//SHOOTING
			if(!flickering() && FlxG.keys.justPressed("C"))
			{
				// action stuff goes here
			}
				
			//UPDATE POSITION AND ANIMATION
			super.update();
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
	}
}