% created by JN Kather 2016
% jakob.kather@nct-heidelberg.de, ORCID http://orcid.org/0000-0002-3730-5348
% License: see separate file in parent folder
% thise file belongs to the project "Color-coded visualization of magnetic resonance imaging multiparametric maps", Scientific Reports, 2016
% please cite this article if you use the code

% this script serves to create dataset files for further analyses

function main_createDatasetFiles()
    % specify constants
    cnst.loadDir = '../mri-input/'; % default 'input/'
    cnst.inputFormat = '*.dcm'; % default '*.dcm'
 
    % --- DIFFUSION PERFUSION BACKGROUND OVERLAY
    
    % Prostate 142 --------------------------------------
    Dataset.Dir = 'Color_142/ProstateMultivariate/';
    Dataset.Name = 'Prostate_142_ADC_PBF_B800_Backgrounds';
    Dataset.Channel1.Dir = 'resampled_adc_5368/';
    Dataset.Channel1.ShortName = 'ADC';
    Dataset.Channel2.Dir = 'resampled_pbf_5366/';
    Dataset.Channel2.ShortName = 'PBF';
    Dataset.Channel3.Dir = 'b800_resampled_5324/';
    Dataset.Channel3.ShortName = 'B800';
    Dataset.Backgrounds1.Dir = 't1_resampled_5334/'; % t2_tse_tra_320_p2_5 t1_resampled_5334
    Dataset.Backgrounds2.Dir = 't2_tse_tra_320_p2_5/'; % t2_tse_tra_320_p2_5 t1_resampled_5334
    Dataset.SampleImageNumber = 12;
    Dataset.extraMode = 'Backgrounds';

    saveDataset(cnst,Dataset);     
    
    % Prostate 159 --------------------------------------
    Dataset.Dir = 'Color_159/ProstateMultivariate/';
    Dataset.Name = 'Prostate_159_ADC_PBF_B800_Backgrounds';
    Dataset.Channel1.Dir = 'resampled_adc_5347/';
    Dataset.Channel1.ShortName = 'ADC';
    Dataset.Channel2.Dir = 'resampled_pbf_5400/';
    Dataset.Channel2.ShortName = 'PBF';
    Dataset.Channel3.Dir = 'b800_resampled_5356/';
    Dataset.Channel3.ShortName = 'B800';
    Dataset.Backgrounds1.Dir = 't1_resampled_5314/'; % T1
    Dataset.Backgrounds2.Dir = 't2_tse_tra_320_p2_5/'; % T2
    Dataset.SampleImageNumber = 12;
    Dataset.extraMode = 'Backgrounds';

    saveDataset(cnst,Dataset);     
    
    % Prostate 152 --------------------------------------
    Dataset.Dir = 'Color_152/ProstateMultivariate/';
    Dataset.Name = 'Prostate_152_ADC_PBF_B800_Backgrounds';
    Dataset.Channel1.Dir = 'resampled_adc_5374/';
    Dataset.Channel1.ShortName = 'ADC';
    Dataset.Channel2.Dir = 'resampled_pbf_5358/';
    Dataset.Channel2.ShortName = 'PBF';
    Dataset.Channel3.Dir = 'b800_resampled_5325/';
    Dataset.Channel3.ShortName = 'B800';
    Dataset.Backgrounds1.Dir = 't1_resampled_5344/'; % T1
    Dataset.Backgrounds2.Dir = 't2_tse_tra_320_p2_5/'; % T2
    Dataset.SampleImageNumber = 12;
    Dataset.extraMode = 'Backgrounds';

    saveDataset(cnst,Dataset);     
    
    % Prostate 237 --------------------------------------
    Dataset.Dir = 'Color_237/ProstateMultivariate/';
    Dataset.Name = 'Prostate_237_ADC_PBF_B800_Backgrounds';
    Dataset.Channel1.Dir = 'resampled_adc_5363/';
    Dataset.Channel1.ShortName = 'ADC';
    Dataset.Channel2.Dir = 'resampled_pbf_5374/';
    Dataset.Channel2.ShortName = 'PBF';
    Dataset.Channel3.Dir = 'b800_resampled_5333/';
    Dataset.Channel3.ShortName = 'B800';
    Dataset.Backgrounds1.Dir = 't1_resampled_5345/'; % T1
    Dataset.Backgrounds2.Dir = 't2_tse_tra_320_p2_5/'; % T2
    Dataset.SampleImageNumber = 12;
    Dataset.extraMode = 'Backgrounds';

    saveDataset(cnst,Dataset);     
    
    % Prostate 112 --------------------------------------
    Dataset.Dir = 'Color_112/ProstateMultivariate/';
    Dataset.Name = 'Prostate_112_ADC_PBF_B800_Backgrounds';
    Dataset.Channel1.Dir = 'resampled_adc_5409/';
    Dataset.Channel1.ShortName = 'ADC';
    Dataset.Channel2.Dir = 'resampled_pbf_5384/';
    Dataset.Channel2.ShortName = 'PBF';
    Dataset.Channel3.Dir = 'b800_resampled_5381/';
    Dataset.Channel3.ShortName = 'B800';
    Dataset.Backgrounds1.Dir = 'resampled_t1_5380/'; % T1
    Dataset.Backgrounds2.Dir = 't2_tse_tra_320_p2_5/'; % T2
    Dataset.SampleImageNumber = 12;
    Dataset.extraMode = 'Backgrounds';

    saveDataset(cnst,Dataset);   

    % Prostate 121 --------------------------------------
    Dataset.Dir = 'Color_121/ProstateMultivariate/';
    Dataset.Name = 'Prostate_121_ADC_PBF_B800_Backgrounds';
    Dataset.Channel1.Dir = 'resampled_adc_5372/';
    Dataset.Channel1.ShortName = 'ADC';
    Dataset.Channel2.Dir = 'resampled_pbf_5399/';
    Dataset.Channel2.ShortName = 'PBF';
    Dataset.Channel3.Dir = 'b800_resampled_5340/';
    Dataset.Channel3.ShortName = 'B800';
    Dataset.Backgrounds1.Dir = 't1_resampled_5349/'; % T1
    Dataset.Backgrounds2.Dir = 't2_tse_tra_320_p2_5/'; % T2
    Dataset.SampleImageNumber = 12;
    Dataset.extraMode = 'Backgrounds';

    saveDataset(cnst,Dataset);  
    
    % Prostate 186 --------------------------------------
    Dataset.Dir = 'Color_186/ProstateMultivariate/';
    Dataset.Name = 'Prostate_186_ADC_PBF_B800_Backgrounds';
    Dataset.Channel1.Dir = 'resampled_adc_5333/';
    Dataset.Channel1.ShortName = 'ADC';
    Dataset.Channel2.Dir = 'resampled_pbf_5378/';
    Dataset.Channel2.ShortName = 'PBF';
    Dataset.Channel3.Dir = 'b800_resampled_5344/';
    Dataset.Channel3.ShortName = 'B800';
    Dataset.Backgrounds1.Dir = 't1_resampled_5356/'; % T1
    Dataset.Backgrounds2.Dir = 't2_tse_tra_320_p2_6/'; % T2
    Dataset.SampleImageNumber = 12;
    Dataset.extraMode = 'Backgrounds';

    saveDataset(cnst,Dataset);  
    
    % Prostate 187 --------------------------------------
    Dataset.Dir = 'Color_187/ProstateMultivariate/';
    Dataset.Name = 'Prostate_187_ADC_PBF_B800_Backgrounds';
    Dataset.Channel1.Dir = 'resampled_adc_5347/';
    Dataset.Channel1.ShortName = 'ADC';
    Dataset.Channel2.Dir = 'resampled_pbf_5382/';
    Dataset.Channel2.ShortName = 'PBF';
    Dataset.Channel3.Dir = 'b800_resampled_5366/';
    Dataset.Channel3.ShortName = 'B800';
    Dataset.Backgrounds1.Dir = 't1_resampled_5322/'; % T1
    Dataset.Backgrounds2.Dir = 't2_tse_tra_320_p2_7/'; % T2
    Dataset.SampleImageNumber = 12;
    Dataset.extraMode = 'Backgrounds';

    saveDataset(cnst,Dataset);  
    
    % Prostate 234 --------------------------------------
    Dataset.Dir = 'Color_234/ProstateMultivariate/';
    Dataset.Name = 'Prostate_234_ADC_PBF_B800_Backgrounds';
    Dataset.Channel1.Dir = 'resampled_adc_5349/';
    Dataset.Channel1.ShortName = 'ADC';
    Dataset.Channel2.Dir = 'resampled_pbf_5331/';
    Dataset.Channel2.ShortName = 'PBF';
    Dataset.Channel3.Dir = 'b800_resampled_5367/';
    Dataset.Channel3.ShortName = 'B800';
    Dataset.Backgrounds1.Dir = 't1_resampled_5320/'; % T1
    Dataset.Backgrounds2.Dir = 't2_tse_tra_320_p2_5/'; % T2
    Dataset.SampleImageNumber = 12;
    Dataset.extraMode = 'Backgrounds';

    saveDataset(cnst,Dataset);  
    
    % Prostate 146 --------------------------------------
    Dataset.Dir = 'Color_146/ProstateMultivariate/';
    Dataset.Name = 'Prostate_146_ADC_PBF_B800_Backgrounds';
    Dataset.Channel1.Dir = 'resampled_adc_5348/';
    Dataset.Channel1.ShortName = 'ADC';
    Dataset.Channel2.Dir = 'resampled_pbf_5350/';
    Dataset.Channel2.ShortName = 'PBF';
    Dataset.Channel3.Dir = 'b800_resampled_5363/';
    Dataset.Channel3.ShortName = 'B800';
    Dataset.Backgrounds1.Dir = 't1_resampled_5319/'; % T1
    Dataset.Backgrounds2.Dir = 't2_tse_tra_320_p2_5/'; % T2
    Dataset.SampleImageNumber = 12;
    Dataset.extraMode = 'Backgrounds';

    saveDataset(cnst,Dataset);  

    % Prostate 192 --------------------------------------
    Dataset.Dir = 'Color_192/ProstateMultivariate/';
    Dataset.Name = 'Prostate_192_ADC_PBF_B800_Backgrounds';
    Dataset.Channel1.Dir = 'resampled_adc_5354/';
    Dataset.Channel1.ShortName = 'ADC';
    Dataset.Channel2.Dir = 'resampled_pbf_5330/';
    Dataset.Channel2.ShortName = 'PBF';
    Dataset.Channel3.Dir = 'b800_resampled_5346/';
    Dataset.Channel3.ShortName = 'B800';
    Dataset.Backgrounds1.Dir = 't1_resampled_5322/'; % T1
    Dataset.Backgrounds2.Dir = 't2_tse_tra_320_p2_5/'; % T2
    Dataset.SampleImageNumber = 12;
    Dataset.extraMode = 'Backgrounds';

    saveDataset(cnst,Dataset);  
    
    % Prostate 225 --------------------------------------
    Dataset.Dir = 'Color_225/ProstateMultivariate/';
    Dataset.Name = 'Prostate_225_ADC_PBF_B800_Backgrounds';
    Dataset.Channel1.Dir = 'resampled_adc_5399/';
    Dataset.Channel1.ShortName = 'ADC';
    Dataset.Channel2.Dir = 'resampled_pbf_5381/';
    Dataset.Channel2.ShortName = 'PBF';
    Dataset.Channel3.Dir = 'b800_resampled_5336/';
    Dataset.Channel3.ShortName = 'B800';
    Dataset.Backgrounds1.Dir = 't1_resampled_5343/'; % T1
    Dataset.Backgrounds2.Dir = 't2_tse_tra_320_p2_5/'; % T2
    Dataset.SampleImageNumber = 12;
    Dataset.extraMode = 'Backgrounds';

    saveDataset(cnst,Dataset);  
    
    % Prostate 226 --------------------------------------
    Dataset.Dir = 'Color_226/ProstateMultivariate/';
    Dataset.Name = 'Prostate_226_ADC_PBF_B800_Backgrounds';
    Dataset.Channel1.Dir = 'resampled_adc_5383/';
    Dataset.Channel1.ShortName = 'ADC';
    Dataset.Channel2.Dir = 'resampled_pbf_5363/';
    Dataset.Channel2.ShortName = 'PBF';
    Dataset.Channel3.Dir = 'b800_resampled_5366/';
    Dataset.Channel3.ShortName = 'B800';
    Dataset.Backgrounds1.Dir = 't1_resampled_5323/'; % T1
    Dataset.Backgrounds2.Dir = 't2_tse_tra_320_p2_5/'; % T2
    Dataset.SampleImageNumber = 12;
    Dataset.extraMode = 'Backgrounds';

    saveDataset(cnst,Dataset);  

    % Prostate 227 --------------------------------------
    Dataset.Dir = 'Color_227/ProstateMultivariate/';
    Dataset.Name = 'Prostate_227_ADC_PBF_B800_Backgrounds';
    Dataset.Channel1.Dir = 'resampled_adc_5364/';
    Dataset.Channel1.ShortName = 'ADC';
    Dataset.Channel2.Dir = 'resampled_pbf_5347/';
    Dataset.Channel2.ShortName = 'PBF';
    Dataset.Channel3.Dir = 'b800_resampled_5339/';
    Dataset.Channel3.ShortName = 'B800';
    Dataset.Backgrounds1.Dir = 't1_resampled_5344/'; % T1
    Dataset.Backgrounds2.Dir = 't2_tse_tra_320_p2_5/'; % T2
    Dataset.SampleImageNumber = 12;
    Dataset.extraMode = 'Backgrounds';

    saveDataset(cnst,Dataset);  

    % Prostate 238 --------------------------------------
    Dataset.Dir = 'Color_238/ProstateMultivariate/';
    Dataset.Name = 'Prostate_238_ADC_PBF_B800_Backgrounds';
    Dataset.Channel1.Dir = 'resampled_adc_5396/';
    Dataset.Channel1.ShortName = 'ADC';
    Dataset.Channel2.Dir = 'resampled_pbf_5328/';
    Dataset.Channel2.ShortName = 'PBF';
    Dataset.Channel3.Dir = 'b800_resampled_5348/';
    Dataset.Channel3.ShortName = 'B800';
    Dataset.Backgrounds1.Dir = 't1_resampled_5367/'; % T1
    Dataset.Backgrounds2.Dir = 't2_tse_tra_320_p2_5/'; % T2
    Dataset.SampleImageNumber = 12;
    Dataset.extraMode = 'Backgrounds';

    saveDataset(cnst,Dataset);  
    
    % Prostate 260 --------------------------------------
    Dataset.Dir = 'Color_260/ProstateMultivariate/';
    Dataset.Name = 'Prostate_260_ADC_PBF_B800_Backgrounds';
    Dataset.Channel1.Dir = 'resampled_adc_5355/';
    Dataset.Channel1.ShortName = 'ADC';
    Dataset.Channel2.Dir = 'resampled_pbf_5389/';
    Dataset.Channel2.ShortName = 'PBF';
    Dataset.Channel3.Dir = 'b800_resampled_5372/';
    Dataset.Channel3.ShortName = 'B800';
    Dataset.Backgrounds1.Dir = 't1_resampled_5331/'; % T1
    Dataset.Backgrounds2.Dir = 't2_tse_tra_320_p2_5/'; % T2
    Dataset.SampleImageNumber = 12;
    Dataset.extraMode = 'Backgrounds';

    saveDataset(cnst,Dataset); 

    
end

function saveDataset(cnst,Dataset)
    % save Dataset information
    Dataset.Channel1.FullPath = strcat(cnst.loadDir, Dataset.Dir, ...
        Dataset.Channel1.Dir);
    Dataset.Channel1.Files = dir([Dataset.Channel1.FullPath, cnst.inputFormat]);
    Dataset.Channel2.FullPath = strcat(cnst.loadDir, Dataset.Dir, ...
        Dataset.Channel2.Dir);
    Dataset.Channel2.Files = dir([Dataset.Channel2.FullPath, cnst.inputFormat]);
    Dataset.Channel3.FullPath = strcat(cnst.loadDir, Dataset.Dir, ...
        Dataset.Channel3.Dir);
    Dataset.Channel3.Files = dir([Dataset.Channel3.FullPath, cnst.inputFormat]);
    
    % if Backgrounds are present
    if isfield(Dataset,'Backgrounds1')
    Dataset.Backgrounds1.FullPath = strcat(cnst.loadDir, Dataset.Dir, ...
        Dataset.Backgrounds1.Dir);
    Dataset.Backgrounds1.Files = dir([Dataset.Backgrounds1.FullPath, cnst.inputFormat]);   
    Dataset.Backgrounds2.FullPath = strcat(cnst.loadDir, Dataset.Dir, ...
        Dataset.Backgrounds2.Dir);
    Dataset.Backgrounds2.Files = dir([Dataset.Backgrounds2.FullPath, cnst.inputFormat]);   
    else
        Dataset.extraMode = 'n';
    end
    
    save([cnst.loadDir,char(Dataset.Name),'.mat'], 'Dataset');
end