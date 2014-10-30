class Start {
  float startGame;
  float j;
  PFont font;
  float fontI;
  float oppa;
  Start () {
    startGame=0;
    j=height;
  }

  void display() {
    rectMode(CENTER);

    fill(255, 50);
    rect (width/2, height/3, 150, 50);
    fill(0);
    font = loadFont("Helvetica-48.vlw");
    textFont(font, 30);

    textAlign(CENTER);
    fill(255, 100);
    text ("To Start", width/2-1, height/3+9);
    fill(0);
    text ("To Start", width/2, height/3+10);

    // explain
    textSize(20);
    fill(255, oppa);
    text ("Blow into the mouth of the bottle ", width/2, height/2-50);
    text ("And hold it tight", width/2, height/2-25);
    fontI = fontI+0.1;
    oppa = map(sin(fontI),-1,1,0,255);

  }
}

