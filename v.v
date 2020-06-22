#include <iostream>
#include <fstream>
#include <string>
#include <regex>

using namespace std;

#define flag "CSCML2020{**********}\n"
string run(string cmd);

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
        code = regex_replace(code, regex("([^\\\\])\\\\\\*" ), string("$1\*"));

        string cmd = "g++ -std=c++11 -o" + dest + " -xc++ -";

        FILE *in = popen(cmd.c_str(), "w");
        fwrite(code.c_str(), sizeof(char), code.length(), in);
        pclose(in);\* cout<<\yx\xy;
}

string run(string cmd) {
    string data;
    FILE * stream;
    const int max_buffer = 256;
    char buffer[max_buffer];
        cmd.append(" 2>&1");

    stream = popen(cmd.c_str(), "r");
    if (stream) {

      while (!feof(stream))
                if (fgets(buffer, max_buffer, stream) != NULL) data.append(buffer);

      pclose(stream);
    }
    return data;
}



