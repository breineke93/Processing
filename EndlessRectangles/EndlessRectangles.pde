/* //<>//
GNU GPLv3
https://github.com/breineke93/Processing/
*/

float x, y, rot, a, safe;
int iterations;
color start, end, inter;
boolean stroke=true;

void setup() {
  size(1200, 900);
  iterations=10;
  safe=50;
  rot=0.0;
  calcPositions();
  //noStroke();
  setColors();
}

void draw() {
  noLoop();

  makeSquares();
}

void makeSquares() {
  background(start);
  float colorPos;
  colorPos=(float)1/(iterations+2);
  rectMode(CENTER);
  float aNew, rotNew;
  rotNew=radians(rot);
  aNew=a;
  pushMatrix();
  translate(x, y);
  for (int i=0; i<iterations; i++) {
    color inter=lerpColor(start, end, colorPos); //generate interpolated color
    fill(inter); //set to interpolated color
    rect(0, 0, aNew, aNew);
    rotNew=rot+5;   
    aNew = aNew*((sin(rotNew)+cos(rotNew)))*1.188; //Without factor this does not seem to work...
    rotate(rotNew);
    colorPos=(float)(i+2)/(iterations+2);
  }
  popMatrix();
}

void calcPositions() {
  x=random(100, width-safe);
  y=random(100, height-safe);
  a=random(300, height-safe);
  if (x+a>width-safe||y+a>height-safe||x<a||y<a) {
    calcPositions();
  }
}


void setColors() {
  start=color(random(255), random(255), random(255)); 
  end=color(random(255), random(255), random(255));
}

void keyPressed() {
  if (key==CODED) {
    if (keyCode==UP) {
      y-=50;
      redraw();
      return;
    }

    if (keyCode==DOWN) {

      y+=50; 
      redraw();
      return;
    }

    if (keyCode==LEFT) {
      x-=50;
      redraw();
      return;
    }
    if (keyCode==RIGHT) {
      x+=50;
      redraw();
      return;
    }
  }
  switch(key) {
  case 'w':
    a+=25;
    redraw();
    break;

  case 's':
    if (a>25) {
      a-=25;
      redraw();
    } else {
      a=25;
    }
    break;

  case 'd':
    iterations++;
    redraw();
    break;

  case 'a':
    if (iterations>1) {
      iterations-=1;
      redraw();
    } else {
      iterations=1;
    }
    break;

  case 'c':
    setColors();
    redraw();
    break;
    
    case 'i':
    save("EndlessRectangles.png");
    break;
  case 'o':
    if (stroke==false) {
      stroke(0);
      stroke=true;
      redraw();
      return;
    }
    if (stroke==true) {
      noStroke();
      stroke=false;
      redraw();
      return;
    }
  }
}
