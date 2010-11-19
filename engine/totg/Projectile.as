package engine.totg
{
	import engine.flixel.*;

	public class Projectile extends FlxSprite
	{
/*    [Embed(source="../../../data/bullet.png")] private var ImgBullet:Class;*/
		
		protected var power:int;
		
		// An object of functions that take this projectile as its parameter
		// List of available hooks:
		//   kill, hit
		private var hooks:Object;
		
    // Default projectile, deals no damage.
    // Other classes should extend this class
    //
		public function Projectile(hooks:Object)
		{
			super();
			
			this.hooks = hooks;
			
			createGraphic(6,6);
			
			power = 0;
			
			width = 6;
			height = 6;
			offset.x = 1;
			offset.y = 1;
      exists = false;
		}
		
		override public function update():void
		{
			super.update();
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
		
		public function shoot(X:int, Y:int, VelocityX:int, VelocityY:int):Projectile
		{
      super.reset(X,Y);
			solid = true;
			velocity.x = VelocityX;
			velocity.y = VelocityY;
			return this;
		}
		
		private function hook(name:String):void {
		  if(hooks[name]) hooks[name](this);
		}
	}
}