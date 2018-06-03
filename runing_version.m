mat_d=zeros(14,14);
b=0.85;
a=0.02;
for x=1:14
    for y=1:14
        if x==y
            mat_d(x,y)=1;
        end
    end
end
count=0;

matrix=input_x();
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
while E >= 0.001
    count=count+1;
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
        e=(1/14)*(d(x)-out(x))*(d(x)-out(x));
        E=E+e;
        
    end
    ceta_y_pl=0;
    %%%오차
    for x=1:14
        ceta_y(x)=(d(x)-out(x))*out(x)*(1-out(x));
        ceta_y_pl=ceta_y_pl+ceta_y(x);
    end
    w_y_pl=zeros(1,64);
    for x=1:64
        for y=1:14
        w_y_pl(x)=w_y_pl(x)+w_y(y,x);
        end
    end
    
    
        for y=1:64
            ceta_z(y)=hide_la(y)*(1-hide_la(y))*w_y_pl(y)*ceta_y_pl;
        end
    
    
    
    %%가중치 구하기
    for x=1:14
        for y=1:64
            ch_w_y(x,y)=(b*ch_w_y(x,y))+(a*hide_la(y)*ceta_y(x));
        end
    end
    
    for x=1:64
        for y=1:64
            ch_w_z(x,y)=(b*ch_w_z(x,y))+(a*matrix(i,y)*ceta_z(x));
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
fprintf("반복횟수의 값은? %d\n",count);
end
