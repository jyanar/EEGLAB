# PSD Ratios Walkthrough

While the canlab plugin is now primarily used for preprocessing EEG files in order to run the [spectral slopes analysis](https://github.com/canlabluc/psd-slope-rs-gng), it was first written in order to test whether taking the following ratios from each subject's power spectral density was a useful aging biomarker:

| Algorithm Implementation | Paper |
| -------------------------|-------|
| [`cl_alpha3alpha2.m`](https://github.com/canlabluc/EEGLAB/blob/master/plugins/canlab1.0/cl_alpha3alpha2.m) | [Moretti et al. (2013)](http://www.frontiersin.org/Journal/DownloadFile.ashx?pdf=1&FileId=34165&articleId=65285&ContentTypeId=21&FileName=fnagi-05-00063.pdf&Version=1) |
| [`cl_alphatheta.m`](https://github.com/canlabluc/EEGLAB/blob/master/plugins/canlab1.0/cl_alphatheta.m) | [Schmidt et al. (2013)](https://www.researchgate.net/profile/Antonio_Nardi/publication/257839823_Index_of_AlphaTheta_Ratio_of_the_Electroencephalogram_A_New_Marker_for_Alzheimers_Disease/links/004635314bb865df72000000.pdf) |

The general pipeline for performing both analyses is shown below. Users can either use the `cl_pipeline_psdratios.m` function or run through the pipeline manually. Supposing that we start off with some unprocessed cnt files:

## Using `cl_pipeline_psdratios.m`
First we define the struct containing the parameters for cl_pipeline. We'll be calculating the upper / lower alpha ratio:
```matlab
>> % Define parameters for the pipeline
>> params.analysis = 'cl_alpha3alpha2';
>> params.cntimport = true;
>> params.samplerate = 512;
>> params.lowerfreq = 0.5;
>> params.higherfreq = 45;
>> params.chexclusion = 'stdClinicalCh';
>> params.reference = 'CAR';
>> params.rejectBadFits = false;
>> params.guiFit = false;
```

Then,
```matlab
>> subj = cl_pipeline_psdratios('~/data/raw-cnt-files/', '~/sample_project/', params)
```

subj is a MATLAB struct containing the results of all of the analyses. Note that results were also written to the '~/sample_project/' directory specified above.

## Manually running through the pipeline
Import .cnt files and convert them to .set files for use in MATLAB.
```matlab
>> cl_importcnt('~/data/2015-05-01/raw_cnt_files/', '~/sample_project/raw_set_files/')
```

Exclude channels. Currently there are two options: 'stdClinicalCh' and 'extClinicalCh'. See `cl_excludechannels.m` for more detail.
```matlab
>> cl_excludechannels('~/sample_project/raw_set_files', '~/sample_project/excl_set/', 'stdClinicalCh')
```

Apply a digital bandpass filter. We'll bandpass from 0.5 Hz to 45 Hz.
```matlab
>> cl_bandpassfilter('~/sample_project/excl_set', '~/sample_project/exclfilt_set', 0.5, 45)
```

Re-reference the data to the common average.
```matlab
>> cl_rereference('~/sample_project/exclfilt_set', '~/sample_project/exclfiltCAR_set', 'CAR')
```

Convert file names to NBT nomenclature, so that we can utilize NBT's `nbt_doPeakFit` algorithm. This allows us to calculate individualized alpha and theta frequencies, as described in Moretti et al. (2013). A few different prompts will appear. All files are of the same type; files are in the correct format, and the sampling rate is 512.
```matlab
>> cl_nbtfilenames('~/sample_project/exclfiltCAR_set', '~/sample_project/exclfiltCAR-NBT_mat')
```

Now we perform the analysis, running either `cl_alphatheta` or `cl_alpha3alpha2`. Both will output a CSV to the specified export folder.
```matlab
>> subj = cl_alpha3alpha2('~/sample_project/exclfiltCAR-NBT_mat', '~/sample_project/results/', true, false);
```
The first and second arguments for `cl_alpha3alpha2`:

`rejectBadFits`
  - If set to true, subjects for whom `nbt_doPeakFit` returned bad values will simply not be assigned an IAF / TF.
  - If set to false, a subject with a bad IAF value will have the value corrected to a 9. Bad TF values are corrected to 4.5.

`guiFit`
  - If set to true, you will be asked to visually select the IAF and TF for subjects where `nbt_doPeakFit` returned bad values.
  - If set to false, the program will default to whatever `rejectBadFits` is set to.