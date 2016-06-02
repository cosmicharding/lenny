/*----------------------
Aligner

Renders all images within an ImgStack array and allows users
to slide mouse back and forth to align images to their desired
focal point. Designed for use with series of photos taken at
regular horizontal intervals.

For more information on photography technique:
http://www.instructables.com/id/3D-lenticular-printing-using-Photoshop-and-inkjet-/
----------------------*/

//IS THIS AN ABSTRACT CLASS?
class Aligner {
	boolean exportTriggered = false;
	int exportOffset;

	Aligner(){
	}

	void renderStack(ImgStack imgStack){
		//background(0);
		if(exportTriggered == false){
			background(255);
			imageMode(CENTER);

			for (int i=0; i < imgStack.stagedImgs.length; i++){
				pushMatrix();
				  translate(width/2, height/2);
				  int xOffset = mouseX-width/2;
				  int xLoc = xOffset*i / (imgStack.frames-1); //
				  int opac = 255/(i+1);//layers gradually get more transparent
				  tint(255, opac);  // Display at partial opacity
				  image(imgStack.get(imgStack.stagedImgs[i]), xLoc, 0);

					//debug crop
					if(i == imgStack.stagedImgs.length-1){

						//float cropOffset = xOffset * (imgStack.stagedImgs.length-1) / (imgStack.frames-1); //sign is flipped to compensate for origin offset
						float linePosX;
						if(xLoc < 0){
							linePosX = (0.5*imgStack.width) + xLoc; //note that xLoc is already negative
						} else {
							linePosX = -1 * (0.5*imgStack.width) + xLoc;
						}
						stroke(#ff0000);
						strokeWeight(2);
						line( linePosX, -0.5*height, linePosX, 0.5*height);
					}
				popMatrix();

			}
		}
		if(exportTriggered == true){
			//export files

			//DISPLAY EXPORT NOTICE
			fill(#FF00FF);
			noStroke();
			rectMode(CENTER);
			rect(width/2, height/2, 400, 100);
			fill(#FFFFFF);
			PFont arial = createFont("Arial-Black",32);
			textFont(arial);
			textSize(32);
			textAlign(CENTER, CENTER);
			text("EXPORTING...", width/2, height/2);


			//EXPORT IMAGES
			float cropOffset = imgStack.scale * exportOffset * (imgStack.stagedImgs.length-1) / (imgStack.frames-1); //sign is flipped to compensate for origin offset
			PGraphics canvas = createGraphics(imgStack.fullWidth - int(2*abs(cropOffset)), imgStack.fullHeight);
			println("Exporting full resolution, cropped to " + canvas.width + "x " + canvas.height + "px.");

			//PGraphics cropped = createGraphics(cropW, imgStack.fullHeight);

			for (int i=0; i < imgStack.stagedImgs.length; i++){
					float xLoc;
					xLoc = imgStack.scale * exportOffset*i / (imgStack.frames-1);
					println("imgStack.scale : " + imgStack.scale);
					println("xLoc : " + xLoc);
					canvas.beginDraw();
					canvas.background(255);
					canvas.imageMode(CENTER);
					//GET FULL RES IMAGES ON EXPORT
					canvas.image(imgStack.getBig(imgStack.stagedImgs[i]), canvas.width/2 + xLoc -cropOffset, canvas.height/2, imgStack.fullWidth, imgStack.fullHeight);
					canvas.endDraw();
					String path = "exports/" + nf(i,3) + ".tif";
					canvas.save(path);
					println("Frame " + (i+1) + " exported.");
			}

			//exit when done
			exit();
		}
	}

	void export(){
		exportTriggered = true;
		println("EXPORT TRIGGERED.");
		exportOffset = mouseX-width/2;
	}



}
