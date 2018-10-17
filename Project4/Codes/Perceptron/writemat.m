function [] = writemat( filename, probMat )
    fileID1 = fopen(filename,'w');
    formatspec1 = '%f %f %d %d %f\n';
    size_m = size(probMat);
    row = size_m(1);
    for k = 1:row
        fprintf(fileID1, formatspec1, probMat(k, 1), probMat(k, 2), probMat(k, 3), probMat(k, 4), probMat(k, 5));
    end
end