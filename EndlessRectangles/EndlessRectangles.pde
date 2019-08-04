float x,y,rot,a,safe;
int iterations;
color start,end,inter;

void setup(){
  size(1200, 900);
  iterations=5;
  safe=50;
  rot=0.0;
  calcPositions();
  //noStroke();
}

void draw(){
  noLoop();
  setColors();
  makeSquares();
}

void makeSquares(){
 background(start);
 float colorPos;
 colorPos=0.0;
 colorPos=(float)1/(iterations);
 rectMode(CENTER);
 float aNew,rotNew;
 rotNew=radians(rot);
 aNew=a;
 pushMatrix();
 translate(x,y);
 for (int i=0;i<iterations;i++){
   color inter=lerpColor(start, end, colorPos); //generate interpolated color
   fill(inter); //set to interpolated color
   rect(0,0,aNew,aNew);
   rotNew=rot+5;
   rotate(rotNew);
   aNew = aNew*(sin(rotNew)+cos(rotNew));
   colorPos=(float)(i+1)/(iterations);
   }
 popMatrix();
  }

void calcPositions(){
  x=random(100,width-safe);
  y=random(0,height-safe);
  a=random(100,height-safe);
  if(x+a>width-safe||y+a>height-safe){ //checks dont work with CENTER mode right now
   calcPositions(); 
  }
}
  

void setColors(){
  start=color(random(255), random(255), random(255)); 
  end=color(random(255), random(255), random(255));
}

void keyPressed(){
  
}
