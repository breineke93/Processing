/* //<>// //<>//
GNU GPLv3
 https://github.com/breineke93/Processing/
 */

color start, endX, interStartY, interEndY, inter, endY, endXY, back;
float x, y=0;
float offsetX, offsetY, colorPosX, colorPosY;
int size, amountRows, amountPositions;
boolean twoTone;
int randomOrientation, randomDraw;

void setup() {
  size(1200, 900);
  size=200;
  generateColors();
  twoTone=false;
  calculate();
  noStroke();
}

void draw() {
  noLoop();
  background(45);
  drawArcs();
}

void drawArcs() {

  x+=offsetX;
  y+=offsetY;
  if (twoTone) {
    background(back);
    fill(255);
    for (int i=0; i<amountRows; i++) {
      for (int j=0; j<amountPositions; j++) {

        randomOrientation=(int)random(4);
        switch(randomOrientation) {
        case 0:
          rect(x, y, size-5, size-5, size-5, 10, 10, 10);
          break;
        case 1:
          rect(x, y, size-5, size-5, 10, size-5, 10, 10);
          break;
        case 2:
          rect(x, y, size-5, size-5, 10, 10, size-5, 10);
          break;
        case 3:
          rect(x, y, size-5, size-5, 10, 10, 10, size-5);
          break;
        }

        x+=size;
      }
      y+=size;
      x=0+offsetX;
    }
  } else {
    background(45);

    for (int i=0; i<amountRows; i++) {
      colorPosY=(float)i/amountRows;
      interStartY=lerpColor(start, endY, colorPosY);
      interEndY=lerpColor(endX, endXY, colorPosY);
      for (int j=0; j<amountPositions; j++) {
        colorPosX=(float)j/amountPositions;
        inter=lerpColor(interStartY, interEndY, colorPosX);
        fill(inter);
        randomOrientation=(int)random(4);
        switch(randomOrientation) {
        case 0:
          rect(x, y, size-5, size-5, size-5, 10, 10, 10);
          break;
        case 1:
          rect(x, y, size-5, size-5, 10, size-5, 10, 10);
          break;
        case 2:
          rect(x, y, size-5, size-5, 10, 10, size-5, 10);
          break;
        case 3:
          rect(x, y, size-5, size-5, 10, 10, 10, size-5);
          break;
        }

        x+=size;
      }
      y+=size;
      x=0+offsetX;
    }
  }
  x=0;
  y=0;
}

void generateColors() {
  start=color(random(255), random(255), random(255));
  endX=color(random(255), random(255), random(255));
  endY=color(random(255), random(255), random(255));
  endXY=color(random(255), random(255), random(255));
  back=color(random(255), random(255), random(255));
}

void calculate() {
  amountPositions=(int)width/(size+10);
  amountRows=(int)height/(size+10);
  if (amountRows*size!=height || amountPositions*size!=width) {
    offsetX=(width-(amountPositions*size))/2;
    offsetY=(height-(amountRows*size))/2;
  }
}

void keyPressed() {
  switch(key) {
  case 'r': //since colors and orientations are random we generate new values for all
    generateColors();
    redraw();
    break;

  case 'm':
    twoTone=!twoTone;
    redraw();
    break;

  case 'i':
    if (twoTone)
    {
      save("Arcs_twoTone.png");
      break;
    } else {
      save("Arcs_gradient.png");
      break;
    }

  case 's':
    size-=20;
    calculate();
    redraw();
    break;
  }
}
