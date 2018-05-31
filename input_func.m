function result = input_func()
input=imread('korean_word_image\ÀÚÀ½.png');
ko_letter=rgb2gray(input);
[row,col]=size(ko_letter);

for x=1:row
    for y=1:col
       if ko_letter(x,y)> 200
           ko_letter(x,y)=0;
       else
           ko_letter(x,y)=1;
       end
    end
end
result=ko_letter;
end
