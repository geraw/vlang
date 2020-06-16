#include <iostream>
#include <fstream>
#include <string>

using namespace std;

void replace_all(string &data, const string &toSearch, const string &replaceStr);

int main(int argc, char *argv[])
{
	string source = argv[1];
	string dest = source.substr(0, source.rfind("."));

	ifstream ifs(source.c_str());
	string code;
	getline(ifs, code, (char)ifs.eof());

	replace_all(code, "\\hw", "\hw");

	string cmd = "g++ -std=c++11 -o" + dest + " -xc++ -";

	FILE *in = popen(cmd.c_str(), "w");
	fwrite(code.c_str(), sizeof(char), code.length(), in);
	pclose(in); 
}

void replace_all(string &data, const string &toSearch, const string &replaceStr)
{
	size_t pos = data.find(toSearch);
	while (pos != string::npos)
	{
		if( data[pos-1] != '\\' ) {
			data.replace(pos, toSearch.size(), replaceStr);
			pos = data.find(toSearch, pos + replaceStr.size());
		}
		else {
			pos = data.find(toSearch, pos + toSearch.size());
		}
	}
}
