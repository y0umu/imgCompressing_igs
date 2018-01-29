#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <opencv2\opencv.hpp>
#define PROGRAM_NAME igs_demo

using namespace cv;
using namespace std;
//--------------------------------------------------------
// 解析命令行
bool isCmdLineOk(int argc, char** argv)
{
	int b;
	if (argc != 3)
		return false;

	try
	{
		b = atoi(argv[1]);
		if (b <= 0 || b > 8)
			return false;
	}
	catch (int e)
	{
		fprintf(stderr, "error code is %d\n", e);
		return false;
	}
	return true;
}

//--------------------------------------------------------
void help()
{
	fprintf(stderr, "Usage:\n\tigs_demo <quantizing bits> <input image>\n");
	fprintf(stderr, "where the <quantizing bits> should be an integer between 1 to 8 (includes 1 and 8)\n");
}

//--------------------------------------------------------
int main(int argc, char** argv)
{
	Mat img_src, img_igs;
	if (isCmdLineOk(argc, argv) == false)
	{
		help();
		exit(1);
	}
	img_src = imread(argv[2], IMREAD_GRAYSCALE);
	if (img_src.empty())
	{
		fprintf(stderr, "Cannot load in image \"%s\"\n", argv[1]);
		exit(2);
	}
	img_igs.create(img_src.size(), CV_8UC1);

	// 正片开始~
	uchar lo, hi;	// 低位掩码和高位掩码
	uchar b;		// 量化位数
	uchar s;		// 存储和值

	b = (uchar)atoi(argv[1]);
	hi = ((0x01 << b) - 1) << (8 - b);    // 用来取出低位的掩码，如b = 4，lo = 00001111
	lo = (uchar)255 - hi;  // 用来取出高位的掩码，如b = 4，hi = 11110000

	for (int i = 0; i < img_src.rows; ++i)
	{
		s = 0;
		uchar *p = img_src.ptr<uchar>(i);
		uchar *q = img_igs.ptr<uchar>(i);
		for (int j = 0; j < img_src.cols; ++j)
		{
			if ((p[j] & hi) == hi )
				s = p[j];	// 特殊情况：原像素值高位全为1
			else
				s = (s & lo) + p[j];	// 新的和值由旧的和值的低(8-b)位与当前像素相加产生
			q[j] = s & hi;
		}
	}
	imshow("Original image", img_src);
	imshow("Processed image", img_igs);
	waitKey(0);

	return 0;
}