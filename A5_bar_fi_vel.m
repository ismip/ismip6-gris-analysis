% plot ISMIP6 results

clear

load diag_fi_A5.mat

% labs names/ models list
load set_default.mat

% unit conversion
spy=31556926;

ax=[0,100,-5,200];
%ylab='RMSE velocity (10^{-6} m s^{-1})';
ylab='RMSE velocity (m yr^{-1})';
%ylab=[];

colors=get(0,'DefaultAxesColorOrder');
% color coded strings
igrpmodcol={};
for m=1:(diag.n-4)
    k = m;
    igrpmodcol{m}=['\color[rgb]{',num2str(colors(m,1)),',',num2str(colors(m,2)),',',num2str(colors(m,3)),',0} ', papgrpmod{k}];
    %k = ch.order(m);
    %igrpmodcol{m}=['\color[rgb]{',num2str(colors(m,1)),',',num2str(colors(m,2)),',',num2str(colors(m,3)),',0} ', ch.ids{k}];
end

% Plot
%figure('Position',[440   383   750   415])
figure('Position',[440   383   450   415])
%title('SMB','Interpreter','tex');

hold on; box on
for m=1:(diag.n-4);
    k=m;
    
    bar(m,diag.rms_velsurf_lin_mm_ssm{k}*spy,'FaceColor',colors(m,:));
    % mark up init method
    %if(ch.dasp(k)==1)
    %    text(m-0.12,3.5,'v', 'FontSize', 16, 'FontWeight' ,'bold','Rotation',90,'Color','k')
    %    text(m-0.1,5,'v', 'FontSize', 14,'Rotation',90,'Color','w')
    %elseif(ch.dasp(k) == 2)
    %    text(m-0.12,3.5,'s', 'FontSize', 16, 'FontWeight' ,'bold','Rotation',90,'Color','k')
    %    text(m-0.1,5,'s', 'FontSize', 14,'Rotation',90,'Color','w')
    %end
end
hold off

% Make up
set(gca,'Xtick',1:1:(diag.n-4))
set(gca,'XtickLabel',igrpmodcol,'XTickLabelRotation', 90)
set(gca,'YTickLabelRotation', 90)

ylabel(ylab,'Interpreter','tex');
ax=axis;
%axis([0 (diag.n-4)+1 ax(3) ax(4)])
axis([0 (diag.n-4)+1 0 65])

% save
print('-r300', '-dpng', ['Figures/' 'A5_bar_fi_diag_velsurf_ssm']);
