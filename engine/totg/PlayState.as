package engine.totg {
import engine.flixel.*;

public class PlayState extends FlxState
{
	
	private var _map:MapForestyForestOfForestry;
	public var player:Player;
	
	protected var _enemies:FlxGroup;
	protected var _e_attacks:FlxGroup;
	
	protected var _objects:FlxGroup;
	protected var _enemiesGroup:FlxGroup;
	
	override public function create():void
	{
	  super.create();
		_map = new MapForestyForestOfForestry;
		
		_enemies = new FlxGroup();
		_e_attacks = new FlxGroup();
		
    // meta groups for collision
    _enemiesGroup = new FlxGroup();
    _enemiesGroup.add(_enemies);
    _enemiesGroup.add(_e_attacks);
		
		//Add the layers to current the FlxState
		this.add(_map.layerBackground);
		this.add(_map.layerMain);
		
		this.add(_enemies);
		
		player = new Player(0,0);
		this.add(player);
		//this.add(player.hpBar);
		//this.add(player.mpBar);
		
		this.add(_e_attacks);
		
		FlxG.follow(player);
		FlxG.followBounds(_map.boundsMinX, _map.boundsMinY, _map.boundsMaxX, _map.boundsMaxY);
		
		_enemies.add(Enemy.create('spider',250,50,{}));
		_enemies.add(Enemy.create('spider',150,70,{}));
		_enemies.add(Enemy.create('spider',100,170,{}));
	}
		
	override public function update():void
	{
		super.update();
		
		//collisions with environment
    /*FlxU.collide(_blocks,_objects);*/
    _map.layerMain.collide(player);
    _map.layerMain.collide(player.attacks);
		FlxU.overlap(_enemiesGroup,player,overlapped);
		FlxU.overlap(player.attacks,_enemies,overlapped);
	}
	
	protected function overlapped(Object1:FlxObject,Object2:FlxObject):void
	{
    if(Object1 is Projectile && Object2 is Enemy){
      var p:Projectile = Object1 as Projectile;
      Object2.hurt(p.power);
      p.kill();
    }
	}
	
}


}// end package

