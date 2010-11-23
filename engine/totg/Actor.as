package engine.totg
{
	import engine.flixel.*;

	public class Actor extends FlxSprite
	{
	  public var _hp:int;
		public var _hpMax:int;
		public var _mp:int;
		public var _mpMax:int;
		public var _ap:int;
		public var _apMax:int;
		
		// An object of functions that take this projectile as its parameter
		// List of available hooks:
		//   kill, hit
		protected var hooks:Object;
		
		public function Actor(X:int,Y:int,hooks:Object)
		{
		  super(X,Y);
		  this.hooks = hooks;
		}
		
    /* Boring but useful getters and setters */
		public function get hp():int { return _hp; }
		public function set hp(val:int):void {
		  _hp = Math.max(val,0);
		}
		public function get hpMax():int { return _hpMax; }
		public function set hpMax(val:int):void {
		  _hpMax = Math.max(val,0);
		  _hp = Math.min(_hpMax,_hp);
		}
		
		
		public function get mp():int { return _mp; }
		public function set mp(val:int):void {
		  _mp = Math.max(val,0);
		}
		public function get mpMax():int { return _mpMax; }
		public function set mpMax(val:int):void {
		  _mpMax = Math.max(val,0);
		  _mp = Math.min(_mpMax,_mp);
		}
		
		
		public function get ap():int { return _ap; }
		public function set ap(val:int):void {
		  _ap = Math.max(val,0);
		}
		public function get apMax():int { return _apMax; }
		public function set apMax(val:int):void {
		  _apMax = Math.max(val,0);
		  _ap = Math.min(_apMax,_ap);
		}
		
    /* A bit more interesting stuff */
		
		// reduces incoming damage based on armor, defense, etc
		//
		override public function hurt(dmg:Number):void
		{
		  if(flickering()) return;
		  hp -= dmg;
		  flicker(0.2);
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
		
		public function push(xForce:Number,yForce:Number):void
		{
		  FlxG.log('pushing x:'+xForce+', y:'+yForce);
      // for some reason I feel like this function is needed
		  velocity.x += xForce;
		  velocity.y += yForce;
		}
		
		public function hook(name:String):void {
		  if(hooks[name]) hooks[name](this);
		}
  }
}