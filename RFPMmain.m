S = [ 0 0;
      0 2;
      -2 0
      2 0;
      0 -2
      4 0;
      -4 0;
      0 4;
      0 -4];
PATH = 3;
discreteX = linspace(-1, 1, 1000);
discreteY = linspace(-1, 1, 1000);  

%establish the dataBase of average
map = discreteX.' * discreteY;
flag = zeros(1, size(map,1) * size(map,2) );    %0 for not conclude, 1 for correct, -1 for no enough data 
fingerprint = zeros( size(map,1) * size(map,2), PATH);
