% imgCompressing_igs_demo.m

% ע�⣺����ʾʵ���е����ȫ�ֱ�������������imgCompressing_igs.m���и�ֵ�ģ�
% ��ˣ���ͨ����������ñ���ʾʵ����������������󣡣���
% ���⣬��Ϊ������ҲҪ�õ���ʵ����ȫ�ֱ��������Ա�figure��CloseRequestFcn
% ��������clear global���

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

% ��������������ȫ�ֱ����Ƿ񶼽����˸�ֵ
global QUANTIZING_BITS
global IMG_SRC;
is_global_empty = isempty(QUANTIZING_BITS) ||  isempty(IMG_SRC);
if is_global_empty
    errordlg('�����Ե������ñ����������������룡','����','modal');
    error('�����Ե������ñ����������������룡');
end


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

% �ȵ���һ�κ���bitsrl����MATLAB��������������ڴ棬��Ȼ�ڡ���һ������ť�Ļص�����
% �У���һ�ε��ô˺����Ῠ��
bitsrl(uint8(2),1);

% ��guiΪ��ʼ״̬
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
%                             �ǻص�����
%--------------------------------------------------------------------------
function guiResetAll(handles)
%guiResetAll ���ý���Ϊ��ʼ״̬
guiResetWidget(handles);    % �ؼ�����
guiResetEnable(handles);    % ʹ������
guiResetVisible(handles);   % �ɼ���ʹ��
%--------------------------------------------------------------------------
function guiResetWidget(handles)
%guiResetWidget �ؼ�����
global QUANTIZING_BITS;         % ��ʾʵ��������λ���ĳ�ʼֵ����������
global BUTTON_NEXT_CURRENT_CNT; % ����һ������ť������
BUTTON_NEXT_CURRENT_CNT = 0;

% ��������
% set(gcf,'CurrentAxes',handles.axes_imgSrc); cla reset; axis off;
% guiResetAxesImgIgs(handles.axes_imgIgs);

% ������
set(handles.table_igsDemo,'Data',[]);

% ���ó�ʼ������λ��������Slider��
set(handles.slider_quantizingBits, 'Value', QUANTIZING_BITS);    % �˴���������ͬ
QUANTIZING_BITS = round( get(handles.slider_quantizingBits, 'Value') );   % �������룬ֻȡ����
set(handles.text_quatizingBits,'String',num2str(QUANTIZING_BITS) );
% �趨��ʼ��ʾ����
set(handles.edit_igsDemoLine,  'string', '1'); 
% edit_igsDemoLine_Callback(hObject, eventdata, handles);
% �趨��ʼ��ʾ������
set(handles.edit_igsDemoPixels, 'String', '5');
% edit_igsDemoPixels_Callback(hObject, eventdata, handles);   % ֱ�ӵ�����ص��������ʼֵ�ϲ����ʡ��쳣����ɻص���������

% �����Զ������������
str = ['01101100',char(10),'10001011',char(10),'10000111',char(10),'11110100'];
set(handles.edit_customSrc, 'String',str);

% �����л���ť
set(handles.togglebutton_selectDemoSource, 'Value', 0);
set(handles.togglebutton_selectDemoSource, 'String', 'ʹ���������е�ͼ��');
%--------------------------------------------------------------------------
function guiResetEnable(handles)
%guiResetEnable ����ʹ��
set(handles.button_startIgsDemo, 'Enable', 'on');   % ʹ�ܡ���ʼ��ʾIGS�������̡���ť
set(handles.button_next, 'Enable', 'off');            % ���á���һ������ť
set(handles.slider_quantizingBits, 'Enable', 'on');  % ʹ������λ��ѡ�񻬶���
set(handles.togglebutton_selectDemoSource, 'Enable', 'on'); % ʹ��ģʽѡ��ť
togglebutton_state = get(handles.togglebutton_selectDemoSource, 'Value');
if togglebutton_state == 0   % ���£�ѡ���������е�ͼ��
    set(handles.edit_igsDemoLine,  'Enable', 'on') ;     % ʹ�ܡ������������
    set(handles.edit_igsDemoPixels, 'Enable', 'on');  % ʹ�ܡ��������������
    set(handles.edit_customSrc, 'Enable', 'off');   % ʹ���Զ����������������
else    % ����ѡ���Զ�������
    set(handles.edit_igsDemoLine,  'Enable', 'off') ;     % ʹ�ܡ������������
    set(handles.edit_igsDemoPixels, 'Enable', 'off');  % ʹ�ܡ��������������
    set(handles.edit_customSrc, 'Enable', 'on');   % ʹ���Զ����������������
end
    
%--------------------------------------------------------------------------
function guiResetVisible(handles)
%guiResetVisible ����ɼ���
h_source_settings_group = [handles.text_demoDataSourceSetting_line_1; ...
                           handles.edit_igsDemoLine; ...
                           handles.text_demoDataSourceSetting_line_2; ...
                           handles.text_demoDataSourceSetting_pixels_1; ...
                           handles.edit_igsDemoPixels; ...
                           handles.text_demoDataSourceSetting_pixels_2];
set(h_source_settings_group, 'Visible', 'on');
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
function str_out = precedingZeros(str_in, len)
%precedingZeros ��������ַ���str_in�Ŀ�ͷ���0��ʹ�������ַ����Ŀ��Ϊlen
% str_in - ������ַ���
% len    - ϣ���ﵽ�Ŀ��
% ���str_in�ĳ����Ѿ�>=length�Ļ�����ʲôҲ������ԭ�����
len_to_fill = len - length(str_in(1,:)) ;
if ( len_to_fill > 0)
    str_out = strcat(char(zeros(1,len_to_fill)+48), str_in);
else
    str_out = str_in;
end
%--------------------------------------------------------------------------
function vector = evalUserInput(str)
%evalUserInput ����û�������Զ�����������С�����û�����������ͱ���
% ����Ͱ��û�����Ķ�������ת��Ϊ��Ӧ��ʮ����������
% str    -  char�Ͷ�ά���顣�����û���������С��˶�ά�����Ȳ��ܳ���8��
% vector -  uint8��������
[m, n] = size(str);
if n > 8 || n < 1
    errordlg('��Ӧ������8λ��������','����','modal');
    error('��Ӧ������8λ��������');
elseif m <= 0
    errordlg('���벻��Ϊ��','����','modal');
    error('���벻��Ϊ��');
else
    try
        vector = bin2dec(str);
    catch exception
        errordlg('����������������','����','modal');
        error('����������������');
    end
end
%--------------------------------------------------------------------------

%----------------------------�ǻص����� end--------------------------------
%--------------------------------------------------------------------------
%                              �ص�����
%--------------------------------------------------------------------------

function button_startIgsDemo_Callback(hObject, eventdata, handles)
% ���� handles.table_igs_demo��Data���MAT_IGS_DEMO��ϵ��˵����
% MAT_IGS_DEMOΪhandles.table_igs_demo��Data���ṩ����̨���ݡ�
% ���м��㶼�Ƕ�MAT_IGS_DEMO���еģ�MAT_IGS_DEMO�������֮��ͨ���Ա�Ľ�
% ��ת����������handles.table_igs_demo��Data����Ҫ��������ʽ��
global IMG_SRC;
global QUANTIZING_BITS;
global MAT_IGS_DEMO;
global IGS_DEMO_LINE;
global IGS_DEMO_PIXELS;
global IGS_DEMO_DATA;

% disp('----> timer Z starts');tic;
% �����ʾʵ���������������������޸ģ���ôҪ���û���������������
set(handles.slider_quantizingBits, 'Value', QUANTIZING_BITS);
set(handles.text_quatizingBits, 'String', num2str(QUANTIZING_BITS));

button_state = get(handles.togglebutton_selectDemoSource, 'Value');

% disp('--> timer 11 starts');tic;
if button_state == 0    % ��ť���£�ѡ���������е�ͼ��Ϊ��ʾ����Դ
    % �����������м�鲢��������Ĺ���
    edit_igsDemoLine_Callback(hObject, eventdata, handles);
    edit_igsDemoPixels_Callback(hObject, eventdata, handles);
    local_img_src = IMG_SRC;
    local_igs_demo_pixels = IGS_DEMO_PIXELS;
    % ��ʼ��ʾ֮ǰ���������������Ҫ������ȫ�����
    [igs_code, igs_sum] = igsQuantize(local_img_src(IGS_DEMO_LINE,1:IGS_DEMO_PIXELS), ...
                                      QUANTIZING_BITS);
else    % ��ť����ѡ���Զ�������Ϊ��ʾ����Դ
%     msgbox('Custom source');
    sequence = get(handles.edit_customSrc, 'String');
    local_img_src = evalUserInput(sequence);
    local_img_src = local_img_src';    % ��������������
    local_igs_demo_pixels = length(local_img_src);
    set(handles.edit_customSrc, 'Userdata', local_igs_demo_pixels);
    [igs_code, igs_sum] = igsQuantize(local_img_src(1:local_igs_demo_pixels), ...
                                      QUANTIZING_BITS);
end
% toc;disp('--- timer 11 ends');

% ���ƿؼ�
set(handles.button_startIgsDemo,'Enable','off');  % ���á���ʼ��ʾIGS�������̡���ť
set(handles.button_next,'Enable','on');           % ʹ�ܡ���һ������ť
set(handles.slider_quantizingBits, 'Enable', 'off');  % ��������λ��ѡ�񻬶���
set(handles.edit_igsDemoLine,  'Enable', 'off');     % ���á������������
set(handles.edit_igsDemoPixels, 'Enable', 'off');  % ��ֹ����ʾ�������趨�������
set(handles.togglebutton_selectDemoSource, 'Enable', 'off'); % ����ģʽѡ��ť

% ׼��������ɣ���Ϸ��ʼ
    % IGS_DEMO_DATA��ǰ̨������ݣ�MAT_IGS_DEMO�Ǻ�̨�������
    % ��1�б�ʾ�Ҷȼ�
    % ��2�б�ʾ��
    % ��3�б�ʾIGS����ֵ
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
% ��һ����ʵû��ʲô�ر�֮���������Ͼ��ǲ�ͣ���������ݸ���
% handles.table_igsDemo�е�Data��
% �����˵�������õ�����������Ԫ����
% MAT_IGS_DEMO    -  ��Ļ����Ա��
% IGS_DEMO_DATA   -  û��HTML��ǵ��м����ݡ��Ѿ�����ͨ��set��handles.table_igsDemo�е�Data��
% demo_data_html  -  ��ǰ̨���ݳ����������Ƕ�IGS_DEMO_DATA�Ŀ����������й���������һЩ�޸ġ�
global QUANTIZING_BITS;
global BUTTON_NEXT_CURRENT_CNT; % ����һ������ť������
global MAT_IGS_DEMO;
global IGS_DEMO_DATA;
global IGS_DEMO_PIXELS;    % ��ʾ�������������趨

% ����������
BUTTON_NEXT_CURRENT_CNT = BUTTON_NEXT_CURRENT_CNT + 1;

togglebutton_state = get(handles.togglebutton_selectDemoSource, 'Value');
if togglebutton_state == 0    % ��ť���£�ѡ���������е�ͼ��Ϊ��ʾ����Դ
    local_igs_demo_pixels = IGS_DEMO_PIXELS;
else    % ��ť����ѡ���û���������Ϊ��ʾ����Դ
    local_igs_demo_pixels = get(handles.edit_customSrc, 'Userdata');
end


if BUTTON_NEXT_CURRENT_CNT <= local_igs_demo_pixels
    current_line = BUTTON_NEXT_CURRENT_CNT + 1;
%     disp('----> timer X starts');tic;
    % �����2��
    sum_str = dec2bin(MAT_IGS_DEMO(current_line,2));
    sum_str = precedingZeros(sum_str, 8);
    IGS_DEMO_DATA{current_line, 2} = sum_str;

    tmp = bitsrl(MAT_IGS_DEMO(current_line,3), 8-QUANTIZING_BITS);   % �˴�tmp���������ڴ��к���һ�г��֣������ط���û����
    igs_code = dec2bin(tmp);    % ʹ��tmp��������Ϊֱ�Ӱ���ôһ��д��dec2bin�Ĳ������������������������
    igs_code = precedingZeros(igs_code, QUANTIZING_BITS);
    IGS_DEMO_DATA{current_line, 3} = igs_code;
    demo_data_html = IGS_DEMO_DATA;  % ����IGS_DEMO_DATA


    % ʹ��HTML������ɫ�ȵ�
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
    if is_msb_all_ones    % �߼�λȫ��1
        demo_data_html{current_line,1} = strcat('<html><body><span style="color: red;">', ...
                                                str_gray_1_current_line, ...
                                                '</span>', ...
                                                str_gray_2_current_line, ...
                                                '</body></html>');
    else                  % �߼�λ��ȫ��1
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
    % ��������λ
    BUTTON_NEXT_CURRENT_CNT = 0;
    guiResetEnable(handles);    % �ؼ�ʹ������
end

function button_reset_Callback(hObject, eventdata, handles)
guiResetAll(handles);


function slider_quantizingBits_Callback(hObject, eventdata, handles)
global QUANTIZING_BITS;
QUANTIZING_BITS = round (get(hObject, 'Value') );  % �������룬ֻȡ����
set(hObject, 'Value', QUANTIZING_BITS);    % ʹ������ͣ����λ��Ҳֻ����������
set(handles.text_quatizingBits,'String',num2str(QUANTIZING_BITS) );


function slider_quantizingBits_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function n = edit_igsDemoPixels_Callback(hObject, eventdata, handles)
%edit_igsDemoPixelsTotal_Callback ����û�������������ַ����Ƿ�Ϸ�
% ֱ�Ӵ�handles�ж�ȡhandles.edit_igsDemoPixelsTotal��String��
% �˺���ͬʱ����ȫ�ֱ���IMG_SRCΪ������������û�Ҫ��Ĳ�������ͼ��Ŀ�ʱ��
% ��nΪͼ��Ŀ����û�Ҫ��Ĳ�����0���߸�����ʱ����nΪ1
% �������nΪ�û�������ֵ
global IMG_SRC;
global IGS_DEMO_PIXELS;
str = get(handles.edit_igsDemoPixels, 'String');
[~ ,width_of_img] = size(IMG_SRC);
n = str2double(str);
if isnan(n) || isempty(n)
    errordlg('���Ϸ��������룬����Command Window�еĴ�����Ϣ','����', 'modal');
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
%edit_igsDemoLine_Callback ����û�����������ַ����Ƿ�Ϸ�
% ֱ�Ӵ�handles�ж�ȡhandles.edit_igsDemoPixelsTotal��String��
% �˺���ͬʱ����ȫ�ֱ���IMG_SRCΪ������������û�Ҫ��Ĳ�������ͼ��ĸ�ʱ��
% ��nΪͼ��ĸߡ����û�Ҫ���������0���߸�����ʱ����nΪ1
% �������nΪ�û�������ֵ
global IMG_SRC;
global IGS_DEMO_LINE;
str = get(handles.edit_igsDemoLine, 'String');
[height_of_img, ~] = size(IMG_SRC);
n = str2double(str);
if isnan(n) || isempty(n)
    errordlg('���Ϸ��������룬����Command Window�еĴ�����Ϣ','����', 'modal');
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
%figure_imgCompressing_igs_demo_CloseRequestFcn�൱��C++�е���������
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
button_state = get(hObject,'Value');    % button_state - 0��ʾ����1��ʾ����

h_source_settings_group = [handles.text_demoDataSourceSetting_line_1; ...
                           handles.edit_igsDemoLine; ...
                           handles.text_demoDataSourceSetting_line_2; ...
                           handles.text_demoDataSourceSetting_pixels_1; ...
                           handles.edit_igsDemoPixels; ...
                           handles.text_demoDataSourceSetting_pixels_2];
if button_state == 1
    set(hObject, 'String', 'ʹ���Զ�������');
    set(handles.edit_customSrc, 'Enable', 'on');
    set(h_source_settings_group, 'Visible', 'off');
else
    set(hObject, 'String', 'ʹ���������е�ͼ��');
    set(handles.edit_customSrc, 'Enable', 'off');
    set(h_source_settings_group, 'Visible', 'on');
end
