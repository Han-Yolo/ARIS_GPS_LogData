#include <string.h>
#include <iostream>
#include <fstream>

using namespace std;

bool read(char *buffer, int *length);

ifstream in;

int main(int argc, char *argv[])
{
	if(argc != 3)
	{
		cout << "wrong number of input arguments" << endl;
		return -1;
	}

	string inFileName = string(argv[1]);
	in.open(inFileName.c_str());

	string outFileName = string(argv[2]) + ".csv";
	ofstream out;
	out.open(outFileName.c_str());
	out << "Hour,Minute,Second";
	out << ",Latitude[deg],Latitude[min]";
	out << ",Longitude[deg],Longitude[min]";
	out << ",Status";
	out << ",Altitude[mamsl]" << endl;

	char buf[100];
 	int len;

	for(;;)
	{
		char c;
		if(!(in >> c)) break;
		if(c != '$') continue;

		if(!read(buf, &len)) break;
        if(string(buf+2, 3) != "GGA") continue;	

		if(!read(buf, &len)) break; // time
		out << string(buf, 2) << ',';
 		out << string(buf+2, 2) << ','; 
		out << string(buf+4) << ',';

		cout << "UTC: " << string(buf, 2) << ':' << string(buf+2, 2);
		cout << ' ' << string(buf+4) << endl;
		
		if(!read(buf, &len)) break; // latitude
		out << string(buf, 2) << ',';
		out << string(buf+2) << ',';

		if(!read(buf, &len)) break; // northing indcator

		if(!read(buf, &len)) break; // longitude
		out << string(buf, 3) << ',';
		out << string(buf+3) << ',';

		if(!read(buf, &len)) break; // easting indicator

		if(!read(buf, &len)) break; // status
		out << string(buf, 1) << ',';

		if(!read(buf, &len)) break; // SVs used
		if(!read(buf, &len)) break; // HDOP

		if(!read(buf, &len)) break; // altitude
		out << string(buf) << endl;
	}
	in.close();
	out.close();

	return 0;
}

bool read(char *buffer, int *length)
{
	char c = 0;
	int i = 0;
	for(;;)
	{
		if(!(in >> c)) return false;
		if((c == ',') || (i > 20)) break;
		else buffer[i] = c;
		i++;
	}
	buffer[i] = '\0';
	*length = i;
	return true;
}
