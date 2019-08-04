/* //<>//
 GNU GPLv3
 https://github.com/breineke93/Processing/
 */
//set everything up
float x, y, rot, a, safe;
int iterations;
color start, end, inter;
boolean stroke=true; //start with outlines, makes everything easier

void setup() {
  size(1200, 900);
  iterations=10; //10 iterations to boot
  safe=50; //50px safe zone
  rot=0.0; //no rotation at the beginning, changing this messes up final rotations somehow
  calcPositions(); //set up coordinates etc
  setColors(); //set up colors
}

void draw() {
  noLoop();
  makeSquares();
}

void makeSquares() {
  background(start); //setup background color
  float colorPos; //setup position in gradient
  colorPos=(float)1/(iterations+2); //calculate position since we use it for background already
  rectMode(CENTER); //create rectangles from center
  float aNew, rotNew; //maybe we don't even need this
  rotNew=radians(rot); //calculate the radians
  aNew=a; //start with the calculated a
  pushMatrix(); //store the coordinate system
  translate(x, y); //move coordinate system to beginning
  for (int i=0; i<iterations; i++) { //loop over iterations
    color inter=lerpColor(start, end, colorPos); //generate interpolated color
    fill(inter); //set to interpolated color
    rect(0, 0, aNew, aNew); //create the rectangle
    rotNew=rot+5; //increase rotation
    aNew = aNew*((sin(rotNew)+cos(rotNew)))*1.188; //Without factor this does not seem to work...
    rotate(rotNew); //rotate
    colorPos=(float)(i+2)/(iterations+2); //advance the gradient
  }
  popMatrix(); //reset the coordinates
}

void calcPositions() {
  x=random(100, width-safe); //generate x-coordinates
  y=random(100, height-safe); //generate y-coordinates
  a=random(300, height-safe); //generate length
  if (x+a>width-safe||y+a>height-safe||x<a||y<a) { //make sure we fit in the image
    calcPositions(); // if not: recalculate
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
