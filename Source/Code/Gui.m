function varargout = Gui(varargin)
% GUI MATLAB code for Gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gui

% Last Modified by GUIDE v2.5 30-Dec-2021 15:39:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gui_OpeningFcn, ...
                   'gui_OutputFcn',  @Gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Gui is made visible.
function Gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Gui (see VARARGIN)

% Choose default command line output for Gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Img_Btn.
function Img_Btn_Callback(hObject, eventdata, handles)
global image2;
global filename;
%% read image 
[filename, pathname] = uigetfile({'*.jpg';'*.jpeg';'*.bmp';'*.png';'*.tif';'*.tiff'}, 'Open File');
fullpath = strcat(pathname, filename);
image2 = rgb2gray(imread(fullpath));
set(handles.ImgView ,'Units','pixels');
 resizePos = get(handles.ImgView,'Position');
 myImage= imresize(image2, [resizePos(3) resizePos(3)]);
axes(handles.ImgView);
imshow(myImage);
set(handles.ImgView,'Units','normalized');

% --- Executes on button press in Audio_Btn.
function Audio_Btn_Callback(hObject, eventdata, handles)

global image2;
global filename;
%% Reading Image
    gray_image = image2; 
 %% Dividing the music score into staves and recognising them
  recognizedScore = ProcessStaves(gray_image);
 %% Reshaping the data and Creating the audio sample
  Audio =GenerateAudio(recognizedScore);
  str = split(filename,'.'); % to create audio with image name
  audioname = str(1,:); 
  audiopath = strcat('C:\Users\LENOVO\OneDrive\Documents\githup\Music-Score-Reader-OMR-\Source\TestCases\' , audioname , '.wav' );
  audiopath = cast(audiopath , 'char'); % for audiowrite
  fs = 44100;
  audiowrite(audiopath , Audio , fs);
 %% Play Audio
 [y, Fs] = audioread(audiopath);
 clear sound;
 sound(y,Fs);
 S = audioplayer(y, Fs);
 play( S);
