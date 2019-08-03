color start=color(204, 102, 0); //<>// //<>// //<>// //<>//
color inter;
color end=color(0, 102, 153);
float pos_color;
float x, y;
int size=25;
int numberX, numberY, numberMaskX, numberMaskY, maskY, deltaMaskY;
int sizeMask=100;
PGraphics mask, circles, back;

void setup() {
  size(1200, 900);
  numberMaskY=1; //start with 1 row of mask circles
  maskY=height/(numberMaskY+1); //calculate starting point of mask circles (middle of screen)
  deltaMaskY=0; //no offset since we are starting with 1 row only
}

void draw() {
  noLoop(); 
  numberMaskX=(int)width/sizeMask; //determine amount of mask circles to fit on screen x-wise
  noStroke();
  back=createGraphics(width, height);
  mask=createGraphics(width, height);
  circles=createGraphics(width, height);
  hint(ENABLE_DEPTH_SORT); //don't know if this is really needed here?
  drawCircles();
  drawMask(deltaMaskY); //on startup deltaMaskY is 0
  circles.mask(mask);
  back.beginDraw();
  back.background(0);
  back.endDraw();
  image(back, 0, 0);
  image(circles, 0, 0);
  save("colorCircles.png");
}

void drawCircles() {
  circles.beginDraw();
  circles.noStroke();
  x=size/2; //so that they start at the edge
  y=size/2;
  numberY=height/size;
  numberX=width/size;
  circles.background(0); //paint it black
  for (int i=0; i<numberY; i++) {
    start=color(random(255), random(255), random(255));
    end=color(random(255), random(255), random(255)); //at some point generate "pretty" color here
    for (int j=0; j<numberX; j++) {
      pos_color=(float)j/numberY;
      color inter=lerpColor(start, end, pos_color);
      circles.fill(inter);
      circles.ellipse(x, y, size, size);
      x+=size; //move 1 size to the right
    }
    y+=size; //move 1 size down, so next row can be drawn
    x=size/2; //start at beginning again
  }
  circles.endDraw();
}

void drawMask(int delta) {
  mask.beginDraw();
  mask.stroke(0);
  mask.strokeWeight(3); //if we use noStroke, then the fill will be aliased, so we draw a nice thick-ish stroke
  mask.fill(0, 0, 255); //make circles blue, since mask() uses blue as alpha channel (why? I don't know)
  int posx=0+(width/numberMaskX)/2; //Start at the left edge... 
  maskY=height/(numberMaskY+1)+delta; //set the starting y-value with the delta.
  for (int j=0; j<numberMaskY; j++) {
    for (int i=0; i<numberMaskX; i++)
    {
      mask.ellipse(posx, maskY, sizeMask, sizeMask);
      posx+=width/numberMaskX; //increase X so we move to the next circle
    }
    maskY+=sizeMask; //increase Y so we move to the next row
    posx=0+(width/numberMaskX)/2; //reset X so we start at the beginning again
  }
  mask.endDraw();
}

void keyPressed() {
  if (key == CODED) { //this is needed to check if we pressed a CODED key
    if (keyCode==UP) {
      size+=20;
      redraw();
    }
    if (keyCode==DOWN) {
      if (size>10) {
        size-=10;
        redraw();
      } else {
        return;
      }
    }
    if (keyCode==LEFT) {
      if (sizeMask>20) {
        sizeMask-=20;
        redraw();
      } else {
        return;
      }
    }  
    if (keyCode==RIGHT) {

      sizeMask+=20;
      redraw();
    }
  }
//all this can probably done using a switch statement more elegantly -.- oh well.
  if (key =='w' || key =='W') { //move mask up
    deltaMaskY-=25;
    redraw();
  }

  if (key =='s' || key =='S') { //move mask down
    deltaMaskY+=25;
    redraw();
  }

  if (key =='a' || key =='A') { //less mask rows
    if (numberMaskY>1)
    {
      numberMaskY--;
    }
    redraw();
    return;
  }

  if (key =='d' || key =='D') { //more mask rows
    numberMaskY++;
    redraw();
    return;
  }

  if (key =='i' || key =='I') { //save (I)mage
    save("ColorCircles.png");
  }
}
