class GpxHandler{
  
  Location[] pts;
  double minLat, maxLat, minLon, maxLon;
  
  String fileToParse = "newforest.gpx";
  
  GpxHandler(List<Feature> _parsedGpx){
    List<Feature> parsedGpx = _parsedGpx;
    List<Marker> markers = (List) MapUtils.createSimpleMarkers(parsedGpx);
    pts = new Location[markers.size()];
    for(int i = 0; i < markers.size(); i++){
      Marker currentMarker = markers.get(i);
      //pts[i] = currentMarker.getLocation();
      println(currentMarker);
    }
    
    minLat = getMinOrMax("min", "lat");
    maxLat = getMinOrMax("max", "lat");
    minLon = getMinOrMax("min", "lon");
    maxLon = getMinOrMax("max", "lon");
  }
  
  
  //i.e. getMin("max", "lat");
  float getMinOrMax(String minOrMax, String latOrLon) {
    float[] allPts = new float[pts.length];
    for (int i = 0; i < pts.length; i++) {
      if (latOrLon.equals("lat")) allPts[i] = (float) pts[i].getLat();
      else if (latOrLon.equals("lon")) allPts[i] = (float) pts[i].getLon();
    }
    if (minOrMax.equals("min")) {
      return min(allPts);
    }
    else return max(allPts);
  }
  
//  Float[] getCenter(){
//    
//  }
  
}
