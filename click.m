#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <iostream>
#include <vector>
#include <time.h>
#include <algorithm>
#include "opencv2/imgproc/imgproc.hpp"
#include "chessboard.h"
#include <fstream>

#include "opencv2/video/background_segm.hpp"
#include "opencv2/video/tracking.hpp"

//#include <ApplicationServices/ApplicationServices.h>
//#include <unistd.h>
 
using namespace cv;
using namespace std;

vector<string> chessboard_notate(){

  vector<string> chessboard_notation;

  chessboard_notation.push_back("a8");chessboard_notation.push_back("b8");chessboard_notation.push_back("c8");chessboard_notation.push_back("d8");
  chessboard_notation.push_back("e8");chessboard_notation.push_back("f8");chessboard_notation.push_back("g8");chessboard_notation.push_back("h8");

  chessboard_notation.push_back("a7");chessboard_notation.push_back("b7");chessboard_notation.push_back("c7");chessboard_notation.push_back("d7");
  chessboard_notation.push_back("e7");chessboard_notation.push_back("f7");chessboard_notation.push_back("g7");chessboard_notation.push_back("h7");

  chessboard_notation.push_back("a6");chessboard_notation.push_back("b6");chessboard_notation.push_back("c6");chessboard_notation.push_back("d6");
  chessboard_notation.push_back("e6");chessboard_notation.push_back("f6");chessboard_notation.push_back("g6");chessboard_notation.push_back("h6");

  chessboard_notation.push_back("a5");chessboard_notation.push_back("b5");chessboard_notation.push_back("c5");chessboard_notation.push_back("d5");
  chessboard_notation.push_back("e5");chessboard_notation.push_back("f5");chessboard_notation.push_back("g5");chessboard_notation.push_back("h5");

  chessboard_notation.push_back("a4");chessboard_notation.push_back("b4");chessboard_notation.push_back("c4");chessboard_notation.push_back("d4");
  chessboard_notation.push_back("e4");chessboard_notation.push_back("f4");chessboard_notation.push_back("g4");chessboard_notation.push_back("h4");

  chessboard_notation.push_back("a3");chessboard_notation.push_back("b3");chessboard_notation.push_back("c3");chessboard_notation.push_back("d3");
  chessboard_notation.push_back("e3");chessboard_notation.push_back("f3");chessboard_notation.push_back("g3");chessboard_notation.push_back("h3");

  chessboard_notation.push_back("a2");chessboard_notation.push_back("b2");chessboard_notation.push_back("c2");chessboard_notation.push_back("d2");
  chessboard_notation.push_back("e2");chessboard_notation.push_back("f2");chessboard_notation.push_back("g2");chessboard_notation.push_back("h2");

  chessboard_notation.push_back("a1");chessboard_notation.push_back("b1");chessboard_notation.push_back("c1");chessboard_notation.push_back("d1");
  chessboard_notation.push_back("e1");chessboard_notation.push_back("f1");chessboard_notation.push_back("g1");chessboard_notation.push_back("h1");

  return chessboard_notation;
}

vector<string> board_square_occupied(){

  vector<string> square_occupied;
  for(int x = 0; x < 64; x++){
    square_occupied.push_back("x");
  }
  return square_occupied;
}

void crop_screenshot(Mat image){

  //prepare to cut the layout of the chesboard from the screenshot take
  //this till needs to be refined, see what you get on the other computers and take it from there
  int x = 88;
  int y = 90;
  int x1 = 200;
  int y1 = 114;
  int x2 = 717;
  int y2 = 717;
  Rect cut_chessboard(x1, y1, x2, y2);
  rectangle(image, cut_chessboard, Scalar(255), 1, 1, 0);
  Mat chessboard = image(cut_chessboard);

  Size size(640,640);
  Mat dst_chessboard;//dst image
  resize(chessboard,dst_chessboard,size);//resize image
  imwrite("chessboard.png",dst_chessboard);

}

//chess pieces names
vector<string> get_chess_pieces_name(){
  vector<string> chess_pieces_name;
  
  for(int x  = 0; x < 2; x++){
    string piece_colour;
    if(x < 1)piece_colour = "black";
    else piece_colour = "white";
    chess_pieces_name.push_back(piece_colour + "_rook");
    chess_pieces_name.push_back(piece_colour + "_horse");
    chess_pieces_name.push_back(piece_colour + "_bishop");
    chess_pieces_name.push_back(piece_colour + "_queen");
    chess_pieces_name.push_back(piece_colour + "_king");
    chess_pieces_name.push_back(piece_colour + "_pawn");
  }
  return chess_pieces_name;
}
              
vector<Mat> get_chessboard_squares_mat(){
  vector<Mat> chessboard_squares_mat; 
  for(int x = 0;x < 64; x++)
  {
      //chessboard_squares_mat.push_back(image3(chessboard_squares[x]));
  }
  return chessboard_squares_mat;
}

string get_chessboard_square(Point location)
{
  int x = location.x;
  int y = location.y;
  string chessboard_square;

  if( x > 0 and x< 80){
    chessboard_square = "a";
  }
  if( x > 80 and x < 160){
    chessboard_square = "b";
  }
  if( x > 160 and x < 240){
    chessboard_square = "c";
  }
  if( x > 240 and x < 320){
    chessboard_square = "d";
  }
  if( x > 320 and x < 400){
    chessboard_square = "e";
  }
  if( x > 400 and x < 480){
    chessboard_square = "f";
  }
  if( x > 480 and x < 560){
    chessboard_square = "g";
  }
  if( x > 560 and x < 640){
    chessboard_square = "h";
  }

  if( y > 0 and y < 80){
    chessboard_square = chessboard_square + "8";
  }
  if( y > 80 and y < 160){
    chessboard_square = chessboard_square + "7";
  }
  if( y > 160 and y < 240){
    chessboard_square = chessboard_square + "6";
  }
  if( y > 240 and y < 320){
    chessboard_square = chessboard_square + "5";
  }
  if( y > 320 and y < 400){
    chessboard_square = chessboard_square + "4";
  }
  if( y > 400 and y < 480){
    chessboard_square = chessboard_square + "3";
  }
  if( y > 480 and y < 560){
    chessboard_square = chessboard_square + "2";
  }
  if( y > 560 and y < 640){
    chessboard_square = chessboard_square + "1";
  }
  
  return chessboard_square;
}

int match(string filename, string templatename, vector<string> &chessboard_notation, vector<string> &square_occupied)
{
    string piece_name;

    //vector<string> chessboard_notation = chessboard_notate();
    //vector<string> square_occupied = board_square_occupied();

    if(templatename == "black_rook")piece_name = "r";
    else if(templatename == "black_horse")piece_name = "n";
    else if(templatename == "black_bishop")piece_name = "b";
    else if(templatename == "black_queen")piece_name = "q";
    else if(templatename == "black_king")piece_name = "k";
    else if(templatename == "black_pawn")piece_name = "p";
    else if(templatename == "white_rook")piece_name = "R";
    else if(templatename == "white_horse")piece_name = "N";
    else if(templatename == "white_bishop")piece_name = "B";
    else if(templatename == "white_queen")piece_name = "Q";
    else if(templatename == "white_king")piece_name = "K";
    else if(templatename == "white_pawn")piece_name = "P";

    bool match_found = false;
    Mat ref = cv::imread(filename + ".png");
    Mat tpl = cv::imread(templatename + ".png");
    if (ref.empty() || tpl.empty())
    {
        cout << "Error reading file(s)!" << endl;
        return -1;
    }

    //imshow("file", ref);
    //imshow("template", tpl);

    Mat res_32f(ref.rows - tpl.rows + 1, ref.cols - tpl.cols + 1, CV_32FC1);
    matchTemplate(ref, tpl, res_32f, CV_TM_CCOEFF_NORMED);

    Mat res;
    res_32f.convertTo(res, CV_8U, 255.0);
    //imshow("result", res);

    int size = ((tpl.cols + tpl.rows) / 4) * 2 + 1; //force size to be odd
    adaptiveThreshold(res, res, 255, ADAPTIVE_THRESH_MEAN_C, THRESH_BINARY, size, -128);
    //imshow("result_thresh", res);

    while (true) 
    {
        double minval, maxval, threshold = 0.8;
        Point minloc, maxloc;
        minMaxLoc(res, &minval, &maxval, &minloc, &maxloc);

        if (maxval >= threshold)
        {
            rectangle(ref, maxloc, Point(maxloc.x + tpl.cols, maxloc.y + tpl.rows), CV_RGB(0,255,0), 2);
            floodFill(res, maxloc, 0); //mark drawn blob
            match_found = true;
            //cout<<piece_name<<" at "<<get_chessboard_square(maxloc)<<endl;
            //cout << chessboard_notation.find(chessboard_notation.begin(),chessboard_notation.end(),get_chessboard_square(maxloc)) - chessboard_notation.begin()<<endl;
            std::vector<string>::const_iterator it = std::find(chessboard_notation.begin(), chessboard_notation.end(), get_chessboard_square(maxloc));
            //cout<<**it;

            for(int x = 0; x < 64; x++){
              if(chessboard_notation[x] == get_chessboard_square(maxloc)){
                square_occupied[x] = piece_name;
                //cout<<"matched at element "<<x<<endl;
              }
            }
        }
        else
            break;
    }

    //imshow("final", ref);
    //waitKey(0);

    return 0;
}

bool move_made()
{
    bool match_found = false;
    Mat ref = cv::imread("chessboard.png");
    Mat tpl = cv::imread("moved.png");
    if (ref.empty() || tpl.empty())
    {
        cout << "Error reading file(s)!" << endl;
        return -1;
    }

    //imshow("file", ref);
    //imshow("template", tpl);

    Mat res_32f(ref.rows - tpl.rows + 1, ref.cols - tpl.cols + 1, CV_32FC1);
    matchTemplate(ref, tpl, res_32f, CV_TM_CCOEFF_NORMED);

    Mat res;
    res_32f.convertTo(res, CV_8U, 255.0);
    //imshow("result", res);

    int size = ((tpl.cols + tpl.rows) / 4) * 2 + 1; //force size to be odd
    adaptiveThreshold(res, res, 255, ADAPTIVE_THRESH_MEAN_C, THRESH_BINARY, size, -128);
    //imshow("result_thresh", res);

    while (true) 
    {
        double minval, maxval, threshold = 0.8;
        Point minloc, maxloc;
        minMaxLoc(res, &minval, &maxval, &minloc, &maxloc);

        if (maxval >= threshold)
        {
            rectangle(ref, maxloc, Point(maxloc.x + tpl.cols, maxloc.y + tpl.rows), CV_RGB(0,255,0), 2);
            floodFill(res, maxloc, 0); //mark drawn blob
            match_found = true;

        }
        else{
            match_found = false;
            break;
          }
    }

    //imshow("final", ref);
    //waitKey(0);

    return match_found;
}

string get_FEN_string(vector<string> rank)
{

  string FEN_string;
  int count = 0;
  for(int x = 0; x < 8; x++){
      if(rank[x] != "1"){
        if( count == 0)FEN_string = FEN_string + rank[x];
        else FEN_string = FEN_string + to_string(count) + rank[x];
        count = 0;
      }
      if(rank[x] == "1"){
        count++;
      }
      if(rank[x] == "1" and x == 7){
        FEN_string = FEN_string + to_string(count);
      }
  }
  return FEN_string;
}

void ranks(vector<string> square_occupied,vector<string> &rank_8, vector<string> &rank_7, vector<string> &rank_6, vector<string> &rank_5,vector<string> &rank_4, vector<string> &rank_3, vector<string> &rank_2, vector<string> &rank_1){
      for(int x = 0; x < 8; x++){
          if(square_occupied[x] =="x"){
            rank_8.push_back("1");
          }
          else
          rank_8.push_back(square_occupied[x]);
      }
      for(int x = 8; x < 16; x++){
          if(square_occupied[x] =="x"){
            rank_7.push_back("1");
          }
          else
          rank_7.push_back(square_occupied[x]);
      }
      for(int x = 16; x < 24; x++){
          if(square_occupied[x] =="x"){
            rank_6.push_back("1");
          }
          else
          rank_6.push_back(square_occupied[x]);
      }
      for(int x = 24; x < 32; x++){
          if(square_occupied[x] =="x"){
            rank_5.push_back("1");
          }
          else
          rank_5.push_back(square_occupied[x]);
      }
      for(int x = 32; x < 40; x++){
          if(square_occupied[x] =="x"){
            rank_4.push_back("1");
          }
          else
          rank_4.push_back(square_occupied[x]);
      }
      for(int x = 40; x < 48; x++){
          if(square_occupied[x] =="x"){
            rank_3.push_back("1");
          }
          else
          rank_3.push_back(square_occupied[x]);
      }
      for(int x = 48; x < 56; x++){
          if(square_occupied[x] =="x"){
            rank_2.push_back("1");
          }
          else
          rank_2.push_back(square_occupied[x]);
      }
      for(int x = 56; x < 64; x++){
          if(square_occupied[x] =="x"){
            rank_1.push_back("1");
          }
          else
          rank_1.push_back(square_occupied[x]);
      }
}

void take_screenshot()
{
  string command = "./screenshot.sh";
  system(command.c_str());
}

void move_piece(string move)
{
  string current_x = move.substr(0,1);
  string current_y = move.substr(1,1);
  string new_x = move.substr(2,1);
  string new_y = move.substr(3,1);

  int from_x;
  int from_y;
  int to_x;
  int to_y;

  //cout<<move<<endl;

  //cout<<current_x<<":"<<current_y<<endl;

  if(current_x == "a"){
    from_x = 246;
  }else if(current_x == "b"){
    from_x = 336;
  }else if(current_x == "c"){
    from_x = 425;
  }else if(current_x == "d"){
    from_x = 514;
  }else if(current_x == "e"){
    from_x = 604;
  }else if(current_x == "f"){
    from_x = 693;
  }else if(current_x == "g"){
    from_x = 783;
  }else if(current_x == "h"){
    from_x = 872;
  }

  if(current_y == "1"){
    from_y = 804;
  }else if(current_y == "2"){
    from_y = 714;
  }else if(current_y == "3"){
    from_y = 625;
  }else if(current_y == "4"){
    from_y = 536;
  }else if(current_y == "5"){
    from_y = 446;
  }else if(current_y == "6"){
    from_y = 356;
  }else if(current_y == "7"){
    from_y = 267;
  }else if(current_y == "8"){
    from_y = 179;
  }

  if(new_x == "a"){
    to_x = 246;
  }else if(new_x == "b"){
    to_x = 336;
  }else if(new_x == "c"){
    to_x = 425;
  }else if(new_x == "d"){
    to_x = 514;
  }else if(new_x == "e"){
    to_x = 604;
  }else if(new_x == "f"){
    to_x = 693;
  }else if(new_x == "g"){
    to_x = 783;
  }else if(new_x == "h"){
    to_x = 872;
  }

  if(new_y == "1"){
    to_y = 804;
  }else if(new_y == "2"){
    to_y = 714;
  }else if(new_y == "3"){
    to_y = 625;
  }else if(new_y == "4"){
    to_y = 536;
  }else if(new_y == "5"){
    to_y = 446;
  }else if(new_y == "6"){
    to_y = 356;
  }else if(new_y == "7"){
    to_y = 267;
  }else if(new_y == "8"){
    to_y = 179;
  }

  //cout<<from_x<<":"<<from_y<<endl;

  ofstream myfile;
  myfile.open ("move_piece.sh");
  myfile << "#!/bin/sh"<<endl;
  myfile << "./cliclick "<<"dd:"<<from_x<<","<<from_y<<" w:100 "<<"du:"<<to_x<<","<<to_y;
  myfile.close();
  string command = "./move_piece.sh";
  system(command.c_str());

  //./cliclick dd:604,714 w:100 du:604,536
}
 
int main( )
{
  int move_count_white = 0;
  int move_count_black = 0;

  string FEN;
  string previous_FEN_sring;

  string starting_position = "position fen rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1";
  string empty_FEN = "position fen 8/8/8/8/8/8/8/8 w KQkq - 0 1";
  string move;
  string previous_move;

  //string command = "./startup.sh";
  //system(command.c_str());

  while(1)
  {
    take_screenshot();
    clock_t tStart = clock();
    string colour_to_move = "b";
    string white_castle_kingside = "K";
    string white_castle_queenside = "Q";
    string black_castle_kingside = "k";
    string black_castle_queenside = "q";
    string FEN_string;
    vector<string> chessboard_notation = chessboard_notate();
    vector<string> square_occupied = board_square_occupied();

    vector<string> rank_8, rank_7, rank_6, rank_5, rank_4, rank_3, rank_2, rank_1;

    Mat image0;
    // LOAD image
    image0 = imread("./background.png", CV_LOAD_IMAGE_COLOR);  
    //image1 = imread("1.png", CV_LOAD_IMAGE_COLOR);

    if(!image0.data)  // Check for invalid input
    {
      cout <<  "Could not open or find the image" << std::endl;
      //return -1;
    }

    if(image0.data)
    {
      crop_screenshot(image0);
      //load chessboard
      Mat chessboard_greyed = imread("./chessboard.png", CV_LOAD_IMAGE_COLOR);
      //imshow( "chessboard", chessboard_greyed ); // Show osr image inside it.

      vector<string> all_pieces_names = get_chess_pieces_name();

      for(int x = 0;x < 12; x++)
      {
          match("chessboard",all_pieces_names[x],chessboard_notation,square_occupied);
      }

      ranks(square_occupied,rank_8,rank_7,rank_6,rank_5,rank_4,rank_3,rank_2,rank_1);

      string FEN = get_FEN_string(rank_8)+"/"+get_FEN_string(rank_7)+"/"+get_FEN_string(rank_6)+"/"+get_FEN_string(rank_5)+"/"+get_FEN_string(rank_4)+"/"+get_FEN_string(rank_3)+"/"+get_FEN_string(rank_2)+"/"+get_FEN_string(rank_1);
      //string FEN = get_FEN_string(rank_3);

      FEN = "position fen " + FEN + " w KQkq - 0 1";
      //cout<<FEN<<endl;

      if(FEN == starting_position and move_count_white == 0){
        cout<<"FEN not starting position, looking for starting position"<<endl;
        cout<<FEN<<endl;
        //cout<<"go depth 5"<<endl;
        ofstream myfile;
        myfile.open ("stockfish_move.sh");
        myfile << "#!/bin/sh"<<endl;
        myfile << "("<<endl;
        myfile << "echo " << "\""<< FEN << "\""<< ";"<<endl;
        myfile << "echo " << "\""<<"go movetime 50" << "\""<<";"<<endl;
        myfile << "sleep 0.5"<<endl;
        myfile << ") | ./stockfish";
        myfile.close();
        string command = "./stockfish_move.sh | grep bestmove > bestmove.txt";
        system(command.c_str());
        move_count_white++;
        previous_FEN_sring = FEN;
      }
      else if(FEN != previous_FEN_sring and FEN != empty_FEN and move_count_white != 0){
        cout<<move_count_white<<" : ";
        cout<<FEN<<endl;
        previous_FEN_sring = FEN;
        move_count_white++;

        ofstream myfile;
        myfile.open ("stockfish_move.sh");
        myfile << "#!/bin/sh"<<endl;
        myfile << "("<<endl;
        myfile << "echo " << "\""<< FEN << "\""<< ";"<<endl;
        myfile << "echo " << "\""<<"go movetime 50" << "\""<<";"<<endl;
        myfile << "sleep 0.5"<<endl;
        myfile << ") | ./stockfish";
        myfile.close();
        string command = "./stockfish_move.sh | grep bestmove > bestmove.txt";
        system(command.c_str());
        move_count_white++;
        previous_FEN_sring = FEN;
      }
      //printf("Time taken: %.2fs\n", (double)(clock() - tStart)/CLOCKS_PER_SEC);
      //waitKey(0);               
      //return 0;
    }
      std::ifstream bestmove("bestmove.txt");
      //std::string move;
      std::getline(bestmove, move);
      if(!move.empty()){
        //cout<<move<<endl;
        move = move.substr(9,4);
        if(previous_move != move){
          cout<<move<<endl;
        }

      }else{
        //cout<<"empty"<<endl;
      }
      
      if(previous_move != move and !move.empty()){
          move_piece(move);
      }

      previous_move = move;

      if(move_made()){
        cout<<"mahlatse"<<endl;
      }

      //printf("Time taken: %.2fs\n", (double)(clock() - tStart)/CLOCKS_PER_SEC);
  }

}

