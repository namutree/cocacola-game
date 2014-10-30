
import ddf.minim.*;

Minim minim;
AudioPlayer sou;
AudioPlayer bubblePop;

ArrayList<Bubble> b;
int score, count, ballPop, ballMiss, startTime, finishTime;
float aX, aY, bX, bY;
Start startBox;
Finish endup;
float duration;
Score1 scoreShow;
float xAdd, yAdd, zAdd;
float blow;
float xpos, ypos;
boolean firstContact = false; 
float fontII, oppac;
PImage photo;
PImage photoLeft;
boolean turnon=false;

Serial myPort; 
String myString = null;
import processing.serial.*;     // import the Processing serial library
int lf = 10;    // Linefeed in ASCII

void setup() {
  size (480, 680);
  duration = 900;
  b = new ArrayList<Bubble>();  
  startBox = new Start();
  endup = new Finish();
  b.add(new Bubble(15, random(0, width)));
  scoreShow = new Score1();


  serialSetup();

  xpos = width/2;
  ypos = height/2;

  photo = loadImage("ploarBear.png");
  photoLeft = loadImage("ploarBear_.png");

  minim = new Minim(this);
  sou = minim.loadFile("gamestart.mp3");
  bubblePop = minim.loadFile("bubblePopSound.mp3");
}


void draw () {
  serialEvent();
  //------------- come back to the first screen ----------
  if (keyPressed) {
    if (key==10) {
      // get rid of bubbles...
      for (int i=0;i<b.size();i++) {
        b.remove(i);
      }
      //start agian from the beginning
      startBox.startGame = 0;
    }
  }
  //-------------start screen----------
  if (startBox.startGame==0) {
    cokeBackground();
    startBox.display();
    startTime= frameCount;
    score = 0;
    ballPop = 0;
    ballMiss = 0;

    if (blow>15) {
      sou.rewind();
      sou.play();
      startBox.startGame = 1;
    }
  }


  //----------Try Again----------
  if (startBox.startGame ==0.1) { 
    startTime= frameCount;
    score = 0;
    ballPop = 0;
    ballMiss = 0;
    startBox.startGame = 1;
  }

  //-------Game--------
  if (startBox.startGame==1 && frameCount<duration+startTime) {
    cokeBackground();
    generator();
    //bubbles
    for (int i = 0;i< b.size()-1;i++) {
      Bubble b01 = b.get(i);
      b01.display();
      b01.ascend ();
      b01.stir();
      if  (xpos<b01.x+b01.radius+20 && xpos>b01.x-b01.radius-10 && ypos<b01.y+b01.radius+20 && ypos>b01.y-b01.radius-10) {
        b01.pop();
        aX=b01.x;
        aY=b01.y;
        b.remove(i);

        bubblePop.rewind();
        bubblePop.play();

        score = score +10;
        ballPop += 1;
      }
      scoreShow.display();

      if (b01.y<b01.radius+20) {
        if (count==100) {
          b01.pop();
          bX=b01.x;
          bY=b01.y;
          b.remove(i);
          score = score -3;
          count=0;
          ballMiss += 1;
        }

        scoreShow.display2();
        count +=1;
      }

      if (b01.y<height/2 && blow>40) {
        b01.y = b01.y +blow/10*(height/b01.y/10) ;
      }
    }
  }



  //---- finish Screen------
  if (frameCount > duration+startTime && score>=1000) {
    endup.displaySuccess();
    endup.tryAgain();
    if (blow>15) startBox.startGame = 0.1;
  }


  if (frameCount > duration+startTime && score<1000) {
    endup.displayFailure();   
    endup.tryAgain();
    if (blow>15) startBox.startGame = 0.1;
  }

  scoreShow.displayBottom();

  xpos = xpos + xAdd;
  ypos = ypos + yAdd;
  xpos = constrain(xpos, 0, width-15);
  ypos = constrain(ypos, 0, height-15);
  if (xAdd>0) {
    image(photo, xpos-3, ypos-3);
  } 
  else {  
    image(photoLeft, xpos-3, ypos-3);
  }
}



//------mouse moving generates bubbles-------
//------faster move, more bubbles------------
void generator () {
  for (int i=0;i<abs(xAdd/5)-0.65;i++) {
    b.add(new Bubble(random(7, 20), random(width)));
  }
  for (int i=0;i<abs(yAdd/5)-0.65;i++) {
    b.add(new Bubble(random(7, 20), random(width)));
  }
}

// --------Background-----------
void cokeBackground () {
  for (int i=0; i<height;i++) {
    float colorRange = map (i, 0, height, 0, 255);
    stroke (colorRange, 0, 0);
    line (0, i, width, i);
  }
  noStroke();
  fill (255, 220);
  beginShape();
  vertex (435, 680);
  quadraticVertex(413, 680, 368, 680);
  quadraticVertex(394, 634, 405, 606);
  quadraticVertex(421, 558, 431, 523);
  quadraticVertex(441, 478, 443, 452);
  quadraticVertex(446, 419, 447, 403);
  quadraticVertex(447, 362, 447, 343);
  quadraticVertex(444, 284, 442, 263);
  quadraticVertex(432, 198, 426, 170);
  quadraticVertex(415, 120, 411, 91);
  quadraticVertex(407, 47, 406, 29);
  quadraticVertex(406, 7, 406, 0);
  quadraticVertex(410, 0, 438, 0);
  quadraticVertex(435, 11, 433, 29);
  quadraticVertex(430, 59, 429, 78);
  quadraticVertex(428, 117, 430, 137);
  quadraticVertex(434, 174, 437, 200);
  quadraticVertex(442, 240, 445, 263);
  quadraticVertex(455, 330, 459, 364);
  quadraticVertex(464, 406, 466, 425);
  quadraticVertex(470, 490, 469, 511);
  quadraticVertex(463, 584, 457, 612);
  quadraticVertex(446, 658, 435, 680);
  endShape();
}

void serialSetup()
{
  println(Serial.list());
  String portName = Serial.list()[8];
  myPort = new Serial(this, portName, 9600);
  myPort.clear();
  myString = myPort.readStringUntil(lf);
  myString = null;
}

void serialEvent() {
  if (myPort.available () > 0) {
    myString = myPort.readStringUntil(lf);

    if (myString != null) {
      //println(myString);
      myString = trim(myString);
      float sensors[] = float(split(myString, ','));

      for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
        //print(sensorNum + ": " + sensors[sensorNum] + "\t");
      }  
      if (sensors.length == 4) {
        yAdd = sensors[0]*5;
        zAdd = sensors[1]*5;
        xAdd = -sensors[2]*5;        
        blow  = map(sensors[3], 0, 800, 0, 150);
        println(xAdd+" "+yAdd+" "+zAdd+" "+blow);
        //println();
      }
    }
  }
}

