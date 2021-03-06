% load ISMIP6 results in a structure per exp

clear

% uncommented for update
%load lithk_A5

ares = '05';
step = 1;

% Path to archive
datapath=(['../../ismip6-gris-results-processing/Archive_2d/Data']);

% labs names/ models list
load set_default.mat

%% labs names/ models list
%igrp = {'AWI','AWI','AWI','BGC','ILTS_PIK','ILTS_PIK','IMAU','IMAU','JPL','JPL','LSCE','UCIJPL'}
%imod = {'ISSM1','ISSM2','ISSM3','BISICLES','SICOPOLIS2','SICOPOLIS3','IMAUICE1','IMAUICE2','ISSM','ISSMPALEO','GRISLI','ISSM1'};
%igrpmod={};
%for i=1:length(igrp)
%    igrpmod{i}=[igrp{i},'-' , imod{i}];
%end

%vars={'lithk','orog','topg','sftgif','sftgrf','sftflf'};

vars={'lithk','orog','topg','sftgif','sftgrf','sftflf','acabf','velmean'};
%vars={'velmean'};

% Load model data
li.igrp=strrep(igrp,'_','');
li.imod=imod;
li.igrpmod=strrep(igrpmod,'_','');
li.n=length(igrp);

% all
for m=1:li.n;
% update some
%for m=[16];
%for m=[18 19];
%for m=[22,23];

    % historical
    for k=1:length(vars);
        ncfile=[datapath,'/',igrp{m},'/',imod{m},'/historical_' ares '/', vars{k}, '_2014' '_GIS_', igrp{m},'_',imod{m},'_', 'historical', '.nc'];
        % check file exists
        if exist(ncfile, 'file') == 2
            ncfile
            in=ncload(ncfile);
            eval(['li.historical{m}.',vars{k},'=single(in.',vars{k},'(:,:));']);
        else
            %eval(['li.historical{m}.',vars{k},'=single(zeros(337,577));']);
            eval(['li.historical{m}.',vars{k},'=[];']);
        end
    end

    % ctrl_proj
    for k=1:length(vars);
        ncfile=[datapath,'/',igrp{m},'/',imod{m},'/ctrl_proj_' ares '/', vars{k}, '_2100' '_GIS_', igrp{m},'_',imod{m},'_', 'ctrl_proj', '.nc']
        % check file exists
        if exist(ncfile, 'file') == 2
            ncfile
            in=ncload(ncfile);
            eval(['li.ctrl_proj{m}.',vars{k},'=single(in.',vars{k},'(:,:));']);
        else
            eval(['li.ctrl_proj{m}.',vars{k},'=[];']);
        end
    end

    % exp05
    for k=1:length(vars);
        ncfile=[datapath,'/',igrp{m},'/',imod{m},'/exp05_' ares '/', vars{k}, '_2100' '_GIS_', igrp{m},'_',imod{m},'_', 'exp05', '.nc'];
        % check file exists
        if exist(ncfile, 'file') == 2
            ncfile
            in=ncload(ncfile);
            eval(['li.exp05{m}.',vars{k},'=single(in.',vars{k},'(:,:));']);
        else
            eval(['li.exp05{m}.',vars{k},'=[];']);
        end
    end



end

save lithk_A5 li

