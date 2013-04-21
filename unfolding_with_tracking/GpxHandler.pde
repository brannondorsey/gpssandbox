class GpxHandler{
  
  GPX gpx;
  GPXPoint[] pts;
  double minLat, maxLat, minLon, maxLon;
  
  String fileToParse = "newforest.gpx";
  
  GpxHandler(GPX _gpx){
    gpx = _gpx;
    setPointsData();
    minLat = getMinOrMax("min", "lat");
    maxLat = getMinOrMax("max", "lat");
    minLon = getMinOrMax("min", "lon");
    maxLon = getMinOrMax("max", "lon");
  }
  
   void setPointsData() {
    gpx.parse(fileToParse);
    for (int i = 0; i < gpx.getTrackCount(); i++) {
      GPXTrack trk = gpx.getTrack(i);
      // do something with trk.name
      for (int j = 0; j < trk.size(); j++) {
        GPXTrackSeg trkseg = trk.getTrackSeg(j);
        for (int k = 0; k < trkseg.size(); k++) {
          GPXPoint p = trkseg.getPoint(k);
          pts = (GPXPoint[]) append(pts, p);
        }
      }
    }

    for (int i = 0; i < gpx.getWayPointCount(); i++) {
      GPXWayPoint wpt = gpx.getWayPoint(i);
      // do something with wpt.lat or wpt.lon or wpt.name or wpt.type
    }
  }
  
  //i.e. getMin("max", "lat");
  float getMinOrMax(String minOrMax, String latOrLon) {
    float[] allPts = new float[pts.length];
    for (int i = 0; i < pts.length; i++) {
      if (latOrLon.equals("lat")) allPts[i] = (float) pts[i].lat;
      else if (latOrLon.equals("lon")) allPts[i] = (float) pts[i].lon;
    }
    if (minOrMax.equals("min")) {
      return min(allPts);
    }
    else return max(allPts);
  }
  
  GPXPoint[] getPointsData(){
    return pts;
  }
  
//  Float[] getCenter(){
//    
//  }
  
}
