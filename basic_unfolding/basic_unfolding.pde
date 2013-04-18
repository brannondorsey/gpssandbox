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

void setup(){
  size(800, 600, GLConstants.GLGRAPHICS);
  map = new UnfoldingMap(this, new OpenStreetMap.CloudmadeProvider("038dee0bec3441f495c0dee8b72467fd", 93093));
  MapUtils.createDefaultEventDispatcher(this, map);
}

void draw(){
   map.draw(); 
   Location location = map.getLocation(mouseX, mouseY);
   fill(0);
   text(location.getLat()+", "+location.getLon(), mouseX, mouseY);
}
