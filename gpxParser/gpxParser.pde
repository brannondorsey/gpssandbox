XMLElement gpxDoc;
TrackPoint[] trkpts;

void setup() {
  size(600, 600);
  gpxDoc = new XMLElement(this, "marathon.xml");

  int numEntries = gpxDoc.getChildCount();
  println(numEntries);
  for (int i = 0; i < numEntries; i++) {
    XMLElement allChildren = gpxDoc.getChild(i);
    println(allChildren);
  }
  XMLElement trk = gpxDoc.getChild(2);
  XMLElement[] trkseg = trk.getChild(2).getChildren();
  int numTrkChildren = trkseg.length;
  trkpts = new TrackPoint[numTrkChildren];
  println("the number of trackpoints is "+trkseg.length);
  for (int i = 0; i <numTrkChildren; i++) {
    float lat = trkseg[i].getFloat("lat");
    float lon = trkseg[i].getFloat("lon");

    XMLElement trkPtTimestamp = trkseg[i].getChild(1);
    String timestamp = trkPtTimestamp.getContent();
    trkpts[i] = new TrackPoint(lat, lon, timestamp);
  }
  for (int i = 0; i < trkpts.length; i++) {
    println("this trackpoints lat is "+trkpts[i].lat);
  }
}

void draw() {
  background(0);
}

