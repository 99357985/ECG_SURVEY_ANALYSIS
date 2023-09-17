sig=load('./data/7.txt');% change to load other files 
len = length(sig);
fs = 200;
tm=(1:length(sig))/fs;
figure();
subplot(3,2,1);plot(tm(1:1800),sig(1:1800));ylabel('Raw signal')
% lowpass
B=[1 0 0 0 0 0 -2 0 0 0 0 0 1];
A=[1 -2 1];
sig_L=filter(B,A,sig);
subplot(3,2,2);plot(tm(1:1800),sig_L(1:1800));ylabel('After lowpass');
% highpass
B=[-1/32 zeros(1,15) 1 -1 zeros(1,14) 1/32];
A=[1 -1];
sig_h=filter(B,A,sig_L);
subplot(3,2,3);plot(tm(1:1800),sig_h(1:1800));ylabel('After highpass');
% difference
B=1/8*[2 1 0 -1 -2];
A=[1];
sig_d=filter(B,A,sig_h);
subplot(3,2,4);plot(tm(1:1800),sig_d(1:1800));ylabel('Derivative')
% square
sig_s=sig_d.^2;
subplot(3,2,5);plot(tm(1:1800),sig_s(1:1800));ylabel('Squaring')
% window average
N=round(0.15*fs);
B=1/N*ones(1,N);
A=[1];
sig_w=filter(B,A,sig_s);
subplot(3,2,6);plot(tm(1:1800),sig_w(1:1800));ylabel('Window Integration')
