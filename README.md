# Music-Score-Reader-OMR-

#### OMR Description
Optical music recognition (OMR) has been the subject of research for decades. <br> 
An accessible and easy-to-use OMR application could provide an amazing tool for improving the musical education experience. <br>
For example, a novice musician could use such a tool to hear what a selected piece of music should sound like.

Ideally, an OMR, given an image of a simple or complex music sheet, automatically identifies the notes, and plays the musical piece. <br>
For this project, our goal is to develop an algorithm to parse music sheet images, <br>
produce the associated annotation, and implement a playback mechanism for the parsed musical notes.

***
## Overview
<b> The process is broken down into the following tasks: </b>

**`1. Staff Lines Detection and Removal`** <br>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
     Detect the location of all staff lines and remove them to get the musical symbols.<br>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     The staff lines location will be stored for Segmentation and Note Identification. <br>
**`2. Segmentation`** <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
     Perform segmentation to extract the individual symbol. <br> 
**`3. Symbol Recognition`** <br>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
     Perform template matching on each symbol to determine the musical notation. <br>
**`4. Note Identification`** <br>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
     For each note, determine the pitch by comparing the symbol location and the staff lines location. <br>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
     Also determine the duration based on the result from Symbol Recognition. <br>
**`5. Music Transformation`** <br> 
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
     Create a playable music based on the pitch and duration of the notes. <br>
