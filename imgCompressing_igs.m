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

% 把用户界面移至屏幕中央
movegui(hObject, 'center');

% 屏蔽所有中断（感谢张戌同学的发现）
h_interruptible_list = findobj(hObject, '-property','Interruptible');
set(h_interruptible_list, 'Interruptible', 'off');
% 统一含有String属性的控件的字体样式。注意！下面的语句会覆盖guide中进行的设置！
% 也就是说不管你在guide中给按钮设置什么字体名称和大小，都会被无视掉
% 受影响的GUI对象：text（不是axes上的那个text！）、edit、pushbutton、radiobutton
h_property_string_list = findobj(hObject, '-property','String');
set(h_property_string_list, 'FontSize',10.0);
set(h_property_string_list, 'FontName','微软雅黑');
% 统一所有含有Title属性的控件的字体样式
% 受影响GUI的对象：uipanel
h_property_title_list = findobj(hObject, '-property','Title');
set(h_property_title_list, 'FontSize',10.0);
set(h_property_title_list, 'FontName','微软雅黑');

% 置gui为初始状态
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
%                             非回调函数
%--------------------------------------------------------------------------
function guiResetAll(handles)
%guiResetAll 重置界面为初始状态
global IMAGE_FILE_INPUT;
guiResetWidget(handles);    % 控件重置
guiResetEnable(handles);    % 使能重置
IMAGE_FILE_INPUT = which('cameraman.tif');  % 此变量仅由“使用OpenCV处理”菜单项目使用
guiShowImg(handles,'cameraman.tif');    % 显示图像
imgInfoShow(handles);       % 更新图像信息
%--------------------------------------------------------------------------

function guiResetWidget(handles)
%guiResetWidget 控件重置
global QUANTIZING_BITS;

% 清坐标轴
% set(gcf,'CurrentAxes',handles.axes_imgSrc); cla reset; axis off;
% guiResetAxesImgIgs(handles.axes_imgIgs);

% 重置“图像信息”
set(handles.text_imgInfoWidthVal, 'String', []);
set(handles.text_imgInfoHeightVal, 'String', []);
set(handles.text_imgInfoBitsVal, 'String', []);
set(handles.text_imgInfoIgsBitsVal, 'String', []);
set(handles.text_imgInfoRatioVal, 'String', []);

% 设置初始的量化位数（重置Slider）
set(handles.slider_quantizingBits, 'Value', 4);
QUANTIZING_BITS = round( get(handles.slider_quantizingBits, 'Value') );   % 四舍五入，只取整数
set(handles.text_quatizingBits,'String',num2str(QUANTIZING_BITS) );
%--------------------------------------------------------------------------

function guiResetEnable(handles)
%guiResetEnable 重设使能
set(handles.slider_quantizingBits, 'Enable', 'on');  % 使能量化位数选择滑动条

%--------------------------------------------------------------------------

function guiShowImg(handles, img_file_name)
%guiShowImg 显示图像，显示图像信息
% 注意！此函数如果不抛出异常，则一定要在后面紧跟着调用guiResetWidget、
% guiResetEnable和guiShowImgInfo！
% img_file_name  -  文件所在路径
global IMG_SRC;
% 清空坐标轴区域
set(gcf,'CurrentAxes',handles.axes_imgSrc);

% 读初始图像
IMG_SRC = imread(img_file_name);
IMG_SRC = im2uint8(IMG_SRC);    % 强制转换成8位的……

% 我们只处理灰度图像
if numel(size(IMG_SRC)) > 2    % 多于2个通道，转为灰度
    IMG_SRC = rgb2gray(IMG_SRC);
end

% 显示初始图像
set(gcf,'CurrentAxes',handles.axes_imgSrc);
h_img_src = imshow(IMG_SRC);
% 点击图像即可在新窗口中查看图像
set(handles.axes_imgSrc, 'Userdata', h_img_src);
set(h_img_src, 'ButtonDownFcn', @imgSrc_ButtonDownFcn);

% 清空IGS区先前留下的图像
guiResetAxesImgIgs(handles.axes_imgIgs);

%--------------------------------------------------------------------------

function guiResetAxesImgIgs(h_axes_img_src)
%guiResetAxesImgIgs 重置IGS显示区的函数，h_axes_img_src是指向那个坐标轴的
% 句柄
set(gcf, 'CurrentAxes', h_axes_img_src); cla reset; axis off;
msg = ['点击“处理图像”按钮',char(10),'将在此显示结果'];
text(0.2, 0.5, msg);
%--------------------------------------------------------------------------

function [y, s_all] = igsQuantize(x, b)
%igsQuantize 将输入uint8图像x进行量化位数为b的IGS量化，输出y
% y     - uint8。输出量化后的图像
% s_all - uint8。输出中间值“和”
% 如果只对量化后的图像感兴趣的话，调用的时候这样写：[y,~] = igsQuantize(x, b);
lo = uint8(2 ^ (8 - b) - 1);    % 用来取出低位的掩码，如b=4，lo=00001111
hi = uint8(2 ^ 8 - double(lo) -1);  % 用来取出高位的掩码，如b=4，lo=11110000
[m, n] = size(x);
y = zeros(m,n);
s = zeros(m,1);    % 存储和值
s_all = zeros(m,n);

for j=1:n
    % 当前像素点的高位全为1，则hitest=0
    if all(bitand(uint8(x(:,j)), hi) == hi)
        hitest = uint8(zeros(m ,1));
    else
        hitest = uint8(uint8(zeros(m ,1)) + 255);
    end
    s = x(:,j) + bitand( hitest, bitand(uint8(s),lo) ) ;    % s 为当前点与前一和值的低位形成的新的和值
    s_all(:,j) = s;
    y(:,j) = bitand(uint8(s),hi); % 量化值取和值的高位
end
y = uint8(y);
s_all = uint8(s_all);
%--------------------------------------------------------------------------

% function str_out = precedingZeros(str_in, len)
% %precedingZeros 给输入的字符串str_in的开头添加0以使处理后的字符串的宽度为len
% % str_in - 输入的字符串
% % len    - 希望达到的宽度
% % 如果str_in的长度已经>=length的话，则什么也不做，原样输出
% len_to_fill = len - length(str_in(1,:)) ;
% if ( len_to_fill > 0)
%     str_out = strcat(char(zeros(1,len_to_fill)+48), str_in);
% else
%     str_out = str_in;
% end
%--------------------------------------------------------------------------

function imgInfoShow(handles)
%imgInfoShow 在图像信息区显示图像信息
global IMG_SRC;
global QUANTIZING_BITS;
[m, n] = size(IMG_SRC);   % 获取长宽
bits = m * n * 8;
igs_bits = m * n * QUANTIZING_BITS;
ratio = QUANTIZING_BITS / 8 * 100;   % 按百分比
set(handles.text_imgInfoWidthVal, 'String', num2str(m));
set(handles.text_imgInfoHeightVal, 'String', num2str(n));
set(handles.text_imgInfoBitsVal, 'String', num2str(bits));
set(handles.text_imgInfoIgsBitsVal, 'String', num2str(igs_bits));
set(handles.text_imgInfoRatioVal, 'String', strcat(num2str(ratio),'%'));
%----------------------------非回调函数 end--------------------------------


%--------------------------------------------------------------------------
%                              回调函数
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
% 此函数同时是工具条上边那个“打开”按钮的回调函数
% global IMG_SRC;
global IMAGE_FILE_INPUT;
IMAGE_FILE_INPUT = '';
[fname, fpath] = uigetfile({'*.bmp; *.cur;  *.fts; *.fits; *.gif;  *.hdf; *.ico;  *.j2c; *.j2k; *.jp2;  *.jpf; *.jpx; *.jpg; *.jpeg; *.pbm;  *.pcx;  *.pgm;  *.png;  *.pnm;  *.ppm;  *.ras;  *.tif; *.tiff; *.xwd; ','所有支持的图片格式'}, '打开图像文件');
fullpath = fullfile(fpath,fname);
if fname ~= 0    % 此时用户打开了文件
    % 防止用户打开假的图像
    try
        guiShowImg(handles, fullpath);     % 此函数还有一个全局变脸IMG_SRC输入
        IMAGE_FILE_INPUT = fullpath;
    catch exception
        if strcmp(exception.identifier,'MATLAB:imagesci:imread:fileFormat')
            errordlg('MATLAB不能识别您的图像，您是不是打开了假的图像？',...
                    '您可能打开了假的图像？','modal');
        else
            errordlg('其他错误，详情请检查Command Window的输出',...
                    '错误','modal');
            rethrow(exception);
        end
    end
    guiResetWidget(handles);
    guiResetEnable(handles);
    imgInfoShow(handles);       % 更新图像信息
end
%--------------------------------------------------------------------------
function button_processImage_Callback(hObject, eventdata, handles)
global IMG_SRC;
global QUANTIZING_BITS;
% 如果演示实例对这两个变量进行了修改，那么要在用户界面上有所体现
set(handles.slider_quantizingBits, 'Value', QUANTIZING_BITS);
set(handles.text_quatizingBits, 'String', num2str(QUANTIZING_BITS));

[img_igs, ~] = igsQuantize(IMG_SRC,QUANTIZING_BITS);
set(gcf,'CurrentAxes',handles.axes_imgIgs);
h_img_igs = imshow(img_igs);
% 点击图像可在新窗口中显示
set(handles.axes_imgIgs, 'UserData', h_img_igs);
set(h_img_igs,'ButtonDownFcn', @imgIgs_ButtonDownFcn);
%--------------------------------------------------------------------------
function imgIgs_ButtonDownFcn(hObject, eventdata)
h_fig = figure('Name','IGS量化后图像');
handles = guidata(hObject);
h_img_igs = get(handles.axes_imgIgs, 'UserData');
imshow(get(h_img_igs,'CData'));
%--------------------------------------------------------------------------
function imgSrc_ButtonDownFcn(hObject, eventdata)
h_fig = figure('Name','原图像');
handles = guidata(hObject);
h_img_src = get(handles.axes_imgSrc, 'UserData');
imshow(get(h_img_src,'CData'));
%--------------------------------------------------------------------------
function button_reset_Callback(hObject, eventdata, handles)
guiResetAll(handles);
%--------------------------------------------------------------------------
function slider_quantizingBits_Callback(hObject, eventdata, handles)
global QUANTIZING_BITS;
QUANTIZING_BITS = round (get(hObject, 'Value') );  % 四舍五入，只取整数
set(hObject, 'Value', QUANTIZING_BITS);    % 使滑动条停靠的位置也只允许有整数
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
    msgbox('您还未打开图片','提示');
else
    h_fig = msgbox(['即将使用MATLAB之外的、基于OpenCV的IGS量化程序。', ...
           char(10), '处理结束后，屏幕上会显示两个原图和处理结果两个窗口。', ...
           char(10), '两个窗口都关闭之后，方可返回本软件的主界面。'], '提示');
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
msg = ['IGS利用眼睛对边缘固有的敏感性，通过一个伪随机数加到每个', char(10),...
    '像素上将这些边缘拆散。这个伪随机数是在对结果进行量化之', char(10), ...
    '前，根据表示相邻像素灰度级的原编码的低位生成的。由于低', char(10), ...
    '位完全是随机的，所以这样做等于增加了通常与伪轮廓相关的', char(10), ...
    '人工边缘随机性的灰度级。',char(10), char(10),...
    'IGS量化过程：先由当前的8位灰度级值和前面产生灰度级值', char(10), ...
    '（初始值为零）的低4位相加。如果当前值的高4位是1111，', char(10), ...
    '则用0000与其相加，保持其不变。将得到的和的高4位的', char(10), ...
    '值作为编码像素值。'];
msgbox(msg,'IGS量化方法');
%--------------------------------------------------------------------------
function menuitem_about_Callback(hObject, eventdata, handles)
msg = ['作者：徐志超', char(10), ...
       'Email： xzzccc@163.com'];
msgbox(msg,'关于');
%--------------------------------------------------------------------------
function menuitem_openStock_Callback(hObject, eventdata, handles)
global IMAGE_FILE_INPUT;
IMAGE_FILE_INPUT = '';
file_list = {'AT3_1m4_01.tif', 'AT3_1m4_02.tif', 'AT3_1m4_03.tif', 'AT3_1m4_04.tif', 'AT3_1m4_05.tif', 'AT3_1m4_06.tif', 'AT3_1m4_07.tif', 'AT3_1m4_08.tif', 'AT3_1m4_09.tif', 'AT3_1m4_10.tif', 'autumn.tif', 'bag.png', 'blobs.png', 'board.tif', 'cameraman.tif', 'canoe.tif', 'cell.tif', 'circbw.tif', 'circles.png', 'circlesBrightDark.png', 'circuit.tif', 'coins.png', 'coloredChips.png', 'concordaerial.png', 'concordorthophoto.png', 'eight.tif', 'fabric.png', 'football.jpg', 'forest.tif', 'gantrycrane.png', 'glass.png', 'greens.jpg', 'hestain.png', 'kids.tif', 'liftingbody.png', 'logo.tif', 'm83.tif', 'mandi.tif', 'moon.tif', 'mri.tif', 'office_1.jpg', 'office_2.jpg', 'office_3.jpg', 'office_4.jpg', 'office_5.jpg', 'office_6.jpg', 'onion.png', 'paper1.tif', 'pears.png', 'peppers.png', 'pillsetc.png', 'pout.tif', 'rice.png', 'saturn.png', 'shadow.tif', 'snowflakes.png', 'spine.tif', 'tape.png', 'testpat1.png', 'text.png', 'tire.tif', 'tissue.png', 'trees.tif', 'westconcordaerial.png', 'westconcordorthophoto.png'};
[sel, is_ok] = listdlg(...
    'ListString',       file_list, ...
    'Name',             '请选择一项', ...
    'OKString',         '确定', ...
    'CancelString',      '取消', ...
    'SelectionMode',    'single', ...
    'ListSize',         [200 400]);
if is_ok
    try
         guiShowImg(handles, file_list{sel});     % 此函数还有一个全局变脸IMG_SRC输入
         IMAGE_FILE_INPUT = which(file_list{sel});
    catch exception
        if strcmp(exception.identifier,'MATLAB:imagesci:imread:fileFormat')
            errordlg(['因为某种原因作者把MATLAB库中假的图像也加进来了......', ...
                     char(10), '您不妨把这个图像文件从列表中去掉。列表见于', ...
                     char(10), 'menuitem_openStock_Callback函数中的file_list元胞变量'], ...
                    '您可能打开了假的图像？','modal');
        else
            errordlg('其他错误，详情请检查Command Window的输出',...
                    '错误','modal');
            rethrow(exception);
        end
    end
    guiResetWidget(handles);
    guiResetEnable(handles);
    imgInfoShow(handles);       % 更新图像信息
end
%--------------------------------------------------------------------------
function menuitem_demo_Callback(hObject, eventdata, handles)
imgCompressing_igs_demo
%--------------------------------------------------------------------------
function figure_imgCompressing_igs_CloseRequestFcn(hObject, eventdata, handles)
% global QUANTIZING_BITS IMG_SRC;
% clear QUANTIZING_BITS IMG_SRC
clear global -regexp QUANTIZING_BITS IMG_SRC IMAGE_FILE_INPUT    % clear QUANTIZING_BITS IMG_SRC似乎不好使，只能用正则表达式了
% 如果打开了演示实例，一并将之关闭
h_demo = findobj('Tag','figure_imgCompressing_igs_demo');
if ~isempty(h_demo)
    delete(h_demo);
end
% Hint: delete(hObject) closes the figure
delete(hObject);
%--------------------------------------------------------------------------
%------------------------------回调函数 end--------------------------------
