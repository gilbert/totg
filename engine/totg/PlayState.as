package engine.totg {
import engine.flixel.*;

public class PlayState extends FlxState
{
	
	private var _map:MapForestyForestOfForestry;
	public var player:Player;
	protected var _p_attacks:FlxGroup;
	
	protected var _enemies:FlxGroup;
	protected var _e_attacks:FlxGroup;
	
	protected var _objects:FlxGroup;
	protected var _enemiesGroup:FlxGroup;
	
	override public function create():void
	{
	  super.create();
		_map = new MapForestyForestOfForestry;
		
		_p_attacks = new FlxGroup();
		_enemies = new FlxGroup();
		_e_attacks = new FlxGroup();
		
    // meta groups for collision
    _enemiesGroup = new FlxGroup();
    _enemiesGroup.add(_enemies);
    _enemiesGroup.add(_e_attacks);
    _objects = new FlxGroup();
    _objects.add(player);
    _objects.add(_p_attacks);
		
		//Add the layers to current the FlxState
		this.add(_map.layerBackground);
		this.add(_map.layerMain);
		
		player = new Player(50,50);
		this.add(player);
		this.add(player.hpBar);
		this.add(player.mpBar);
		
		FlxG.follow(player);
		FlxG.followBounds(_map.boundsMinX, _map.boundsMinY, _map.boundsMaxX, _map.boundsMaxY);
	}
		
	override public function update():void
	{
		super.update();
		
		//collisions with environment
    /*FlxU.collide(_blocks,_objects);*/
    _map.layerMain.collide(player);
		FlxU.overlap(_enemiesGroup,player,overlapped);
		FlxU.overlap(_p_attacks,_enemies,overlapped);
	}
	
	protected function overlapped(Object1:FlxObject,Object2:FlxObject):void
	{
    /*if(false && Object1 is Attack)*/
      /*Object2.hurt(Object1.health);*/
	}
	
}


}// end package

