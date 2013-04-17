class Map {
  GPX gpx;
  Marker[] markers;
  float minLat, maxLat, minLon, maxLon;
  
  PImage mapImage;

  Map(GPX _gpx) {
    gpx = _gpx;
    getMarkers();
    minLat = getMinOrMax("min", "lat");
    maxLat = getMinOrMax("max", "lat");
    minLon = getMinOrMax("min", "lon");
    maxLat = getMinOrMax("min", "lat");
    
    mapImage = getImage();
  }

  void getMarkers() {
    gpx.parse("newforest.gpx");
    for (int i = 0; i < gpx.getTrackCount(); i++) {
      GPXTrack trk = gpx.getTrack(i);
      // do something with trk.name
      for (int j = 0; j < trk.size(); j++) {
        GPXTrackSeg trkseg = trk.getTrackSeg(j);
        for (int k = 0; k < trkseg.size(); k++) {
          GPXPoint pt = trkseg.getPoint(k);
          //markers[k] = new Marker(pt); 
          println("this points lat is "+pt.lat);
        }
      }
    }

    for (int i = 0; i < gpx.getWayPointCount(); i++) {
      GPXWayPoint wpt = gpx.getWayPoint(i);
      // do something with wpt.lat or wpt.lon or wpt.name or wpt.type
    }
  }
  
  void displayImage(){
    image(mapImage, width, height);
  }
  
  PImage getImage(){
    int scale = 1;
    String mapType = "terrain";
    double centerLat = maxLat-((maxLat-minLat)/2);
    double centerLon = maxLon-((maxLon-minLon)/2);
    String[] styleData = loadStrings("style.txt");
    String style = join(styleData,"");
    
    PImage img = loadImage("http://maps.googleapis.com/maps/api/staticmap?center="+centerLat+","+centerLon+
    "&scale="+scale+"&size="+width+"x"+height+"&maptype="+mapType+style);
    return img;
  }
  
  //i.e. getMin("max", "lat");
  float getMinOrMax(String minOrMax, String latOrLon) {
    float[] allMarkers = new float[markers.length];
    for(int i = 0; i < markers.length; i++){
      if(latOrLon.equals("lat")) allMarkers[i] = (float) markers[i].lat;
      else if(latOrLon.equals("lon")) allMarkers[i] = (float) markers[i].lon;
    }
    if(minOrMax.equals("min")) return min(allMarkers);
    else return max(allMarkers);
  }
}

