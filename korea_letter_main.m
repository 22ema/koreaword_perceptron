mat_d=zeros(1,14);
a=0.1;
for x=1:14
    mat_d(x)=1;
end


matrix=input_x();
w_z=-0.5 + 0.5 .*rand(64,64);
w_y=-0.5 + 0.5 .*rand(14,64);
hide_la=zeros(1,64);
out=zeros(1,14);

ceta_y=zeros(1,14);
ceta_z=zeros(14,64);
%%for
E=0;
for i=1:14
    d=mat_d(i);
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
    for x=1:14
        e=(1/14)*(d-out(x))*(d-out(x));
        E=E+e;
    end
    
    %%%¿ÀÂ÷
    for x=1:14
        ceta_y(x)=(d-out(x))*out(x)*(1-out(x));
    end
    for x=1:14
        for y=1:64
            ceta_z(x,y)=hide_la(y)*(1-hide_la(y))*w_y(x,y)*ceta_y(x);
        end
    end
    
    
    
end

