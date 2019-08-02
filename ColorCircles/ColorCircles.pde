color start=color(204, 102, 0); //<>//
color inter;
color end=color(0, 102, 153);
float pos_color;
float x, y;
int size=25;
int numberx, numbery;

void setup() {
  size(1000, 1000);
  noStroke();
}

void draw() {
  noLoop();
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
    ;
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode==UP) {
      size+=100;
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
  }
}
