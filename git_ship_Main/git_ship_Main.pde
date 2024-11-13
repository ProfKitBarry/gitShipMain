// Here's where we'll put all the variables to mess with

//crew roster
String pilot = "Prof Kit";
String copilot = "Alec";

//spacecraft controls
boolean viewscreen = true; //powers up main viewscreen
boolean displays = true; //powers up left and right cockpit displays
boolean attitudeControl = true;
boolean artificialGravity = true;
boolean sensors = true; //turns on sensors
boolean parkingBrake = false;
boolean shields = false; //turns on shields

boolean redAlert = false; //turns on red alert

// End of variables to mess with in Basic Training

//declare all the things
float speed = 0;
float drift;

//colours for drawing the spaceship
color white = color(255);
color grey = color(100);
color black = color(0);
color holo = color(255, 255, 0);

//slider values: 0, 10 values set in code
float slider1 = 0;
float slider2 = 4;
float slider3 = 7;
float slider4 = 6;
//map location: 0 to 10 in x & y, set in code
float x = 4;
float y = 3;
String location = "at warp";

boolean flashOn = false; //controls flashing lights
boolean atWarp;
boolean showDialogue;

Star[] stars = new Star[400];
Planet earth;
Planet moon;
Holodeck holodeck;
Checksum healthbar;
Junk junk;

void setup(){
  size(600, 400);
  noCursor();
  init();
}

void keyPressed(){
  if(!parkingBrake){
    //toggle warp drive
    atWarp = !atWarp;
    //handle new location
    if(atWarp){
      speed = 9.99;
      location = "at warp";
    }
    else dropOutOfWarp();
  }
  
  ////toggle viewscreen
  //showDialogue = !showDialogue;
}

void draw(){
  //display things
  
  //background
  background(0);
  
  if(viewscreen) {
    //begin attitude control
    if(!attitudeControl) beginDrift();
    
    //starfield simulation
    for(int i = 0; i < stars. length; i++){
     stars[i].update();
     stars[i].display();
    }
    //location
    if(!atWarp) { 
     earth.update();
     earth.display();
     moon.update();
     moon.display();
    }
    //holodeck
    holodeck.update();
    holodeck.display();
  
    //end of attitude control
    if(!attitudeControl) endDrift();
  }
  else {
    noSignal();
  }
  
  //cockpit
  drawCockpit();
  
  //junk
  junk.update();
  
  //overlay
  if(redAlert) RedAlert();
}

void init(){
  //initialise all the things
  
  //checksum
  healthbar = new Checksum();
  //starfield simulation
  for(int i = 0; i < stars. length; i++){
    stars[i] = new Star();
  }
  //cargo
  loadCargo();
  println("Cargo manifest:");
  for(String item : cargo){
    println(item);
  }
  //engineering adjustments
  DeregulateDilithuimColumator();
  //location
  earth = new Planet(2*width/3, height/4, 50);
  moon = new Planet(2.1*width/3, height/3, 10);
  holodeck = new Holodeck(holo);
  //junk
  junk = new Junk();
  
  dropOutOfWarp();
}

void dropOutOfWarp(){
  speed = 0.00;
  float rndX = random(0.25*width, 0.75*width);
  float rndY = random(0.25*height, 0.5*height);
  x = map(rndX, 0.25*width, 0.75*width, 0, 10);
  y = map(rndY, 0.25*height, 0.5*height, 0, 10);
  earth = new Planet(rndX, rndY, random(50, 375));
  earth.sliders();
  location = "sector " + int(x) + "-" + int(y);
}

/////////////////////////////////////////////////////
///////////engineering working party/////////////////
/////////////////////////////////////////////////////
void beginDrift(){
  drift += 0.01;
  pushMatrix();
  translate(width/2, height/2);
  rotate(drift);
}

void endDrift(){
  popMatrix();
}

void DeregulateDilithuimColumator(){
  char[] bin = binary(healthbar.checksum).toCharArray();
  bin[bin.length-2] = '0';
  healthbar.checksum = unbinary(new String(bin));
}
/////////////////////////////////////////////////////
//////////end engineering working party//////////////
/////////////////////////////////////////////////////

void noSignal(){
  noStroke();
  fill(grey);
  Font.draw(15, 100, 5, new Word("No signal"));
  Font.draw(325, 100, 5, new Word("No signal"));
}

void RedAlert(){
  fill(255, 0, 0);
  stroke(255);
  ellipse(35.5, 306.25, 10, 10);
  noStroke();
  if(frameCount%50==0){
    flashOn = !flashOn;
  } 
  if(flashOn) {
    fill(255, 0, 0, 50);
  }
  else {
    fill(255, 0, 0, 100);
  }
  rect(0, 0, width, height);
}

void drawCockpit(){
  //x25 from virtal graph paper
  fill(black);
  //11.5, 0 --> 12.5, 11. x, y: 287.5, 0  w, h: 25, 275
  rect(287.5, 0, 25, 275); //upright
  fill(white);
  rect(288, 0, 2, 275);
  rect(310, 0, 2, 275);
  noStroke();
  fill(black);
  //0, 11 --> 24, 16. x, y: 0, 275 w, h: 600, 125
  rect(0, 275, 600, 125); //main console, minus the top triangles
  fill(black);
  //0, 11 --> 12, 10.5 --> 12, 11. x1, y1: 0, 275 x2, y2: 300, 262.5 x3, y3: 300, 275
  triangle(0, 275, 300, 262.5, 300, 275); //left top edge of console
  stroke(white);
  fill(white);
  strokeWeight(2);
  line(0, 273.5, 288, 261);
  noStroke();
  fill(black);
  //24, 11 --> 12, 10.5 --> 12, 11. x1, y1: 600, 275 x2, y2: x3, y3:
  triangle(600, 275, 300, 262.5, 300, 275); //right top edge of console
  stroke(white);
  fill(black);
  strokeWeight(2);
  line(600, 275.5, 310, 261);
  
  //3 LH lights, text
  //1.5, 12.25 rad 0.25 x, y: 37.5, 306.25 r: 6.25
  //1.5, 13 y: 325
  //1.5, 13.75 y: 343.75
  ellipse(35.5, 306.25, 10, 10);
  ellipse(35.5, 325, 10, 10);
  ellipse(35.5, 343.75, 10, 10);
  
  //LH screen background
  //4, 12 --> 8, 14. x, y: 100, 300 w, h: 100, 50
  rect(100, 295, 100, 55);
  //LH screen display
  showCargo();
  
  //sensor strip
  //9, 13.5 --> 15, 14. x, y: 225, 337.5 w, h: 150, 12.5
  fill(black);
  stroke(white);
  rect(225, 337.5, 150, 12.5); //background
  //9.25, 13.75 <--> 14.75, 13.75 x1, y1: 231.25, 343.75 x2: 368.75
  fill(white);
  noStroke();
  ellipse(231.25, 343.75, 6.25, 6.25);
  ellipse(368.75, 343.75, 6.25, 6.25);
  if(sensors){
    //ellipse(map(frameCount%20, 0, 19, 231.25, 368.75), 343.75, 6.25, 6.25);
    fill(255);
    ellipse(map(sin(frameCount/10), -1.75, 1.75, 231.25, 368.75), 343.75, 6.25, 6.25);
    fill(200);
    ellipse(map(sin((frameCount+0.005)/10), -1.75, 1.75, 231.25, 368.75), 343.75, 6.25, 6.25);
    fill(100);
    ellipse(map(sin((frameCount+0.2)/10), -1.75, 1.75, 231.25, 368.75), 343.75, 6.25, 6.25);
  }
  
  //throttle
  fill(black);
  stroke(white);
  //LH buttons
  //9, 14.75 --> 9.25, 15 x, y: 225, 368.75 w, h: 6.25, 6.25
  //9, 15.25 --> 9.25, 15.5 y: 387.5
  //9, 15.75 --> 9.25, 16 y: 400
  //RH buttons
  //14.75, etc x: 368.75
  rect(225, 362.5, 6.25, 6.25); //LH top
  rect(225, 375, 6.25, 6.25); //LH middle
  rect(225, 387.5, 6.25, 6.25); //LH bottom
  rect(368.75, 362.5, 6.25, 6.25); //RH top
  rect(368.75, 375, 6.25, 6.25); //RH middle
  rect(368.75, 387.5, 6.25, 6.25); //RH bottom
  //9.5, 14.5 --> 10.5, 16.5 x, y: 237.5, 362.5 w, h: 25, 50
  //9.75, 14.75 --> 10, 16.5 x, y: 243.75, 368.75 w, h: 6.25, 43.75
  rect(237.5, 362.5, 25, 50);
  rect(243.75, 368.75, 6.25, 43.75);
  //13.75 x: 343.75
  rect(337.5, 362.5, 25, 50);
  rect(350, 368.75, 6.25, 43.75);
  //11.75, 14.75 --> 12.25, 16.5 x, y: 293.75, 368.75 w, h: 12.5, 43.75
  fill(white);
  rect(293.75, 368.75, 12.5, 43.75);
  //11, 14.75 --> 13, 15.25 x, y: 275, 362.5 w, h: 50, 12.5
  fill(black);
  rect(275, map(speed, 15, 0, 362.5, 390), 50, 12.5);
  
  //RH slider grooves
  //RH slider values
  //16 x: 400
  //16.75 x: 418.75
  //17.5 x: 437.5
  //18.25, 11.75 --> 18.25, 14 x: 456.25 y1, y2: 293.75, 350
  line(400, 293.75, 400, 350);
  line(418.75, 293.75, 418.75, 350);
  line(437.5, 293.75, 437.5, 350);
  line(456.25, 293.75, 456.25, 350);
  fill(white);
  rect(393.75, map(slider1, 0, 10, 295, 350), 12.5, 6.25);
  rect(412.5, map(slider2, 0, 10, 295, 350), 12.5, 6.25);
  rect(431.25, map(slider3, 0, 10, 295, 350), 12.5, 6.25);
  rect(450, map(slider4, 0, 10, 295, 350), 12.5, 6.25);
  
  //RH screen background
  //19.25, 12 --> 23, 14 x, y: w, h:
  fill(black);
  rect(480, 295, 100, 55);
  //RH screen display
  showStatus();
  
  //map background
  //9, 9 --> 15, 12.75 x, y: 225, 225 w, h: 150, 93.75
  fill(black);
  stroke(white);
  rect(225, 225, 150, 93.75);
  //map grid
  //9.5, 9.5 --> 14.5, 12.25 x, y: 237.5, x2, y2: 362.5, 306.25
  stroke(grey);
  for(float i = 237.5; i <= 362.5; i+=12.5){
    line(i, 237.5, i, 306.25);
  }
  for(float i = 237.5; i <= 306.25; i+=11.35){
    line(237.5, i, 362.5, i);
  }
  
  //location
  if(sensors){
    fill(white);
    ellipse(map(x, 0, 10, 237.5, 362.5), map(y, 0, 10, 237.5, 306.25), 6 + (sin(frameCount/15) * 2), 6 + (sin(frameCount/15) * 2));
  }
  
  //chairs
  stroke(white);
  fill(grey);
  //1, 14.5 --> 8, 16+ x, y: 25, 362.5 w, h: 175, 50 r:
  //16, 14.5 --> 23, 16+ x, y: 400, 362.5 w, h: 175, 50 r: 
  rect(25, 362.5, 175, 70, 25);
  rect(400, 362.5, 175, 70, 25);
  pilot();
  coPilot();
  
  healthbar.drawStatus();
}

void showCargo(){
  //start text at 105, 305
  //16 $ per line, 5 lines max --> 60 character message
  //+40 in y for each line at font 4
  
  if(!displays){
    //displays turned off
    noStroke();
    fill(grey);
    Font.draw(105, 315, 1, _space, _space, _space, _space, _space, _n, _o, _space, _s, _i, _g, _n, _a, _l); 
  }
  else {
    //displays are on!
    if(shields){
    noStroke();
    fill(0, 255, 255);
    Font.draw(105, 335, 1, _space, _space, _space, _space, _s, _h, _i, _e, _l, _d, _s, _space, _u, _p, _exclam); 
    }
    else {
      noStroke();
      fill(grey);
      Font.draw(105, 335, 1, _space, _space, _space, _s, _h, _i, _e, _l, _d, _s, _space, _d, _o, _w, _n); 
    }
    //show rest of screen
    noStroke();
    
    //show instructions to player:
    // ! warning !
    // attitude ctrl / artificial grav / sensors
    // off-line

    if(!attitudeControl){
      fill(255, 0, 0);
      Font.draw(105, 305, 1, _space, _space, _space, _space, _exclam, _space, _w, _a, _r, _n, _i, _n, _g, _space, _exclam);
      Font.draw(105, 315, 1, _a, _t, _t, _i, _t, _u, _d, _e, _space, _c, _o, _n, _t, _r, _o, _l);
      Font.draw(105, 325, 1, _o, _f, _f, _dash, _l, _i, _n, _e);
    }
    else if(!artificialGravity){
      fill(255, 0, 0);
      Font.draw(105, 305, 1, _space, _space, _space, _space, _exclam, _space, _w, _a, _r, _n, _i, _n, _g, _space, _exclam);
      Font.draw(105, 315, 1, _a, _r, _t, _i, _f, _i, _c, _i, _a, _l, _space, _g, _r, _a, _v, _period);
      Font.draw(105, 325, 1, _o, _f, _f, _dash, _l, _i, _n, _e);
    }
    else if(!sensors){
      fill(255, 0, 0);
      Font.draw(105, 305, 1, _space, _space, _space, _space, _exclam, _space, _w, _a, _r, _n, _i, _n, _g, _space, _exclam);
      Font.draw(105, 315, 1, _f, _o, _r, _w, _a, _r, _d, _space, _s, _e, _n, _s, _o, _r, _s);
      Font.draw(105, 325, 1, _o, _f, _f, _dash, _l, _i, _n, _e);
    }
    
    // release
    // parking brake
    // for warp speed
    
    else if(parkingBrake){
      fill(255, 0, 0);
      Font.draw(105, 305, 1, _space, _space, _space, _space, _exclam, _space, _r, _e, _l, _e, _a, _s, _e, _space, _exclam);
      Font.draw(105, 315, 1, _p, _a, _r, _k, _i, _n, _g, _space, _b, _r, _a, _k, _e);
      Font.draw(105, 325, 1, _f, _o, _r, _space, _w, _a, _r, _p, _space, _s, _p, _e, _e, _d);
    }
    
    // press space
    // to engage
    // warp engines
    
    else {
      fill(255);  
      Font.draw(105, 305, 1, _p, _r, _e, _s, _s, _space, _s, _p, _a, _c, _e);
      Font.draw(105, 315, 1, _t, _o, _space, _e, _n, _g, _a, _g, _e);
      Font.draw(105, 325, 1, _w, _a, _r, _p, _space, _e, _n, _g, _i, _n, _e, _s);
    }
    
    } 
}

void showStatus(){
  //start text at 485, 305
  //16 $ per line, 5 lines max --> 60 character message
  //+40 in y for each line at font 4
  
  if(!displays){
    //displays turned off
    noStroke();
    fill(grey);
    Font.draw(485, 315, 1, _space, _space, _space, _space, _space, _n, _o, _space, _s, _i, _g, _n, _a, _l); 
  }
  else {
    if(redAlert){
      noStroke();
      fill(255, 0, 0);
      Font.draw(485, 335, 1, _space, _space, _space, _space, _space, _r, _e, _d, _space, _a, _l, _e, _r, _t, _exclam);    
    }
    fill(grey);
    noStroke();
    Font.draw(485, 305, 1, _g, _i, _t, _space, _s, _h, _i, _p, _space, _m, _period, _a, _period, _i, _period, _n, _period);
    Font.draw(485, 315, 1, _w, _a, _r, _p, _space, _f, _a, _c, _t, _o, _r);
    Font.draw(553, 315, 1, new Number(speed, 2));
    Font.draw(485, 325, 1, new Word(location));
    //line 4 for red alert only
  }
}

void pilot(){
  noStroke();
  fill(255);
  Font.draw(45, 377, 2, new Word(pilot));
}

void coPilot(){
  noStroke();
  fill(255);
  Font.draw(415, 377, 2, new Word(copilot));
}
