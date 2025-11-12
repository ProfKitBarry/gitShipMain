//art inspired by https://ih1.redbubble.net/image.928484824.4037/raf,750x1000,075,t,8DB3D2:e6f0370482.u2.jpg

class Person {
  
  color shirt;
  color shadow; //face & shirt shadows
  color eyes; //eyes & shirt detail 1
  color skin;
  color skinShadow;
  color hair; //hair & shirt detail 2
  color teeth;
  boolean ridges;
  
  int frame; //for animating the mouth
  float ta;
  int textSpeed = 3; //frames per add-another-word to speach
  int spoken; //how much of the message is on-screen;
  Letter[] display = { _a, _b, _c };
  
  Person(){
    SetIdentity(0);
  }
  
  void SetIdentity(int i){
    //we'll take the helpful comments out to disguise who is speaking
    //this is so folks can't just find the words, it's got to be the correct speaker
    ridges = i == 3;
    switch(i){
      case 0:
        shirt = color(#FF004D);
        shadow = color(#A90033); //shirt shadows
        eyes = color(#000000); //eyes & shirt detail 1
        skin = color(#FCE0CF);
        skinShadow = color(#B39176); //face & shirt shadows
        hair = color(#FFA300); //hair & shirt detail 2
        teeth = color(#FFFFFF);
        break;
      case 1:
        shirt = color(#FFEC27);
        shadow = color(#FFA300); //face & shirt shadows
        eyes = color(#000000); //eyes & shirt detail 1
        skin = color(#FCB487);
        skinShadow = color(#B39176); //face & shirt shadows
        hair = color(#AB5236); //hair & shirt detail 2
        teeth = color(#FFFFFF);
        break;
      case 2:
        shirt = color(#29ADFF);
        shadow = color(#1D7AB4); //face & shirt shadows
        eyes = color(#000000); //eyes & shirt detail 1
        skin = color(#FFCCAA);
        skinShadow = color(#B39176); //face & shirt shadows
        hair = color(#C2C3C7); //hair & shirt detail 2
        teeth = color(#FFFFFF);
        break;
      case 3:
        shirt = color(#FFEC27);
        shadow = color(#FFA300); //face & shirt shadows
        eyes = color(#000000); //eyes & shirt detail 1
        skin = color(#AB5236);
        skinShadow = color(#833F29); //face & shirt shadows
        hair = color(#5C2D1D); //hair & shirt detail 2
        teeth = color(#FFFFFF);
        break;
    }
  }
  
  void update(){
    ta += 0.01;
    if(frameCount%10==0) {
      frame = int(random(0, 3));
    }
  }
  
  void display(){
    backdrop();
    body();
    head();
    
    //cycle through talking frames
    switch(frame){
      case 0:
        frameA();
        break;
      case 1:
        frameB();
        break;
      case 2:
        frameC();
        break;
    }
    showDialogue();
    showStatic();
  }
  
  void backdrop(){
    //fill left half of screen with something
    //0, 0 --> 12, 11.25
    fill(#46937C);
    rect(0, 0, width, 281.25);
  }
  
  void body(){
    fill(shirt);
    //4.25, 7.25 --> 7.5, 11
    //3.75, 7.75 --> 8, 11
    rect(106.25, 181.25, 81.25, 93.75);
    rect(93.75, 193.75, 106.25, 81.25);
    fill(skinShadow);
    //5.25, 6.5 --> 6.75, 7.5
    rect(131.25, 162.5, 37.5, 25);
    fill(shadow);
    //4.75, 8.75 --> 5.25, 11
    rect(118.75, 218.75, 12.5, 56.25);
    //7.5, 7.5 --> 8, 11
    rect(187.5, 187.5, 12.5, 87.5);
    fill(eyes);
    //4.75, 7.25 --> 7.25, 7.75
    rect(118.75, 181.25, 62.5, 12.5);
  }
  
  void head(){
    fill(skin);
    //3.75, 2.25 --> 7.75, 6.25
    //3.25, 4.25 --> 8.25, 5.25
    rect(93.75, 56.25, 100, 100);
    rect(81.25, 106.25, 125, 25);
    fill(hair);
    //3.75, 2.25 --> 4.25, 4.75
    rect(93.75, 56.25, 12.5, 62.5);
    //4.25, 1.75 --> 7.25, 2.25
    rect(106.25, 43.75, 75, 12.5);
    //4.25, 1.75 --> 6.75, 2.75
    rect(106.25, 43.75, 62.5, 25);
    //7.25, 2.25 --> 7.75, 4.75
    rect(180, 56.25, 13.5, 62.5);
    fill(eyes);
    //5.25, 4.25 --> 5.75, 4.75
    //6.75, 4.25 --> 7.25, 4.75
    rect(131.25, 106.25, 12.5, 12.5);
    rect(168.75, 106.25, 12.5, 12.5);
    fill(skinShadow);
    //6.25, 4.25 --> 6.25, 4.25
    rect(156.25, 106.25, 12.5, 25);
    if(ridges){
      strokeWeight(4);
      stroke(skinShadow);
      line(150, 93.75, 143.75, 87.5);
      line(143.75, 87.5, 133.75, 87.5);
      line(133.75, 87.5, 118.75, 81.25);
      //5.75, 3.25 --> 5.5, 3.25 --> 5, 3 --> 4.75, 3
      line(143.75, 81.25, 137.5, 81.25);
      line(137.5, 81.25, 125, 75);
      line(125, 75, 118.75, 75);
      //6.25, 3.25 --> 6.75, 3 --> 7, 2.75
      line(156.25, 81.25, 168.75, 75);
      line(168.75, 75, 175, 68.75);
      //6.5, 3.75 --> 6.5, 3.5 --> 7, 3.25
      line(162.5, 93.75, 162.5, 87.5);
      line(162.5, 87.5, 175, 81.25);
    }
    noStroke();
  }
  
  void frameA(){
    fill(skin);
    //4.25, 5.5 --> 7.25, 6.75
    rect(106.25, 137.5, 75, 31.25);
    fill(teeth);
    //5.25, 5.75 --> 6.75, 6.25
    rect(130, 143.74, 37.5, 12.5);
  }
  
  void frameB(){
    fill(skin);
    //4.25, 5.5 --> 7.25, 7
    rect(106.25, 137.5, 75, 37.5);
    fill(teeth);
    //5.25, 5.75 --> 6.75, 6.5
    rect(130, 143.74, 37.5, 18.75);
  }
  
  void frameC(){
    fill(skin);
    //4.25, 5.5 --> 7.25, 6.75
    rect(106.25, 137.5, 75, 31.25);
    fill(teeth);
    //5.75, 5.75 --> 6.25, 6.25
    rect(143.74, 143.74, 12.5, 12.5);
  }
  
  void showStatic(){
    for(int x = 0; x < width; x+=10){
      for(int y = 0; y < height; y+=10){
        float col = map(noise(x, y, ta), 0, 1, 0, 255);
        fill(col, 50);
        rect(x, y, 10, 10);
      }
    }
  }
  
  void showDialogue(){
    //start text at 320, 50
    //12 $ per line, 4 lines max --> 48 character message
    //+40 in y for each line at font 4
    fill(shirt);
    Font.draw(320, 50, 4, _w, _e, _l, _c, _o, _m, _e, _space, _t, _o);
    Font.draw(320, 90, 4, _n, _e, _w, _space, _t, _o, _r, _o, _n, _t, _o, _exclam);
    Font.draw(320, 130, 4, _b, _e, _a, _m, _i, _n, _g, _space, _t, _h, _e);
    Font.draw(320, 170, 4, _n, _e, _r, _d, _space, _t, _o, _space, _y, _o, _u, _period);
  }
}
