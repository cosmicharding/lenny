import java.io.*; 

/*----------------------
ImgStack 

Stores all images within a folder as an array of PImages. 
Default folder is "data". 
Contains screen-res array for preview rendering and original-resolution
images for printing. 
----------------------*/
public class ImgStack {
	int totalImg; 
	PImage[] smallImgs; 
	PImage[] fullResImgs; 
	String inputFolderPath; 
}