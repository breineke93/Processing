/*
GNU GPLv3
https://github.com/breineke93/Processing/
*/

int iterations, sizeStart, sizeNew;
float x, y, rotation, initialRot;
color col;
boolean mirrorX, mirrorY=false;
boolean isCircle, isSquare;

void setup() {
  size(1200, 900);
  isCircle=true; //let's start with circles
  isSquare=false; //so we turn off squares
  rotation=20.0; //this is a sane default
  ellipseMode(CENTER); //draw the circles with coordinates of the center
  noStroke(); //turn off stroke
  randomize(); //generate some random starting values to draw
}

void draw() {
  noLoop();
  background(25); //set the background to a very dark gray
  generateSwirl(); //drawing happens
}

void generateSwirl() {
  fill(col); //set fill to the generated color
  sizeNew=sizeStart;
  pushMatrix(); //save coordinates
  translate(x, y);
  rotate(radians(initialRot));
  if (isCircle) {
    for (int i=0; i<iterations; i++) {
      ellipse(-sizeNew/2, 0, sizeNew, sizeNew);
      sizeNew+=50;
      rotate(radians(rotation));
    }
    popMatrix(); //restore coordinates
  }
  if (isSquare) {
    for (int i=0; i<iterations; i++) {
      rect(0, 0, sizeNew, sizeNew);
      sizeNew+=50;
      rotate(radians(rotation));
    }
    popMatrix(); //restore coordinates
  }
}

void randomize() { //for x,y there is a 50 safety margin
  x=random(50, width-50);
  y=random(50, height-50);
  initialRot=random(360);
  sizeStart=(int)random(20, 200);
  iterations=(int)random(3, 25);
  generateColors();
}

void generateColors() {
  col=color(random(255), random(255), random(255), 50);
}

void keyPressed() {
  if (key!=CODED) {
    switch (key) {
    case 'w':
      sizeStart+=25;
      redraw();
      break;

    case 's':
      sizeStart-=25;
      redraw();
      break;

    case 'd':
      rotation+=5.0;
      redraw();
      break;

    case 'a':
      rotation-=5.0;
      redraw();
      break;

    case 'i':
      save("Spirals.png");
      break;

    case 'c':
      generateColors();
      redraw();
      break;

    case ',':
      initialRot+=10.0;
      redraw();
      break;

    case '.':
      initialRot-=10.0;
      redraw();
      break;

    case '+':
      iterations++;
      redraw();
      break;

    case '-':
      iterations--;
      redraw();
      break;

    case '1':
      isCircle=true;
      isSquare=false;
      redraw();
      break;

    case 'b':
      col=color(200, 200, 200, 35);
      redraw();
      break;

    case '2':
      isCircle=false;
      isSquare=true;
      redraw();
      break;

    case 'r':
      randomize();
      redraw();
      break;
    }
  } else {
    if (keyCode==UP) {
      y-=10;
      redraw();
    }

    if (keyCode==DOWN) {
      y+=10;
      redraw();
    }

    if (keyCode==LEFT) {
      x-=10;
      redraw();
    }

    if (keyCode==RIGHT) {
      x+=10;
      redraw();
    }

    //maybe we can put the redraw after the if conditionals? so we redraw in the end.
  }
}
