//USER INPUT VARS
String IMAGES_FOLDER = "data";
int FRAME_COUNT = 4; // 17 for 18 images FIX

ImgStack imgStack;
Aligner aligner;
int[] staged;

public void settings() {
  size(886, 800);
}
void setup() {
  //size(displayWidth, displayHeight); //886 × 800
  imgStack = new ImgStack(IMAGES_FOLDER);
  aligner = new Aligner();

  staged = imgStack.getStagedImages(FRAME_COUNT);
}

void draw(){
	aligner.renderStack(imgStack);
}

//need to implement export on click
void mouseClicked(){
  aligner.export();
}
