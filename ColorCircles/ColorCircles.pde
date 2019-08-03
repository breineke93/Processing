color start=color(204, 102, 0); //<>//
color inter;
color end=color(0, 102, 153);
float pos_color;
float x, y;
int size=25;
int numberx, numbery, numberMask;
int sizeMask=100;
PGraphics mask, circles, back;

void setup() {
  size(1200, 900);
}

void draw() {
  noLoop(); 

  numberMask=(int)width/sizeMask;
  noStroke();
  back=createGraphics(width, height);
  mask=createGraphics(width, height);

  circles=createGraphics(width, height);
  hint(ENABLE_DEPTH_SORT);
  drawCircles();
  drawMask();
  circles.mask(mask);

  back.beginDraw();
  back.background(0);
  back.endDraw();
  image(back, 0, 0);
  image(circles, 0, 0);
}

void drawCircles() {
  //circles.smooth(8);
  circles.beginDraw();
  circles.noStroke();
  x=size/2;
  y=size/2;
  numbery=height/size;
  numberx=width/size;
  circles.background(0);
  for (int i=0; i<numbery; i++) {
    start=color(random(255), random(255), random(255));
    end=color(random(255), random(255), random(255));
    for (int j=0; j<numberx; j++) {
      pos_color=(float)j/numbery;
      color inter=lerpColor(start, end, pos_color);
      circles.fill(inter);
      circles.ellipse(x, y, size, size);
      x+=size;
    }
    y+=size;
    x=size/2;
  }
  circles.endDraw();
}

void drawMask() {
  mask.beginDraw();
  mask.stroke(0);
  mask.strokeWeight(4);
  mask.fill(0, 0, 255);
  int posx=0+(width/numberMask)/2;
  for (int i=0; i<numberMask; i++)
  {
    mask.ellipse(posx, height/2, sizeMask+3, sizeMask+3);
    posx+=width/numberMask;
  }
  mask.endDraw();
}

void keyPressed() {
  if (key == CODED) {
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
}
