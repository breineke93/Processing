/* //<>// //<>//
GNU GPLv3
 https://github.com/breineke93/Processing/
 */

int startNumber, numberCurrent, passes, currentPass, numberY;
float widthCircle, ySlice;
color start, end, inter, darker, interY;
boolean single;

void setup() {
  size(1200, 900);
  startNumber=4; //start with 4 circles in first round
  passes=3; //do 3 passes initially
  setColors(); //generate random colors
  noStroke();
  single=true;
  //strokeWeight(2);
  numberY=3;
}

void draw() {
  noLoop();
  drawCircles(); //drawing happens in this method
}

void drawCircles() {
  background(45); //start by setting the background to a dark-ish gray
  float x, y, colorPos, colorPosY; //define variables we need
  if (single)
  {
    y=height/2; //draw at half the image height
    x=0+width/startNumber/2; //start at left edge of image (offset is half the circle size)
    numberCurrent=startNumber; //set the current iteration nr to the start number
    colorPos=0.0; //begin with start color HERE MIGHT BE AN ERROR - set to 0 and then ??
    for (int i=0; i<passes; i++) { //loop through the passes
      colorPos=(float)i/passes; //calculate the current position in the gradient
      if (width/numberCurrent<=height) //make sure circle always fits in image y-wise
        widthCircle=(float)width/numberCurrent;
      else
        widthCircle=height;
      color inter=lerpColor(start, end, colorPos); //generate interpolated color
      fill(inter); //set to interpolated color
      for (int j=0; j<numberCurrent; j++) { //loop x-wise
        ellipse(x, y, widthCircle, widthCircle);
        x+=widthCircle; //increment x position by circle width
      }
      numberCurrent=numberCurrent*2; //every iteration double the circle amount
      x=0+width/numberCurrent/2; //reset x position
    }
  }
  if (!single)
  {
    widthCircle=height/numberY;
    y=widthCircle/2;
    x=0+width/startNumber/2; //start at left edge of image (offset is half the circle size)
    numberCurrent=startNumber; //set the current iteration nr to the start number
    colorPos=0.0; //begin with start color for inner circle iterations HERE MIGHT BE AN ERROR - set to 0 and then ??
    colorPosY=0.0; //begin with start Color in Y-direction
    for (int i=0; i<numberY; i++) {
      colorPosY=(float)i/numberY;
      color interY=lerpColor(start, end, colorPosY);
      for (int j=0; j<passes; j++) {
        colorPos=(float)j/passes;
        darker=color(red(interY)-10, blue(interY)-10, green(interY)-10);
        color inter=lerpColor(interY, darker, colorPos);
        fill(inter);
        widthCircle=(float)width/numberCurrent;
        for (int k=0; k<numberCurrent; k++) { //loop x-wise
          ellipse(x, y, widthCircle, widthCircle);
          x+=widthCircle; //increment x position by circle width
        }
        numberCurrent=numberCurrent*2; //every iteration double the circle amount
        x=0+width/numberCurrent/2; //reset x position
      }
      widthCircle=height/numberY;
      y+=widthCircle;
      numberCurrent=startNumber;
      x=0+width/numberCurrent/2;
    }
  }
}


void keyPressed() {
  if (key==CODED) {
    if (keyCode==UP) { //more passes
      passes++;
      redraw();
    }
    if (keyCode==DOWN) {
      if (passes>1) { //less passes (cannot go lower than 1)
        passes--; 
        redraw();
      } else
        return;
    }
    if (keyCode==LEFT) { //less circles in first pass
      if (startNumber>1) {
        startNumber--;
        redraw();
      } else
        return;
    }
    if (keyCode==RIGHT) { //more circles in first pass
      startNumber++;
      redraw();
    }
  }
  switch(key) {
  case 'c': //random color
    setColors();
    redraw();
    break;
  case 'i': //save (i)mage
    save("SubCircles.png");
    break;
  case 'r': //reset
    setColors();
    startNumber=2;
    passes=2;
    redraw();
    break;
  case 'm':
    single=!single;
    redraw();
    break;
  }
}

void setColors() { //initialize random colors
  start=color(random(255), random(255), random(255)); 
  end=color(random(255), random(255), random(255));
}
