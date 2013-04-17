PImage map;

double centerLat = 41.878114;
double centerLon = -87.629798;
int scale = 12;

void setup() {
  size(600, 600);
  map = getImage();
  image(map, 0, 0);
  double[] corners = getCorner(centerLat, centerLon, scale, width, height);
  println("the bottom is "+corners[0]);
  println("the top is "+corners[2]);
  println("the left is "+corners[1]);
  println("the right is "+corners[3]);
}

PImage getImage() {
  String[] styleData = loadStrings("style.txt");
  String style = join(styleData, "");
  PImage img = loadImage("http://maps.googleapis.com/maps/api/staticmap?maptype=roadmap&sensor=false&size="+width+"x"+height+
  "&zoom="+scale+"&center="+centerLat+","+centerLon+style+"&style=.png"); //for some reason a trailing &style= must be added at the end of style or else the last style will not be recognized
  return img;
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
public static double[] getCorner(double centerLat, double centerLon, int zoom, int imagew, int imageh) {
  double[] pixelsPerLonDegree = {93206.75555555556,
                                 46603.37777777778,
                                 23301.68888888889,
                                 11650.844444444445,
                                 5825.422222222222,
                                 2912.711111111111,
                                 1456.3555555555556,
                                 728.1777777777778,
                                 364.0888888888889,
                                 182.04444444444445,
                                 91.02222222222223,
                                 45.51111111111111,
                                 22.755555555555556,
                                 11.377777777777778,
                                 5.688888888888889,
                                 2.8444444444444446,
                                 1.4222222222222223,
                                 0.7111111111111111};
                                 
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

