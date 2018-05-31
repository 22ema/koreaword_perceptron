function result=input_x()
matrix=zeros(14,64);
input_mat=input_func();

for z=1:14
    for x=1:8
        for y=1+8*(x-1):8+8*(x-1)
            if y<=8
            matrix(z,y)=input_mat(x,y+(z*8)-8);
            elseif y>8
                matrix(z,y)=input_mat(x,y-8*(x-1)+(z*8)-8);
            end
            
        
        end
        
    end
   
end
result=matrix;
end