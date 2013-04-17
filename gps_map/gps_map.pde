import tomc.gpx.*;

GPX gpx;
Map map;
Marker[] markers;

void setup() {
  size(600, 600);
  background(255);
  gpx = new GPX(this);
  map = new Map(gpx);
}

void draw() {
}

