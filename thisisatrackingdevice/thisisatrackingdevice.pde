import processing.opengl.*;
import codeanticode.glgraphics.*;
import de.fhpotsdam.unfolding.mapdisplay.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.interactions.*;
import de.fhpotsdam.unfolding.ui.*;
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.texture.*;
import de.fhpotsdam.unfolding.events.*;
import de.fhpotsdam.utils.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.providers.*;


UnfoldingMap map;
GpxHandler gpxHandler;
SimplePointMarker chicagoMarker;

void setup(){
  size(800, 600, GLConstants.GLGRAPHICS);
  noStroke();
  
  int zoom = 14;
  float latitude = 41.8500;
  float longitude = -87.6500;
  float maxPanningDistance = 30; // in km
  
  map = new UnfoldingMap(this, new OpenStreetMap.CloudmadeProvider("038dee0bec3441f495c0dee8b72467fd", 93093));
  List<Feature> parsedGpx = GPXReader.loadData(this, "sample.gpx");
  gpxHandler = new GpxHandler(parsedGpx);
  MapUtils.createDefaultEventDispatcher(this, map);
  Location chicago = new Location(latitude, longitude);
  map.zoomAndPanTo(chicago, zoom);
  map.setPanningRestriction(chicago, maxPanningDistance);
  chicagoMarker = new SimplePointMarker(chicago);
  map.addMarkers(chicagoMarker);
  
}

void draw(){
   map.draw(); 
   ScreenPosition chicagoPosition = chicagoMarker.getScreenPosition(map);
   fill(255, 0, 0, 100);
   ellipse(chicagoPosition.x, chicagoPosition.y, 10, 10);
   Location location = map.getLocation(mouseX, mouseY);
   fill(0);
   text(location.getLat()+", "+location.getLon(), mouseX, mouseY);
}
