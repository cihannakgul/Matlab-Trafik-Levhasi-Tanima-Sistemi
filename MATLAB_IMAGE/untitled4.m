function varargout = untitled4(varargin)
% UNTITLED4 MATLAB code for untitled4.fig
%      UNTITLED4, by itself, creates a new UNTITLED4 or raises the existing
%      singleton*.
%
%      H = UNTITLED4 returns the handle to a new UNTITLED4 or the handle to
%      the existing singleton*.
%
%      UNTITLED4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED4.M with the given input arguments.
%
%      UNTITLED4('Property','Value',...) creates a new UNTITLED4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled4

% Last Modified by GUIDE v2.5 10-May-2022 03:07:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled4_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled4_OutputFcn, ...
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


% --- Executes just before untitled4 is made visible.
function untitled4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled4 (see VARARGIN)

% Choose default command line output for untitled4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in karsilastir.
function karsilastir_Callback(hObject, eventdata, handles)
% hObject    handle to karsilastir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in resimekle.
function resimekle_Callback(hObject, eventdata, handles)
[filename, pathname] = uigetfile('*.*', 'Pick a MATLAB code file');
set(handles.edit1,'String',filename);
    if isequal(filename,0) || isequal(pathname,0)
       disp('User pressed cancel')
    else
       filename=strcat(pathname,filename);
       a=imread(filename);
       axes(handles.axes1);
       imshow(a);
       handles.o=a;
       guidata(hObject, handles);
    end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in kbeyaz.
function kbeyaz_Callback(hObject, eventdata, handles)
% hObject    handle to kbeyaz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clc;
x = get(handles.edit1,'String');
 
vidFrame = imread(x);
 %%subplot(1,3,1)
 
 imshow(vidFrame)
 axes(handles.axes2); %%Resmin GUI'de g??r??nt??lenmesi 
 handles.o=vidFrame;
 guidata(hObject, handles);
 
%% Bu thresholder algoritmas?? 
%% g??r??nt??deki levhay?? BINARY format??na d??n????t??r??r
%% Algoritma i??in resmi HSV format??na d??n????t??r??yoruz 
I = rgb2hsv(vidFrame); %%Thresholder i??in resmi HSV format??na d??n????t??r??yoruz 

% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.745;
channel1Max = 0.020;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.290;
channel2Max = 1.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.337;
channel3Max = 1.000;

% Create mask based on chosen histogram thresholds
sliderBW = ( (I(:,:,1) >= channel1Min) | (I(:,:,1) <= channel1Max) ) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
BW = sliderBW;

%%subplot(1,3,2)
%%figure
imshow(BW) %% ????kan resmi GUI'de g??r??nt??l??yoruz
axes(handles.axes3);
handles.o=BW;
guidata(hObject,handles);

 

%% Temizlik a??amas??

%% strel komudu binary t??r??nde gereksiz ????eleri filtreler
%% 3 yar????ap??ndafiltreleme yapt??r??yoruz

diskElem = strel('disk',3);
Ibwopen = imopen(BW,diskElem);
%%subplot(1,3,3)
%%figure
imshow(Ibwopen)
axes(handles.axes4); %% Filtrenen fotoyu ekranda g??steriyoruz
handles.o=Ibwopen;
guidata(hObject, handles);

%% Blob Analizi
%% ekrandaki binary ????elerini i??ler.
%% Thresholder algoritmas??n??n bize ????kard?????? resmin konumuna eri??mek i??in Blob analizi kullan??r??z


hBlobAnalysis = vision.BlobAnalysis('MinimumBlobArea',1000, ...
    'MaximumBlobArea',100000);
[objArea,objCentroid,bboxOut]= step(hBlobAnalysis,Ibwopen);

%% Levhay?? kar????la??t??rmak i??in ekrandan kopar??p yeni bir resim olarak atar??z
%%imtool(Ibwopen);
disp(bboxOut)
  cropped = imcrop(Ibwopen,[bboxOut(1,1) bboxOut(1,2) bboxOut(1,3) bboxOut(1,4)]);
 

%% Levhan??n oldu??u yere bir kare ekleyerek levhan??n yerini g??steriririz

Ishape = insertShape(vidFrame,'rectangle',bboxOut,'Linewidth',15);
 

%%figure
%%subplot(1,2,1)
 
imshow(Ishape)
%%axes(handles.axes5);
%handles.o=Ishape;
%%guidata(hObject, handles);

%% Kars??last??rma

templateKlasoru = 'C:\Users\Cihan\Desktop\Templa\';
%% Taslaklar??n oldu??u klas??r?? g??steriyoruz
 

%% Bu k??s??mda elimizdeki resmi taslaktaki her resim ile kar????la??t??r??yoruz

%%cropped = rgb2gray(cropped);

 fileFolder = fullfile(templateKlasoru);
dirOutput = dir(fullfile(fileFolder,'*.png'));
fileNames = {dirOutput.name};
numFrames = numel(fileNames);

yeniKopardim =  imresize(cropped, [110, 110]);

  enBuyukOran=0; %% Benzerlik oran??n?? tutan de??i??ken
  hangiDegerYakin = 0; %% Hangi de??erin levham??z oldu??unu tutan de??i??ken

  for i=1:length(fileNames) %% Elimizdeki resmi TEMP klas??r??ndeki her resim ile kar????la??t??r??yoruz
     resimYolu = append(templateKlasoru,fileNames{i});
     templateResim = imread(resimYolu);

       templateResim = rgb2gray(templateResim); %%resmi 2 boyutlu hale indirgiyoruz
%% normxcorr bir kar????la??t??rma fonksiyonudur
%% C2 de??i??keni benzerlik oran??n?? tutar. bu oran??n en b??y??k oldu??u taslak aranan Levhad??r.
 C2 = normxcorr2(templateResim,yeniKopardim); 
  karsilastirmaOrani =  max(C2(:));
     if karsilastirmaOrani>enBuyukOran
      enBuyukOran = karsilastirmaOrani;
      hangiDegerYakin = i;
     end
  end


disp(karsilastirmaOrani)
 
 levhalar = ["B??S??KLET G??REMEZ" "D??KKAT LEVHASI" "??IKI?? YOK" "OTOB??S G??REMEZ" "SA??A D??N???? YOK" "SOLA D??N???? YOK" "DUR LEVHASI" "TIR G??REMEZ" "U D??N?????? YASAKTIR" "YOL VER"];
disp(levhalar(hangiDegerYakin))
set(handles.text3,'String',levhalar(hangiDegerYakin))

% --- Executes on button press in ksiyah. 
%% IKINCI BUTON KISMI --- 
function ksiyah_Callback(hObject, eventdata, handles)
% hObject    handle to ksiyah (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
x = get(handles.edit1,'String');
 
vidFrame = imread(x);
 %%subplot(1,3,1)
 
 imshow(vidFrame)
 axes(handles.axes2);
 handles.o=vidFrame;
 guidata(hObject, handles);
 
% Convert RGB image to chosen color space
I = rgb2hsv(vidFrame);

% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.000;
channel1Max = 1.000;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.000;
channel2Max = 1.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.000;
channel3Max = 0.969;

% Create mask based on chosen histogram thresholds
sliderBW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
BW = sliderBW;

%%subplot(1,3,2)
%%figure
imshow(BW)
axes(handles.axes3);
handles.o=BW;
guidata(hObject,handles);


%% Temizlik a??amas??
diskElem = strel('disk',3);
Ibwopen = imopen(BW,diskElem);
%%subplot(1,3,3)
%%figure
imshow(Ibwopen)
axes(handles.axes4);
handles.o=Ibwopen;
guidata(hObject, handles);

%% Blob Analizi

hBlobAnalysis = vision.BlobAnalysis('MinimumBlobArea',1000, ...
    'MaximumBlobArea',100000);
[objArea,objCentroid,bboxOut]= step(hBlobAnalysis,Ibwopen);

%% Koparma Islemi
%%imtool(Ibwopen);
disp(bboxOut)
  cropped = imcrop(Ibwopen,[bboxOut(1,1) bboxOut(1,2) bboxOut(1,3) bboxOut(1,4)]);
 

%% Foto son

Ishape = insertShape(vidFrame,'rectangle',bboxOut,'Linewidth',15);
 

%%figure
%%subplot(1,2,1)
imshow(Ishape)
%%axes(handles.axes5);
%handles.o=Ishape;
%%guidata(hObject, handles);

%% Kars??last??rma

templateKlasoru = 'C:\Users\Cihan\Desktop\Templa\';
 

%%cropped = rgb2gray(cropped);

 fileFolder = fullfile(templateKlasoru);
dirOutput = dir(fullfile(fileFolder,'*.png'));
fileNames = {dirOutput.name};
numFrames = numel(fileNames);
yeniKopardim =  imresize(cropped, [110, 110]);

  enBuyukOran=0;
  hangiDegerYakin = 0;

  for i=1:length(fileNames)
     resimYolu = append(templateKlasoru,fileNames{i});
     templateResim = imread(resimYolu);

       templateResim = rgb2gray(templateResim);

 C2 = normxcorr2(templateResim,yeniKopardim);
  karsilastirmaOrani =  max(C2(:));
     if karsilastirmaOrani>enBuyukOran
      enBuyukOran = karsilastirmaOrani;
      hangiDegerYakin = i;
     end
  end


  
  disp(enBuyukOran)
 
 levhalar = ["B??S??KLET G??REMEZ" "D??KKAT LEVHASI" "??IKI?? YOK" "OTOB??S G??REMEZ" "SA??A D??N???? YOK" "SOLA D??N???? YOK" "DUR LEVHASI" "TIR G??REMEZ" "U D??N?????? YASAKTIR" "YOL VER"];
disp(levhalar(hangiDegerYakin))
set(handles.text3,'String',levhalar(hangiDegerYakin))
