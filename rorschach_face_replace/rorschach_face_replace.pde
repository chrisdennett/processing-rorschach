import controlP5.*;
import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;

OpenCV opencv;
ControlP5 cP5;
Rectangle[] faces;
Capture cam;
PImage camImg;
int thresh = 75;
Rorschach ror;
Rectangle face;

void setup() {
  size(640, 480);

  opencv = new OpenCV(this, 640, 480);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  cP5 = new ControlP5(this);
  //cP5.addSlider("thresh", 0, 255, 10, 10, 100, 10);

  cam = new Capture(this, width, height);
  cam.start();

  ror = new Rorschach();
}

void draw() {
  opencv.loadImage(cam);
  opencv.useColor();
  faces = opencv.detect();

  //opencv.threshold(thresh);
  //opencv.threshold(thresh);
  camImg = opencv.getSnapshot();

  //camImg.loadPixels();

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  //for (int i = 0; i < faces.length; i++) {
  //  rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height); 
  //}

  if (faces.length > 0) {
    face = faces[0];
  }

  if (face != null) {
    ror.update(face);
    camImg.blend(ror.holderImg, 0, 0, 600, 600, face.x+ 15, face.y-10, floor(face.width*0.8), floor(face.height*1.1), PImage.SOFT_LIGHT   ); 
    image(camImg, 0, 0);
  }

  saveFrame("frames/rorschach_square_####");
}

void captureEvent(Capture c) {
  c.read();
}