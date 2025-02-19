//execute code on key pressed
void keyPressed() {

  switch(key) {
  case '1': //raw motor control

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

    
    break;

  case '2': //Sun code at bottom of this file
   
    sun();
    
    break;

  case '3': //multi-targeting control

    //motor control with multiple targets specified (simplified), specification found at:
    //https://toio.github.io/toio-spec/en/docs/ble_motor/#motor-control-with-multiple-targets-specified
    //targets should be formatted as {x, y, theta} or {x, y}. Unless specified, theta = 0
    // void multiTarget(int mode, int[][] targets)



  case '4': // This is the code for the snow icon. It also plays the song and 
  
    snow();
    break;
   

  case '5': //wind
  
   wind();
    break;
  
  case '6': // rain

    //play sound effects, specification can be found at:
    //https://toio.github.io/toio-spec/en/docs/ble_sound
    // sound(int soundeffect, int volume) {
      
    rain();
    break;
  case '7': // Single Midi Tone

    //play Midi Note (single), specification can be found at:
    //https://toio.github.io/toio-spec/en/docs/ble_sound/#playing-the-midi-note-numbers
    // void midi(int duration, int noteID, int volume)
    cubes[0].midi(10, 69, 255);
    break;

  case '8': // Sequencial Midi Tones

    //play Midi Notes (sequence), specification can be found at:
    //https://toio.github.io/toio-spec/en/docs/ble_sound/#playing-the-midi-note-numbers
    //targets should be formatted as {duration, noteID, volume} or {duration, noteID}. Unless specified, volume = 255
    // void midi(int repetitions, int[][] notes)
    int[][] notes = {{30, 64, 20}, {30, 63, 20}, {30, 64, 20}, {30, 63, 20}, {30, 64, 20}, {30, 63, 20}, {30, 59, 20}, {30, 62, 20}, {30, 60, 20}, {30, 57, 20}};
    cubes[0].midi(1, notes);
    break;

  default:
    break;
  }
}

//execute code when mouse is pressed
void mousePressed() {
  if (mouseX > 45 && mouseX < matDimension[2] - xOffset && mouseY > 45 && mouseY < matDimension[2] - yOffset) {
    cubes[0].target(mouseX, mouseY, 0);
  }

  //insert code here;
}

//execute code when mouse is released
void mouseReleased() {
  //insert code here;
}

//execute code when button on toio is pressed
void buttonDown(int id) {
  println("Button Pressed!");
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
void doubleTap(int id) {
  //int[][] ZeroCirc={{250,185,0},{320, ,90},{250,315,180},{180,250 , 270}};
  //int[][] OneCirc={{250,315,0},{180,315,90},{250,185,180},{320,250,270}};
  println("Double Tap Detected!");
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
}

//Weather icons: We can also change these to have variables (ex, the direction for wind, or an offset or something for x or y

void sun(){ 
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
    
    cubes[0].led(0, 244, 88, 15);
    cubes[1].led(0, 244, 88, 15);
    cubes[2].led(0, 244, 88, 15);
    cubes[3].led(0, 244, 88, 15);
    cubes[4].led(0, 244, 88, 15);
    cubes[5].led(0, 244, 88, 15);
    
    //cubes[7].target(cubes[7].x, 150, 0);
    
    int[][] newNotes = {{30, 64, 20}, {30, 68, 20}, {30, 68, 20}, {30, 68, 20}, {15, 66, 20}, {15, 64, 20}, {90, 71, 20}, {15, 71, 20}, {15, 69, 20}, {30, 68, 20}, {30, 68, 20}, {30, 68, 20}, {15, 66, 20}, {15, 64, 20}, {90, 71, 20}};
    cubes[0].midi(1, newNotes);
}

void snow(){
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
    
    delay(1500);
    
   int[][] rainWTargets0={{203,300,90},{203,270,90}};
   int[][] rainWTargets1={{203,232,90},{203,202,90}};
   int[][] rainWTargets2={{256,195,90},{256,165,90}};
   int[][] rainWTargets3={{292,231,90},{292,201,90}};
   int[][] rainWTargets4={{294,287,90},{294,257,90}};
   int[][] rainWTargets5={{255,328,90},{255,298,90}};
   cubes[0].multiTarget(0,rainWTargets0);  
   cubes[1].multiTarget(0,rainWTargets1);
   cubes[2].multiTarget(0,rainWTargets2);
   cubes[3].multiTarget(0,rainWTargets3);
   cubes[4].multiTarget(0,rainWTargets4);
   cubes[5].multiTarget(0,rainWTargets5);
}
  
