#include <iostream>
#include <fstream>
#include <string>
#include <regex>

using namespace std;

/***********************************************************************************************
/* This is a compiler of a simple c-like language called v. 
/* The language adds simple escape sequences to like \hw that expands to 'Hello World;. 
/* It compiles itself: ./v v.v 
/***********************************************************************************************/
int main(int argc, char *argv[])
{
	string source = argv[1];
	string dest = source.substr(0, source.rfind("."));

	ifstream ifs(source.c_str());
	string code;
	getline(ifs, code, (char)ifs.eof());

	code = regex_replace(code, regex("([^\\\\])\\\\xy"), string("$1\xy"));
	code = regex_replace(code, regex("([^\\\\])\\\\hw"), string("$1\hw"));
	code = regex_replace(code, regex("([^\\\\])\\\\yx"), string("$1\yx"));
	code = regex_replace(code, regex("([^\\\\])\\\\\\*"), string("$1if(!run(dest)"));

	cout << code << endl;

	string cmd = "g++ -std=c++11 -o" + dest + " -xc++ -";

	FILE *in = popen(cmd.c_str(), "w");
	fwrite(code.c_str(), sizeof(char), code.length(), in);
	pclose(in);
}
