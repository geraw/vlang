#include <iostream>
#include <fstream>
#include <string>
#include <regex>

using namespace std;

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
        code = regex_replace(code, regex("([^\\\\])\\\\\\*"), string("$1if(!run(dest).compare(code)) "));

        string cmd = "g++ -o" + dest + " -xc++ -";

        FILE *in = popen(cmd.c_str(), "w");
        fwrite(code.c_str(), sizeof(char), code.length(), in);
        pclose(in);
}
