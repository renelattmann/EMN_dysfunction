%% 
%% The Second-Level GLM obtained in Dysfunction of the episodic memory network 
%% in the Alzheimer's disease cascade using the SwE toolbox. 

matlabbatch{1}.swe.smodel.dir = cellstr(fullfile("/Output/Folder"));
matlabbatch{1}.swe.smodel.scans = cellstr(Data.ConMaps);
matlabbatch{1}.swe.smodel.ciftiAdditionalInfo.ciftiGeomFile = struct('brainStructureLabel', {}, 'geomFile', {}, 'areaFile', {});
matlabbatch{1}.swe.smodel.ciftiAdditionalInfo.volRoiConstraint = 1;
matlabbatch{1}.swe.smodel.giftiAdditionalInfo.areaFileForGiftiInputs = {};
matlabbatch{1}.swe.smodel.type.classic.ss = 4;
matlabbatch{1}.swe.smodel.type.classic.dof_cl = 0;
matlabbatch{1}.swe.smodel.subjects = Data.Subject;
matlabbatch{1}.swe.smodel.cov(1).c = ones(height(Data.IDs),1);
matlabbatch{1}.swe.smodel.cov(1).cname = 'Intercept';
matlabbatch{1}.swe.smodel.cov(2).c = zscore(Data.Time);
matlabbatch{1}.swe.smodel.cov(2).cname = 'Time';
% Inputs here are the time-shift estimations
% note: they were corrected for age, sex, and education beforehand 
matlabbatch{1}.swe.smodel.cov(3).c = zscore(Data.TS);
matlabbatch{1}.swe.smodel.cov(3).cname = 'TS - Linear';

% After correction for age, sex, and education, quadratic effects were
% tested as well by squaring the Data.TS scores
matlabbatch{1}.swe.smodel.cov(4).c = zscore(Data.TS_quadr);
matlabbatch{1}.swe.smodel.cov(4).cname = 'TS - Quadratic';

% Add demographics
matlabbatch{1}.swe.smodel.cov(5).c = zscore(Data.age);
matlabbatch{1}.swe.smodel.cov(5).cname = 'Age';
matlabbatch{1}.swe.smodel.cov(6).c = zscore(Data.education);
matlabbatch{1}.swe.smodel.cov(6).cname = 'Education';
matlabbatch{1}.swe.smodel.cov(7).c = zscore(Data.sex_swe); % coded es specified by SWE toolbox
matlabbatch{1}.swe.smodel.cov(7).cname = 'Sex';
matlabbatch{1}.swe.smodel.cov(8).c = zscore(Data.age .* Data.Time);

% Interactions of demographics with time
matlabbatch{1}.swe.smodel.cov(8).cname = 'Age X Time';
matlabbatch{1}.swe.smodel.cov(9).c = zscore(Data.Education .* Data.Time);
matlabbatch{1}.swe.smodel.cov(9).cname = 'Education X Time';
matlabbatch{1}.swe.smodel.cov(10).c = zscore(Data.sex_swe .* Data.Time);
matlabbatch{1}.swe.smodel.cov(10).cname = 'Sex X Time';
matlabbatch{1}.swe.smodel.multi_cov = struct('files', {});
matlabbatch{1}.swe.smodel.masking.tm.tm_none = 1;
matlabbatch{1}.swe.smodel.masking.im = 1;
matlabbatch{1}.swe.smodel.masking.em = {'GM_Mask.nii'};
matlabbatch{1}.swe.smodel.WB.WB_yes.WB_ss = 4;
matlabbatch{1}.swe.smodel.WB.WB_yes.WB_nB = 1000;
matlabbatch{1}.swe.smodel.WB.WB_yes.WB_SwE = 0;
matlabbatch{1}.swe.smodel.WB.WB_yes.WB_stat.WB_T.WB_T_con = [0,0,1,0,0,0,0];
matlabbatch{1}.swe.smodel.WB.WB_yes.WB_infType.WB_TFCE.WB_TFCE_E = 0.5;
matlabbatch{1}.swe.smodel.WB.WB_yes.WB_infType.WB_TFCE.WB_TFCE_H = 2;
matlabbatch{1}.swe.smodel.globalc.g_omit = 1;
matlabbatch{1}.swe.smodel.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.swe.smodel.globalm.glonorm = 1;