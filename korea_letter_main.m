mat_d=zeros(14,14);
a=0.5;
for x=1:14
    for y=1:14
        if x==y
            mat_d(x,y)=1;
        end
    end
end

out_korea_mat=["ㄱ" "ㄴ" "ㄴ" "ㄹ" "ㅁ" "ㅂ" "ㅅ" "ㅇ" "ㅈ" "ㅊ" "ㅋ" "ㅌ" "ㅍ" "ㅎ"];


matrix=input_x(14,64,8);
test_matrix=input_x(9,64,8);
w_z=-0.5 + 0.5 .*rand(64,64);
w_y=-0.5 + 0.5 .*rand(14,64);
d=zeros(1,14);
%은닉층과 출력층
hide_la=zeros(1,64);
out=zeros(1,14);
%오차 배열
ceta_y=zeros(1,14);
ceta_z=zeros(1,64);
%가중치 배열
ch_w_y=zeros(14,64);
ch_w_z=zeros(64,64);
E=1;
while E > 0.001
E=0;
for i=1:14
    %%활성화 함수
    for x=1:14
        d(x)=mat_d(i,x);
    end
    for x=1:64
        netx=0;
        for y=1:64
        netx=netx+matrix(i,y)*w_z(x,y);
        end
        hide_la(x)=1/(1+exp(-netx));
    end
    
    for x=1:14
        nety=0;
        for y=1:64
            nety=nety+hide_la(y)*w_y(x,y);
        end
        out(x)=1/(1+exp(-nety));
        
    end
    
    %%%%오차 제곱
    for x=1:14
        e=0.5*(d(x)-out(x))*(d(x)-out(x));
        E=E+e;
        
    end
    ceta_y_pl=0;
    %%%오차
    for x=1:14
        ceta_y(x)=(d(x)-out(x))*out(x)*(1-out(x));
        %%ceta_y_pl=ceta_y_pl+ceta_y(x);
    end
    %%w_y_pl=zeros(1,64);
    %%for x=1:64
        %%%%w_y_pl(x)=w_y_pl(x)+w_y(y,x);
        %%end
    %%end
    sub=zeros(1,64);
    for x=1:14
        for y=1:64
            sub(y)=sub(y)+ceta_y(x)*w_y(x,y);
        end
    end
    
    
        for y=1:64
            ceta_z(y)=hide_la(y)*(1-hide_la(y))*sub(y);
        end
    
    
    
    %%가중치 구하기
    for x=1:14
        for y=1:64
            ch_w_y(x,y)=a*hide_la(y)*ceta_y(x);
        end
    end
    
    for x=1:64
        for y=1:64
            ch_w_z(x,y)=a*matrix(i,y)*ceta_z(x);
        end
    end
    
    %%변화량과 원래 값 더하기
    
     for x=1:14
        for y=1:64
            w_y(x,y)=w_y(x,y)+ch_w_y(x,y);
            
        end
     end
    for x=1:64
        for y=1:64
           w_z(x,y)=w_z(x,y)+ch_w_z(x,y);
        end
    end
    
    
end
fprintf("오류의 값은? %.4f\n",E);
end

for i=1:9
    for x=1:64
        netx=0;
        for y=1:64
        netx=netx+test_matrix(i,y)*w_z(x,y);
        end
        hide_la(x)=1/(1+exp(-netx));
    end
    res="";
    for x=1:14
        nety=0;
        for y=1:64
            nety=nety+hide_la(y)*w_y(x,y);
        end
        out(x)=1/(1+exp(-nety));
        fprintf("1번의 출력값은 %.2f",out(x));
        
        if out(x)>=0.7
             res=out_korea_mat(x);
                
        end
                
        
        
            
    end
    
    fprintf("%s이다\n",res);
end







