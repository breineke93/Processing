/*
GNU GPLv3
https://github.com/breineke93/Processing/
*/

color start, endX, interStartY,interEndY,inter,endY,endXY;
float x, y=0;
float offsetX,offsetY,colorPosX,colorPosY;
int size, amountRows, amountPositions;
boolean twoTone;
int randomOrientation, randomDraw;

void setup() {
  size(1200, 900);
  size=200;
  generateColors();
  twoTone=false;
  calculate();
}

void draw() {
  noLoop();
  background(45);
  drawArcs();
}

void drawArcs() {
  if (!twoTone) {
    x+=offsetX;
    y+=offsetY;
     for (int i=0; i<amountRows; i++) {
      colorPosY=(float)i/amountRows;
      interStartY=lerpColor(start,endY,colorPosY);
      interEndY=lerpColor(endX,endXY,colorPosY);
      for (int j=0; j<amountPositions; j++) {
       colorPosX=(float)j/amountPositions;
       inter=lerpColor(interStartY,interEndY,colorPosX);
       fill(inter);
       rect(x,y,size-5,size-5);
       x+=size;       
      }
      y+=size;
      x=0+offsetX;
           
    }
    x=0;
    y=0;
  }

}
void generateColors() {
  start=color(random(255),random(255),random(255));
  endX=color(random(255),random(255),random(255));
  endY=color(random(255),random(255),random(255));
  endXY=color(random(255),random(255),random(255));
}

void calculate() {
  amountPositions=(int)width/(size+10);
  amountRows=(int)height/(size+10);
  if (amountRows*size!=height || amountPositions*size!=width){ //<>//
  offsetX=(width-(amountPositions*size))/2;
  offsetY=(height-(amountRows*size))/2; //<>//
  }
}

void keyPressed(){
switch(key){
 case 'r':
 generateColors();
 redraw();
 break;
 
 case 's':
 size-=25;
 calculate();
 redraw();
 break;
}
}
