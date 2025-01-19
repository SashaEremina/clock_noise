
tf=ispc; %for windows
if tf==1
    if ~contains(pwd,strcat(selpath,'\figures')) 
        cd([selpath,'\figures']);
    end
else %mac, linux
    if ~contains(pwd,strcat(selpath,'/figures'))
        cd([selpath,'/figures']);
    end
end


hfig = figure(2);  % save the figure handle in a variable
picturewidth = 20; % set this parameter and keep it forever
hw_ratio = 0.8; % feel free to play with this ratio
hw_ratio1 = 0.8; % feel free to play with this ratio

set(findall(hfig,'-property','FontSize'),'FontSize',20)

set(findall(hfig,'-property','Box'),'Box','off') % optional
set(findall(hfig,'-property','Interpreter'),'Interpreter','latex') 
set(findall(hfig,'-property','TickLabelInterpreter'),'TickLabelInterpreter','latex')
if hw_ratio1==0.8
    set(hfig,'Units','centimeters','Position',[3 3 picturewidth hw_ratio*picturewidth])
else
    set(hfig,'Units','centimeters','Position',[3 3 picturewidth*1.3 hw_ratio*picturewidth])
end    
pos = get(hfig,'Position');
set(hfig,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
print(hfig,fname,'-dpdf','-painters','-fillpage')
print(hfig,fname,'-dpng','-painters')
