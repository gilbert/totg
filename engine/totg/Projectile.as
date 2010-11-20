package engine.totg
{
	import engine.flixel.*;

	public class Projectile extends FlxSprite
	{
    public static function create(type:String,hooks:Object):Projectile
    {
      switch(type){
        case 'slash': return new Slash(hooks);
        default: return new Projectile(hooks);
      }
    }
    
    // instance vars
    //
    protected var animDims:Object = {
  	  (''+LEFT):  {width:5,height:5,posOffset:{x:0,y:0},offset:{x:0,y:0}},
  	  (''+RIGHT): {width:5,height:5,posOffset:{x:0,y:0},offset:{x:0,y:0}},
  	  (''+UP):    {width:5,height:5,posOffset:{x:0,y:0},offset:{x:0,y:0}},
  	  (''+DOWN):  {width:5,height:5,posOffset:{x:0,y:0},offset:{x:0,y:0}}
  	}
		
		// An object of functions that take this projectile as its parameter
		// List of available hooks:
		//   kill, hit
		protected var hooks:Object;
		public var speed:int;
		public var power:int;
		public var duration:int;
		
    // Default projectile, deals no damage.
    // Other classes should extend this class
    //
		public function Projectile(hooks:Object)
		{
			super();
			
			this.hooks = hooks;
			
			createGraphic(6,6);
			
			speed = 10;
			power = 0;
			duration = 999;
			
			width = 5;
			height = 5;
			offset.x = 0;
			offset.y = 0;
      exists = false;
		}
		
		override public function update():void
		{
			super.update();
			duration -= 1;
			if(duration <= 0){
			  kill();
			}
		}
		
		override public function render():void
		{
			super.render();
		}

		override public function hitRight(Contact:FlxObject,Velocity:Number):void { kill(); }
		override public function hitLeft(Contact:FlxObject,Velocity:Number):void { kill(); }
		override public function hitBottom(Contact:FlxObject,Velocity:Number):void { kill(); }
		override public function hitTop(Contact:FlxObject,Velocity:Number):void { kill(); }
		
		override public function kill():void
		{
			if(dead) return;
			velocity.x = 0;
			velocity.y = 0;
			dead = true;
			solid = false;
			
			hook('kill');
		}
		
		public function fire(X:int, Y:int, facing:uint):Projectile
		{
      super.reset(X,Y);
			solid = true;
			velocity.x = 0;
			velocity.y = 0;
			
			var dims:Object = animDims[facing];
			width = dims.width;
			height = dims.height;
			offset.x = dims.offset.x;
			offset.y = dims.offset.y;
			x += dims.posOffset.x;
			y += dims.posOffset.y;
			
			switch(facing){
			  case LEFT:  velocity.x = -speed; play('fire-left'); break;
			  case RIGHT: velocity.x = speed; play('fire-right'); break;
			  case UP:    velocity.y = -speed; play('fire-up'); break;
			  case DOWN:  velocity.y = speed; play('fire-down'); break;
			}
			
			return this;
		}
		
		private function hook(name:String):void {
		  if(hooks[name]) hooks[name](this);
		}
	}
}

import engine.totg.*;

class Slash extends Projectile
{
  [Embed(source="../../content/textures/effects/slash.png")]
	private var ImgSlash:Class;
	
  public function Slash(hooks:Object)
  {
    super(hooks);
    
    width = 12;
		height = 29;
		offset.x = 0;
		offset.y = 0;
    
    animDims = {
  	  (''+LEFT):  {width:12,height:29,posOffset:{x:-12,y:0},offset:{x:0,y:0}},
  	  (''+RIGHT): {width:12,height:29,posOffset:{x:0,y:0},offset:{x:0,y:0}},
  	  (''+UP):    {width:30,height:12,posOffset:{x:-6,y:-12},offset:{x:0,y:0}},
  	  (''+DOWN):  {width:30,height:12,posOffset:{x:-6,y:0},offset:{x:0,y:0}}
  	};
    
    loadGraphic(ImgSlash,true);
    addAnimation('fire-right',[0], 1, false);
    addAnimation('fire-left',[1], 1, false);
    addAnimation('fire-up',[2], 1, false);
    addAnimation('fire-down',[3], 1, false);
    
    speed = 160;
    power = 5;
    duration = 15;
  }
}
