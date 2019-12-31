class Text
{
  //"constants"
  ///////////////////////////////////////////
  int N=60; //number of copies of each letter
  int digits=4; //number of digits in index
  int imSize=200; //number of pixels along one side of original (square) images
  int[] setWidth = new int[128]; //128 spots for all ASCII values
  {
    setWidth[' ']=91;
    
    setWidth['A']=101;
    setWidth['B']=79;
    setWidth['C']=97;
    setWidth['D']=65;
    setWidth['E']=65;
    setWidth['F']=62;
    setWidth['G']=72;
    
    setWidth['a']=87;
    setWidth['b']=71;
    setWidth['c']=78;
    setWidth['d']=73;
    setWidth['e']=78;
    setWidth['f']=58;
    setWidth['g']=78;
    setWidth['h']=58;
    setWidth['i']=29;
    setWidth['j']=44;
    setWidth['k']=53;
    setWidth['l']=29;
    setWidth['m']=87;
    setWidth['n']=61;
    setWidth['o']=77;
    setWidth['p']=67;
    setWidth['q']=67;
    setWidth['r']=47;
    setWidth['s']=57;
    setWidth['t']=54;
    setWidth['u']=61;
    setWidth['v']=61;
    setWidth['w']=87;
    setWidth['x']=71;
    setWidth['y']=74;
    setWidth['z']=84;
    
    setWidth[39 ]=33; //apostrophe
    setWidth[44 ]=33; //comma
  }

  //variables
  //////////////////////////////////////////
  //string to store the text
  String string;
  //int to store string length
  int l;
  //int to store time steps to print string ie number of "valid" characters
  int t;
  //starting vertical and horizontal position from top left
  int x=0;
  int y=0;
  //vector to store previous state
  int[] preVect;
  //kerning (adjusts space after character)
  int[] kerning;
  //horizontal shift
  int[] yShift;
  //scale of each character
  float[] scale;
  
  //
  PImage letter;
  
  


  //constructor
  ////////////////////////
  Text(String s, int x0, int y0)
  {
    string=s;
    x=x0;
    y=y0;
    l=string.length();
    preVect = new int[l];
    kerning = new int[l];
    scale = new float[l];
    yShift = new int[l];
    
    //determine t
    for (int i=0; i<l; i++)
    {
      if(string.charAt(i) != ' ' && string.charAt(i) != 39 && string.charAt(i) != 96)
      {
        t++;
      }
    }

    //randomize preVect
    //set scale to 0.5
    //set kerning to 0
    for (int i=0; i<l; i++)
    {
      preVect[i]=int(random(0, N));
      scale[i]=0.5;
      kerning[i]=0;
    }
    
    
  }
  
  //accessors
  int l(){return l;};
  int t(){return t;};
  int end()
  {
    int end=0;
    for(int i=0; i<l; i++)
    {
      end = end + setWidth[i]+kerning[i];
    }
    return end;
  }
  
  //mutators
  void kernAll(int j)
  {
    for(int i=0; i<l; i++)
    {
      kerning[i]=j;
    }
  }
  void kerning(int i, int j)
  {
    kerning[i]=j;
  }
  
  void scaleAll(float s)
  {
    for(int i=0; i<l; i++)
    {
      scale[i]=s;
    }
  }
  void scaleChar(int i, float s)
  {
    scale[i]=s;
  }


  
  //display functions
  /////////////////////////////
  //x, y are top left position, cap is how many characters of the string to display
  void reg(int cap) 
  {
    int locX=x;
    int locY=y;
    
    int num; //Variable for which image number to grab
    int i=0; //index place in string
    int j=0; //count number of "valid" characters shown
    while(j<cap && i <l) 
    {
      num = int(random(0,N-1)); //Generates an integer in [0,N-2]
      if( num >= preVect[i] ){num++;} //makes sure num is in [0,N-1]\{prev}
      
      //only load an image if the character is not a space
      if( string.charAt(i) != ' ')
      {
        letter=loadImage(int(string.charAt(i))+nf(num,digits)+".png"); //load the image
        image(letter,locX,locY+yShift[i],imSize*scale[i],imSize*scale[i]); //actually display the image
        //count "valid" characters
        if(string.charAt(i)!=39 && string.charAt(i)!=96) //39 is ' and 96 is `
        {
          j++;
        }
      }
      //move x position to the right by character's set width, adjusted by spacing variable and scaled by scale[]
      locX=locX+kerning[i]+int(float(setWidth[string.charAt(i)])*scale[i]);
      preVect[i]=num;
      
      i++; //increment index
    }
  }
  
  
  //debug
  //////////////////
  void printPreVect()
  {
    print("state:");
    for(int i=0; i<l; i++)
    {
      print(preVect[i]+", ");
    }
    println();
  }
  
}
