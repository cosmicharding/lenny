//LENNY LENTICULAR INTERLACER
Lenny len = new Lenny();

//LENNY SPEC HELPER

LPI = 60;  //Lenticules per inch
DPI = 600; //Dots per inch of printer
PRINT_W = 11 * 25.4 //inch to mm //Print width in mm
PRINT_H = 8.5 * 25.4 //Print height in mm
NUM_IMAGES = 10//number of images must be compatible with DPL (Dots per Lenticule)
FILE_PATH = "data";
//LEN_TYPE = //ANIMATION, 3D, 25D

void setup() {
	len = new Lenny(LPI, DPI, PRINT_W, PRINT_H, NUM_IMAGES, FILE_PATH, STEREO);
	//If STEREO, alignment render mode gets called first
	//export happens

	//PITCH TEST MODE
	//len = new Lenny();
	//lenny.pitchTest();
}


void draw() {

}
