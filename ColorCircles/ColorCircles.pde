color start=color(204, 102, 0); //<>//
color inter;
color end=color(0, 102, 153);
float pos_color;
float x, y;
int size=25;
int numberx, numbery;
PGraphics mask, circles;

void setup() {
  size(1980, 1080);
  noStroke();
  mask=createGraphics(width, height);
  circles=createGraphics(width, height);
  blendMode(BLEND);
}

void draw() {
  noLoop();
  drawCircles();
  drawMask();
  image(mask,0,0);
  image(circles, 0, 0);
  
}

void drawCircles() {
  circles.beginDraw();
  x=size/2;
  y=size/2;
  numbery=height/size;
  numberx=width/size;
  background(45);
  for (int i=0; i<numbery; i++) {
    start=color(random(255), random(255), random(255));
    end=color(random(255), random(255), random(255));
    for (int j=0; j<numberx; j++) {
      pos_color=(float)j/10.0;
      color inter=lerpColor(start, end, pos_color);
      fill(inter);
      ellipse(x, y, size, size);
      x+=size;
    }
    y+=size;
    x=size/2;
  }
  circles.endDraw();
}

void drawMask() {
  mask.beginDraw();
  //background(0);
  fill(255,255,255,255);
  int posx=height/2;
  for (int i=0; i<5; i++)
  {
    ellipse(posx, height/2, height, height);
    posx+=height;
  }
  mask.endDraw();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode==UP) {
      size+=100;
      redraw();
    }
    if (keyCode==DOWN) {
      if (size>50) {
        size-=50;
        redraw();
      } else {
        return;
      }
    }
  }
}
