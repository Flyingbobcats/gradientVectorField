
function saveplots(F,format)
figures = F; 
figSize = [21, 29];            % [width, height]
figUnits = 'Centimeters';
for f = 1:numel(figures)
      fig = figures(f);
      % Resize the figure
%       set(fig, 'Units', figUnits);
%       pos = get(fig, 'Position');
%       pos = [pos(1), pos(4)+figSize(2), pos(3)+figSize(1), pos(4)];
%       set(fig, 'Position', pos);
      % Output the figure
      set(gca,'LooseInset',get(gca,'TightInset'))
      saveas(fig,num2str(f), format);
end
end