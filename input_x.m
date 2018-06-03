function result=input_x(i,j,l)
matrix=zeros(i,j);
input_mat=input_func();
test_mat=output_func();
for z=1:i
    for x=1:l
        for y=1+l*(x-1):l+l*(x-1)
            if y<=l
                if i==14
            matrix(z,y)=input_mat(x,y+(z*l)-l);
                
                else
                    matrix(z,y)=test_mat(x,y+(z*l)-l);
                end
            elseif y>l
                if i==14
                matrix(z,y)=input_mat(x,y-l*(x-1)+(z*l)-l);
                else
                    matrix(z,y)=test_mat(x,y-l*(x-1)+(z*l)-l);
                end
            end
            
        
        end
        
    end
   
end
result=matrix;
end