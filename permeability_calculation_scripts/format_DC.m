DC(:,1) = [-1.6:0.2:1.4] - 1;
%%
dc(:,1) = DC_from_XACF('xacf20/conf%d_xacf_1.xvg',16);
dc(:,2) = DC_from_XACF('xacf20/conf%d_xacf_2.xvg',16);
dc(:,3) = DC_from_XACF('xacf20/conf%d_xacf_3.xvg',16);
dc(:,4) = DC_from_XACF('xacf20/conf%d_xacf_4.xvg',16);
%dc = circshift(dc,1)
plot(DC(:,1),dc)
DC(:,2) = mean(dc,2);
DC(:,3) = std(dc,[],2); %/sqrt(size(dc,2));
errorbar(DC(:,1),DC(:,2),DC(:,3))
%%
out = DC;
in = DC ;
in(in(:,1) > 0, :) = [];
out(out(:,1) > 0, :) = [];
in(:,1) = abs(in(:,1));
in = flip(in);
in(1,:) = [];
DC = [out;in];
save DC.mat DC;
csvwrite('DC.csv', DC)
errorbar(DC(:,1),DC(:,2),DC(:,3))