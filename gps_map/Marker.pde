class Marker {

  GPXPoint pt;
  double lat;
  double lon;
  float x;
  float y;
  float s;

  Marker(GPXPoint _pt) {
    pt = _pt;
    lat = pt.lat;
    lon = pt.lon;
  }

  void display() {
    x = (float) map((float) lon, (float) map.left, (float) map.right, 0, width);
    y = (float) map((float) lat, (float) map.top, (float) map.bottom, -100, height+100);
    s = 10;
    
    fill(#AD0A0A, 200);
    ellipse(x, y, s, s);
    println("this points lat is "+lat);
    println("the left side value is "+map.left);
    println("the right side value is "+map.right);
  }
}
