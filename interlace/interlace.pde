PImage imgMask;
PImage img;
PImage masked;
String imgFile2 = "0";
String imgFile[] = {"slice",imgFile2, ".tif"};
String file;
color[] colorArray;

int frames = 5;


void setup() {
  size(displayWidth,displayHeight);
  noSmooth();
  img = loadImage("slice1.tif");
  masked = createImage(img.width, img.height, RGB);
  
}

void draw() {

 
  for (int i=0; i<frames; i++){  //pull pixels from each image
    imgFile2 = nf(i+1);
    imgFile[1] = imgFile2;
    file = join(imgFile,"");
    img = loadImage(file);
    for (int y = 0; y < img.height; y++){
      for (int x = i; x < img.width; x = x + frames) {
            masked.pixels[x+(y*img.width)] = img.pixels[x+(y*img.width)];
          } 
    }
    clear();
    }
  image(masked,0,0, img.width, img.height);
       //masked = get(0,0,img.width,img.height); 
     String path = savePath("test.tif");
     masked.save(path);
  noLoop();
}