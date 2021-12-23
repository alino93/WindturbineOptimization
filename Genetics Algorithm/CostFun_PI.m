function f =CostFun_PI(x)

R=35;
Rho=1.225;
Jr=2.96e6;
Jg=53.036;
Cls=1e5;
Kls=5.6e5;
Cr=625;
Cg=0.05;
ng=87.965;
lambda_opt=7.1;
time = 0:0.1:30;
v = 3*ones(301,1); 

a11=-Cr/Jr;
a12=0;
a13=-1/Jr;
a21=0;
a22=-Cg/Jg;
a23=1/ng/Jg;
a31=Kls-Cls*Cr/Jr;
a32=(Cls*Cg/Jg-Kls)/ng;
a33=-Cls*(Jr+ng^2*Jg)/(ng^2*Jg*Jr);

b11=1/Jr;
b12=0;
b21=0;
b22=-1/Jg;
b31=Cls/Jr;
b32=Cls/ng/Jg;

A=[a11 a12 a13;a21 a22 a23;a31 a32 a33];         % states:Wr;Wg;Tls
B=[0 b11 b12;0 b21 b22;0 b31 b32];               % inputs:v;Ta;Tem
C=[0 0 0;1 0 0;1 0 0] ;                          % outputs: Tem;Wr;Wr-Wr_opt=error
D=[0 0 1;0 0 0;-lambda_opt/R 0 0];
WT=ss(A,B,C,D);
K_pid=tf([x(1), x(2)],[1, 0]);
CLoop = lft( WT([1:3 3],1:3) , K_pid );

Ta=Rho/2*pi*R^3*0.4857/7.1*v.^2;

y = lsim(CLoop(1:3,1:2),[v,Ta],time,[1;1;0;0]);            % Generate C.L. response

Wr=lambda_opt*v(1)/R;
WrError=sumabs(y(:,3))/300/Wr;
WrVar=0;
for i=1:300
WrVar=WrVar+abs(y(i+1,2)-y(i,2))/30/Wr;
end

f=[WrError,WrVar];
end

