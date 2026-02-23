function [M] = rl_surf_results_bidirectional(path_positive,path_negative, effect, mask, thresh)
%rl_surf_results_bidirectional
%   Get a surface representation of T contrasts for plotting. Use positive
%   and negative plots, combine them, threshold the results and save the
%   output as a gifti file. Input paths to swe files with log-p-value representation.
%
%   - René Lattmann (last updated on 23.02.2026)
%
%   path_positive   - path to an nii (positive contrast)
%   path_negative   - path to an nii (negative contrast)
%   effect          - string for later file naming (i.e. your EOI)
%   thresh          - threshold the maps in the style of -log10(thresh)

if mask 
    positive = gifti(char(path_positive));
    negative = gifti(char(path_negative));

    positive.cdata(positive.cdata == 1) = 2;
    M.cdata = positive.cdata + negative.cdata;
    M.private.metadata = struct('name','SurfaceID','value',[effect '_Overlap.gii']);

    save(gifti(M),[effect 'Overlap.gii'], 'Base64Binary');
else

    positive = gifti(char(path_positive));
    negative = gifti(char(path_negative));

% Threshold the results to the user-specified threshold
    positive.cdata(positive.cdata <= -log10(num(thresh))) = 0;
    negative.cdata(negative.cdata <= -log10(num(thresh))) = 0; 

    M.cdata = positive.cdata - negative.cdata;
    M.private.metadata = struct('name','SurfaceID','value',[effect '_combined_Tsurf_uncorr_p001.gii']);

    save(gifti(M),[effect '_combined_Tsurf_thresh_p' thresh '.gii'], 'Base64Binary');

end