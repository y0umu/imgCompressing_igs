% imgCompressing_igs_demo.m

% 注意：此演示实例中的许多全局变量是由主程序imgCompressing_igs.m进行赋值的，
% 因此，不通过主程序调用本演示实例，会引发程序错误！！！
% 另外，因为主程序也要用到本实例的全局变量，所以本figure的CloseRequestFcn
% 不可以有clear global语句

function varargout = imgCompressing_igs_demo(varargin)
% IMGCOMPRESSING_IGS_DEMO MATLAB code for imgCompressing_igs_demo.fig
%      IMGCOMPRESSING_IGS_DEMO, by itself, creates a new IMGCOMPRESSING_IGS_DEMO or raises the existing
%      singleton*.
%
%      H = IMGCOMPRESSING_IGS_DEMO returns the handle to a new IMGCOMPRESSING_IGS_DEMO or the handle to
%      the existing singleton*.
%
%      IMGCOMPRESSING_IGS_DEMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMGCOMPRESSING_IGS_DEMO.M with the given input arguments.
%
%      IMGCOMPRESSING_IGS_DEMO('Property','Value',...) creates a new IMGCOMPRESSING_IGS_DEMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before imgCompressing_igs_demo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to imgCompressing_igs_demo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help imgCompressing_igs_demo

% Last Modified by GUIDE v2.5 22-Mar-2017 17:10:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imgCompressing_igs_demo_OpeningFcn, ...
                   'gui_OutputFcn',  @imgCompressing_igs_demo_OutputFcn, ...
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


% --- Executes just before imgCompressing_igs_demo is made visible.
function imgCompressing_igs_demo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to imgCompressing_igs_demo (see VARARGIN)

% 检查来自主程序的全局变量是否都进行了赋值
global QUANTIZING_BITS
global IMG_SRC;
is_global_empty = isempty(QUANTIZING_BITS) ||  isempty(IMG_SRC);
if is_global_empty
    errordlg('不可以单独调用本程序，请从主程序进入！','错误','modal');
    error('不可以单独调用本程序，请从主程序进入！');
end


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

% 先调用一次函数bitsrl，让MATLAB把这个函数读入内存，不然在“下一步”按钮的回调函数
% 中，第一次调用此函数会卡。
bitsrl(uint8(2),1);

% 置gui为初始状态
guiResetAll(handles);

% Choose default command line output for imgCompressing_igs_demo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes imgCompressing_igs_demo wait for user response (see UIRESUME)
% uiwait(handles.figure_imgCompressing_igs_demo);


% --- Outputs from this function are returned to the command line.
function varargout = imgCompressing_igs_demo_OutputFcn(hObject, eventdata, handles) 
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
guiResetWidget(handles);    % 控件重置
guiResetEnable(handles);    % 使能重置
guiResetVisible(handles);   % 可见性使能
%--------------------------------------------------------------------------
function guiResetWidget(handles)
%guiResetWidget 控件重置
global QUANTIZING_BITS;         % 演示实例的量化位数的初始值来自主程序
global BUTTON_NEXT_CURRENT_CNT; % “下一步”按钮计数器
BUTTON_NEXT_CURRENT_CNT = 0;

% 清坐标轴
% set(gcf,'CurrentAxes',handles.axes_imgSrc); cla reset; axis off;
% guiResetAxesImgIgs(handles.axes_imgIgs);

% 表格清除
set(handles.table_igsDemo,'Data',[]);

% 设置初始的量化位数（重置Slider）
set(handles.slider_quantizingBits, 'Value', QUANTIZING_BITS);    % 此处和主程序不同
QUANTIZING_BITS = round( get(handles.slider_quantizingBits, 'Value') );   % 四舍五入，只取整数
set(handles.text_quatizingBits,'String',num2str(QUANTIZING_BITS) );
% 设定初始演示行数
set(handles.edit_igsDemoLine,  'string', '1'); 
% edit_igsDemoLine_Callback(hObject, eventdata, handles);
% 设定初始演示像素数
set(handles.edit_igsDemoPixels, 'String', '5');
% edit_igsDemoPixels_Callback(hObject, eventdata, handles);   % 直接调用其回调函数查初始值合不合适。异常情况由回调函数处理

% 重设自定义待量化序列
str = ['01101100',char(10),'10001011',char(10),'10000111',char(10),'11110100'];
set(handles.edit_customSrc, 'String',str);

% 重设切换按钮
set(handles.togglebutton_selectDemoSource, 'Value', 0);
set(handles.togglebutton_selectDemoSource, 'String', '使用主程序中的图像');
%--------------------------------------------------------------------------
function guiResetEnable(handles)
%guiResetEnable 重设使能
set(handles.button_startIgsDemo, 'Enable', 'on');   % 使能“开始演示IGS量化过程”按钮
set(handles.button_next, 'Enable', 'off');            % 禁用“下一步”按钮
set(handles.slider_quantizingBits, 'Enable', 'on');  % 使能量化位数选择滑动条
set(handles.togglebutton_selectDemoSource, 'Enable', 'on'); % 使能模式选择按钮
togglebutton_state = get(handles.togglebutton_selectDemoSource, 'Value');
if togglebutton_state == 0   % 按下，选择主程序中的图像
    set(handles.edit_igsDemoLine,  'Enable', 'on') ;     % 使能“行数”输入框
    set(handles.edit_igsDemoPixels, 'Enable', 'on');  % 使能“像素数”输入框
    set(handles.edit_customSrc, 'Enable', 'off');   % 使能自定义量化序列输入框
else    % 弹起，选择自定义序列
    set(handles.edit_igsDemoLine,  'Enable', 'off') ;     % 使能“行数”输入框
    set(handles.edit_igsDemoPixels, 'Enable', 'off');  % 使能“像素数”输入框
    set(handles.edit_customSrc, 'Enable', 'on');   % 使能自定义量化序列输入框
end
    
%--------------------------------------------------------------------------
function guiResetVisible(handles)
%guiResetVisible 重设可见性
h_source_settings_group = [handles.text_demoDataSourceSetting_line_1; ...
                           handles.edit_igsDemoLine; ...
                           handles.text_demoDataSourceSetting_line_2; ...
                           handles.text_demoDataSourceSetting_pixels_1; ...
                           handles.edit_igsDemoPixels; ...
                           handles.text_demoDataSourceSetting_pixels_2];
set(h_source_settings_group, 'Visible', 'on');
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
function str_out = precedingZeros(str_in, len)
%precedingZeros 给输入的字符串str_in的开头添加0以使处理后的字符串的宽度为len
% str_in - 输入的字符串
% len    - 希望达到的宽度
% 如果str_in的长度已经>=length的话，则什么也不做，原样输出
len_to_fill = len - length(str_in(1,:)) ;
if ( len_to_fill > 0)
    str_out = strcat(char(zeros(1,len_to_fill)+48), str_in);
else
    str_out = str_in;
end
%--------------------------------------------------------------------------
function vector = evalUserInput(str)
%evalUserInput 检查用户输入的自定义待量化序列。如果用户输入有问题就报错
% 否则就把用户输入的二进制数转化为对应的十进制列向量
% str    -  char型二维数组。保存用户输入的序列。此二维数组宽度不能超过8；
% vector -  uint8型列向量
[m, n] = size(str);
if n > 8 || n < 1
    errordlg('您应该输入8位二进制数','错误','modal');
    error('您应该输入8位二进制数');
elseif m <= 0
    errordlg('输入不能为空','错误','modal');
    error('输入不能为空');
else
    try
        vector = bin2dec(str);
    catch exception
        errordlg('输入有误，请检查输入','错误','modal');
        error('输入有误，请检查输入');
    end
end
%--------------------------------------------------------------------------

%----------------------------非回调函数 end--------------------------------
%--------------------------------------------------------------------------
%                              回调函数
%--------------------------------------------------------------------------

function button_startIgsDemo_Callback(hObject, eventdata, handles)
% 关于 handles.table_igs_demo的Data域和MAT_IGS_DEMO关系的说明：
% MAT_IGS_DEMO为handles.table_igs_demo的Data域提供“后台数据”
% 所有计算都是对MAT_IGS_DEMO进行的，MAT_IGS_DEMO生成完毕之后，通过自编的接
% 口转换函数生成handles.table_igs_demo的Data域需要的数据形式。
global IMG_SRC;
global QUANTIZING_BITS;
global MAT_IGS_DEMO;
global IGS_DEMO_LINE;
global IGS_DEMO_PIXELS;
global IGS_DEMO_DATA;

% disp('----> timer Z starts');tic;
% 如果演示实例对这两个变量进行了修改，那么要在用户界面上有所体现
set(handles.slider_quantizingBits, 'Value', QUANTIZING_BITS);
set(handles.text_quatizingBits, 'String', num2str(QUANTIZING_BITS));

button_state = get(handles.togglebutton_selectDemoSource, 'Value');

% disp('--> timer 11 starts');tic;
if button_state == 0    % 按钮按下，选择主程序中的图像为演示数据源
    % 这两个函数有检查并纠正输入的功能
    edit_igsDemoLine_Callback(hObject, eventdata, handles);
    edit_igsDemoPixels_Callback(hObject, eventdata, handles);
    local_img_src = IMG_SRC;
    local_igs_demo_pixels = IGS_DEMO_PIXELS;
    % 开始演示之前，把整个表格中需要的数据全都算好
    [igs_code, igs_sum] = igsQuantize(local_img_src(IGS_DEMO_LINE,1:IGS_DEMO_PIXELS), ...
                                      QUANTIZING_BITS);
else    % 按钮弹起，选择自定义序列为演示数据源
%     msgbox('Custom source');
    sequence = get(handles.edit_customSrc, 'String');
    local_img_src = evalUserInput(sequence);
    local_img_src = local_img_src';    % 列向量变行向量
    local_igs_demo_pixels = length(local_img_src);
    set(handles.edit_customSrc, 'Userdata', local_igs_demo_pixels);
    [igs_code, igs_sum] = igsQuantize(local_img_src(1:local_igs_demo_pixels), ...
                                      QUANTIZING_BITS);
end
% toc;disp('--- timer 11 ends');

% 控制控件
set(handles.button_startIgsDemo,'Enable','off');  % 禁用“开始演示IGS量化过程”按钮
set(handles.button_next,'Enable','on');           % 使能“下一步”按钮
set(handles.slider_quantizingBits, 'Enable', 'off');  % 禁用量化位数选择滑动条
set(handles.edit_igsDemoLine,  'Enable', 'off');     % 禁用“行数”输入框
set(handles.edit_igsDemoPixels, 'Enable', 'off');  % 禁止“演示步骤数设定”输入框
set(handles.togglebutton_selectDemoSource, 'Enable', 'off'); % 禁用模式选择按钮

% 准备工作完成，好戏开始
    % IGS_DEMO_DATA是前台表格数据，MAT_IGS_DEMO是后台表格数据
    % 第1列表示灰度级
    % 第2列表示和
    % 第3列表示IGS量化值
%     disp('--> timer 12 starts');tic;
    MAT_IGS_DEMO = zeros(local_igs_demo_pixels+1, 3, 'uint8');
    MAT_IGS_DEMO(2:local_igs_demo_pixels+1, 1) = local_img_src(1,1:local_igs_demo_pixels);
    MAT_IGS_DEMO(1,2) = uint8(0);
    MAT_IGS_DEMO(2:local_igs_demo_pixels+1, 2) = igs_sum';
    MAT_IGS_DEMO(2:local_igs_demo_pixels+1, 3) = igs_code';

    IGS_DEMO_DATA = cell(local_igs_demo_pixels + 1, 3);
    tmp = dec2bin(MAT_IGS_DEMO(2:local_igs_demo_pixels+1,1));
    tmp = precedingZeros(tmp, 8);
    data_col_1 = vertcat([],tmp);
    IGS_DEMO_DATA{1,1} = 'N/A';
    IGS_DEMO_DATA{1,2} = '00000000';
    IGS_DEMO_DATA{1,3} = 'N/A';
    for i=1:local_igs_demo_pixels
        IGS_DEMO_DATA{i+1,1} = data_col_1(i,:);
    end
    set(handles.table_igsDemo,'Data',IGS_DEMO_DATA);
%     toc;disp('--- timer 12 ends');
% toc;disp('----- timer Z ends');
%--------------------------------------------------------------------------
function button_next_Callback(hObject, eventdata, handles)
% 下一步其实没有什么特别之处，本质上就是不停地用新数据覆盖
% handles.table_igsDemo中的Data域。
% 具体的说，这里用到了三个矩阵（元胞）
% MAT_IGS_DEMO    -  “幕后人员”
% IGS_DEMO_DATA   -  没有HTML标记的中间数据。已经可以通过set给handles.table_igsDemo中的Data域
% demo_data_html  -  “前台的演出”。本来是对IGS_DEMO_DATA的拷贝，在运行过程中做了一些修改。
global QUANTIZING_BITS;
global BUTTON_NEXT_CURRENT_CNT; % “下一步”按钮计数器
global MAT_IGS_DEMO;
global IGS_DEMO_DATA;
global IGS_DEMO_PIXELS;    % 演示过程总像素数设定

% 计数器自增
BUTTON_NEXT_CURRENT_CNT = BUTTON_NEXT_CURRENT_CNT + 1;

togglebutton_state = get(handles.togglebutton_selectDemoSource, 'Value');
if togglebutton_state == 0    % 按钮按下，选择主程序中的图像为演示数据源
    local_igs_demo_pixels = IGS_DEMO_PIXELS;
else    % 按钮弹起，选择用户输入序列为演示数据源
    local_igs_demo_pixels = get(handles.edit_customSrc, 'Userdata');
end


if BUTTON_NEXT_CURRENT_CNT <= local_igs_demo_pixels
    current_line = BUTTON_NEXT_CURRENT_CNT + 1;
%     disp('----> timer X starts');tic;
    % 处理第2列
    sum_str = dec2bin(MAT_IGS_DEMO(current_line,2));
    sum_str = precedingZeros(sum_str, 8);
    IGS_DEMO_DATA{current_line, 2} = sum_str;

    tmp = bitsrl(MAT_IGS_DEMO(current_line,3), 8-QUANTIZING_BITS);   % 此处tmp变量仅仅在此行和下一行出现，其他地方再没有了
    igs_code = dec2bin(tmp);    % 使用tmp变量是因为直接把那么一大串写到dec2bin的参数里面会严重拖慢程序运行
    igs_code = precedingZeros(igs_code, QUANTIZING_BITS);
    IGS_DEMO_DATA{current_line, 3} = igs_code;
    demo_data_html = IGS_DEMO_DATA;  % 拷贝IGS_DEMO_DATA


    % 使用HTML增加颜色等等
%     disp('--> timer 03 starts');tic;
    is_msb_all_ones = (bitsrl(MAT_IGS_DEMO(current_line,1), 8-QUANTIZING_BITS) == uint8(2^QUANTIZING_BITS-1) );
    str_sum_1_previous_line = IGS_DEMO_DATA{current_line-1,2}(1:QUANTIZING_BITS);
    str_sum_2_previous_line = IGS_DEMO_DATA{current_line-1,2}((QUANTIZING_BITS+1):8);
    str_gray_1_current_line = IGS_DEMO_DATA{current_line,1}(1:QUANTIZING_BITS);
    str_gray_2_current_line = IGS_DEMO_DATA{current_line,1}((QUANTIZING_BITS+1):8);
    str_sum_1_current_line = IGS_DEMO_DATA{current_line,2}(1:QUANTIZING_BITS);
    str_sum_2_current_line = IGS_DEMO_DATA{current_line,2}((QUANTIZING_BITS+1):8);
    str_igs_code = IGS_DEMO_DATA{current_line,3};
%     toc;disp('--- timer 03 ends');

%     disp('--> timer 04 starts');tic;
    if is_msb_all_ones    % 高几位全是1
        demo_data_html{current_line,1} = strcat('<html><body><span style="color: red;">', ...
                                                str_gray_1_current_line, ...
                                                '</span>', ...
                                                str_gray_2_current_line, ...
                                                '</body></html>');
    else                  % 高几位不全是1
        demo_data_html{current_line-1,2} = strcat('<html><body>', ...
                                        str_sum_1_previous_line, ...
                                        '<span style="color: blue;">', ...
                                        str_sum_2_previous_line, ...
                                        '</span></body></html>');
        demo_data_html{current_line,1} = strcat('<html><body><span style="color: green;">', ...
                                                str_gray_1_current_line, ...
                                                '</span>', ...
                                                str_gray_2_current_line, ...
                                                '</body></html>'); 
    end   %  if is_msb_all_ones
    demo_data_html{current_line,2} = strcat('<html><body><u>', ...
                                                str_sum_1_current_line, ...
                                                '</u>', ...
                                                str_sum_2_current_line, ...
                                                '</body></html>'); 
    demo_data_html{current_line,3} = strcat('<html><body><u>', ...
                                                str_igs_code, ...
                                                '</u>', ...
                                                '</body></html>'); 
    set(handles.table_igsDemo,'Data',demo_data_html);
%     toc;disp('--- timer 04 ends');
%     toc;disp('----- timer X ends');
end    % if BUTTON_NEXT_CURRENT_CNT <= local_igs_demo_pixels


if BUTTON_NEXT_CURRENT_CNT >= local_igs_demo_pixels
    % 计数器复位
    BUTTON_NEXT_CURRENT_CNT = 0;
    guiResetEnable(handles);    % 控件使能重置
end

function button_reset_Callback(hObject, eventdata, handles)
guiResetAll(handles);


function slider_quantizingBits_Callback(hObject, eventdata, handles)
global QUANTIZING_BITS;
QUANTIZING_BITS = round (get(hObject, 'Value') );  % 四舍五入，只取整数
set(hObject, 'Value', QUANTIZING_BITS);    % 使滑动条停靠的位置也只允许有整数
set(handles.text_quatizingBits,'String',num2str(QUANTIZING_BITS) );


function slider_quantizingBits_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function n = edit_igsDemoPixels_Callback(hObject, eventdata, handles)
%edit_igsDemoPixelsTotal_Callback 检查用户输入的像素数字符串是否合法
% 直接从handles中读取handles.edit_igsDemoPixelsTotal的String域。
% 此函数同时接收全局变量IMG_SRC为输入参数。当用户要求的步数大于图像的宽时，
% 置n为图像的宽。当用户要求的步数是0或者负数的时候，置n为1
% 其他情况n为用户的输入值
global IMG_SRC;
global IGS_DEMO_PIXELS;
str = get(handles.edit_igsDemoPixels, 'String');
[~ ,width_of_img] = size(IMG_SRC);
n = str2double(str);
if isnan(n) || isempty(n)
    errordlg('不合法的量输入，请检查Command Window中的错误信息','错误', 'modal');
    cell_msg = strcat('"',str,'"',' is not a string representing a number');
    error(cell_msg{1});
elseif n > width_of_img
    n = width_of_img;
    set(handles.edit_igsDemoPixels, 'String', num2str(n));
elseif n <= 0
    n = 1;
    set(handles.edit_igsDemoPixels, 'String', num2str(n));
end
IGS_DEMO_PIXELS = n;

function edit_igsDemoPixels_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_igsDemoLine_Callback(hObject, eventdata, handles)
%edit_igsDemoLine_Callback 检查用户输入的行数字符串是否合法
% 直接从handles中读取handles.edit_igsDemoPixelsTotal的String域。
% 此函数同时接收全局变量IMG_SRC为输入参数。当用户要求的步数大于图像的高时，
% 置n为图像的高。当用户要求的行数是0或者负数的时候，置n为1
% 其他情况n为用户的输入值
global IMG_SRC;
global IGS_DEMO_LINE;
str = get(handles.edit_igsDemoLine, 'String');
[height_of_img, ~] = size(IMG_SRC);
n = str2double(str);
if isnan(n) || isempty(n)
    errordlg('不合法的量输入，请检查Command Window中的错误信息','错误', 'modal');
    error('Your input is not a numeric value');
elseif n > height_of_img
    n = height_of_img;
    set(handles.edit_igsDemoLine, 'String', num2str(n));
elseif n <= 0
    n = 1;
    set(handles.edit_igsDemoLine, 'String', num2str(n));
end
IGS_DEMO_LINE = n;

function edit_igsDemoLine_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function figure_imgCompressing_igs_demo_CloseRequestFcn(hObject, eventdata, handles)
%figure_imgCompressing_igs_demo_CloseRequestFcn相当于C++中的析构函数
clear global -regexp IGS_DEMO_DATA MAT_IGS_DEMO IGS_DEMO_LINE IGS_DEMO_PIXELS;
% Hint: delete(hObject) closes the figure
delete(hObject);


function edit_customSrc_Callback(hObject, eventdata, handles)


function edit_customSrc_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function togglebutton_selectDemoSource_Callback(hObject, eventdata, handles)
button_state = get(hObject,'Value');    % button_state - 0表示弹起，1表示按下

h_source_settings_group = [handles.text_demoDataSourceSetting_line_1; ...
                           handles.edit_igsDemoLine; ...
                           handles.text_demoDataSourceSetting_line_2; ...
                           handles.text_demoDataSourceSetting_pixels_1; ...
                           handles.edit_igsDemoPixels; ...
                           handles.text_demoDataSourceSetting_pixels_2];
if button_state == 1
    set(hObject, 'String', '使用自定义序列');
    set(handles.edit_customSrc, 'Enable', 'on');
    set(h_source_settings_group, 'Visible', 'off');
else
    set(hObject, 'String', '使用主程序中的图像');
    set(handles.edit_customSrc, 'Enable', 'off');
    set(h_source_settings_group, 'Visible', 'on');
end
