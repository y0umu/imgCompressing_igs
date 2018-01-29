#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <opencv2\opencv.hpp>
#define PROGRAM_NAME igs_demo

using namespace cv;
using namespace std;
//--------------------------------------------------------
// ����������
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

	// ��Ƭ��ʼ~
	uchar lo, hi;	// ��λ����͸�λ����
	uchar b;		// ����λ��
	uchar s;		// �洢��ֵ

	b = (uchar)atoi(argv[1]);
	hi = ((0x01 << b) - 1) << (8 - b);    // ����ȡ����λ�����룬��b = 4��lo = 00001111
	lo = (uchar)255 - hi;  // ����ȡ����λ�����룬��b = 4��hi = 11110000

	for (int i = 0; i < img_src.rows; ++i)
	{
		s = 0;
		uchar *p = img_src.ptr<uchar>(i);
		uchar *q = img_igs.ptr<uchar>(i);
		for (int j = 0; j < img_src.cols; ++j)
		{
			if ((p[j] & hi) == hi )
				s = p[j];	// ���������ԭ����ֵ��λȫΪ1
			else
				s = (s & lo) + p[j];	// �µĺ�ֵ�ɾɵĺ�ֵ�ĵ�(8-b)λ�뵱ǰ������Ӳ���
			q[j] = s & hi;
		}
	}
	imshow("Original image", img_src);
	imshow("Processed image", img_igs);
	waitKey(0);

	return 0;
}