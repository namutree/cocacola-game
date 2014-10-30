
class Finish {

  float r[] = new float[height * width];
  float g[] = new float[height * width];
  float b[] = new float[height * width];
  int i;
  int a;
  PImage bottle;
  int xImg, yImg;

  Finish () {
    a=0;
    bottle = loadImage("bottle.png");
    xImg=0;
    yImg=0;
  }

  void displaySuccess () {
    PImage s= get();
    tint(255, 50);
    image (s, 0, 0);
    tint(255, 255);
    
    image(bottle, xImg, yImg);
    xImg= (xImg+20)%width;
    if (xImg==0) yImg = (yImg+68)%height;

    fill(5);
    textAlign(CENTER);
    textSize(27);
    text ("You scored more than 1000!", width/2, height/2);
  }   

  void displayFailure () {
    PImage s =get();
    image (s, 0, 0);

    loadPixels();
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        int loc = x + y * width;
        r[loc] = red(pixels[loc]);
        g[loc] = green(pixels[loc]);
        b[loc] = blue(pixels[loc]);

        if (r[loc]>150 && g[loc]>150 && b[loc]>150 ) {
          r[loc] =255;
          g[loc] =255;
          b[loc] =255;
        } 
        else if (loc%3==0 || loc%3==1) {
          r[loc] =0;
          g[loc] =0;
          b[loc] =0;
        }
        pixels[loc] = color ((r[loc]+g[loc]+b[loc])/3);
      }
    }
    updatePixels();

    fill(255, 0, 0);
    textAlign(CENTER);
    textSize(25);
    text ("You scored less than 1000!", width/2, height/2);
  }

  void tryAgain () {


    textAlign(LEFT);
    fill(255, 20, 20);
    textSize(30);
    text ("To try again", 30-1, 40-1);
    fill(255, 0, 0);
    text ("To try again", 30, 40);

    textSize(20);
    fill(255, 0, 0);
    text ("Blow into the mouth of the bottle ", 30, 40+40);
  }
}

