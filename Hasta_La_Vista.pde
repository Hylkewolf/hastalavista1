
/* --------------------------------------------
 * Program for running the installation HastaLaVista
 * Checking the persons position
 * Running the user interface
 * Controling the sensors
 * -------------------------------------------
 */

//Importing the library's
import SimpleOpenNI.*;
import mpe.client.*;


//Making the variables
SimpleOpenNI context;
blobDetection blobDetect;

//This variables have to be determined at the beginning
int maxDetectionDistance = 8000;
int minDetectionDistance = 500;
int steps = 1;
int adjacent = 2000;
int kinectHeight = 2600;
PVector startPosition;

void setup()
{
  context = new SimpleOpenNI(this);
  if (context.isInit() == false)
  {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }
  //Start the detphCamera
  context.enableDepth();
  context.start();
  
  
  
  //Define PVectors
  startPosition = new PVector(300, 300);
  //Import the different classes
  blobDetect = new blobDetection(steps, ( minDetectionDistance + maxDetectionDistance ) / 2, adjacent, kinectHeight, startPosition);

  //Setup the size
  size(context.depthWidth()*2, context.depthHeight());
  background(50);
  frameRate( 30 );
  
  blobDetect.createPathArray();
}

void draw()
{

  context.update();

  blobDetect.makeBlobArray();    
  blobDetect.drawBlobmap();
  blobDetect.calculateMiddlePoint();
  blobDetect.saveUserPosition();
  
}

