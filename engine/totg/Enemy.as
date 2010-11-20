package engine.totg
{
	import engine.flixel.*;

	public class Enemy extends FlxSprite
	{
    public static function create(type:String,X:int,Y:int,hooks:Object):Enemy
    {
      switch(type){
        case 'spider': return new Spider(X,Y,hooks);
        default: return new Enemy(X,Y,hooks);
      }
    }
    
    // instance vars
    //
		public var power:int;
		public var hp:int;
		public var hpMax:int;
		
		// An object of functions that take this projectile as its parameter
		// List of available hooks:
		//   kill, hit
		protected var hooks:Object;
		protected var speed:int;
		protected var duration:int;
		
    // Default enemy, a killer, non-lethal square.
    // Other enemy classes should extend this class
    //
		public function Enemy(X:int,Y:int,hooks:Object)
		{
			super(X,Y);
			
			this.hooks = hooks;
			
			createGraphic(16,16);
			
			speed = 10;
			power = 0;
			hpMax = 15;
			hp = hpMax;
			
			width = 16;
			height = 16;
			offset.x = 0;
			offset.y = 0;
		}
		
		override public function update():void
		{
			super.update();
		}
		
		override public function render():void
		{
			super.render();
		}
		
		// reduces incoming damage based on armor, defense, etc
		//
		override public function hurt(dmg:Number):void
		{
		  if(flickering()) return;
		  hp -= dmg;
		  flicker(0.2);
		  if(hp < 0) hp = 0;
		  if(hp == 0) kill();
		}
		
		override public function kill():void
		{
			if(dead) return;
			velocity.x = 0;
			velocity.y = 0;
			dead = true;
			solid = false;

			hook('kill');
		}
		
		private function hook(name:String):void {
		  if(hooks[name]) hooks[name](this);
		}
	}
}

import engine.totg.*;

class Spider extends Enemy
{
  [Embed(source="../../content/textures/actors/spider.png")]
	private var ImgSpider:Class;
	
  public function Spider(X:int,Y:int,hooks:Object)
  {
    super(X,Y,hooks);
    
    loadGraphic(ImgSpider,true,true,40);
    
    width = 16;
		height = 5;
		offset.x = 12;
		offset.y = 18;
    
    addAnimation('walk',[0,1], 3);
    addAnimation('death',[2,3,4], 8, false);
    play('walk');
    
    speed = 20;
    power = 1;
  }
  
  override public function kill():void
  {
    play('death');
    super.kill();
  }
}