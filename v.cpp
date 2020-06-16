#include <iostream>
#include <fstream>
#include <string>
//#include <regex>
#include <bits/stdc++.h>

using namespace std;

void replace_all(string &data, const string &toSearch, const string &replaceStr);

/***********************************************************************************************
/* This is a compiler of a simple c-like language called v. 
/* The language adds simple escape sequences to like \hw that expands to 'Hello World;. 
/* Compile it with: g++ -std=c++11 v.cpp -o v
/***********************************************************************************************/
int main(int argc, char *argv[])
{
	string source = argv[1];
	string dest = source.substr(0, source.rfind("."));

	ifstream ifs(source.c_str());
	string code;
	getline(ifs, code, (char)ifs.eof());

	code = regex_replace(code, regex("([^\\\\])\\\\hw"), string("$1Hello World"));

	string cmd = "g++ -std=c++11 -o" + dest + " -xc++ -";

	FILE *in = popen(cmd.c_str(), "w");
	fwrite(code.c_str(), sizeof(char), code.length(), in);
	pclose(in);
}
