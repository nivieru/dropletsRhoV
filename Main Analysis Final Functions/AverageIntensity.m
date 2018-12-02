function AverageIntensityMatrix=AverageIntensity(pix_matrix_1,Number_of_frames_1) 

sum_matrix=pix_matrix_1(:,:,1)+pix_matrix_1(:,:,2);

  for f=3:Number_of_frames_1; 
    
    sum_matrix=sum_matrix+pix_matrix_1(:,:,f);
    
  end

AverageIntensityMatrix=sum_matrix;
AverageIntensityMatrix=sum_matrix/Number_of_frames_1;

end
    