x = sin(linspace(1, 30, 30)*0.314);
y = AMPD(x);
fprintf('Peaks indexes        : %d, %d\n', y)
fprintf('Peaks values         : %d, %d\n', x(y))
fprintf('Left values of peaks : %d, %d\n', x(y - 1))
fprintf('Right values of peaks: %d, %d\n', x(y + 1))

% Peaks indexes        : 5, 25
% Peaks values         : 9.999997e-01, 9.999921e-01
% Left values of peaks : 9.508595e-01, 9.498684e-01
% Right values of peaks: 9.513514e-01, 9.523280e-01
