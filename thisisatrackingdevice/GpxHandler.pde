class GPXHandler {
  ArrayList<Location> pts;
  float minLat, maxLat, minLon, maxLon;

  GPXHandler(List<Feature> parsedData) {
    pts = new ArrayList();
    List<Marker> parsedDataMarkers = MapUtils.createSimpleMarkers(parsedData);
    for (int i = 0; i < parsedDataMarkers.size();i++) {
      Marker pt = parsedDataMarkers.get(i);
      println("this points location is "+pt.getLocation());
      pts.add(pt.getLocation());
    }
    minLat = getMinOrMax("min", "lat");
    maxLat = getMinOrMax("max", "lat");
    minLon = getMinOrMax("min", "lon");
    maxLon = getMinOrMax("max", "lon");
  }

  //i.e. getMin("max", "lat");
  float getMinOrMax(String minOrMax, String latOrLon) {
    float[] allPts = new float[pts.size()];
    for (int i = 0; i < allPts.length; i++) {
      Location currentPt = pts.get(i);
      if (latOrLon.equals("lat")) allPts[i] = (float) currentPt.getLat();
      else if (latOrLon.equals("lon")) allPts[i] = (float) currentPt.getLon();
    }
    if (minOrMax.equals("min")) {
      return min(allPts);
    }
    else return max(allPts);
  }

  Location getCenter() {
    double centerLat = maxLat-((maxLat-minLat)/2);
    double centerLon = maxLon-((maxLon-minLon)/2);
    return new Location(centerLat, centerLon);
  }
}

