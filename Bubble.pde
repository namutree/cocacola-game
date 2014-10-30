class Bubble {
  float x;
  float y;
  float radius;
  float radiusXfactor=random(1, 2);
  float radiusYfactor=random(1, 2);
  float xMove;
  float ySpeed = random(1.2, 1.7);


  Bubble (float _radius, float _x) {
    x= _x;
    y= height;
    radius = _radius;
  }

  void display () {

    //bubble
    stroke(255);
    noFill();
    ellipse (x, y, radius*2, radius*2);

    //highlight
    fill(255);
    noStroke();
    ellipse (x-radius/2.5, y-radius/2.5, radius/4, radius/4);
 
    // bubble's move
    xMove = xMove +sin(PI/random(15, 18));
    x= x+sin(xMove); 
    x = constrain(x, 0+radius, width-radius);
  }

  void ascend () {
    if (y<=radius) {
      y=radius;
    } 
    else {
      y = y - ySpeed;
    }
  }

  void stir () {
    if (xpos<x+radius*4 && xpos>x-radius*4 && xpos<y+radius*4 && xpos>y-radius*4) {
      if (xAdd>0) {
        x +=1.5;
      } 
      else if (xAdd <0) {
        x -=1.5;
      }
      if (yAdd>0) {
        y +=1.5;
      } 
      else if (yAdd>0) {
        y -=1.5;
      }
    }
  }

  void pop () {
    fill(255);
    beginShape();
    for (int j=1;j<15;j+=2) {
      vertex (x+(radius+10.00)*cos(PI*j/7), y+(radius+10.00)*sin(PI*j/7));
      vertex (x+(radius/3)*cos(PI*(j+1)/7), y+(radius/3)*sin(PI*(j+1)/7));
    }
    endShape(CLOSE);
  }
}

