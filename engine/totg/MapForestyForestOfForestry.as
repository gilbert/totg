//Code generated by Flan. http://www.tbam.com.ar/utility--flan.php

package engine.totg {
	import engine.flixel.*;
	
	public class MapForestyForestOfForestry extends MapBase {
		//Media content declarations
		[Embed(source="../../content/levels/MapCSV_ForestyForestOfForestry_Main.txt", mimeType="application/octet-stream")] public var CSV_Main:Class;
		[Embed(source="../../content/textures/tiles/forest1.png")] public var Img_Main:Class;
		[Embed(source="../../content/levels/MapCSV_ForestyForestOfForestry_Background.txt", mimeType="application/octet-stream")] public var CSV_Background:Class;
		[Embed(source="../../content/textures/tiles/forest1.png")] public var Img_Background:Class;

		
		public function MapForestyForestOfForestry() {

			_setCustomValues();

			bgColor = 0xff00ff6e;

			layerMain = new FlxTilemap();
			layerMain.loadMap(new CSV_Main, Img_Main,40,40);
			layerMain.x = 0;
			layerMain.y = 0;
			layerMain.scrollFactor.x = 1.000000;
			layerMain.scrollFactor.y = 1.000000;
			
			layerBackground = new FlxTilemap()
			layerBackground.loadMap(new CSV_Background, Img_Background,40,40);
			layerBackground.x = 0;
			layerBackground.y = 0;
			layerBackground.scrollFactor.x = 1.000000;
			layerBackground.scrollFactor.y = 1.000000;

			allLayers = [ layerMain, layerBackground ];


			boundsMinX = 0;
			boundsMinY = 0;
			boundsMaxX = 800;
			boundsMaxY = 400;
		}

		override public function customFunction(param:* = null):* {

		}

		private function _setCustomValues():void {
		}

	}
}
