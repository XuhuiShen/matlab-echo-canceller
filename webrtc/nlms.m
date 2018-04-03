clear all;
close all;
clc;
snr=20;
order=8;
Hn =[0.8783   -0.5806    0.6537   -0.3223    0.6577   -0.0582   0.2895   -0.2710    0.1278   -0.1508    0.0238   -0.1814   0.2519   -0.0396    0.0423   -0.0152    0.1664   -0.0245   0.1463   -0.0770    0.1304   -0.0148    0.0054   -0.0381    0.0374   -0.0329    0.0313   -0.0253    0.0552  -0.0369   0.0479   -0.0073    0.0305   -0.0138    0.0152   -0.0012  0.0154   -0.0092    0.0177   -0.0161    0.0070   -0.0042  0.0051   -0.0131    0.0059   -0.0041    0.0077   -0.0034   0.0074   -0.0014    0.0025   -0.0056    0.0028   -0.0005   0.0033   -0.0000    0.0022   -0.0032    0.0012   -0.0020   0.0017   -0.0022    0.0004   -0.0011      0          0   ];
          Hn=Hn(1:order);
          N=1000;
          EE=zeros(N,1);   Loop=150;  mu=0.5;
          EE1=zeros(N,1);EE2=zeros(N,1);EE3=zeros(N,1);
   for   nn=1:Loop
          r=sign(rand(N,1)-0.5);
          output=conv(r,Hn); 
          output=awgn(output,snr,'measured');
          win=zeros(1,order); 
          win1=zeros(1,order); 
          win2=zeros(1,order); 
          win3=zeros(1,order); 
          error=zeros(1,N)';
          error1=zeros(1,N)';
          error2=zeros(1,N)';
          error3=zeros(1,N)';
          
          for i=order:N
              input=r(i:-1:i-order+1);
              y(i)=win*input;
              e=output(i)-win*input;
              e1=output(i)-win1*input;
              e2=output(i)-win2*input;
              e3=output(i)-win3*input;
              fai=0.0001; 
              if i<200
                  mu=0.32;
              else
                  mu=0.15;
              end
              win=win+0.3*e*input'/(fai+input'*input);     % 不同步长的NLMS
              win1=win1+0.8*e1*input'/(fai+input'*input);
              win2=win2+1.3*e2*input'/(fai+input'*input);
              win3=win3+1.8*e3*input'/(fai+input'*input);
              error(i)=error(i)+e^2;
              error1(i)=error1(i)+e1^2;
              error2(i)=error2(i)+e2^2;
              error3(i)=error3(i)+e3^2;
%               y1(i)=win1*input;
%               e1=output(i)-win1*input;
%               win1=win1+0.2*e1*input';                   % LMS
%               error1(i)=error1(i)+e1^2;
          end
          EE=EE+error;
          EE1=EE1+error1;
          EE2=EE2+error2;
          EE3=EE3+error3;
   end
   error=EE/Loop;
   error1=EE1/Loop;
   error2=EE2/Loop;
   error3=EE3/Loop;
   
%    figure;
%    error=10*log10(error(order:N));
%    error1=10*log10(error1(order:N));
%    plot(error,'r');
%    hold on;
%    plot(error1,'b.');
%    axis tight;
%    legend('NLMS算法','LMS算法');
%    title('NLMS算法和LMS算法误差曲线');
%    xlabel('样本');
%    ylabel('误差/dB');
%    grid on;
%    
%    figure;
%    plot(win,'r');
%    hold on;
%    plot(Hn,'b');
%    grid on;
%    axis tight;
% figure;
% subplot(2,1,1);
% plot(y,'r');
% subplot(2,1,2);
% plot(y1,'b');
    figure;
   error=10*log10(error(order:N));
   error1=10*log10(error1(order:N));
   error2=10*log10(error2(order:N));
   error3=10*log10(error3(order:N));
   hold on;
   plot(error,'r');
   hold on;
   plot(error1,'b');
  hold on;
   plot(error2,'y');
   hold on;
   plot(error3,'g');
   axis tight;
   legend('η = 0.3','η = 0.8','η = 1.3','η = 1.8');
   title('不同步长对NLMS算法的影响');
   xlabel('样本');
   ylabel('误差/dB');
   grid on;
