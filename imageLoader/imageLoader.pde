ImgStack images; 

void setup(){
	images = new ImgStack("images");
}

void draw(){
	PImage[] oddImages = images.get(1,3); //Test array out of bounds exception
	//image(images.get(19), 0,0);//Test array out of bounds exception
}


// void keyPressed(){
// 	if(keyCode == 38 ){
// 		if(currentBMode < images.totalImgs - 1){
// 			currentBMode++;
// 		} else {
// 			currentBMode = 0; 
// 		}
// 	}
// 	if(keyCode == 40){
// 		if(currentBMode > 0){
// 			currentBMode--;
// 		} else {
// 			currentBMode = 9; 
// 		}
// 	}
// 	println(B_MODES[currentBMode]);
// }