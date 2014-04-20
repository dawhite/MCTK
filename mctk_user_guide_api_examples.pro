;Level 1A example
pro test_batch_modis_conversion_level_1a
  compile_opt idl2

  modis_l1a_file = 'C:\MCTK_Input\MOD01.A2013034.1620.006.2013298222057.hdf'

  ;The specified output location MUST end in the appropriate path 
  ;separator for your OS
  output_location = 'C:\MCTK_Output\'

  output_rootname = 'level_1a'

  ;Output method schema is:
  ;0 = Standard, 1 = Projected, 2 = Standard and Projected
  out_method = 1

  ;Specify MOD03/MYD03 file to use for georeferencing
  geoloc_file = 'C:\MCTK_Input\MOD03.A2013034.1620.006.2013035002707.hdf'

  output_projection = envi_proj_create(/geographic)

  ;Choosing linear interpolation
  interpolation_method = 1

  ;do not put the bridge creation/destruction code inside a loop
  bridges = mctk_create_bridges()

  convert_modis_data, in_file=modis_l1a_file, out_path=output_location, $
    out_root=output_rootname, out_method=out_method, $
    geoloc_file=geoloc_file, out_proj=output_projection, $
    interp_method=interpolation_method, $
    sd_pos=[0,1,2,3], /no_msg, r_fid_array=r_fid_array, $
    r_fname_array=r_fname_array, bridges=bridges, msg=msg

  mctk_destroy_bridges, bridges

end


;Level 1B example
pro test_batch_modis_conversion_level_1b
  compile_opt idl2

  modis_l1b_file = 'C:\MCTK_Input\MOD021KM.A2013273.0200.006.2013273140519.hdf'

  ;The specified output location MUST end in the appropriate path 
  ;separator for your OS
  output_location = 'C:\MCTK_Output\'

  output_rootname = 'level_1b'

  ;Calibration method schema is:
  ;0 = Radiance / Emissivity, 1 = Reflectance / Emissivity, 2 = Radiance / Brightness Temp
  calib_method = 2

  ;Output method schema is:
  ;0 = Standard, 1 = Projected, 2 = Standard and Projected
  out_method = 1

  output_projection = envi_proj_create(/geographic)

  ;do not put the bridge creation/destruction code inside a loop
  bridges = mctk_create_bridges()

  ;Choosing linear interpolation
  interpolation_method = 1

  convert_modis_data, in_file=modis_l1b_file, out_path=output_location, $
    out_root=output_rootname, out_method=out_method, $
    interp_method=interpolation_method, $
    out_proj=output_projection, calib_method=calib_method, $
    sd_pos=[1,3], /no_msg, background=0.0, r_fid_array=r_fid_array, $
    r_fname_array=r_fname_array, bridges=bridges, msg=msg

  mctk_destroy_bridges, bridges

end


;MOD14 example
pro test_batch_modis_conversion_mod14
  compile_opt idl2

  modis_mod14_file = 'C:\MCTK_Input\MOD14.A2013290.0150.005.2013290065458.hdf'

  ;The specified output location MUST end in the appropriate path 
  ;separator for your OS
  output_location = 'C:\MCTK_Output\'

  output_rootname = 'fire_mask'

  sd_names = ['fire mask','algorithm QA']

  ;Since MOD14/MYD14 files have no geofields, georeferencing is 
  ;not possible with this product unless you supply separate MOD03/MYD03 files
  out_method = 1
  geoloc_file = 'C:\MCTK_Input\MOD03.A2013290.0150.005.2013290074930.hdf'
  
  ;use nearest neighbor interpolation
  interpolation = 0

  ;do not put the bridge creation/destruction code inside a loop
  bridges = mctk_create_bridges()
  
  ;use default UTM projection
  convert_modis_data, in_file=modis_mod14_file, $
    out_path=output_location, out_root=output_rootname, $
    sd_names=sd_names, out_method=out_method, geoloc_file=geoloc_file, $
    /default_utm, interp_method=interpolation, r_fid_array=r_fid_array, $
    r_fname_array=r_fname_array, bridges=bridges, msg=msg

  mctk_destroy_bridges, bridges

end


;Level 2 swath example
pro test_batch_modis_conversion_l2_swath
  compile_opt idl2

  modis_swath_file = 'C:\MCTK_Input\MOD07_L2.A2013173.0710.006.2013173195131.hdf'

  ;The specified output location MUST end in the appropriate path 
  ;separator for your OS
  output_location = 'C:\MCTK_Output\'

  output_rootname = 'atm_profile'

  swath_name = 'mod07'

  sd_names = ['Retrieved_Temperature_Profile','Total_Ozone','Water_Vapor']

  ;Output method schema is:
  ;0 = Standard, 1 = Projected, 2 = Standard and Projected
  out_method = 1

  output_projection = envi_proj_create(/geographic)

  ;Choosing nearest neighbor interpolation
  interpolation_method = 0

  ;do not put the bridge creation/destruction code inside a loop
  bridges = mctk_create_bridges()

  convert_modis_data, in_file=modis_swath_file, $
    out_path=output_location, out_root=output_rootname, $
    swt_name=swath_name, sd_names=sd_names, $
    out_method=out_method, out_proj=output_projection, $
    interp_method=interpolation_method, /no_msg, $
    r_fid_array=r_fid_array, r_fname_array=r_fname_array, $
    bridges=bridges, msg=msg

  mctk_destroy_bridges, bridges

end


;Grid example
pro test_batch_modis_conversion_grid
  compile_opt idl2

  modis_grid_file = 'C:\MCTK_Input\MOD09GA.A2014108.h17v06.005.2014110053957.hdf'

  ;The specified output location MUST end in the appropriate path 
  ;separator for your OS
  output_location = 'C:\MCTK_Output\'

  output_rootname = 'surf_refl'

  grid_name = 'MODIS_Grid_500m_2D'

  sd_names = ['sur_refl_b01_1','sur_refl_b02_1','sur_refl_b03_1',$
    'sur_refl_b04_1','sur_refl_b05_1','sur_refl_b06_1','sur_refl_b07_1']

  ;Output method schema is:
  ;0 = Standard, 1 = Reprojected, 2 = Standard and reprojected
  out_method = 1

  output_projection = envi_proj_create(/geographic)

  ;Specify the output X and Y pixel sizes in double precision floating 
  ;point. Sizes must be in units relevant to selected output projection 
  ;(degrees in this example).
  out_ps = [0.004187d,0.004187d]

  ;Choosing cubic convolution interpolation.
  interpolation_method = 2

  ;Set reprojection background and any native fill values to NaN
  nan_fill = float('NaN')
  convert_modis_data, in_file=modis_grid_file, $
    out_path=output_location, out_root=output_rootname, $
    gd_name=grid_name, sd_names=sd_names, $
    out_method=out_method, out_proj=output_projection, $
    out_ps=out_ps, interp_method=interpolation_method, $
    background=nan_fill, fill_replace_value=nan_fill, $
    r_fid_array=r_fid_array, r_fname_array=r_fname_array, $
    msg=msg

end
