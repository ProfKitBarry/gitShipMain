class Checksum {
  int checksum = 3;
  color[] barColors = { color(#FF004D), color(#29ADFF), color(#FFEC27), color(#FFEC27), color(#FFEC27), color(#FFEC27), color(#FFEC27), color(#FFEC27), color(#FFEC27), color(#C2C3C7) };

  Checksum(){ 
    char[] bin = binary(checksum).toCharArray();
    if(parkingBrake == true) bin[bin.length - 1] = '0';
    checksum = unbinary(new String(bin));
  }

  void drawStatus(){
    //draw completed sections of the bar
    stroke(white);
    fill(black);
    //6.75, 0 --> 17.25, 1.5
    rect(168.75, 0, 262.5, 37.5);
    for(int i = 0; i < 10; i++){
      fill(barColors[i]);
      if((checksum & (1 << i)) > 0) {
        //7, 0.25 --> 8, 1.25
        rect(175 + (i * 25), 6.25, 25, 25);
      }
    }
  }
}
