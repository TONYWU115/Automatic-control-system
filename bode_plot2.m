zeros = [];
poles = [];
gain = 1; %K

sys = zpk(zeros, poles, gain);
bode(sys);

title('Bode Plot');
grid on;