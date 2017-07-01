# SQDecoder
Created by Marcel S. after he was annoyed by not having a quad decoder for the Mac OS

There are four files of interest...
  1) QuadDecoder.m - For a user to easily decode quad files, run this (SQ, QS, DY, or EV at the moment)
  
  2) QuadUnravel.m - the meat and potatos, this actually performs the appropriate matrix conversion and returns a matrix sutible for a standard 5.1 system. You can select multiple files.
  
  3) clipDiagnose.m - occasionally there will be slight clipping, this will let you know if there is any and tell you if it's signifigant. The most I've ever seen is three clipped samples per song.
  
  4) exporter.m - faccilitates a clean export to a wav.
  
  Hit me up if you got any questions
