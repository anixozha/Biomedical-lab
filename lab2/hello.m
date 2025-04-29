load mit200;
subplot(211);
plot(ecgsig);
cleanECG=ecgsig(3640:6197);
timecleanECG=tm(3640:6197);
subplot(212);
plot(cleanECG)