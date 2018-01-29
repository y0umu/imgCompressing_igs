% imgCompressing_igs.m

function varargout = imgCompressing_igs(varargin)
% IMGCOMPRESSING_IGS MATLAB code for imgCompressing_igs.fig
%      IMGCOMPRESSING_IGS, by itself, creates a new IMGCOMPRESSING_IGS or raises the existing
%      singleton*.
%
%      H = IMGCOMPRESSING_IGS returns the handle to a new IMGCOMPRESSING_IGS or the handle to
%      the existing singleton*.
%
%      IMGCOMPRESSING_IGS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMGCOMPRESSING_IGS.M with the given input arguments.
%
%      IMGCOMPRESSING_IGS('Property','Value',...) creates a new IMGCOMPRESSING_IGS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before imgCompressing_igs_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to imgCompressing_igs_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help imgCompressing_igs

% Last Modified by GUIDE v2.5 23-Apr-2017 11:23:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imgCompressing_igs_OpeningFcn, ...
                   'gui_OutputFcn',  @imgCompressing_igs_OutputFcn, ...
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


% --- Executes just before imgCompressing_igs is made visible.
function imgCompressing_igs_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to imgCompressing_igs (see VARARGIN)

% ���û�����������Ļ����
movegui(hObject, 'center');

% ���������жϣ���л����ͬѧ�ķ��֣�
h_interruptible_list = findobj(hObject, '-property','Interruptible');
set(h_interruptible_list, 'Interruptible', 'off');
% ͳһ����String���ԵĿؼ���������ʽ��ע�⣡��������Ḳ��guide�н��е����ã�
% Ҳ����˵��������guide�и���ť����ʲô�������ƺʹ�С�����ᱻ���ӵ�
% ��Ӱ���GUI����text������axes�ϵ��Ǹ�text������edit��pushbutton��radiobutton
h_property_string_list = findobj(hObject, '-property','String');
set(h_property_string_list, 'FontSize',10.0);
set(h_property_string_list, 'FontName','΢���ź�');
% ͳһ���к���Title���ԵĿؼ���������ʽ
% ��Ӱ��GUI�Ķ���uipanel
h_property_title_list = findobj(hObject, '-property','Title');
set(h_property_title_list, 'FontSize',10.0);
set(h_property_title_list, 'FontName','΢���ź�');

% ��guiΪ��ʼ״̬
guiResetAll(handles);

% Choose default command line output for imgCompressing_igs
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes imgCompressing_igs wait for user response (see UIRESUME)
% uiwait(handles.figure_imgCompressing_igs);


% --- Outputs from this function are returned to the command line.
function varargout = imgCompressing_igs_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%--------------------------------------------------------------------------
%                             �ǻص�����
%--------------------------------------------------------------------------
function guiResetAll(handles)
%guiResetAll ���ý���Ϊ��ʼ״̬
global IMAGE_FILE_INPUT;
guiResetWidget(handles);    % �ؼ�����
guiResetEnable(handles);    % ʹ������
IMAGE_FILE_INPUT = which('cameraman.tif');  % �˱������ɡ�ʹ��OpenCV�����˵���Ŀʹ��
guiShowImg(handles,'cameraman.tif');    % ��ʾͼ��
imgInfoShow(handles);       % ����ͼ����Ϣ
%--------------------------------------------------------------------------

function guiResetWidget(handles)
%guiResetWidget �ؼ�����
global QUANTIZING_BITS;

% ��������
% set(gcf,'CurrentAxes',handles.axes_imgSrc); cla reset; axis off;
% guiResetAxesImgIgs(handles.axes_imgIgs);

% ���á�ͼ����Ϣ��
set(handles.text_imgInfoWidthVal, 'String', []);
set(handles.text_imgInfoHeightVal, 'String', []);
set(handles.text_imgInfoBitsVal, 'String', []);
set(handles.text_imgInfoIgsBitsVal, 'String', []);
set(handles.text_imgInfoRatioVal, 'String', []);

% ���ó�ʼ������λ��������Slider��
set(handles.slider_quantizingBits, 'Value', 4);
QUANTIZING_BITS = round( get(handles.slider_quantizingBits, 'Value') );   % �������룬ֻȡ����
set(handles.text_quatizingBits,'String',num2str(QUANTIZING_BITS) );
%--------------------------------------------------------------------------

function guiResetEnable(handles)
%guiResetEnable ����ʹ��
set(handles.slider_quantizingBits, 'Enable', 'on');  % ʹ������λ��ѡ�񻬶���

%--------------------------------------------------------------------------

function guiShowImg(handles, img_file_name)
%guiShowImg ��ʾͼ����ʾͼ����Ϣ
% ע�⣡�˺���������׳��쳣����һ��Ҫ�ں�������ŵ���guiResetWidget��
% guiResetEnable��guiShowImgInfo��
% img_file_name  -  �ļ�����·��
global IMG_SRC;
% �������������
set(gcf,'CurrentAxes',handles.axes_imgSrc);

% ����ʼͼ��
IMG_SRC = imread(img_file_name);
IMG_SRC = im2uint8(IMG_SRC);    % ǿ��ת����8λ�ġ���

% ����ֻ����Ҷ�ͼ��
if numel(size(IMG_SRC)) > 2    % ����2��ͨ����תΪ�Ҷ�
    IMG_SRC = rgb2gray(IMG_SRC);
end

% ��ʾ��ʼͼ��
set(gcf,'CurrentAxes',handles.axes_imgSrc);
h_img_src = imshow(IMG_SRC);
% ���ͼ�񼴿����´����в鿴ͼ��
set(handles.axes_imgSrc, 'Userdata', h_img_src);
set(h_img_src, 'ButtonDownFcn', @imgSrc_ButtonDownFcn);

% ���IGS����ǰ���µ�ͼ��
guiResetAxesImgIgs(handles.axes_imgIgs);

%--------------------------------------------------------------------------

function guiResetAxesImgIgs(h_axes_img_src)
%guiResetAxesImgIgs ����IGS��ʾ���ĺ�����h_axes_img_src��ָ���Ǹ��������
% ���
set(gcf, 'CurrentAxes', h_axes_img_src); cla reset; axis off;
msg = ['���������ͼ�񡱰�ť',char(10),'���ڴ���ʾ���'];
text(0.2, 0.5, msg);
%--------------------------------------------------------------------------

function [y, s_all] = igsQuantize(x, b)
%igsQuantize ������uint8ͼ��x��������λ��Ϊb��IGS���������y
% y     - uint8������������ͼ��
% s_all - uint8������м�ֵ���͡�
% ���ֻ���������ͼ�����Ȥ�Ļ������õ�ʱ������д��[y,~] = igsQuantize(x, b);
lo = uint8(2 ^ (8 - b) - 1);    % ����ȡ����λ�����룬��b=4��lo=00001111
hi = uint8(2 ^ 8 - double(lo) -1);  % ����ȡ����λ�����룬��b=4��lo=11110000
[m, n] = size(x);
y = zeros(m,n);
s = zeros(m,1);    % �洢��ֵ
s_all = zeros(m,n);

for j=1:n
    % ��ǰ���ص�ĸ�λȫΪ1����hitest=0
    if all(bitand(uint8(x(:,j)), hi) == hi)
        hitest = uint8(zeros(m ,1));
    else
        hitest = uint8(uint8(zeros(m ,1)) + 255);
    end
    s = x(:,j) + bitand( hitest, bitand(uint8(s),lo) ) ;    % s Ϊ��ǰ����ǰһ��ֵ�ĵ�λ�γɵ��µĺ�ֵ
    s_all(:,j) = s;
    y(:,j) = bitand(uint8(s),hi); % ����ֵȡ��ֵ�ĸ�λ
end
y = uint8(y);
s_all = uint8(s_all);
%--------------------------------------------------------------------------

% function str_out = precedingZeros(str_in, len)
% %precedingZeros ��������ַ���str_in�Ŀ�ͷ���0��ʹ�������ַ����Ŀ��Ϊlen
% % str_in - ������ַ���
% % len    - ϣ���ﵽ�Ŀ��
% % ���str_in�ĳ����Ѿ�>=length�Ļ�����ʲôҲ������ԭ�����
% len_to_fill = len - length(str_in(1,:)) ;
% if ( len_to_fill > 0)
%     str_out = strcat(char(zeros(1,len_to_fill)+48), str_in);
% else
%     str_out = str_in;
% end
%--------------------------------------------------------------------------

function imgInfoShow(handles)
%imgInfoShow ��ͼ����Ϣ����ʾͼ����Ϣ
global IMG_SRC;
global QUANTIZING_BITS;
[m, n] = size(IMG_SRC);   % ��ȡ����
bits = m * n * 8;
igs_bits = m * n * QUANTIZING_BITS;
ratio = QUANTIZING_BITS / 8 * 100;   % ���ٷֱ�
set(handles.text_imgInfoWidthVal, 'String', num2str(m));
set(handles.text_imgInfoHeightVal, 'String', num2str(n));
set(handles.text_imgInfoBitsVal, 'String', num2str(bits));
set(handles.text_imgInfoIgsBitsVal, 'String', num2str(igs_bits));
set(handles.text_imgInfoRatioVal, 'String', strcat(num2str(ratio),'%'));
%----------------------------�ǻص����� end--------------------------------


%--------------------------------------------------------------------------
%                              �ص�����
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function menuitem_file_Callback(hObject, eventdata, handles)
%--------------------------------------------------------------------------
function menuitem_view_Callback(hObject, eventdata, handles)
%--------------------------------------------------------------------------
function menuitem_edit_Callback(hObject, eventdata, handles)
%--------------------------------------------------------------------------
function menuitem_help_Callback(hObject, eventdata, handles)
%--------------------------------------------------------------------------
function menuitem_open_Callback(hObject, eventdata, handles)
% �˺���ͬʱ�ǹ������ϱ��Ǹ����򿪡���ť�Ļص�����
% global IMG_SRC;
global IMAGE_FILE_INPUT;
IMAGE_FILE_INPUT = '';
[fname, fpath] = uigetfile({'*.bmp; *.cur;  *.fts; *.fits; *.gif;  *.hdf; *.ico;  *.j2c; *.j2k; *.jp2;  *.jpf; *.jpx; *.jpg; *.jpeg; *.pbm;  *.pcx;  *.pgm;  *.png;  *.pnm;  *.ppm;  *.ras;  *.tif; *.tiff; *.xwd; ','����֧�ֵ�ͼƬ��ʽ'}, '��ͼ���ļ�');
fullpath = fullfile(fpath,fname);
if fname ~= 0    % ��ʱ�û������ļ�
    % ��ֹ�û��򿪼ٵ�ͼ��
    try
        guiShowImg(handles, fullpath);     % �˺�������һ��ȫ�ֱ���IMG_SRC����
        IMAGE_FILE_INPUT = fullpath;
    catch exception
        if strcmp(exception.identifier,'MATLAB:imagesci:imread:fileFormat')
            errordlg('MATLAB����ʶ������ͼ�����ǲ��Ǵ��˼ٵ�ͼ��',...
                    '�����ܴ��˼ٵ�ͼ��','modal');
        else
            errordlg('����������������Command Window�����',...
                    '����','modal');
            rethrow(exception);
        end
    end
    guiResetWidget(handles);
    guiResetEnable(handles);
    imgInfoShow(handles);       % ����ͼ����Ϣ
end
%--------------------------------------------------------------------------
function button_processImage_Callback(hObject, eventdata, handles)
global IMG_SRC;
global QUANTIZING_BITS;
% �����ʾʵ���������������������޸ģ���ôҪ���û���������������
set(handles.slider_quantizingBits, 'Value', QUANTIZING_BITS);
set(handles.text_quatizingBits, 'String', num2str(QUANTIZING_BITS));

[img_igs, ~] = igsQuantize(IMG_SRC,QUANTIZING_BITS);
set(gcf,'CurrentAxes',handles.axes_imgIgs);
h_img_igs = imshow(img_igs);
% ���ͼ������´�������ʾ
set(handles.axes_imgIgs, 'UserData', h_img_igs);
set(h_img_igs,'ButtonDownFcn', @imgIgs_ButtonDownFcn);
%--------------------------------------------------------------------------
function imgIgs_ButtonDownFcn(hObject, eventdata)
h_fig = figure('Name','IGS������ͼ��');
handles = guidata(hObject);
h_img_igs = get(handles.axes_imgIgs, 'UserData');
imshow(get(h_img_igs,'CData'));
%--------------------------------------------------------------------------
function imgSrc_ButtonDownFcn(hObject, eventdata)
h_fig = figure('Name','ԭͼ��');
handles = guidata(hObject);
h_img_src = get(handles.axes_imgSrc, 'UserData');
imshow(get(h_img_src,'CData'));
%--------------------------------------------------------------------------
function button_reset_Callback(hObject, eventdata, handles)
guiResetAll(handles);
%--------------------------------------------------------------------------
function slider_quantizingBits_Callback(hObject, eventdata, handles)
global QUANTIZING_BITS;
QUANTIZING_BITS = round (get(hObject, 'Value') );  % �������룬ֻȡ����
set(hObject, 'Value', QUANTIZING_BITS);    % ʹ������ͣ����λ��Ҳֻ����������
set(handles.text_quatizingBits,'String',num2str(QUANTIZING_BITS) );
imgInfoShow(handles);
%--------------------------------------------------------------------------
function slider_quantizingBits_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%--------------------------------------------------------------------------
function menuitem_opencv_Callback(hObject, eventdata, handles)
global IMAGE_FILE_INPUT;
global QUANTIZING_BITS;
if isempty(IMAGE_FILE_INPUT)
    msgbox('����δ��ͼƬ','��ʾ');
else
    h_fig = msgbox(['����ʹ��MATLAB֮��ġ�����OpenCV��IGS��������', ...
           char(10), '�����������Ļ�ϻ���ʾ����ԭͼ�ʹ������������ڡ�', ...
           char(10), '�������ڶ��ر�֮�󣬷��ɷ��ر�����������档'], '��ʾ');
    uiwait(h_fig);
    cmd_line = horzcat('"IGS Quantization (OpenCV)\igs_quantize_x86.exe"', ...
                      ' ',num2str(QUANTIZING_BITS), ...
                      ' ', ['"',IMAGE_FILE_INPUT, '"']);
    system(cmd_line);
end
%--------------------------------------------------------------------------
function toolbar_open_ClickedCallback(hObject, eventdata, handles)
menuitem_open_Callback(hObject, eventdata, handles);
%--------------------------------------------------------------------------
function menuitem_helpDoc_Callback(hObject, eventdata, handles)
msg = ['IGS�����۾��Ա�Ե���е������ԣ�ͨ��һ��α������ӵ�ÿ��', char(10),...
    '�����Ͻ���Щ��Ե��ɢ�����α��������ڶԽ����������֮', char(10), ...
    'ǰ�����ݱ�ʾ�������ػҶȼ���ԭ����ĵ�λ���ɵġ����ڵ�', char(10), ...
    'λ��ȫ������ģ���������������������ͨ����α������ص�', char(10), ...
    '�˹���Ե����ԵĻҶȼ���',char(10), char(10),...
    'IGS�������̣����ɵ�ǰ��8λ�Ҷȼ�ֵ��ǰ������Ҷȼ�ֵ', char(10), ...
    '����ʼֵΪ�㣩�ĵ�4λ��ӡ������ǰֵ�ĸ�4λ��1111��', char(10), ...
    '����0000������ӣ������䲻�䡣���õ��ĺ͵ĸ�4λ��', char(10), ...
    'ֵ��Ϊ��������ֵ��'];
msgbox(msg,'IGS��������');
%--------------------------------------------------------------------------
function menuitem_about_Callback(hObject, eventdata, handles)
msg = ['���ߣ���־��', char(10), ...
       'Email�� xzzccc@163.com'];
msgbox(msg,'����');
%--------------------------------------------------------------------------
function menuitem_openStock_Callback(hObject, eventdata, handles)
global IMAGE_FILE_INPUT;
IMAGE_FILE_INPUT = '';
file_list = {'AT3_1m4_01.tif', 'AT3_1m4_02.tif', 'AT3_1m4_03.tif', 'AT3_1m4_04.tif', 'AT3_1m4_05.tif', 'AT3_1m4_06.tif', 'AT3_1m4_07.tif', 'AT3_1m4_08.tif', 'AT3_1m4_09.tif', 'AT3_1m4_10.tif', 'autumn.tif', 'bag.png', 'blobs.png', 'board.tif', 'cameraman.tif', 'canoe.tif', 'cell.tif', 'circbw.tif', 'circles.png', 'circlesBrightDark.png', 'circuit.tif', 'coins.png', 'coloredChips.png', 'concordaerial.png', 'concordorthophoto.png', 'eight.tif', 'fabric.png', 'football.jpg', 'forest.tif', 'gantrycrane.png', 'glass.png', 'greens.jpg', 'hestain.png', 'kids.tif', 'liftingbody.png', 'logo.tif', 'm83.tif', 'mandi.tif', 'moon.tif', 'mri.tif', 'office_1.jpg', 'office_2.jpg', 'office_3.jpg', 'office_4.jpg', 'office_5.jpg', 'office_6.jpg', 'onion.png', 'paper1.tif', 'pears.png', 'peppers.png', 'pillsetc.png', 'pout.tif', 'rice.png', 'saturn.png', 'shadow.tif', 'snowflakes.png', 'spine.tif', 'tape.png', 'testpat1.png', 'text.png', 'tire.tif', 'tissue.png', 'trees.tif', 'westconcordaerial.png', 'westconcordorthophoto.png'};
[sel, is_ok] = listdlg(...
    'ListString',       file_list, ...
    'Name',             '��ѡ��һ��', ...
    'OKString',         'ȷ��', ...
    'CancelString',      'ȡ��', ...
    'SelectionMode',    'single', ...
    'ListSize',         [200 400]);
if is_ok
    try
         guiShowImg(handles, file_list{sel});     % �˺�������һ��ȫ�ֱ���IMG_SRC����
         IMAGE_FILE_INPUT = which(file_list{sel});
    catch exception
        if strcmp(exception.identifier,'MATLAB:imagesci:imread:fileFormat')
            errordlg(['��Ϊĳ��ԭ�����߰�MATLAB���мٵ�ͼ��Ҳ�ӽ�����......', ...
                     char(10), '�����������ͼ���ļ����б���ȥ�����б����', ...
                     char(10), 'menuitem_openStock_Callback�����е�file_listԪ������'], ...
                    '�����ܴ��˼ٵ�ͼ��','modal');
        else
            errordlg('����������������Command Window�����',...
                    '����','modal');
            rethrow(exception);
        end
    end
    guiResetWidget(handles);
    guiResetEnable(handles);
    imgInfoShow(handles);       % ����ͼ����Ϣ
end
%--------------------------------------------------------------------------
function menuitem_demo_Callback(hObject, eventdata, handles)
imgCompressing_igs_demo
%--------------------------------------------------------------------------
function figure_imgCompressing_igs_CloseRequestFcn(hObject, eventdata, handles)
% global QUANTIZING_BITS IMG_SRC;
% clear QUANTIZING_BITS IMG_SRC
clear global -regexp QUANTIZING_BITS IMG_SRC IMAGE_FILE_INPUT    % clear QUANTIZING_BITS IMG_SRC�ƺ�����ʹ��ֻ����������ʽ��
% ���������ʾʵ����һ����֮�ر�
h_demo = findobj('Tag','figure_imgCompressing_igs_demo');
if ~isempty(h_demo)
    delete(h_demo);
end
% Hint: delete(hObject) closes the figure
delete(hObject);
%--------------------------------------------------------------------------
%------------------------------�ص����� end--------------------------------
