class Planet {
  PVector position;
  float radius;
  float tp;
  float r, g, b;
  float resolution = 100;
  float clouds;
  float sf = 1;
  float maxR;
  
  Planet(float x, float y, float r){
    radius = r;
    maxR = radius;
    position = new PVector(x, y);
    tp = 0;
    r = 90;
    g = 55;
    b = 80;
    clouds = random(0.1, 0.7);
    resolution = random(0.01, 0.1);
  }
  
  void sliders(){
    slider1 = map((r+g+b)/3, 0, 50, 0, 10);
    slider2 = map(clouds, 1, 5, 0, 10);
    slider3 = map(resolution, 0, 100, 0, 10);
  }
  
  void update(){
    sf = map(speed, 0, 10, 1, 0);
    radius = maxR * sf;
  }
  
  void display(){
    //x, y is the centre of this planet, which we want to raster scan
    //circle y == 0 +/- radius
    //circle width at any point: point is r cos theta, r sin theta, do trig for adjacent
    for(int i = - int(radius); i < int(radius); i++){
      float y = 0.1 + i;
      float w = radius * cos((asin(y/radius)));

      //instead of drawing a solid line, lets use Perlin noise to vary the alpha
      for(int j = int(position.x - w); j < int(position.x + w); j+=5){
        tp+=(0.00001 * resolution * random(0, clouds));
        float x = 0.1 + j;
        noStroke();
        float alpha = noise(j * resolution + tp, (position.y - y) * resolution);
        float rgb = map(y, 0, radius, 100, 255);
        fill(rgb-r, rgb-g, rgb-b, map(alpha, 0, 1, 0, 255));
        rect(x, position.y-y, 5, 5);
      }
      //tidy up the far side of the planet
      rect(position.x + w, position.y - y, 5, 5);
    }
  }
}
