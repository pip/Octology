/* 967CvXB - FujLyfBukT1010-TouchScrn-XEvntEmu-drvr-967AguA.cpp by PipStuart<Pip@CPAN.Org> to send Fujitsu LifeBook T1010 (Chun) touch-screen as mouse events.
  This utility was derived from code posted 93G by vertago1 at HTTP://UbuntuForums.Org/showthread.php?s=7a382a71fabe71f79bc144c817c5fc8a&t=909516&page=2
2du:  stu XTestLib4FakeButnEvnt&&WarpPtr,cfg,ck"XEvent evnt;"global&&"timespec*rqtp,rmtp;"in timrThrd,
2uze: g++ -pthread -lX11 -lXtst -L/usr/X11R6/include FujLyfBukT1010-TouchScrn-XEvntEmu-drvr-967AguA.cpp -oFujLyfBukT1010-TouchScrn-XEvntEmu-drvr-967AguA.o
lice: This program is Free Software; you can redistribute it and/or modify it under terms of the GNU GeneralPublicLicense Version3 as published by FSF.Org */
#include      <X11/Xlib.h>
#include      <X11/extensions/XTest.h>
#include         <stdio.h>
#include        <string.h>
#include       <pthread.h>
#include      <iostream>
#define  MinX          55
#define  MaxX        3848 //3903 -  55
#define  MinY         234
#define  MaxY        3793 //4027 - 234
#define  Widt        1280 //scrn  widt
#define  Hite         800 //scrn  hite
#define  USlp       65535 //usleep tim
Display*disp;                                                                         int  mous=0;                            int             stat=0;
void*timrThrd(void*thid){                                                                                                     int  lsta=stat;
  while(1){ usleep(USlp);
    if(!stat&&lsta){ XTestFakeButtonEvent(disp,1,0,CurrentTime);XFlush(              disp);mous=0;             std::cout << "\n";} lsta=stat; stat=0;
  }
}
int main(){          Window chld,root;XWindowAttributes ratz;   unsigned int  mask;int  x=0,y=0,xr=0,yr=0,xp=0,yp=0,coun=0,temp;
  pthread_t thrd;                disp=XOpenDisplay(        0);     FILE*inpt; char infl[]="/dev/hidraw0";
  pthread_attr_t     attr ; chld=root=XRootWindow(    disp,0);  XSelectInput(        disp,root,KeyReleaseMask);std::cout << "X11 ready!\n";
  pthread_attr_init(&attr); pthread_create(&thrd,&attr,timrThrd,NULL);  inpt=fopen(infl,"rb");                 std::cout << "file open!\n";
  while(1){      temp=(int)getc(inpt); switch(coun){
    case 0: if(  temp<0x20||0x21<temp)        coun--; break;
    case 1: x |= temp     ;                           break;
    case 2: x |= temp << 8;                           break;
    case 3: y |= temp     ;                           break;
    case 4: y |= temp << 8;           XQueryPointer(  disp,root,&root,&chld,&xr,&yr,&xp,&yp,&mask);            std::cout << "\r(" << x << "," << y << ")\t";
      x=(int)((double)(x-MinX)/MaxX*Widt);                      XGetWindowAttributes(disp,root,&ratz);         std::cout <<  " (" << x << "," << y << ") " ;
      y=(int)((double)(y-MinY)/MaxY*Hite);                      XWarpPointer(        disp,NULL,NULL,0,0,0,0,x-xp-ratz.x,y-yp-ratz.y);
      if(!mous    ){ XTestFakeButtonEvent(disp,1,1,CurrentTime);XFlush(              disp);mous=1; }
      x=y=0; stat=1;                                  break;
    default: coun=0;                                  break;
    }        coun++;
  } return 0;
}
