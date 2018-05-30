function result = input_func(input_ref)
input=imread(input_ref);
ko_letter=rgb2gray(input);
[row,col]=size(ko_letter);

for x=1:row
    for y=1:col
       if ko_letter(x,y)== 0
           ko_letter(x,y)=1;
       else
           ko_letter(x,y)=0;
       end
    end
end
result=ko_letter;
end
