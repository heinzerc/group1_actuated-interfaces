import deadpixel.keystone.*;

Keystone ks;
CornerPinSurface surface1;
CornerPinSurface surface2;

PGraphics offscreen1;
PGraphics offscreen2;

// Table for CSV data
Table table;
int currentRow = 0;

PImage[] images; // Array to hold images
int currentImageIndex = 0; // Index of the currently displayed image

void setup() {
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
  
  // Load images into the array
  images = new PImage[1]; // Change the size to the number of images you have
  images[0] = loadImage("map.png"); // Replace with your image file names
  
  // Load the CSV file
  table = loadTable("Chicago.csv", "header"); //default csv is Chicago
  
  // Set text properties
  textSize(16);
  fill(0); // black text
  
  //// Resize images to fit the offscreen buffer
  for (int i = 0; i < images.length; i++) {
    if (images[i] != null) {
      images[i].resize(offscreen2.width, offscreen2.height);
    } else {
      println("Error: Image " + i + " could not be loaded.");
    }
  }
}

void draw() {
  // Convert the mouse coordinate into surface coordinates for surface1
  // PVector surfaceMouse1 = surface1.getTransformedMouse();
  // Convert the mouse coordinate into surface coordinates for surface2
  PVector surfaceMouse2 = surface2.getTransformedMouse();
  
  // Draw the current image onto the offscreen1 buffer
  offscreen1.beginDraw();
  offscreen1.background(255);
  offscreen1.fill(0); // White text
  offscreen1.textSize(16);
  
  if (currentRow < table.getRowCount()) {
    TableRow row = table.getRow(currentRow);

    // Extract data from the current row
    String dayoftheweek = row.getString("dayoftheweek");
    String date = row.getString("datetime");
    float highTemp = row.getFloat("tempmax");
    float lowTemp = row.getFloat("tempmin");
    String icon = row.getString("icon");
    String city = row.getString("name");

    // Display the data on the surface of offscreen1
    offscreen1.text("City: " + city, 50, 50);
    offscreen1.text("Date: " + date, 50, 80);
    offscreen1.text("Day: " + dayoftheweek, 50, 110);
    offscreen1.text("High Temperature: " + highTemp + "°F", 50, 140);
    offscreen1.text("Low Temperature: " + lowTemp + "°F", 50, 170);
    offscreen1.text("Conditions: " + icon, 50, 200);
  } else {
    offscreen1.text("End of data reached.", 50, 50);
  }
  offscreen1.endDraw();
  
  // add stuff for offscreen2
  
  // Draw the scene for surface2, offscreen
  offscreen2.beginDraw();
  offscreen2.background(255);
  //offscreen2.fill(255, 0, 0);
  if (images[currentImageIndex] != null) {
    offscreen2.image(images[currentImageIndex], 0, 0); // Draw the current image
  }
  offscreen2.endDraw();
  
  // Clear the main screen with a black background
  background(0);
 
  // render the scenes, transformed using the corner pin surfaces
  surface1.render(offscreen1);
  surface2.render(offscreen2);
}

void keyPressed() {
//  // Switch between images when a key is pressed
//  if (key == ' ') { // Use spacebar to toggle images (replace with Toio input)
//    currentRow = (currentRow + 1) % table.getRowCount();
//    redraw(); // Call draw() to update the display
//}

  
  // Load different CSV files based on key presses
  switch(key) {
    case '1':
      table = loadTable("Chicago.csv", "header");
      currentRow = 0; // Reset to the first row
      redraw(); // Update the display
      break;
    case '2':
      table = loadTable("Dallas.csv", "header");
      currentRow = 0;
      redraw();
      break;
    case '3':
      table = loadTable("LA.csv", "header");
      currentRow = 0;
      redraw();
      break;
    case '4':
      table = loadTable("NYC.csv", "header");
      currentRow = 0;
      redraw();
      break;
    case ' ': // Use spacebar to toggle rows
      currentRow = (currentRow + 1) % table.getRowCount();
      redraw(); // Call draw() to update the display
      break;
    // Keystone calibration controls
    case 'c':
      ks.toggleCalibration();
      break;
    case 'l':
      ks.load();
      break;
    case 's':
      ks.save();
      break;
  }
}
