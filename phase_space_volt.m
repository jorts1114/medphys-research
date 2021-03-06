% Plots into phase space using sampled potential instead of time intervals.
% 
function [x_vals, y_vals] = phase_space_volt(u, t, dv, apd_x)

errortolerance = 0.05;

warning('off', 'Octave:possible-matlab-short-circuit-operator');

if !(isvector(u))
  error("expected argument \"u\" to be a vector");
end
  
if !(dv>0 & apd_x>0)
  error("arguments must be nonnegative");
end

maxpot = max(u);
adj_potential = maxpot * (1-apd_x);

first = 1;
last = 1;

for i = 2:length(u)
  if (u(i-1) <= adj_potential & u(i) >= adj_potential)
    first = i;
  end
  if (u(i-1) >= adj_potential & u(i) <= adj_potential)
    last = i-1;
  end
end

uprime = u(first:last);
tprime = t(first:last);
uvals1 = uprime(1):dv:maxpot;
uvals2 = maxpot:-dv:uprime(end);
uvals = [uvals1 uvals2];
utimes = [];
j = 1;

for k = 1:length(uprime)
  if (abs(uprime(k) - uvals(j)) < errortolerance)
    utimes(end+1) = tprime(k);
    j = j + 1;
  end
  if (j > length(uvals))
    break
end

x_vals = utimes(1:end-1);
y_vals = utimes(2:end);
end