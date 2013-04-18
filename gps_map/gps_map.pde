import tomc.gpx.*;

GPX gpx;
Map map;
Marker[] markers;

void setup() {
  size(600, 600);
  smooth();
  noStroke();
  gpx = new GPX(this);
  map = new Map(gpx);
  map.displayImage();
  
  for(int i = 0; i <map.markers.length; i++){
    map.markers[i].display();
  }
}

void draw() {
}

