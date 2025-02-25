//execute code on key pressed
void keyPressed() {

  switch(key) {
    case '0': 
    //basic motor control w/ duration, specification found at:
    //https://toio.github.io/toio-spec/en/docs/ble_motor/#motor-control-with-specified-duration
    //can use negative numbers to move toio backwards
    // void motor(int leftSpeed, int rightSpeed, int duration)
    
    println(cubes[0].getX(), cubes[0].getY(), cubes[0].getTheta());
    println(cubes[1].getX(), cubes[1].getY(), cubes[1].getTheta());
    println(cubes[2].getX(), cubes[2].getY(), cubes[2].getTheta());
    println(cubes[3].getX(), cubes[3].getY(), cubes[3].getTheta());
    println(cubes[4].getX(), cubes[4].getY(), cubes[4].getTheta());
    println(cubes[5].getX(), cubes[5].getY(), cubes[5].getTheta());
    println(cubes[6].getX(), cubes[6].getY(), cubes[6].getTheta());
    println(cubes[7].getX(), cubes[7].getY(), cubes[7].getTheta());

    break;
    
    case '1': //Chicago csv data
      table = loadTable("Chicago.csv", "header");
      currentRow = 0; // Reset to the first row
      redraw(); // Update the display
      break;
  

    case '2': //Dallas csv data
      table = loadTable("Dallas.csv", "header");
      currentRow = 0;
      redraw();
      break;

    case '3': //LA csv data
      table = loadTable("LA.csv", "header");
      currentRow = 0;
      redraw();
      break;
    //multi-targeting control
    //motor control with multiple targets specified (simplified), specification found at:
    //https://toio.github.io/toio-spec/en/docs/ble_motor/#motor-control-with-multiple-targets-specified
    //targets should be formatted as {x, y, theta} or {x, y}. Unless specified, theta = 0
    // void multiTarget(int mode, int[][] targets)

    case '4': // NYC csv data
      table = loadTable("NYC.csv", "header");
      currentRow = 0;
      redraw();
      break;
     
    case ' ': // Use spacebar to toggle rows of CSV data
      currentRow = (currentRow + 1) % table.getRowCount();
      redraw(); // Call draw() to update the display
      break;
      
    case '-': // toggle weather images
      weather_currentImageIndex = weather_currentImageIndex + 1;
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

    case '5': //wind
  
      wind();
      break;
  
    case '6': //rain
      rain();
      break;
      
      //play sound effects, specification can be found at:
      //https://toio.github.io/toio-spec/en/docs/ble_sound
      // sound(int soundeffect, int volume) {
      
    case '7': //snow
      snow();
      break;
    // Single Midi Tone
    //play Midi Note (single), specification can be found at:
    //https://toio.github.io/toio-spec/en/docs/ble_sound/#playing-the-midi-note-numbers
    // void midi(int duration, int noteID, int volume)
    //cubes[0].midi(10, 69, 255);
    //break;

  case '8': //sun
    sun(); //Sun code at bottom of this file
    break;
    //Sequencial Midi Tones
    //play Midi Notes (sequence), specification can be found at:
    //https://toio.github.io/toio-spec/en/docs/ble_sound/#playing-the-midi-note-numbers
    //targets should be formatted as {duration, noteID, volume} or {duration, noteID}. Unless specified, volume = 255
    //// void midi(int repetitions, int[][] notes)
    //int[][] notes = {{30, 64, 20}, {30, 63, 20}, {30, 64, 20}, {30, 63, 20}, {30, 64, 20}, {30, 63, 20}, {30, 59, 20}, {30, 62, 20}, {30, 60, 20}, {30, 57, 20}};
    //cubes[0].midi(1, notes);
    //break;
    
   case '9': //rainWind()
     rainWind();
     break;

    default:
    break;
  }
}

////execute code when mouse is pressed
//void mousePressed() {
//  if (mouseX > 45 && mouseX < matDimension[2] - xOffset && mouseY > 45 && mouseY < matDimension[2] - yOffset) {
//    cubes[0].target(mouseX, mouseY, 0);
//  }

//  //insert code here;
//}

////execute code when mouse is released
//void mouseReleased() {
//  //insert code here;
//}

//execute code when button on toio is pressed
void buttonDown(int id) {
  println("Button Pressed!");
  
  if (id == 7){
    int city = closestCity(cubes[7].x, cubes[7].y);
    if (city == 1){ // LA
      table = loadTable("LA.csv", "header");
      redraw();
      callWeather();
    }
    if (city == 2){ // Dallas
      table = loadTable("Dallas.csv", "header");
      redraw();
      callWeather();
    }
    if (city == 3){ // Chicago
      table = loadTable("Chicago.csv", "header");
      redraw(); // Update the display
      callWeather();
    }
    if (city == 4){ // NYC
      table = loadTable("NYC.csv", "header");
      redraw();
      callWeather();
    }
  }
  
  if (id == 6){
    int day = closestDay(cubes[6].x);
    if (day != 0){
      currentRow = day - 1;
      redraw();
      callWeather();
    }
  }
  
}

void callWeather(){
  TableRow row = table.getRow(currentRow);
  if (row.getString("icon").equals("rainy")) {
    rain();
  }
  if (row.getString("icon").equals("sunny")) {
    sun();
  }
  if (row.getString("icon").equals("windyrainy")) {
    rainWind();
  }
  if (row.getString("icon").equals("windysunny")) {
    wind();
  }
  if (row.getString("icon").equals("snowy")) {
    snow();
  }
  
}

//execute code when button on toio is released
void buttonUp(int id) {
  println("Button Released!");
  
  //delay(100);
}

//execute code when toio detects collision
void collision(int id) {
  println("Collision Detected!");

}

void shake(int id, int shake){
  println(id, " Got shook this much: ", shake);
  cubes[0].target(180,250 , 180);
  cubes[1].target (320,250,0);
  
}

//execute code when toio detects double tap
//void doubleTap(int id) {
  //int[][] ZeroCirc={{250,185,0},{320, ,90},{250,315,180},{180,250 , 270}};
  //int[][] OneCirc={{250,315,0},{180,315,90},{250,185,180},{320,250,270}};
//  println("Double Tap Detected!");
  //cubes[0].multiTarget(0, ZeroCirc);
  //cubes[1].multiTarget(0,OneCirc);
  
  //for(int i=0;i<2;i++){
  //cubes[0].target(250,185,0);
  //cubes[1].target(250,315,0);
  //delay(1000);

  //cubes[0].target(320,250,90);
  //cubes[1].target(180,315,90);
  // delay(1000);  
  //cubes[0].target(250,315,180);
  //cubes[1].target(250,185,180);
  //delay(1000);
  //cubes[0].target(180,250 , 270);
  //cubes[1].target (320,250,270);
  //delay(1000);
  //}
//}

//Weather icons: We can also change these to have variables (ex, the direction for wind, or an offset or something for x or y

void sun(){ 
   weather_currentImageIndex = 0;
   int[][] targets0={{178,371,320},{241, 292, 294}};
   int[][] targets1={{128,223,1},{220, 252, 5}};
   int[][] targets2={{177,158,26},{245, 214, 58}};
   int[][] targets3={{367,124,122},{286, 212, 105}};
   int[][] targets4={{410,248,180},{314, 251, 181}};
   int[][] targets5={{368,354,222},{286, 285, 244}};

   
    cubes[0].multiTarget(0,targets0);
    cubes[1].multiTarget(0,targets1);
    cubes[2].multiTarget(0,targets2);
    cubes[3].multiTarget(0,targets3);
    cubes[4].multiTarget(0,targets4);
    cubes[5].multiTarget(0,targets5);
    
   int[][] sunWiggle0={{241,292,309},{241, 292, 294}};
   int[][] sunWiggle1={{220,252,20},{220, 252, 5}};
   int[][] sunWiggle2={{245,214,73},{245, 214, 58}};
   int[][] sunWiggle3={{286,212,120},{286, 212, 105}};
   int[][] sunWiggle4={{314,251,196},{314, 251, 181}};
   int[][] sunWiggle5={{286,285,269},{286, 285, 244}};
   
   
    cubes[0].led(0, 244, 88, 15);
    cubes[1].led(0, 244, 88, 15);
    cubes[2].led(0, 244, 88, 15);
    cubes[3].led(0, 244, 88, 15);
    cubes[4].led(0, 244, 88, 15);
    cubes[5].led(0, 244, 88, 15);
    
    for(int i=0;i<15;i++){
      cubes[0].multiTarget(0,sunWiggle0);
      cubes[1].multiTarget(0,sunWiggle1);
      cubes[2].multiTarget(0,sunWiggle2);
      cubes[3].multiTarget(0,sunWiggle3);
      cubes[4].multiTarget(0,sunWiggle4);
      cubes[5].multiTarget(0,sunWiggle5);
   }
    
    //cubes[7].target(cubes[7].x, 150, 0);
    
    int[][] newNotes = {{30, 64, 20}, {30, 68, 20}, {30, 68, 20}, {30, 68, 20}, {15, 66, 20}, {15, 64, 20}, {90, 71, 20}, {15, 71, 20}, {15, 69, 20}, {30, 68, 20}, {30, 68, 20}, {30, 68, 20}, {15, 66, 20}, {15, 64, 20}, {90, 71, 20}};
    cubes[0].midi(1, newNotes);
}

void snow(){
   weather_currentImageIndex = 4;  
   int[][] snowTargets0={{178,371,320},{262, 299, 120}};
   int[][] snowTargets1={{128,223,1},{230, 248, 182}};
   int[][] snowTargets2={{177,158,26},{262, 201, 238}};
   int[][] snowTargets3={{367,124,122},{321, 199, 313}};
   int[][] snowTargets4={{410,248,180},{352, 251, 4}};
   int[][] snowTargets5={{368,354,222},{322, 303, 55}};

    cubes[0].multiTarget(0,snowTargets0);
    cubes[1].multiTarget(0,snowTargets1);
    cubes[2].multiTarget(0,snowTargets2);
    cubes[3].multiTarget(0,snowTargets3);
    cubes[4].multiTarget(0,snowTargets4);
    cubes[5].multiTarget(0,snowTargets5);
    
    cubes[0].led(0, 255, 255, 255);
    cubes[1].led(0, 255, 255, 255);
    cubes[2].led(0, 255, 255, 255);
    cubes[3].led(0, 255, 255, 255);
    cubes[4].led(0, 255, 255, 255);
    cubes[5].led(0, 255, 255, 255);
    
    //cubes[7].target(cubes[7].x, 200, 0);
    
    int[][] snotes = {{30, 60, 20}, {30, 72, 20}, {30, 72, 20}, {30, 67, 20}, {30, 67, 20}, {30, 63, 20}, {30, 63, 20}, {30, 60, 20}, {30, 60, 20}, {30, 72, 20}, {30, 70, 20}, {30, 68, 20}, {30, 67, 20}, {30, 65, 20}, {30, 63, 20}, {30, 62, 20}, {30, 60, 20}};
    cubes[0].midi(1, snotes);
}

void wind(){
   weather_currentImageIndex = 1;
   int[][] windTargets0={{178,371,320},{187,302,180}};
   int[][] windTargets1={{128,223,1},{187,236,180}};
   int[][] windTargets2={{251,81,274},{190,182,180}};
   int[][] windTargets3={{367,124,122},{250,203,180}};
   int[][] windTargets4={{410,248,180},{293,246,180}};
   int[][] windTargets5={{368,354,222}, {246,290,180}};
   
    cubes[0].multiTarget(0,windTargets0);
    cubes[1].multiTarget(0,windTargets1);
    cubes[2].multiTarget(0,windTargets2);
    cubes[3].multiTarget(0,windTargets3);
    cubes[4].multiTarget(0,windTargets4);
    cubes[5].multiTarget(0,windTargets5);
    
    cubes[0].led(0, 0, 255, 0);
    cubes[1].led(0, 0, 255, 0);
    cubes[2].led(0, 0, 255, 0);
    cubes[3].led(0, 0, 255, 0);
    cubes[4].led(0, 0, 255, 0);
    cubes[5].led(0, 0, 255, 0);
    
    //cubes[7].target(cubes[7].x, 300, 0);

    int[][] summerNotes = {{30, 67, 20}, {30, 55, 20}, {30, 55, 20}, {30, 55, 20}, {30, 55, 20}, {30, 55, 20}, {30, 65, 20}, {30, 55, 20}, {30, 55, 20}, {30, 55, 20}, {30, 55, 20}, {30, 55, 20}, {30, 63, 20}, {30, 55, 20}, {30, 55, 20}, {30, 55, 20}, {30, 55, 20}, {30, 55, 20}, {30, 62, 20}, {30, 55, 20}, {30, 55, 20}, {30, 55, 20}, {60, 55, 20}};
    cubes[0].midi(1, summerNotes);}
    
void rain(){ //sets toios to rain icon, 
    weather_currentImageIndex = 2;
   int[][] rainTargets0={{178,371,320},{203,270,90}};
   int[][] rainTargets1={{128,223,1},{203,202,90}};
   int[][] rainTargets2={{251,81,274},{256,165,90}};
   int[][] rainTargets3={{367,124,122},{292,201,90}};
   int[][] rainTargets4={{410,248,180},{294,257,90}};
   int[][] rainTargets5={{368,354,222},{255,298,90}};
   
    cubes[0].multiTarget(0,rainTargets0);
    cubes[1].multiTarget(0,rainTargets1);
    cubes[2].multiTarget(0,rainTargets2);
    cubes[3].multiTarget(0,rainTargets3);
    cubes[4].multiTarget(0,rainTargets4);
    cubes[5].multiTarget(0,rainTargets5);
    
    cubes[0].led(0, 0, 0, 255);
    cubes[1].led(0, 0, 0, 255);
    cubes[2].led(0, 0, 0, 255);
    cubes[3].led(0, 0, 0, 255);
    cubes[4].led(0, 0, 0, 255);
    cubes[5].led(0, 0, 0, 255);
    
   // cubes[7].target(cubes[7].x, 250, 0); 

    int[][] fallNotes = {{30, 64, 20}, {30, 64, 20}, {30, 64, 20}, {30, 65, 20}, {60, 64, 20}, {30, 64, 20}, {30, 65, 20}, {30, 64, 20}, {15, 62, 20}, {15, 64, 20}, {30, 65, 20}, {30, 64, 20}, {60, 62, 20}};
    cubes[0].midi(1, fallNotes);
}

void rainWind(){
    rain();
    weather_currentImageIndex = 3;
   // cubes[7].target(cubes[7].x, 250, 0); 

    int[][] fallNotes = {{30, 64, 20}, {30, 64, 20}, {30, 64, 20}, {30, 65, 20}, {60, 64, 20}, {30, 64, 20}, {30, 65, 20}, {30, 64, 20}, {15, 62, 20}, {15, 64, 20}, {30, 65, 20}, {30, 64, 20}, {60, 62, 20}};
    cubes[0].midi(1, fallNotes);
    
    delay(1500);
    
   int[][] rainWTargets0={{203,270,75},{203,270,105}};
   int[][] rainWTargets1={{203,202,75},{203,202,105}};
   int[][] rainWTargets2={{256,165,75},{256,165,105}};
   int[][] rainWTargets3={{292,201,75},{292,201,105}};
   int[][] rainWTargets4={{294,257,75},{294,257,105}};
   int[][] rainWTargets5={{255,298,75},{255,298,105}};
   
   for(int i=0;i<15;i++){
     cubes[0].multiTarget(0,rainWTargets0);  
     cubes[1].multiTarget(0,rainWTargets1);
     cubes[2].multiTarget(0,rainWTargets2);
     cubes[3].multiTarget(0,rainWTargets3);
     cubes[4].multiTarget(0,rainWTargets4);
     cubes[5].multiTarget(0,rainWTargets5);
     delay(500);
   }
}
   
int closestCity(int x, int y){
   float laDist = sqrt(sq(x - 87) + sq(y - 265));
   float dallasDist = sqrt(sq(x - 248) + sq(y - 319));
   float chicagoDist = sqrt(sq(x - 294) + sq(y - 183));
   float nycDist = sqrt(sq(x - 405) + sq(y - 186));
   
   float[] floats = {laDist, dallasDist, chicagoDist, nycDist};
   
   float minimum = min(floats);
   
   if (minimum == laDist){ // Los angeles
     return 1;
   }
   else if (minimum == dallasDist){ // dallas
     return 2;
   }
   else if (minimum == chicagoDist){ // chicago
     return 3;
   }
   else if (minimum == nycDist){ // nyc
     return 4;
   }
   else {
     return 0;
   }
     
     
   
}
int closestDay(int x){ // locations in order from sun: 99 146 201 247 300 343 399
   int sunDist = abs(99 - x);
   int monDist = abs(146 - x);
   int tuesDist = abs(201 - x);
   int wedDist = abs(247 - x);
   int thursDist = abs(300 - x);
   int friDist = abs(343 - x);
   int satDist = abs(399 - x);
   
   int[] ints = {sunDist, monDist, tuesDist, wedDist, thursDist, friDist, satDist};
   
   int minimum = min(ints);
   
   if (minimum == sunDist){ // Sun
     return 1;
   }
   else if (minimum == monDist){ // Mon
     return 2;
   }
   else if (minimum == tuesDist){ // Tues
     return 3;
   }
   else if (minimum == wedDist){ // Wed
     return 4;
   }
   else if (minimum == thursDist){ // Thurs
     return 5;
   }
   else if (minimum == friDist){ // Fri
     return 6;
   }
   else if (minimum == satDist){ // Sat
     return 7;
   }
   else {
     return 0;
   }
     
}
