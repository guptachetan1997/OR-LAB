  vn0 = 2.^[5 : 15];
  venorminf = [  3.2189e-3 ...
                 8.0356e-4 ...
                 2.0081e-4 ...
                 5.0191e-5 ...
                 1.2543e-5 ...
                 3.1327e-6 ...
                 7.8097e-7 ...
                 1.9356e-7 ...
                 4.6817e-8 ...
                 8.0469e-9 ...
                 2.9562e-9];

  % ... produce standard log-log plot using Matlab's loglog command:
  xdata = vn0;
  ydata = venorminf;
  figure('DefaultAxesFontSize', 20);
  H = loglog(xdata, ydata, 'o');
  set(H, 'LineWidth',3, 'MarkerSize',10);
  grid on;
  legend(H, 'infinity norm of true error');
  xlabel('log_{10} (1 / h)');
  ylabel('log_{10} (||u - u_h||_\infty)');
  print -djpeg100 figconvrateloglog.jpg

  % ... produce explicit log-log plot using Matlab's plot command
  %     including a linear least-squares fit:
  xdata = log10(vn0);
  ydata = log10(venorminf);
  p = polyfit(xdata, ydata, 1);
  xmin = min(xdata); xmax = max(xdata);
  dx = (xmax - xmin) / 128;
  x = [xmin : dx : xmax];
  y = polyval(p, x);
  xtic = log10(vn0(1:2:end));
  xticlab = num2cell(10.^xtic);

  figure('DefaultAxesFontSize', 20);
  H = plot(xdata,ydata,'o', x,y,'--');
  set(H, 'LineWidth',3, 'MarkerSize',10);
  set(gca, 'xtick',xtic, 'xticklabel',xticlab);
  grid on;
  str = ['lin. approx. with slope ', num2str(p(1))];
  legend(H, 'infinity norm of true error', str);
  xlabel('1 / h');
  ylabel('log_{10} (||u - u_h||_\infty)');
  print -djpeg100 figconvrateplot.jpg

