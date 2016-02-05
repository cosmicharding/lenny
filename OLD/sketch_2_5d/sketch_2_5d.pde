////based onMove Eye by Simon Greenwold.

//int centermouse;
//int divergence;
//PImage bg;
//PImage img1;
//PImage img2;
//PImage img3;

//int offset1 = 40;
//int offset2 = 20;
//int offset3 = 0;

//int pos1x = -310;
//int pos2x = -50;
//int pos3x = 50;

//int pos1y = 10;
//int pos2y = 0;
//int pos3y = 0;

//float coef1 = 1;
//float coef2 = .75;
//float coef3 = .5;

//void setup() {
//  size(displayWidth, displayHeight, P3D);
//  //bg = loadImage("background.jpg");
//  bg = loadImage("background.jpg");
//  img1 = loadImage("layer1.png");
//  img2 = loadImage("layer2.png");
//  img3 = loadImage("layer3.png");
//}

//void draw() {
//  PGraphics red = createGraphics(displayWidth, displayHeight);
//  PGraphics blue = createGraphics(displayWidth, displayHeight);
//  centermouse = mouseY-displayHeight/2;
//  background(0,0,0,255);
//red.beginDraw();
//red.imageMode(CENTER);
//red.translate(displayWidth/2,displayHeight/2);
//red.image(bg,0,0);
//red.image(img1, (centermouse*coef1)+offset1+pos1x, pos1y, img1.width/2, img1.height/2);
//red.image(img2, (centermouse*coef2)+offset2+pos2x,pos2y, img2.width/2, img2.height/2);
//red.image(img3, (centermouse*coef3)+offset3+pos3x,pos3y, img3.width/2, img3.height/2);
//red.endDraw();

//blue.beginDraw();
//blue.imageMode(CENTER);
//blue.translate(displayWidth/2,displayHeight/2);
////blue.camera(-centermouse, 0, 1000, -centermouse, 0.0, 0.0, 0.0, 1.0, 0.0);
//blue.image(bg,0,0);
//blue.image(img1, (-centermouse*coef1)-offset1+pos1x, pos1y, img1.width/2, img1.height/2);
//blue.image(img2, (-centermouse*coef2)-offset2+pos2x,pos2y, img2.width/2, img2.height/2);
//blue.image(img3, (-centermouse*coef3)-offset3+pos3x,pos3y, img3.width/2, img3.height/2);
//blue.endDraw();


//blendMode(SCREEN);

////move this into the camera, make them load in the same place. move the camera. translate depth. variables: camera distance based on centermouse

//image(red,0,0,displayWidth, displayHeight);
//tint(255,0,0);
//image(blue,0,0,displayWidth, displayHeight);
//tint(0,255,255);

//  //camera(centermouse, 0, 1000, // eyeX, eyeY, eyeZ
//  //       centermouse, 0.0, 0.0, // centerX, centerY, centerZ
//  //       0.0, 1.0, 0.0); // upX, upY, upZ
  
//  //    image(bg,-bg.width/2,-bg.width/2);
//  //    tint(120,0,0,255);

//  //camera(-centermouse, 0, 1000, // eyeX, eyeY, eyeZ
//  //       -centermouse, 0.0, 0.0, // centerX, centerY, centerZ
//  //       0.0, 1.0, 0.0); // upX, upY, upZ

//  //    image(bg,-bg.width/2,-bg.width/2);
//  //    tint(0,100,170,255);
//}

/**
 * Move Eye. 
 * by Simon Greenwold.
 * 
 * The camera lifts up (controlled by mouseY) while looking at the same point.
 */
int centermousex;
int centermousey;
int centermousez = 0;
int mouseZ = 1000;
PImage bg;
PImage img1;
PImage img2;
PImage img3;

void setup() {
  size(displayWidth, displayHeight, P3D);
  fill(204);
  bg = loadImage("background.jpg");
  img1 = loadImage("layer1.png");
  img2 = loadImage("layer2.png");
  img3 = loadImage("layer3.png");
}

void draw() {
  lights();
  bg.resize(displayWidth, displayHeight);
  background(bg);
    centermousex = mouseX-displayWidth/2;
    centermousey = mouseY-displayHeight/2;
  
camera(centermousex, centermousey, mouseZ, // eyeX, eyeY, eyeZ
centermousex, centermousey, 0.0, // centerX, centerY, centerZ
0.0, 1.0, 0.0); // upX, upY, upZ
  
  noStroke();
  image(img3, 0,0);
  pushMatrix();
  translate(500,0,5000);
  image(img2,0,0);
  popMatrix();
  pushMatrix();
  translate(0,-100,900);
  image(img1,0,0);
  popMatrix();
  stroke(255);
}

void mousePressed(){
  centermousez=centermousey;
  mouseZ = mouseZ+centermousez+(mouseY-displayHeight/2);
}