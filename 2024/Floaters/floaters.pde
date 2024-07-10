color frameColor, textColor, floaterColorStart, floaterColorEnd;
float x, y;
float padding;
int sizeX, sizeY;
int floaterLength;
int floaterThickness;
int pinstripeThickness;
boolean pinstripes=true;
boolean frame=true;
boolean inverted=false;
int floaterAmount;

void settings()
{
  sizeX=1200;
  sizeY=900;
  size(sizeX, sizeY);
}

void setup() {
  padding=sizeX*0.05;
  floaterAmount=100;
  floaterLength=10;
  floaterThickness=4;
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
    if (pinstripes) {
    drawLines(pinstripeThickness);
  }
  for (int i=0; i<floaterAmount; i++)
  {
    drawFloater();
  }

  if (frame) {
    drawFrame();
    drawLabel("Floaters", "2024");
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

void drawFloater() {
  strokeWeight(floaterThickness);
  float x = random(sizeX);
  float y = random(sizeY);
  pushMatrix();
  translate(x, y);
  rotate(random(360));
  color floaterColor_int;
  floaterColor_int=lerpColor(floaterColorStart, floaterColorEnd, random(1));
  stroke(floaterColor_int);
  line(0, 0, (floaterLength), (floaterLength));
  popMatrix();
}

void drawLines(int stripeHeight)
{
  int numberX;
  numberX=sizeX/(stripeHeight/2);
  stroke(0,0,0,10);
  for (int i=0; i<numberX; i+=(stripeHeight*2))
  {
    fill(30, 30, 30, 0);
    strokeWeight(stripeHeight);
    line(0,i,sizeX,i);
  }
}

void generateColors() {
  floaterColorStart=color(random(255), random(255), random(255));
  floaterColorEnd=color(random(255), random(255), random(255));
}

void keyPressed() {
  if (key!=CODED) {
    switch(key) {
    case 'r':
      generateColors();
      redraw();
      break;
    case 's':
      save("floaters.png");
      break;
    case 'i':
      inverted=!inverted;
      redraw();
      break;
    }
  } else {
    if (keyCode==UP) {
      floaterAmount+=50;
      redraw();
    }
    if (keyCode==DOWN&&floaterAmount>50) {
      floaterAmount-=50;
      redraw();
    }
    if (keyCode==LEFT&&floaterThickness>2&&floaterLength>4) {
      floaterThickness-=2;
      floaterLength-=4;
      redraw();
    }
    if (keyCode==RIGHT) {
      floaterThickness+=2;
      floaterLength+=4;
      redraw();
    }
  }
}
