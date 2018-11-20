int maxNum=1000;
int currentNum=1;
float[]x=new float[maxNum];
float[]y=new float[maxNum];
float[]r=new float[maxNum];
int[]closestIndex=new int[maxNum];

float maxR=50;
float minR=2;
float mouseRect=30;

void setup() {
  fullScreen(P2D);
  frameRate(10);
  //size(600, 600, P2D);
  background(21);
  smooth();
  //cursor(CROSS);
  noCursor();
  noFill();
  blendMode(ADD);
  colorMode(HSB, 360, 100, 100, 100);
  stroke(200, 100, 100, 100);
  //-----------set up parameter
  x[0]=width/2;
  y[0]=height/2;
  r[0]=maxR;
  closestIndex[0]=0;
        
}

void draw() {
  background(21);

  //----------------intaractive
  if (frameCount%5==0) {

    float newX=random(width-mouseRect)+mouseRect/2;
    float newY=random(height-mouseRect)+mouseRect/2;
    float newR=random(minR, maxR);
    //----------------レーダーみたいなのをかく
    strokeWeight(1);
    rect(newX, newY, mouseRect/2, mouseRect/2);
    rect(newX-mouseRect/2, newY, mouseRect/2, mouseRect/2);
    rect(newX, newY-mouseRect/2, mouseRect/2, mouseRect/2);
    rect(newX-mouseRect/2, newY-mouseRect/2, mouseRect/2, mouseRect/2);

    boolean intersection=false;

    //-------------被りチェック
    for (int i=0; i<currentNum; i++) {
      float d=dist(newX, newY, x[i], y[i]);
      if (d<newR+r[i]) {
        intersection=true;
        break;
      }
    }

    //---------------被りがなかったら格納します
    if (intersection==false) {

      float newRadius=100000;
      //--------------一番近い円を探して半径を決める
      for (int i=0; i<currentNum; i++) {
        float d=dist(newX, newY, x[i], y[i]);
        if (newRadius>d-r[i]) {
          newRadius=d-r[i];
          closestIndex[currentNum]=i;
        }
      }
      //----------------描写する位置と半径の格納
      if (newRadius>maxR) {
        newRadius=maxR;//デカすぎるときもいから
      }
      x[currentNum]=newX;
      y[currentNum]=newY;
      r[currentNum]=newRadius;
      currentNum++;
    }
  }
  //毎フレーム書きます
  for (int i=0; i<currentNum; i++) {
    strokeWeight(1.5);
    ellipse(x[i], y[i], r[i]*2, r[i]*2);
    strokeWeight(1);
    ellipse(x[i], y[i], r[i]*2, r[i]*2);
    int n=closestIndex[i];
    line(x[i], y[i], x[n], y[n]);
    strokeWeight(1.5);
    line(x[i], y[i], x[n], y[n]);
  }

  if (currentNum>maxNum) {
    noLoop();
  }
}
