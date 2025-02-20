import oscP5.*;
import netP5.*;
import deadpixel.keystone.*;
//Imports needed for projection
Keystone ks;
CornerPinSurface surface1;
CornerPinSurface surface2;

//constants
//The soft limit on how many toios a laptop can handle is in the 10-12 range
//the more toios you connect to, the more difficult it becomes to sustain the connection
int nCubes = 8;
int cubesPerHost = 12;
int maxMotorSpeed = 115;
int xOffset;
int yOffset;
//int counter=0;

//Needed for projection
PGraphics offscreen1;
PGraphics offscreen2;

// Table for CSV data
Table table;
int currentRow = 0;

PImage[] map; // Array to hold the map
PImage[] weather_images;
int map_currentImageIndex = 0; // Index of the currently displayed image
int weather_currentImageIndex = 0; 

//// Instruction for Windows Users  (Feb 2. 2025) ////
// 1. Enable WindowsMode and set nCubes to the exact number of toio you are connecting.
// 2. Run Processing Code FIRST, Then Run the Rust Code. After running the Rust Code, you should place the toio on the toio mat, then Processing should start showing the toio position.
// 3. When you re-run the processing code, make sure to stop the rust code and toios to be disconnected (switch to Bluetooth stand-by mode [blue LED blinking]). If toios are taking time to disconnect, you can optionally turn off the toio and turn back on using the power button.
// Optional: If the toio behavior is werid consider dropping the framerate (e.g. change from 30 to 10)
// 
boolean WindowsMode = false; //When you enable this, it will check for connection with toio via Rust first, before starting void loop()

int framerate = 30;

int[] matDimension = {45, 45, 455, 455};

//for OSC
OscP5 oscP5;
//where to send the commands to
NetAddress[] server;

//we'll keep the cubes here
Cube[] cubes;

//void settings() {
//  size(1000, 1000);
//}


void setup() {
  
  //Projection (Keystone)
  // Use P3D or OPENGL renderer for Keystone
  fullScreen(P3D);

  // Initialize Keystone
  ks = new Keystone(this);
  // Create two CornerPinSurfaces
  surface1 = ks.createCornerPinSurface(400, 300, 20);
  surface2 = ks.createCornerPinSurface(400, 300, 20);
  
  // Create two offscreen buffers for each surface
  // surface2 and offscreen2 will relate to the map
  offscreen1 = createGraphics(400, 300, P3D);
  offscreen2 = createGraphics(400, 300, P3D);
  
  offscreen1.beginDraw();
  offscreen1.background(255); // White background
  offscreen1.endDraw();
  
  // Load images into the array
  map = new PImage[1]; // Change the size to the number of images you have
  map[0] = loadImage("map.png"); // Replace with your image file names
  
  // Load weather images into the array
  weather_images = new PImage[5]; // Change the size to the number of images you have
  weather_images[0] = loadImage("sun.png"); // Replace with your image file names
  weather_images[1] = loadImage("wind.jpg");
  weather_images[2] = loadImage("rain.gif");
  weather_images[3] = loadImage("windrain.gif");
  weather_images[4] = loadImage("snow.gif");
  
  // Load the CSV file
  table = loadTable("Chicago.csv", "header"); //default csv is Chicago
  
  // Set text properties
  textSize(16);
  fill(0); // black text
  
  //// Resize images to fit the offscreen1 buffer
  for (int i = 0; i < weather_images.length; i++) {
    if (weather_images[i] != null) {
      weather_images[i].resize(offscreen1.width, offscreen2.height);
    } else {
      println("Error: Image " + i + " could not be loaded.");
    }
  }
  
  //// Resize images to fit the offscreen2 buffer
  for (int i = 0; i < map.length; i++) {
    if (map[i] != null) {
      map[i].resize(offscreen2.width, offscreen2.height);
    } else {
      println("Error: Image " + i + " could not be loaded.");
    }
  }
  
  //launch OSC sercer
  oscP5 = new OscP5(this, 3333);
  server = new NetAddress[1];
  server[0] = new NetAddress("127.0.0.1", 3334);

  //create cubes
  cubes = new Cube[nCubes];
  for (int i = 0; i< nCubes; ++i) {
    cubes[i] = new Cube(i);
  }

  xOffset = matDimension[0] - 45;
  yOffset = matDimension[1] - 45;

  //do not send TOO MANY PACKETS
  //we'll be updating the cubes every frame, so don't try to go too high
  frameRate(framerate);
  if(WindowsMode){
  check_connection();
  }
}

void draw() {
  //Projection (Keystone) Stuff
  // Draw the current image onto the offscreen1 buffer
  offscreen1.beginDraw();
  offscreen1.background(255); // White background to clear the buffer
  
  // Draw weather image
  if (weather_images[weather_currentImageIndex] != null) {
    offscreen1.image(weather_images[weather_currentImageIndex], 0, 0);
  }
  
  // Add white rectangles behind the text for readability
  offscreen1.fill(255); // White color for the rectangle
  offscreen1.noStroke(); // No border for the rectangle
  
  // Rectangle for city
  offscreen1.rect(135, 11, 145, 25); // Adjust position and size as needed
  
  // Rectangle for date
  offscreen1.rect(5, 0, 90, 35); // x, y, width, height
  
  // Rectangle for temperature
  offscreen1.rect(290, 0, 75, 35); // x, y, width, height
  
  // Rectangle for day of the week slider
  offscreen1.rect(15, 250, 340, 30);
  
  // Draw text on top of the white rectangles
  offscreen1.fill(0); // Black text
  offscreen1.textSize(16);
  
  // Display weather text
  if (currentRow < table.getRowCount()) {
    TableRow row = table.getRow(currentRow);

    // Extract data from the current row
    String dayoftheweek = row.getString("dayoftheweek");
    String date = row.getString("datetime");
    int highTemp = (int) row.getFloat("tempmax");
    int lowTemp = (int) row.getFloat("tempmin"); //casting as int
    String city = row.getString("name");

    // Display the data on the surface of offscreen1
    // city
    offscreen1.textSize(20);
    offscreen1.textAlign(CENTER);
    offscreen1.text(city, 205, 30);
    // date
    offscreen1.textSize(16);
    offscreen1.textAlign(LEFT);
    offscreen1.text(dayoftheweek, 10, 30);
    offscreen1.text(date, 10, 15);
    // temperature
    offscreen1.textSize(16);
    offscreen1.text("Hi: " + highTemp + "°F", 300, 15);
    offscreen1.text("Lo: " + lowTemp + "°F", 300, 30);
    offscreen1.textAlign(RIGHT);
    
    // For day of the week slider
    offscreen1.text("Su", 40, 270);
    offscreen1.text("M", 90, 270);
    offscreen1.text("Tu", 140, 270);
    offscreen1.text("W", 190, 270);
    offscreen1.text("Th", 240, 270);
    offscreen1.text("F", 290, 270);
    offscreen1.text("Sa", 340, 270);
  } else {
    offscreen1.text("End of data reached.", 50, 50);
  }
  
  offscreen1.endDraw();

  // Draw the map onto offscreen2 buffer
  offscreen2.beginDraw();
  offscreen2.background(255); // White background to clear buffer
  
  if (map[map_currentImageIndex] != null) {
    offscreen2.image(map[map_currentImageIndex], 0, 0); // Draw the current (map) image
  }
  offscreen2.endDraw();
  
  // Clear the main screen with a black background
  background(0);
 
  // Render the scenes
  surface1.render(offscreen1);
  surface2.render(offscreen2);
}
