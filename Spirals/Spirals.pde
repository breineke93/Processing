int iterations, sizeStart, sizeNew;
float x, y, rotation, initialRot;
color col;
boolean mirrorX, mirrorY=false;
boolean isCircle, isSquare;
void setup() {
  size(1200, 900);
  isCircle=true;
  isSquare=false;
  sizeStart=100;
  x=width/2;
  y=height/2;
  initialRot=0.0;
  rotation=20.0;
  iterations=10;
  ellipseMode(CENTER);
  col=color(200, 200, 200, 35);
  noStroke();
  randomize();
}

void draw() {
  noLoop();
  background(25);
  generateSwirl();
}

void generateSwirl() {
  fill(col);
  sizeNew=sizeStart;
  pushMatrix();
  translate(x, y);
  rotate(radians(initialRot));
  if (isCircle) {
    for (int i=0; i<iterations; i++) {
      ellipse(-sizeNew/2, 0, sizeNew, sizeNew);
      sizeNew+=50;
      rotate(radians(rotation));
    }
    popMatrix();
  }
  if (isSquare) {
    for (int i=0; i<iterations; i++) {
      rect(-sizeNew/2, 0, sizeNew, sizeNew);
      sizeNew+=50;
      rotate(radians(rotation));
    }
    popMatrix();
  }
}

void randomize() {
  x=random(50,width-50);
  y=random(50,height-50);
  initialRot=random(360);
  sizeStart=(int)random(20,200);
  iterations=(int)random(3,25);
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
      col=color(200,200,200,35);
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
