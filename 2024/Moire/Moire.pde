int sizeX, sizeY, amount; //<>// //<>//
boolean arcMode;
int radius, randomRot;
float padding;
int pinstripeThickness;
color frameColor, startColor, endColor;
boolean inverted=false;
int dotSize=20;
int dots=10;

void settings() {
  sizeX=1200;
  sizeY=900;
  padding=sizeX*0.05;
  radius=sizeY-100;
  size(sizeX, sizeY);
  amount=10;
  arcMode=true;
  randomRot=10;
}

void setup() {
  pinstripeThickness=2;
  generateColors();
}

void draw() {
  noLoop();
  if (!inverted) {
    background(#FFFFFC);
  } else {
    background(#555353);
  }
  drawMoire(amount);
  finish("Moiré", "2024", true, true);
}

void drawMoire(int amount) {
  strokeWeight(2);
  color lerpColor;
  float lerp=0.0;
  grid[] grid=new grid[amount];
  float[] positionsX=new float[amount];
  float[] positionsY=new float[amount];
  float[] rotations=new float[amount];
  if(arcMode){
  for (int i=0; i<amount; i++) {
    rotations[i]=(i)*(80/amount);
    positionsX[i]=cos(radians(rotations[i]))*radius;
    positionsY[i]=sin(radians(rotations[i]))*radius;
  }
  }
  else{
     for (int i=0; i<amount; i++) {
    rotations[i]=0;
    positionsX[i]=(sizeX/amount)*(i);
    positionsY[i]=((1.5*dotSize)*dots);
  }
  }
  for (int i=0; i<amount; i++) {
    lerpColor=lerpColor(startColor, endColor, lerp);
    grid[i]=new grid(positionsX[i], positionsY[i], rotations[i], dots, dotSize, lerpColor);
    grid[i].display();
    lerp=(float)i/amount;
  }
}

class grid {
  float x, y;
  int repeats;
  int size;
  float rotation;
  color gridColor;
  grid(float tempX, float tempY, float tempRot, int tempRepeats, int tempSize, color tempColor) {
    x=tempX;
    y=tempY;
    repeats=tempRepeats;
    size=tempSize;
    rotation=tempRot;
    gridColor=tempColor;
  }

  void display() {
    //noFill();
    //noStroke();
    stroke(255, 255, 255, 30);
    fill(gridColor);
    pushMatrix();
    translate(x, y);
    rotate(radians(rotation+random(randomRot)));
    for (int i=0; i<repeats; i++) {
      for (int j=0; j<repeats; j++) {
        circle(1.15*size*j, 1.15*size*i, 0.75*size);
      }
    }
    popMatrix();
  }
}

void finish(String Title, String Subtitle, boolean pinstripes, boolean frame) {
  if (pinstripes)
    if (pinstripes) {
      drawLines(pinstripeThickness);
    }
  if (frame) {
    drawFrame();
    drawLabel(Title, Subtitle);
  }
}

void drawFrame() {
  noStroke();
  if (!inverted) {
    fill(255);
    frameColor=color(0, 0, 0);
  } else {
    fill(#030202);
    frameColor=color(255, 255, 255);
  }
  rect(0, 0, sizeX, padding);
  rect(0, 0, padding, sizeY);
  rect((sizeX-padding), 0, padding, sizeY);
  rect(0, (sizeY-2*padding), sizeX, 2*padding);
  fill(30, 30, 30, 0);
  stroke(frameColor);
  strokeWeight(1);
  rect(padding, padding, (sizeX-2*padding), (sizeY-3*padding));
}

void drawLabel(String Title, String subTitle) {
  if (!inverted) {
    fill(0, 0, 0);
  } else {
    fill(255, 255, 255);
  }
  textAlign(CENTER);
  textSize(60);
  PFont font;
  font=loadFont("serif.vlw");
  textFont(font, 60);
  float posY=sizeY-padding;
  text(Title, sizeX/2, posY);
  textSize(40);
  text(subTitle, sizeX/2, (posY+40));
}

void drawLines(int stripeHeight)
{
  int numberX;
  numberX=sizeX/(stripeHeight/2);
  stroke(0, 0, 0, 10);
  for (int i=0; i<numberX; i+=(stripeHeight*2))
  {
    fill(30, 30, 30, 0);
    strokeWeight(stripeHeight);
    line(0, i, sizeX, i);
  }
}

void keyPressed() {
  if(key!=CODED){
  switch(key) {
  case 'r':
    generateColors();
    redraw(); // this still changes positions of the grids. Can maybe be avoided? Just change colors.
    break;
    case 'm':
  arcMode=!arcMode;
  redraw();
  break;
  case 'o':
  randomRot+=10;;
  redraw();
  break;
  case 'l':
  randomRot-=10;;
  redraw();
  break;
  case 's':
  save("moire.png");
  break;
  }
  }
  else{
  if(keyCode==RIGHT){if(arcMode){
    radius+=100;
    redraw();}}
  if(keyCode==LEFT){
  if(arcMode){
    radius-=100;
    redraw();}}
  if(keyCode==DOWN&&amount>0){amount-=1;
    redraw();}
  if(keyCode==UP){amount+=1;
    redraw();}
}
}
void generateColors() {
  startColor=color(random(255), random(255), random(255));
  endColor=color(random(255), random(255), random(255));

}
