// starfield simulation adapted from Dan Shiffman's Coding Challenge
// https://www.youtube.com/watch?v=17WoOqgXsRM
// modified to work without push/pop

class Star {
  float x;
  float y;
  float z;
  
  Star(){
    x = random(-width, width);
    y = random(-height, height);
    z = random(width);
  }
  
  void update(){
    z = z - speed;
    if(z < 1){
      z = width;
      x = random(-width, width);
      y = random(-height, height);
    }
  }
  
  void display(){
    float alpha = map(noise(x, y), 0, 1, 50, 255);
    fill(255, alpha);
    noStroke();
    
    float sx = map(x/z, 0, 1, width/2, width);
    float sy = map(y/z, 0, 1, height/2, height);
    float r = map(z, 0, width, 8, 0);
    
    rect(sx, sy, r, r);
  }
}
