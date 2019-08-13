color start, end, inter; //<>// //<>// //<>// //<>// //<>//
float colorPos, x, y;
int a;
int tilesX, tilesY, shift;

void setup() {
  size(1000, 1000); 
  generateColors();
  a=10;
  shift=25;
  calculate();
  noLoop();
  noStroke();
}

void generateColors() {
  start=color(random(255), random(255), random(255));
  end=color(random(255), random(255), random(255));
}

void calculate() {
  tilesX=(int)(width/a);
  tilesY=(int)(height/a);
  
}

void draw() {
  background(0);
  x=0;
  y=0;
  colorPos=0.0;
  for (int i=0; i<tilesX; i++) {
    for (int j=0; j<tilesY+2; j++) {

      colorPos=(float)j/tilesY;
      inter=lerpColor(start, end, colorPos);
      fill(inter);
      rect(x, y, a, a);
      if (y<=height) {
        y+=a;
      } else {
        y=0;
      }
    }

    y=(int)random(0, shift)*a;
    x+=a;
  }
}

void keyPressed() {
  switch(key) {
  case 'w':
     a+=10;
    calculate();
    redraw();
    break;

  case 's':
    a-=10;
    calculate();
    redraw();
    break;
    
    case 'c':
    generateColors();
    redraw();
    break;
    
    case '.':
    shift+=10;
    redraw();
    break;
    
    case ',':
    shift-=10;
    redraw();
    break;
  }
}
