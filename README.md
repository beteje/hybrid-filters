# hybrid-filters

The hybrid filter toolbox creates hybrid adaptive filters which implement a
convex combination of two subfilters to take advantage of the different
properties of the filters. By tracking the value of the convex mixing
parameter, lambda, of the hybrid filter can also be used to track changes in
the nature of the signal being processed. This can be achieved using
subfilters designed to deal with different signal properties, such as
nonlinearity, sparsity etc.

The primary hybrid filter operation is performed by 

 - Hybrid_Filter.m

The subfilters used in the hybrid filter can be a combination of the provided
subfilters or your own filter passed as a handle to the function

 - ACLMS_subFilter.m
 - CLMS_subFilter.m
 - CNGD_subFilter.m
 - CNNGD_subFilter.m
 - GNGD_subFilter.m
 - LMS_subFilter.m
 - NLMS_subFilter.m
 - NNGD_subFilter.m
 - SSLMS_subFilter.m

Sample input signals are given in 

 - ar2_gaussian.m
 - ar4_gaussian.m
 - ar4_ikeda.m
 - ikeda.m
 - nonlinearsig.m
 - nonlinearsig2.m
 - sparsesig.m

All of these (except ikeda.m) can also be used to create an alternating signal
with common noise source using

 - alternating.m

