function M = rl_results2surf(path,save_png)
%RESULTS2SURF map SPM and SwE results to surface representation
%   path        >       Path to the nii file to be converted 
%   save_png    >       Whether to save results to png 
%                       Possible values: true / false
%
%   - René Lattmann (last updated on 23.02.2026)
%
P = path;

% names for template and thickness file and output
[pp,ff,ee] = spm_fileparts(P);
Pmesh_lh  = fullfile(spm('dir'),'toolbox','cat12','templates_surfaces_32k',['lh.central.' cat_get_defaults('extopts.shootingsurf') '.gii']);
Pthick_lh = fullfile(spm('dir'),'toolbox','cat12','templates_surfaces_32k',['lh.thickness.' cat_get_defaults('extopts.shootingsurf')]);
Pout_lh   = fullfile(pp,"lh."+ff +".gii");
Pmesh_rh  = fullfile(spm('dir'),'toolbox','cat12','templates_surfaces_32k',['rh.central.' cat_get_defaults('extopts.shootingsurf') '.gii']);
Pthick_rh = fullfile(spm('dir'),'toolbox','cat12','templates_surfaces_32k',['rh.thickness.' cat_get_defaults('extopts.shootingsurf')]);
Pout_rh   = fullfile(pp,"rh."+ff +'.gii');
Pout      = fullfile(pp,"mesh."+ff+".resampled_32k.gii");


% map 3D volume to template surface inside cortical band with maxabs mapping function
cmd = sprintf('CAT_3dVol2Surf -linear -maxabs -steps 7 -start -0.6 -end 0.6 -thickness "%s" "%s" "%s" "%s"',Pthick_lh, Pmesh_lh, P, Pout_lh);
cat_system(cmd,0);
cmd = sprintf('CAT_3dVol2Surf -linear -maxabs -steps 7 -start -0.6 -end 0.6 -thickness "%s" "%s" "%s" "%s"',Pthick_rh, Pmesh_rh, P, Pout_rh);
cat_system(cmd,0);

% combine left and right hemipshere data
M_lh = gifti(char(Pout_lh));
M_rh = gifti(char(Pout_rh));
delete(Pout_lh); delete(Pout_rh); % delete temporary files
M.cdata = [M_lh.cdata; M_rh.cdata];
M.private.metadata = struct('name','SurfaceID','value',char(Pout));
save(gifti(M), char(Pout), 'Base64Binary');
%cat_surf_results('Disp',char(Pout));
%cat_surf_results('surface', 1);
%cat_surf_results('texture', 1);
%cat_surf_results('view', 3);
%cat_surf_results('colormap',4);
%cmap = [zeros(256,2),linspace(0,1,256)'];
%cat_surf_results('colormap','customized',cmap);
%cat_surf_results('threshold',1.96);
% cat_surf_results('transparency');
%cat_surf_results('clim',[1 25]);
if save_png
    cat_surf_results('print');
end

end