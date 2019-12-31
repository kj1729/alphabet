void setup()
{
  size(900,900);
  frameRate(12);
  //l1.scaleAll(1);
}

boolean save = false;
String filename = "";

Text l1 = new Text("Even", 50, 150);
Text l2 = new Text("Far", 50, 260);
Text l3 = new Text("Flop", 50, 370);
Text l4 = new Text("Glop", 50, 480);

int runtime =l1.t()+l2.t()+l3.t()+l4.t()+10;

int count=0;

void draw()
{
  clear();
  background(255);
  if(save)
  {
    if(count<runtime)
    {
      l1.reg(count);
      l2.reg(count-l1.t());
      l3.reg(count-l1.t()-l2.t());
      l4.reg(count-l1.t()-l2.t()-l3.t());
    }
    saveFrame(filename+"###.tiff");
    count++;
  
    if(count>runtime){noLoop();}
  }
  else
  {
     l1.reg(100);
     l2.reg(100);
     l3.reg(100);
     l4.reg(100);
  }
}
