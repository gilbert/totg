package engine.totg
{
	import engine.flixel.*;

	public class Player extends Actor
	{
		[Embed(source="../../content/textures/actors/hat-walk.png")]
		private var ImgHatWalk:Class;

		//private var _bullets:Array;
		//private var _up:Boolean;
		public var runSpeed:uint;
		public var hpBar:StatBar;
		public var mpBar:StatBar;
		
		public function Player(X:int,Y:int,hooks:Object = null)
		{
			super(X,Y,hooks);
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
			attacks = {
			  'slash': Attack.create('slash',this)
			};
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
        
        if(!FlxG.keys.LEFT && !FlxG.keys.RIGHT) play("walk-up");
        velocity.y = -runSpeed;
      }
      else if(FlxG.keys.DOWN){
        facing = DOWN;
        
        if(!FlxG.keys.LEFT && !FlxG.keys.RIGHT) play("walk-down");
        velocity.y = runSpeed;
      }
      
      if(FlxG.keys.LEFT){
				facing = LEFT;
				
				play("walk-left");
				velocity.x = -runSpeed;
			}
			else if(FlxG.keys.RIGHT){
				facing = RIGHT;
				
				play("walk-right");
				velocity.x = runSpeed;
			}
			
			if(!FlxG.keys.LEFT && !FlxG.keys.RIGHT && !FlxG.keys.UP && !FlxG.keys.DOWN){
			  if(facing == LEFT) play('idle-left');
			  else if(facing == RIGHT) play('idle-right');
			  else if(facing == UP) play('idle-up');
			  else play('idle-down');
      }
      
			if(!flickering() && FlxG.keys.justPressed("A"))
			{
				attacks['slash'].launch();
			}
				
			super.update();
			
      for(var key:String in attacks){
        attacks[key].update();
      }
      projectiles.update();
		}
		
		override public function render():void
		{
		  // render current attacks
	    super.render();
	    projectiles.render();
		}
		
		override public function kill():void
		{
			
		}
	}
}