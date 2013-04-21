class GPXHandler {
  Location[] pts;

  GPXHandler(Location[] _pts) {
    pts = _pts;
  }
  
  void test(){
    float t = pts[10].getLat();
    println(t);
  }
  
  
}

