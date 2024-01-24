pmf = bsres2045bins54{:,:};
pmf(:,1) = pmf(:,1) - 1;
%%
bound = -35.06;
bound_err = 0.68;
hydration = -25.18;
hydration_err = 0.76;
dG = bound - hydration;
dG_err = bound_err + hydration_err;
%%
raised = pmf;
raised(:,2) = pmf(:,2) + dG;
raised(:,3) = pmf(:,3) + dG_err;
csvwrite('raised.csv', raised)
%%

out = raised;
in = raised;
in(in(:,1) > 0, :) = [];
out(out(:,1) > 0, :) = [];
in(:,1) = abs(in(:,1));
in = flip(in);
S2 = [out;in];
errorbar(S2(:,1), S2(:,2), S2(:,3))
%%
csvwrite('PMF.csv', S2)