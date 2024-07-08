color frameColor, textColor, floaterColorStart, floaterColorEnd;
float x, y;
float padding;
int sizeX, sizeY;
int length;
int thickness;
boolean frame=true;
boolean inverted=false;
int amount;

void settings()
{
  sizeX=1200;
sizeY=900;
size(sizeX, sizeY);}

void setup(){
padding=sizeX*0.05;
amount=100;
length=10;
thickness=4;
if(!inverted){
textColor=color(0,0,0);
frameColor=color(0,0,0);}
else{
textColor=color(255,255,255);
frameColor=color(255,255,255);
}
generateColors();
}


void draw(){
noLoop();
if(!inverted){
background(#FFFFFC);}
else{
background(#555353);}
for(int i=0; i<amount;i++)
{
drawFloater();
}
if(frame){drawFrame();drawLabel("Floaters","2024");}
}

void drawFrame(){
noStroke();
if(!inverted){
fill(255);  
frameColor=color(0,0,0);
}
else{fill(#030202);frameColor=color(255,255,255);}
rect(0,0,sizeX,padding);
rect(0,0,padding,sizeY);
rect((sizeX-padding),0,padding,sizeY);
rect(0,(sizeY-2*padding),sizeX,2*padding);
fill(30,30,30,0);
stroke(frameColor);
strokeWeight(1);
rect(padding,padding,(sizeX-2*padding),(sizeY-3*padding));
}

void drawLabel(String Title,String subTitle){
if(!inverted){fill(0,0,0);}
else{fill(255,255,255);}
textAlign(CENTER);
textSize(60);
PFont font;
font=loadFont("serif.vlw");
textFont(font,60);
float posY=sizeY-padding;
text(Title, sizeX/2, posY);
textSize(40);
text(subTitle, sizeX/2, (posY+40));
}

void drawFloater(){
strokeWeight(thickness);
float x = random(sizeX);
float y = random(sizeY);
pushMatrix();
translate(x,y);
rotate(random(360));
color floaterColor_int;
floaterColor_int=lerpColor(floaterColorStart,floaterColorEnd,random(1));
stroke(floaterColor_int);
line(0,0,(length),(length));
popMatrix();
}

void generateColors(){
floaterColorStart=color(random(255),random(255),random(255));
floaterColorEnd=color(random(255),random(255),random(255));
}

void keyPressed(){
 if(key!=CODED){
switch(key){
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
}
else{
if(keyCode==UP){
amount+=50;
redraw();
}
if(keyCode==DOWN&&amount>50){
amount-=50;
redraw();
}
if(keyCode==LEFT&&thickness>2&&length>4){
thickness-=2;
length-=4;
redraw();
}
if(keyCode==RIGHT){
thickness+=2;
length+=4;
redraw();
}
}
}
