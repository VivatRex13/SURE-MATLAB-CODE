S_data1 = sparameters('1D_Antenna_Array_Parallel_Microstrip_ZMatrix_5-9mm.s21p');
S_data2 = sparameters('1D_Antenna_Array_Parallel_Microstrip_ZMatrix_10mm.s21p');

S1 = S_data1.Parameters;
S2 = S_data2.Parameters;

S1 = abs(S1);
S2 = abs(S2);

W = width (S1);

S1_sum = S1(2,1);
S2_sum = S2(2,1);

for i = 2:W-1
    S1_sum = S1_sum + S1(i-1,i) + S1(i+1,i);
    S2_sum = S2_sum + S2(i-1,i) + S2(i+1,i);
end

S1_sum = S1_sum + S1(W-1,W);
S2_sum = S2_sum + S2(W-1,W);

S1_av = S1_sum / (2*(W-1))
S2_av = S2_sum / (2*(W-1))