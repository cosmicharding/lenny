int xPos;
int yPos;
int zPos;
PImage export;
int cam = 0;
String path;
String save[] = new String[2];
String file;

void setup() {
  size(3000, 3000, P3D);
  fill(204);
}

void draw() {
  int pointCount = 50;
  int xSpacing = width/pointCount;
  
  lights();
  background(255);
  
 //camera(//cam, 0, 0, // eyeX, eyeY, eyeZ
  //      //width/2-mouseX, height/2-mouseY, 140.0, // eyeX, eyeY, eyeZ
  //      width/2-mouseX, 0.0, 140, // centerX, centerY, centerZ
  //      0.0, 0.0, -10*xSpacing, // centerX, centerY, centerZ
  //      0.0, 1.0, 0.0); // upX, upY, upZ
  //      delay(100);
  //      println(width/2-mouseX);

for (int z=0; z <= 10 ; z++){
  zPos = z*xSpacing*-1;
    int fade = (255*z/10);
    noStroke();
    fill(fade);
 for (int y=0; y < pointCount; y++){
  yPos = y*xSpacing - height/2;
   for (int x=0; x < pointCount; x++){
    xPos = x*xSpacing - width/2;
    
beginShape();
vertex(xPos, yPos, zPos);
vertex(xPos+5, yPos, zPos);
vertex(xPos+5, yPos+5, zPos);
vertex(xPos, yPos+5, zPos);
endShape(CLOSE);
  }
 }
}
//for (float cam = -9; cam < 21; cam = cam+3){
 camera(cam, 0, 2400, // eyeX, eyeY, eyeZ
        0.0, 0.0, -10*xSpacing, // centerX, centerY, centerZ
        0.0, 1.0, 0.0); // upX, upY, upZ
        println(cam);
        export = get(0,0,width,height);
        file = ".tif";
        save[0] = nf(cam);
        save[1] = file;
        file = join(save,"");
        path = savePath(file);
        //export.save(path);
        delay(1000);
//}
}

//cam 9>>21

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      cam = cam + 30;
    }
    if (keyCode == RIGHT) {
      cam = cam - 30;
    } 
    if (keyCode == UP) {
      export.save(path);
    } 
  }
}