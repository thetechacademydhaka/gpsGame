import ketai.sensors.*; 

double longitude, latitude, altitude;
KetaiLocation location;

float leftx = 23.793903;
float lefty = 90.405587;
float rightx = 23.785972;
float righty = 90.411327;

int x;
int y;

void setup() {
  fullScreen();
  orientation(PORTRAIT);
  location = new KetaiLocation(this);

  background(78, 93, 75);
  
  textAlign(LEFT, TOP);
  textSize(displayDensity * 10);

  x = displayWidth/2;
  y = displayHeight/2;
}

void draw() {
  
  fill(0);
  rect(0, 0, width, height/6); 
  
  fill(255);
  
  if (location == null  || location.getProvider() == "none")
    text("Location data is unavailable. \n" +
      "Please check your location settings.", 0, 0, width, height);
  else {
    text("Latitude: " + latitude + "\n" + 
      "Longitude: " + longitude + "\n" + 
      "Altitude: " + altitude + "\n" + 
      "Provider: " + location.getProvider(), 0, 0, width, height);
  // getProvider() returns "gps" if GPS is available
  // otherwise "network" (cell network) or "passive" (WiFi MACID)

    float posX = constrain((float)latitude, rightx, leftx);
    posX = map((float)latitude, leftx, rightx, 0, width);
    
    float posY = constrain((float)longitude, lefty, righty);
    posY = map((float)longitude, lefty, righty, 0, width);
    
    ellipse(posX, posY, 50, 50);
  }
}

void onLocationEvent(double _latitude, double _longitude, double _altitude)
{
  longitude = _longitude;
  latitude = _latitude;
  altitude = _altitude;
  println("lat/lon/alt: " + latitude + "/" + longitude + "/" + altitude);
}
