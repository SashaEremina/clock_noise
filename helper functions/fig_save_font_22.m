
%Location
if ~contains(pwd,'C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\figures')
    cd('C:\Users\sasha.eremina\Documents\MATLAB\Eremina_et_al_Nat_Comms\figures');
end


hfig = figure(1); 
picturewidth = 20; 
hw_ratio = 0.8; 
hw_ratio1 = 0.8; 

set(findall(hfig,'-property','FontSize'),'FontSize',22)

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
