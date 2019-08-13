color topColor, leftColor, rightColor; //<>//
color[][] Scheme = new color[5][3];
float x, y, gapX, dimX, dimY, e, offset;
int number, a, h, numberY;
boolean lineMode=true;

void setup() {
  size(900, 900);
  noLoop();
  a=50;
  h=25;
  gapX=20;
  numberY=6;
}

void draw() {
  setColors();
  calculate();
  background(240);
  //strokeWeight(4);
  //strokeCap(ROUND);
  //stroke(240);
  noStroke();
  if (lineMode) {
    x=((width-(number*dimX))*0.5)+offset; //since x is center we need to add offset
    if(numberY==1){
    y=(height-dimY)/2;}
    else{
    y=(height-(dimY*numberY))/2;
    }
    for (int j=0;j<numberY;j++)
    {
    for (int i=0; i<number; i++) {
      tower t = new tower(x, y, a, h, (int)random(0, 5));
      t.display();
      x+=dimX;
    }
    y+=dimY;
    x=((width-(number*dimX))*0.5)+offset;
    }
  }
}

void calculate() {
  e=2*a*sin(radians(60));
  dimX=e+gapX; //because left and right is gap/2 we add 2*gap/2 = gap
  number=(int)(width/dimX);
  offset=cos(radians(30))*a;
  dimY=(2*a*cos(radians(60)))+h;
}

class tower {

  float centerX, centerY;
  int a, h;
  float tlX, tX, trX, blX, bX, brX;
  float tlY, tY, trY, blY, bY, brY;
  int colorScheme;

  tower(float centerPosX, float centerPosY, int aLength, int hLength, int scheme) {
    centerX=centerPosX;
    centerY=centerPosY;
    a=aLength;
    h=hLength;
    colorScheme=scheme;
    tX=0;
    tY=-2*a*cos(radians(60));
    bX=0;
    bY=h-(tY);
    tlX=cos(radians(30))*a;
    tlY=-sin(radians(30))*a;
    trX=-tlX;
    trY=tlY;
    blY=h-(tY/2);
    blX=tlX;
    brX=-blX;
    brY=blY;
  }

  void display() {
    pushMatrix();
    translate(centerX, centerY);
    PShape top, left, right;
    top = createShape();
    top.setFill(Scheme[colorScheme][2]);
    top.beginShape();
    top.vertex(0, 0);
    top.vertex(tlX, tlY);
    top.vertex(tX, tY);
    top.vertex(trX, trY);
    top.endShape(CLOSE);
    shape(top);

    left = createShape();
    left.setFill(Scheme[colorScheme][1]);
    left.beginShape();
    left.vertex(0, 0);
    left.vertex(tlX, tlY);
    left.vertex(blX, blY);
    left.vertex(bX, bY);
    left.endShape();
    shape(left);

    right = createShape();
    right.setFill(Scheme[colorScheme][0]);
    right.beginShape();
    right.vertex(0, 0);
    right.vertex(trX, trY);
    right.vertex(brX, brY);
    right.vertex(bX, bY);
    right.endShape();
    shape(right);
    popMatrix();
  }
}

void setColors() {
  Scheme[0][0]=#8040f2; //Blueish-purple
  Scheme[0][1]=#9a66f4; //Light
  Scheme[0][2]=#b895f6; //Even lighter

  Scheme[1][0]=#4ead00; //Green, complementary
  Scheme[1][1]=#81d700; //Light
  Scheme[1][2]=#93e800; //Even lighter

  Scheme[2][0]=#7b00d5; //Purple, analogous
  Scheme[2][1]=#ab00de; //Light
  Scheme[2][2]=#bd00e3; //Even lighter

  Scheme[3][0]=#aa006c; //Magetna, triadic
  Scheme[3][1]=#d70077; //Light
  Scheme[3][2]=#e9007b; //Even lighter

  Scheme[4][0]=#f17001; //Orange, triadic
  Scheme[4][1]=#f78002; //Light
  Scheme[4][2]=#fd9003; //Even lighter
}
