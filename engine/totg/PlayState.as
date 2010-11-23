package engine.totg {
import engine.flixel.*;

public class PlayState extends FlxState
{
	
	public static var player:Player;
	
	private var _map:MapForestyForestOfForestry;
	
	protected var _player:Player;
	
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
		
		_player = new Player(150,150);
		this.add(_player);
		PlayState.player = _player;
		this.add(_player.hpBar);
		//this.add(_player.mpBar);
		
		this.add(_e_attacks);
		
		FlxG.follow(_player);
		FlxG.followBounds(_map.boundsMinX, _map.boundsMinY, _map.boundsMaxX, _map.boundsMaxY);
		
		for(var i:int=0;i<5;i++){
		  var ranX:int = Math.ceil(Math.random() * 500);
		  var ranY:int = Math.ceil(Math.random() * 500);
		  var e:Enemy = Enemy.create('spider',ranX,ranY,{})
		  _enemies.add(e);
		  _e_attacks.add(e.projectiles);
		}
	}
		
	override public function update():void
	{
		super.update();
		
		//collisions with environment
    /*FlxU.collide(_blocks,_objects);*/
    _map.layerMain.collide(_player);
    _map.layerMain.collide(_enemies);
    _map.layerMain.collide(_player.projectiles);
		//FlxU.overlap(_enemiesGroup,_player,overlapped);
		FlxU.overlap(_player.projectiles,_enemies,overlapped);
		FlxU.overlap(_e_attacks,_player,overlapped);
	}
	
	protected function overlapped(Object1:FlxObject,Object2:FlxObject):void
	{
    if(Object1 is Projectile && Object2 is Actor){
      var p:Projectile = Object1 as Projectile;
      var a:Actor = Object2 as Actor;
      p.hitActor(a);
    }
	}
	
}


}// end package

