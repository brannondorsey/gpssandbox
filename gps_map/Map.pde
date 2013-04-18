class Map {
  GPX gpx;
  Marker[] markers;
  double minLat, maxLat, minLon, maxLon, centerLat, centerLon, top, right, bottom, left;
  double[] corners;

  PImage mapImage;

  int scale = 14;

  Map(GPX _gpx) {
    gpx = _gpx;
    markers = new Marker[0];
    getMarkers();
    minLat = getMinOrMax("min", "lat");
    maxLat = getMinOrMax("max", "lat");
    minLon = getMinOrMax("min", "lon");
    maxLon = getMinOrMax("max", "lon");
    mapImage = getImage();
    bottom = corners[0];
    left = corners[1];
    top = corners[2];
    right = corners[3];
    
    //latBottom, lonLeft, latTop, lonRight
    

    println("min lat is "+minLat);
    println("max lat is "+maxLat);
    println("min lon is "+minLon);
    println("max lon is "+maxLon);
   
    println("the top boundary is "+corners[0]);
    println("the right boundary is "+corners[1]);
    println("the bottom boundary is "+corners[2]);
    println("the left boundary is "+corners[3]);
    
    
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
          Marker m = new Marker(pt); 
          markers = (Marker[]) append(markers, m);
        }
      }
    }

    for (int i = 0; i < gpx.getWayPointCount(); i++) {
      GPXWayPoint wpt = gpx.getWayPoint(i);
      // do something with wpt.lat or wpt.lon or wpt.name or wpt.type
    }
  }

  void displayImage() {
    image(mapImage, 0, 0);
  }

  PImage getImage() {

    centerLat = maxLat-((maxLat-minLat)/2);
    centerLon = maxLon-((maxLon-minLon)/2);

    // centerLat & centerLong for Chicago
    //  double centerLat = 41.878114;
    //  double centerLon = -87.629798;

    String[] styleData = loadStrings("style.txt");
    String style = join(styleData, "");
    
    corners = getCorner(centerLat, centerLon, scale, width, height);
    PImage img = loadImage("http://maps.googleapis.com/maps/api/staticmap?maptype=roadmap&sensor=false&size="+width+"x"+height+
      "&zoom="+scale+"&center="+centerLat+","+centerLon+style+"&style=.png"); //for some reason a trailing &style= must be added at the end of style or else the last style will not be recognized
    return img;
  }

  //i.e. getMin("max", "lat");
  float getMinOrMax(String minOrMax, String latOrLon) {
    float[] allMarkers = new float[markers.length];
    for (int i = 0; i < markers.length; i++) {
      if (latOrLon.equals("lat")) allMarkers[i] = (float) markers[i].lat;
      else if (latOrLon.equals("lon")) allMarkers[i] = (float) markers[i].lon;
    }
    if (minOrMax.equals("min")) {
      return min(allMarkers);
    }
    else return max(allMarkers);
  }



  /**
   * 
   * @param centerlat
   * @param centerlon
   * @param room
   * @param imagew
   * @param imageh
   * @return  latBottom, lonLeft, latTop, lonRight  (left-bottom and right-top point lat /lon)
   */
  public double[] getCorner(double centerLat, double centerLon, int zoom, int imagew, int imageh) {

    double[] pixelsPerLonDegree = { 
      0.7111111111111111, 
      1.4222222222222223, 
      2.8444444444444446, 
      5.688888888888889, 
      11.377777777777778, 
      22.755555555555556, 
      45.51111111111111, 
      91.02222222222223, 
      182.04444444444445, 
      364.0888888888889, 
      728.1777777777778, 
      1456.3555555555556, 
      2912.711111111111, 
      5825.422222222222, 
      11650.844444444445, 
      23301.68888888889, 
      46603.37777777778, 
      93206.75555555556
    };

    double lonspan = imagew / pixelsPerLonDegree[zoom];
    double latspan = imageh / pixelsPerLonDegree[zoom];

    double lonRight = centerLon + lonspan/2;
    double lonLeft = centerLon - lonspan/2;

    double latTop = centerLat + latspan/2;
    double latBottom = centerLat - latspan/2;

    return new double[] {
      latBottom, lonLeft, latTop, lonRight
    };
 }
}

