/*
SQL Script for the Project "Prediction of Brain Region from Physiology"
Although the project can be ran entirely on Google Colab Notebook, the associated data can also be stored and 
queried from a SQL database. This SQL Script is developed on a PostgreSQL database.
*/

--1.Download 4 necessary csv files ('brain_observatory_1.1_analysis_metrics.csv',
--'functional_connectivity_analysis_metrics.csv','units.csv','channels.csv') using the instructions in the 
--Allen Neuropixels Dataset website (https://allensdk.readthedocs.io/en/latest/visual_coding_neuropixels.html)
--(Same commands can be found in the Google Colab notebook).
--2.Place the 4 necessary csv files in the '../Users/Public' folder of your computer.
--3.Log into to the database that you want to work on.

--4.Create a schema to store all tables related to the Allen Neuropixels Dataset.
CREATE SCHEMA allen_neuropixel;

--5.Create a temporary table that would keep the labels that belong to the visual cortex.
CREATE TABLE allen_neuropixel.visual_cortex_labels (ecephys_structure_acronym varchar(10) primary key);
INSERT INTO allen_neuropixel.visual_cortex_labels (ecephys_structure_acronym) 
	VALUES ('VISp'),('VISal'),('VISam'),('VISrl'),('VISl'),('VISpm'),('VISli');

--6.Create a temporary table that would keep the labels that belong to the hippocampal formation.
CREATE TABLE allen_neuropixel.hippocampal_formation_labels (ecephys_structure_acronym varchar(10) primary key);
INSERT INTO allen_neuropixel.hippocampal_formation_labels (ecephys_structure_acronym) 
	VALUES ('CA1'),('DG'),('CA3'),('CA2'),('SUB'),('ProS'),('HPF'),('PRE');

--7.Create a table that will store the metrics from the Brain Observatory Dataset and 
-- import data from 'brain_observatory_1.1_analysis_metrics.csv'.
CREATE TABLE allen_neuropixel.metrics_brain_observatory 
	(ecephys_unit_id int primary key,c50_dg double precision, area_rf double precision,fano_dg double precision,
	 fano_fl double precision,fano_ns double precision, fano_rf double precision,fano_sg double precision, 
	 f1_f0_dg double precision, g_dsi_dg double precision, g_osi_dg double precision,g_osi_sg double precision, 
	 width_rf double precision,height_rf double precision, azimuth_rf double precision,mod_idx_dg double precision, 
	 p_value_rf double precision,pref_sf_sg double precision, pref_tf_dg double precision,run_mod_dg double precision,
	 run_mod_fl double precision,run_mod_ns double precision, run_mod_rf double precision,run_mod_sg double precision,
	 pref_ori_dg double precision,pref_ori_sg double precision, run_pval_dg double precision,
	 run_pval_fl double precision, run_pval_ns double precision,run_pval_rf double precision,
	 run_pval_sg double precision,elevation_rf double precision, on_screen_rf boolean,pref_image_ns int, 
	 pref_phase_sg double precision,firing_rate_dg double precision, firing_rate_fl double precision,
	 firing_rate_ns double precision, firing_rate_rf double precision,firing_rate_sg double precision, 
	 on_off_ratio_fl double precision,time_to_peak_fl double precision, time_to_peak_ns double precision,
	 time_to_peak_rf double precision, time_to_peak_sg double precision,pref_sf_multi_sg boolean,
	 pref_tf_multi_dg boolean,sustained_idx_fl double precision, pref_ori_multi_dg boolean,pref_ori_multi_sg boolean,
	 pref_phase_multi_sg boolean,image_selectivity_ns double precision, pref_images_multi_ns boolean,
	 lifetime_sparseness_dg double precision, lifetime_sparseness_fl double precision,
	 lifetime_sparseness_ns double precision, lifetime_sparseness_rf double precision,
	 lifetime_sparseness_sg double precision);

COPY allen_neuropixel.metrics_brain_observatory 
	FROM 'C:/Users/Public/brain_observatory_1.1_analysis_metrics.csv' 
	WITH CSV HEADER;

--8.Create a table that will store the metrics from the Functional Connectivity Dataset and 
-- import data from 'functional_connectivity_analysis_metrics.csv'.
CREATE TABLE allen_neuropixel.metrics_functional_connectivity 
	(ecephys_unit_id int primary key, c50_dg double precision, area_rf double precision,fano_dg double precision,
	 fano_dm double precision,fano_fl double precision, fano_rf double precision, f1_f0_dg double precision,
	 g_dsi_dg double precision, g_osi_dg double precision, width_rf double precision,height_rf double precision,
	 azimuth_rf double precision,mod_idx_dg double precision, p_value_rf double precision,pref_tf_dg double precision,
	 run_mod_dg double precision, run_mod_dm double precision,run_mod_fl double precision,run_mod_rf double precision,
	 pref_dir_dm double precision, pref_ori_dg double precision,run_pval_dg double precision,
	 run_pval_dm double precision,run_pval_fl double precision,run_pval_rf double precision,
	 elevation_rf double precision, on_screen_rf boolean,pref_speed_dm double precision,firing_rate_dg double precision,
	 firing_rate_dm double precision, firing_rate_fl double precision,firing_rate_rf double precision,
	 on_off_ratio_fl double precision, time_to_peak_dm double precision,time_to_peak_fl double precision,
	 time_to_peak_rf double precision,pref_tf_multi_dg boolean,sustained_idx_fl double precision, 
	 pref_dir_multi_dg boolean,pref_ori_multi_dg boolean, pref_speed_multi_dm boolean,
	 lifetime_sparseness_dg double precision, lifetime_sparseness_dm double precision, 
	 lifetime_sparseness_fl double precision,lifetime_sparseness_rf double precision);

COPY allen_neuropixel.metrics_functional_connectivity 
	FROM 'C:/Users/Public/functional_connectivity_analysis_metrics.csv' 
	WITH CSV HEADER;

--9.Create a table that will store the unit information and import data from 'units.csv'.
CREATE TABLE allen_neuropixel.units 
	(id int primary key, PT_ratio double precision, amplitude double precision,amplitude_cutoff double precision, 
	 cumulative_drift double precision,d_prime double precision,duration double precision, ecephys_channel_id int,
	 epoch_name_quality_metrics varchar(80), epoch_name_waveform_metrics varchar(80),firing_rate double precision,
	 halfwidth double precision,	isi_violations double precision,isolation_distance double precision,
	 l_ratio double precision, max_drift double precision, nn_hit_rate double precision, nn_miss_rate double precision,
	 presence_ratio double precision, quality varchar(10), recovery_slope double precision,
	 repolarization_slope double precision,silhouette_score double precision, snr double precision,
	 spread double precision,velocity_above double precision, velocity_below double precision);

COPY allen_neuropixel.units 
	FROM 'C:/Users/Public/units.csv' 
	WITH CSV HEADER;

--10.Create a table that will store the channel information and import data from 'channels.csv'.
CREATE TABLE allen_neuropixel.channels 
	(id int primary key,ecephys_probe_id int,local_index int,probe_horizontal_position int,probe_vertical_position int,
	 anterior_posterior_ccf_coordinate int, dorsal_ventral_ccf_coordinate int, left_right_ccf_coordinate int, 
	 ecephys_structure_id double precision, ecephys_structure_acronym varchar(10));

COPY allen_neuropixel.channels 
	FROM 'C:/Users/Public/channels.csv' 
	WITH CSV HEADER;


--11.Create a temporary table by selecting the units with good quality, store their ids and brain regions
--from the tables associated with units and channels.
SELECT ugood.id, ch.ecephys_structure_acronym 
	INTO allen_neuropixel.temp_good_units 
	FROM 
	(SELECT u.id,u.ecephys_channel_id 
	 FROM allen_neuropixel.units as u 
	 WHERE u.quality='good') 
	 as ugood 
	INNER JOIN allen_neuropixel.channels as ch 
	ON (ugood.ecephys_channel_id=ch.id);

--12.Create a temporary table by selecting the units from Brain Observatory with good quality recorded at visual cortex,
--store their metrics from the tables associated with the metrics. 
--After table is created, write it to a csv file and delete this temporary table.
SELECT bo.c50_dg, bo.area_rf,bo.fano_dg, bo.fano_fl,bo.fano_ns, bo.fano_rf ,bo.fano_sg , bo.f1_f0_dg ,bo.g_dsi_dg,
	bo.g_osi_dg ,bo.g_osi_sg , bo.width_rf , bo.height_rf , bo.azimuth_rf ,bo.mod_idx_dg , bo.p_value_rf,bo.pref_sf_sg,
	bo.pref_tf_dg ,bo.run_mod_dg , bo.run_mod_fl ,bo.run_mod_ns , bo.run_mod_rf ,bo.run_mod_sg , bo.pref_ori_dg ,
	bo.pref_ori_sg, bo.run_pval_dg ,bo.run_pval_fl , bo.run_pval_ns ,bo.run_pval_rf, bo.run_pval_sg ,bo.elevation_rf,
	bo.on_screen_rf,bo.pref_image_ns , bo.pref_phase_sg ,bo.firing_rate_dg, bo.firing_rate_fl ,bo.firing_rate_ns , 
	bo.firing_rate_rf ,bo.firing_rate_sg , bo.on_off_ratio_fl ,bo.time_to_peak_fl , bo.time_to_peak_ns ,
	bo.time_to_peak_rf, bo.time_to_peak_sg ,bo.pref_sf_multi_sg , bo.pref_tf_multi_dg ,bo.sustained_idx_fl , 
	bo.pref_ori_multi_dg ,bo.pref_ori_multi_sg , bo.pref_phase_multi_sg ,bo.image_selectivity_ns , 
	bo.pref_images_multi_ns ,bo.lifetime_sparseness_dg , bo.lifetime_sparseness_fl ,bo.lifetime_sparseness_ns , 
	bo.lifetime_sparseness_rf ,bo.lifetime_sparseness_sg 
	INTO allen_neuropixel.temp_bo_vis 
	FROM allen_neuropixel.metrics_brain_observatory as bo 
	INNER JOIN 
	(SELECT goodu.id 
	 FROM allen_neuropixel.temp_good_units as goodu 
	 WHERE goodu.ecephys_structure_acronym 
	 IN 
	(SELECT vc.ecephys_structure_acronym 
	 FROM allen_neuropixel.visual_cortex_labels as vc)) 
	 as ufilt 
	 ON 
	(bo.ecephys_unit_id=ufilt.id); 

COPY allen_neuropixel.temp_bo_vis 
	TO 'C:/Users/Public/Brain_Observatory_Visual_Cortex.csv' WITH 
	CSV HEADER;
DROP TABLE allen_neuropixel.temp_bo_vis;

--13.Create a temporary table by selecting the units from Brain Observatory with good quality recorded at hippocampal
--formation, store their metrics from the tables associated with the metrics. 
--After table is created, write it to a csv file and delete this temporary table. 
SELECT bo.c50_dg, bo.area_rf,bo.fano_dg, bo.fano_fl,bo.fano_ns, bo.fano_rf ,bo.fano_sg , bo.f1_f0_dg ,bo.g_dsi_dg ,
	bo.g_osi_dg ,bo.g_osi_sg , bo.width_rf ,bo.height_rf , bo.azimuth_rf ,bo.mod_idx_dg , bo.p_value_rf ,bo.pref_sf_sg,
	bo.pref_tf_dg ,bo.run_mod_dg , bo.run_mod_fl ,bo.run_mod_ns , bo.run_mod_rf ,bo.run_mod_sg , bo.pref_ori_dg ,
	bo.pref_ori_sg, bo.run_pval_dg ,bo.run_pval_fl , bo.run_pval_ns ,bo.run_pval_rf, bo.run_pval_sg ,bo.elevation_rf ,
	bo.on_screen_rf ,bo.pref_image_ns , bo.pref_phase_sg ,bo.firing_rate_dg, bo.firing_rate_fl ,bo.firing_rate_ns , 
	bo.firing_rate_rf ,bo.firing_rate_sg , bo.on_off_ratio_fl ,bo.time_to_peak_fl , bo.time_to_peak_ns ,
	bo.time_to_peak_rf, bo.time_to_peak_sg ,bo.pref_sf_multi_sg , bo.pref_tf_multi_dg ,bo.sustained_idx_fl , 
	bo.pref_ori_multi_dg ,bo.pref_ori_multi_sg , bo.pref_phase_multi_sg ,bo.image_selectivity_ns , 
	bo.pref_images_multi_ns ,bo.lifetime_sparseness_dg , bo.lifetime_sparseness_fl ,bo.lifetime_sparseness_ns , 
	bo.lifetime_sparseness_rf ,bo.lifetime_sparseness_sg 
	INTO allen_neuropixel.temp_bo_hf 
	FROM allen_neuropixel.metrics_brain_observatory as bo 
	INNER JOIN 
	(SELECT goodu.id 
	 FROM allen_neuropixel.temp_good_units as goodu 
	 WHERE goodu.ecephys_structure_acronym 
	 IN 
	 (SELECT hf.ecephys_structure_acronym 
	  FROM allen_neuropixel.hippocampal_formation_labels as hf)) as ufilt 
	 ON 
	 (bo.ecephys_unit_id=ufilt.id); 

COPY allen_neuropixel.temp_bo_hf TO 'C:/Users/Public/Brain_Observatory_Hippocampal_Formation.csv' 
	WITH CSV HEADER;
DROP TABLE allen_neuropixel.temp_bo_hf;

--Repeat the Same Process for the Functional Connectivity Dataset.

--14.Create a temporary table by selecting the units from Functional Connectivity with good quality recorded at visual 
--cortex, store their metrics from the tables associated with the metrics. 
--After table is created, write it to a csv file and delete this temporary table.
SELECT fc.c50_dg, fc.area_rf,fc.fano_dg, fc.fano_dm ,fc.fano_fl,fc.fano_rf, fc.f1_f0_dg,fc.g_dsi_dg, fc.g_osi_dg, 
	fc.width_rf,fc.height_rf, fc.azimuth_rf,fc.mod_idx_dg, fc.p_value_rf, fc.pref_tf_dg,fc.run_mod_dg, fc.run_mod_dm,
	fc.run_mod_fl,fc.run_mod_rf,fc.pref_dir_dm, fc.pref_ori_dg, fc.run_pval_dg,fc.run_pval_dm,fc.run_pval_fl,
	fc.run_pval_rf, fc.elevation_rf, fc.on_screen_rf, fc.pref_speed_dm, fc.firing_rate_dg,fc.firing_rate_dm, 
	fc.firing_rate_fl,fc.firing_rate_rf, fc.on_off_ratio_fl, fc.time_to_peak_dm,fc.time_to_peak_fl, fc.time_to_peak_rf,
	fc.pref_tf_multi_dg ,fc.sustained_idx_fl, fc.pref_dir_multi_dg,fc.pref_ori_multi_dg,fc.pref_speed_multi_dm,
	fc.lifetime_sparseness_dg, fc.lifetime_sparseness_dm, fc.lifetime_sparseness_fl,fc.lifetime_sparseness_rf 
	INTO allen_neuropixel.temp_fc_vis 
	FROM allen_neuropixel.metrics_functional_connectivity as fc 
	INNER JOIN 
	(SELECT goodu.id 
	 FROM allen_neuropixel.temp_good_units as goodu 
	 WHERE goodu.ecephys_structure_acronym 
	 IN 
	 (SELECT vc.ecephys_structure_acronym 
	  FROM allen_neuropixel.visual_cortex_labels as vc)) as ufilt 
	 ON 
	 (fc.ecephys_unit_id=ufilt.id); 

COPY allen_neuropixel.temp_fc_vis 
	TO 'C:/Users/Public/Functional_Connectivity_Visual_Cortex.csv' 
	WITH CSV HEADER;
DROP TABLE allen_neuropixel.temp_fc_vis;

--15.Create a temporary table by selecting the units from Functional Connectivity with good quality recorded at 
--hippocampal formation cortex, store their metrics from the tables associated with the metrics. 
--After table is created, write it to a csv file and delete this temporary table. 
SELECT fc.c50_dg, fc.area_rf,fc.fano_dg, fc.fano_dm ,fc.fano_fl,fc.fano_rf, fc.f1_f0_dg,fc.g_dsi_dg, fc.g_osi_dg, 
	fc.width_rf,fc.height_rf, fc.azimuth_rf,fc.mod_idx_dg, fc.p_value_rf, fc.pref_tf_dg,fc.run_mod_dg, fc.run_mod_dm,
	fc.run_mod_fl,fc.run_mod_rf,fc.pref_dir_dm, fc.pref_ori_dg, fc.run_pval_dg,fc.run_pval_dm,fc.run_pval_fl,
	fc.run_pval_rf, fc.elevation_rf, fc.on_screen_rf, fc.pref_speed_dm, fc.firing_rate_dg,fc.firing_rate_dm, 
	fc.firing_rate_fl,fc.firing_rate_rf, fc.on_off_ratio_fl, fc.time_to_peak_dm,fc.time_to_peak_fl, fc.time_to_peak_rf,
	fc.pref_tf_multi_dg ,fc.sustained_idx_fl, fc.pref_dir_multi_dg,fc.pref_ori_multi_dg,fc.pref_speed_multi_dm,
	fc.lifetime_sparseness_dg, fc.lifetime_sparseness_dm, fc.lifetime_sparseness_fl,fc.lifetime_sparseness_rf 
	INTO allen_neuropixel.temp_fc_hf 
	FROM allen_neuropixel.metrics_functional_connectivity as fc 
	INNER JOIN 
	(SELECT goodu.id 
	 FROM allen_neuropixel.temp_good_units as goodu 
	 WHERE goodu.ecephys_structure_acronym 
	 IN 
	 (SELECT hf.ecephys_structure_acronym 
	  FROM allen_neuropixel.hippocampal_formation_labels as hf))
	  as ufilt 
	 ON 
	(fc.ecephys_unit_id=ufilt.id); 

COPY allen_neuropixel.temp_fc_hf 
	TO 'C:/Users/Public/Functional_Connectivity_Hippocampal_Formation.csv' 
	WITH CSV HEADER;
DROP TABLE allen_neuropixel.temp_fc_hf;

--16.Delete all the other temporary tables created for this query.
DROP TABLE allen_neuropixel.temp_good_units;
DROP TABLE allen_neuropixel.visual_cortex_labels;
DROP TABLE allen_neuropixel.hippocampal_formation_labels;
