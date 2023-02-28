tar_load(onemap_vcf)

onemap_bins <- find_bins(onemap_vcf)

onemap_segreg_test <- test_segregation(onemap_vcf)
seg_marks <- select_segreg(onemap_segreg_test, numbers = TRUE)


recomb_freq <- rf_2pts(onemap_vcf)
non_dist_marks <- make_seq(recomb_freq, seg_marks)


LGs <- group(non_dist_marks)
set_map_fun(type = "kosambi")

LG_1 <- make_seq(LGs, 1)

marker_map_rcd <- rcd(LG_1)
