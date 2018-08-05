//using ketai library which gives easy access to sensors on android device
import ketai.sensors.*; 

double longitude, latitude;
float altitude, accuracy;

KetaiLocation location;

float maxLat = 23.793903;
float minLong = 90.405587;
float minLat = 23.785972;
float maxLong = 90.411327;

float moarLat = 23.790117;
float moarLong = 90.408415;
Location moar;


void setup() {
  fullScreen();
  orientation(PORTRAIT);
  location = new KetaiLocation(this);
  moar = new Location("Moar");
  moar.setLatitude(moarLat);
  moar.setLongitude(moarLong);

  background(78, 93, 75);
  
  
  textSize(displayDensity * 10);
  
  fill(#80DEEA);
  float moarX = constrain((float) moar.getLongitude(), minLong, maxLong);
  moarX = map(moarX, maxLong, minLong, 0, width);
  float moarY = constrain((float) moar.getLatitude(), minLat, maxLat);
  moarY = map(moarY, minLat, maxLat, 0, height);
  ellipse(moarX, moarY, 70, 70);
  
  textAlign(CENTER, CENTER);
  fill(0);
  text("M", moarX, moarY);
  
  textAlign(LEFT, TOP);
}

void draw() {
  
  fill(0);
  rect(0, 0, width, height/8); 
  
  fill(255);
  
  if (location == null  || location.getProvider() == "none")
    text("Location data is unavailable. \n" +
      "Please check your location settings.", 0, 0, width, height);
  else {
    text("Latitude: " + latitude + "\n" + 
      "Longitude: " + longitude + "\n" + 
      "Altitude: " + altitude + "\n" + 
      "Accuracy: " + accuracy + " meters" + "\n" +
      "Distance to Moar: " + nfc(location.getLocation().distanceTo(moar), 2) + " meters" + "\n" +
      "Provider: " + location.getProvider(), 0, 0, width, height);
  // getProvider() returns "gps" if GPS is available
  // otherwise "network" (cell network) or "passive" (WiFi MACID)

    float posY = constrain((float)latitude, minLat, maxLat); //Latitude is Equator to North or South
    posY = map((float)latitude, maxLat, minLat, 0, height);
    
    float posX = constrain((float)longitude, minLong, maxLong); // Longitude is Greenwich to East or West
    posX = map((float)longitude, minLong, maxLong, 0, width);
    
    ellipse(posX, posY, 50, 50);
  }
}

void onLocationEvent(Location _location)
{
  longitude = _location.getLongitude();
  latitude = _location.getLatitude();
  altitude = (float) _location.getAltitude();
  accuracy = _location.getAccuracy();
}
