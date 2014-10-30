

class Score1 {

  Score1() {
  }  

  void display() {
    textSize(20);
    textAlign(LEFT);
    fill(255);

    aX = constrain (aX, 0, width-50);
    aY = constrain (aY, 30, height);
    text("+10", aX, aY); 
  }
  
  void display2(){
    textSize(20);
    textAlign(LEFT);
    fill(255);
    text("-3", bX, bY+10);
  }
  
  
  void displayBottom() {
    // bottom (background)
    fill(0, 150);
    noStroke ();
    beginShape();
    vertex (0, 615);
    quadraticVertex(0, height*0.95, width/2, height*0.95);
    quadraticVertex(width, height*0.95, width, height*0.9);
    vertex (width, height);
    vertex (0, height);
    endShape(CLOSE);

    //score bottom
    textSize(20);
    fill(255);
    text ("Score:", 40, height-10);
    text (score, 110, height-10);
    text ("Popped:", 180, height-10);
    text (ballPop, 253, height-10);
    text ("Missed:", 330, height-10);
    text (ballMiss, 407, height-10);
  }
}

