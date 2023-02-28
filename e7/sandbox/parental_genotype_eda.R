tar_load(c(vcf_data, output_data, onemap_vcf))

vcf_gt <- extract.gt(vcf_data)

allele_freqs <- output_data$allele_freq %>% 
  mutate(marker_name = paste(CHROM, POS, sep = "_")) %>% 
  select(marker_name, ALLELE_1_FREQ, ALLELE_2_FREQ, ALLELE_3_FREQ)

marker_quality <- output_data %>% 
  pluck("quality_site") %>% 
  mutate(marker_name = paste(CHROM, POS, sep = "_")) %>% 
  select(marker_name, QUAL)


# Get parental genotypes
parent_genos <- vcf_gt[, c("female", "male")] %>% 
  as.data.frame() %>% 
  rownames_to_column(var = "marker_name") %>% 
  left_join(allele_freqs, by = "marker_name") %>% 
  left_join(marker_quality, by = "marker_name") %>% 
  mutate(ALLELE_1_FREQ = as.numeric(ALLELE_1_FREQ), 
         ALLELE_2_FREQ = as.numeric(ALLELE_2_FREQ), 
         ALLELE_3_FREQ = as.numeric(ALLELE_3_FREQ), 
         female = factor(female), 
         male = factor(male))


parent_genos %>% 
  dplyr::filter(ALLELE_1_FREQ < 0.7, ALLELE_1_FREQ > 0.4)


segregating_marks <- test_segregation(onemap_vcf) %>% 
  select_segreg()

parent_seg <- parent_genos %>% 
  mutate(is_segreg = ifelse(marker_name %in% segregating_marks, TRUE, FALSE)) %>% 
  dplyr::filter(is_segreg) %>% 
  arrange(ALLELE_1_FREQ)

parent_genos %>% 
  group_by(female, male) %>% 
  summarize(avg_allele_1 = mean(ALLELE_1_FREQ, na.rm = TRUE), 
            avg_allele_2 = mean(ALLELE_2_FREQ, na.rm = TRUE), 
            n_geno_combs = n(), 
            prop_geno_combs = n_geno_combs/nrow(parent_genos)) %>% 
  arrange(desc(avg_allele_1))
