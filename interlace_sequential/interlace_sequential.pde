PImage imgMask;
PImage img;
PImage masked;
String imgFile2 = "0";
String imgFile[] = {"data/large/slice",imgFile2, ".tif"};
String file;
int DPI = 600;
int LPI = 60
int DPL = DPI/LPI;
//for ideal, DPL == frames
//for repeat, DPL * fractional coef == frames * fractional coef
//for resample, same as repeat, but resized by 1/DPF before and by DPF after interlace
//for sequential frames>DPL && DPL%frames==0
int frames = 5; //number of images you actually have
int DPF = DPL/frames;



void setup() {
  size(displayWidth,displayHeight);
  noSmooth();
  img = loadImage("data/large/slice1.tif");
  masked = createImage(img.width, img.height, RGB);
  
}

void draw() {

 
  for (int i=0; i<frames; i++){  //pull pixels from each image
    imgFile2 = nf(i+1);
    imgFile[1] = imgFile2;
    file = join(imgFile,"");
    img = loadImage(file);
    for (int y = 0; y < img.height; y++){
      for (int x = i*DPF; x < img.width-DPF; x = x + DPL) {
        for (int z = 0; z < DPF; z++){
            masked.pixels[x+(y*img.width)+z] = img.pixels[x+(y*img.width)+z];
              }
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