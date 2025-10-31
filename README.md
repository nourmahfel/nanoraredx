<h1>
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/images/nf-core-nanoraredx_logo_dark.png">
    <img alt="nf-core/nanoraredx" src="docs/images/nf-core-nanoraredx_logo_light.png">
  </picture>
</h1>

[![GitHub Actions CI Status](https://github.com/nf-core/longraredisease/actions/workflows/ci.yml/badge.svg)](https://github.com/nf-core/longraredisease/actions/workflows/ci.yml)
[![GitHub Actions Linting Status](https://github.com/nf-core/longraredisease/actions/workflows/linting.yml/badge.svg)](https://github.com/nf-core/longraredisease/actions/workflows/linting.yml)
[![AWS CI](https://img.shields.io/badge/CI%20tests-full%20size-FF9900?labelColor=000000&logo=Amazon%20AWS)](https://nf-co.re/longraredisease/results)
[![Cite with Zenodo](http://img.shields.io/badge/DOI-10.5281/zenodo.XXXXXXX-1073c8?labelColor=000000)](https://doi.org/10.5281/zenodo.XXXXXXX)
[![nf-test](https://img.shields.io/badge/unit_tests-nf--test-337ab7.svg)](https://www.nf-test.com)

[![Nextflow](https://img.shields.io/badge/nextflow%20DSL2-%E2%89%A524.04.2-23aa62.svg)](https://www.nextflow.io/)
[![run with conda](http://img.shields.io/badge/run%20with-conda-3EB049?labelColor=000000&logo=anaconda)](https://docs.conda.io/en/latest/)
[![run with docker](https://img.shields.io/badge/run%20with-docker-0db7ed?labelColor=000000&logo=docker)](https://www.docker.com/)
[![run with singularity](https://img.shields.io/badge/run%20with-singularity-1d355c.svg?labelColor=000000)](https://sylabs.io/docs/)
[![Launch on Seqera Platform](https://img.shields.io/badge/Launch%20%F0%9F%9A%80-Seqera%20Platform-%234256e7)](https://cloud.seqera.io/launch?pipeline=https://github.com/nf-core/longraredisease)

[![Get help on Slack](http://img.shields.io/badge/slack-nf--core%20%23longraredisease-4A154B?labelColor=000000&logo=slack)](https://nfcore.slack.com/channels/longraredisease)
[![Follow on Twitter](http://img.shields.io/badge/twitter-%40nf__core-1DA1F2?labelColor=000000&logo=twitter)](https://twitter.com/nf_core)
[![Follow on Mastodon](https://img.shields.io/badge/mastodon-nf__core-6364ff?labelColor=FFFFFF&logo=mastodon)](https://mstdn.science/@nf_core)
[![Watch on YouTube](http://img.shields.io/badge/youtube-nf--core-FF0000?labelColor=000000&logo=youtube)](https://www.youtube.com/c/nf-core)

---

## Introduction

**longraredisease** is a comprehensive Nextflow pipeline for Oxford Nanopore sequencing analysis, designed for rare disease research and diagnostics. It delivers high-confidence variant discovery by integrating multiple state-of-the-art tools. longraredisease performs multi-caller structural variant (SV) detection, single nucleotide variant (SNV) calling, copy number variant (CNV) analysis, short tandem repeat (STR) detection, and phasing analysis in a reproducible, modular workflow.

**Pipeline Overview**
- **Structural Variants (SVs):** Sniffles, CuteSV, SVIM, with Jasmine merging
- **Single Nucleotide Variants (SNVs):** Clair3, DeepVariant
- **Copy Number Variants (CNVs):** HifiCNV, Spectre
- **Short Tandem Repeats (STRs):** STRaglr
- **Phasing:** LongPhase
- **Quality Control:** Coverage analysis with mosdepth

---

## Requirements

**Software:**
- Nextflow (≥22.10.0)
- Docker or Singularity/Apptainer

**Hardware:**
Will be updated later in the project

---

## Quick Start

**1. Clone the Repository**
```bash
git clone https://github.com/nourmahfel/nf-core-longraredisease.git
cd nf-core-longraredisease
```
**2. Test Installation**
```bash
nextflow run main.nf -profile test,docker
```
**3. Run with Your Data**
```bash
nextflow run main.nf     --ubam /path/to/bam/files      --outdir results     -profile docker
```
---

## Input Data Requirements

| Parameter        | Description                   | Format         | Required |
|------------------|------------------------------|----------------|----------|
| --ubam           | Directory containing BAM files | Directory path | ✅       |
| --ubam           | Single unmapped bam            | File path      | ✅       |
| --fastq_dir      | Directory containing fastqs    | Directory path | ✅       |
| --aligned_bam    | Single aligneed bam            | File path      | ✅       |
| --fasta_file     | Reference genome FASTA         | .fasta/.fa     | ✅       |
| --outdir         | Output directory               | Directory path | ✅       |
| --str_bed_file   | STR regions for analysis       | .bed           | ✅       |
| --target_bed       | Target regions BED file        | .bed           | Optional |
| --chrom_sizes    | Chromosome sizes file          | .txt           | Optional |


---

## Configuration Parameters

**Core Analysis Options**
```bash
--align_with_bam  true/false      # Enable alignment
--align_with_fastq   true/false   # Enable alignment with FASTQ files
--generate_bam_stats true/false   # Enable generation of BAM statistics
--generate_coverage true/false    # Run mosdepth
--snv true/false                  # SNV calling (default: true)
--cnv_spectre true/false          # CNV calling (default: true)
--cnv_hificnv true/false          # CNV calling (default: true)
--str true/false                  # STR analysis (default: true)
--phase true/false                # Phasing analysis (default: true)
--phase_with_sv true/false        # Include SVs in phasing (default: true)
--qc true/false                   # Enable quality control
--methyl true/false               # Enable methylation calling
--annotate_sv  true/false         # Enable SV annotation with SvAnna

```
**SV Calling Parameters**
```bash
--filter_sv_pass  true/false           # Apply coverage-based filtering (default: true)
--downsample_sv   true/false           # Downsample by coverage
--min_read_support auto/integer        # Minimum read support (default: auto)
--min_read_support_limit integer       # Minimum support limit (default: 3)
--merge_sv       true/false            # Merge calls from multiple callers (default: true)
```
**SNV Calling Parameters**
```bash
--clair3_model string                  # Model name (default: r1041_e82_400bps_sup_v500)
--clair3_platform ont/pacbio           # Sequencing platform (default: ont)
--use_deepvariant true/false           # Run DeepVariant alongside Clair3 (default: true)
```
**CNV Calling Parameters**
```bash
--spectre_fasta_file path              # Full genome FASTA for Spectre
--spectre_mosdepth path                # Mosdepth regions file
--spectre_snv_vcf path                 # SNV VCF for Spectre
```
---

## Usage Examples

**Basic Run**
```bash
nextflow run main.nf     --ubam /data/bam_files     --fasta_file /ref/genome.fasta     --outdir results     -profile docker
```
**SV-Only Analysis**
```bash
nextflow run main.nf     --ubam /data/bam_files     --fasta_file /ref/genome.fasta     --snv false     --cnv_hificnv false     --str false     --phase false     --outdir sv_results     -profile docker
```
**Targeted Analysis with BED File**
```bash
nextflow run main.nf     --ubam /data/bam_files     --fasta_file /ref/genome.fasta     --target_bed /targets/exome.bed       --outdir targeted_results     -profile docker
```
**High-Sensitivity SV Calling**
```bash
nextflow run main.nf     --ubam /data/bam_files     --fasta_file /ref/genome.fasta     --min_supporting_callers 1     --min_sv_size 20     --filter_sv_calls false     --outdir sensitive_sv     -profile docker
```
**Custom Resource Limits**
```bash
nextflow run main.nf     --ubam /data/bam_files     --fasta_file /ref/genome.fasta     --outdir results     -profile docker     --max_cpus 32     --max_memory 128.GB
```
---

## Output Structure

```
.
├── pipeline_info
│   ├── execution_trace_2025-10-31_15-04-22.txt
├── ref
└── test
    ├── bam_stats
    ├── clair3
    ├── cutesv
    ├── deepvariant
    ├── fastq_files
    ├── filtered_pass_sv
    ├── hificnv
    ├── longphase
    ├── mapped_bam
    ├── merged_SNV
    ├── merged_sv
    ├── methyl
    ├── methyl_bedgraph
    ├── mosdepth
    ├── nanoplot_qc
    ├── sniffles
    ├── straglr
    ├── svanna
    ├── svim
    ├── unmapped_bam
    └── unzippedSV_vcfs
```
---

## Configuration Profiles

**Available Profiles:**
- test: Minimal test dataset
- docker: Use Docker containers
- singularity: Use Singularity containers


**Custom Configuration**
```bash
// custom.config
params {
    max_cpus = 16
    max_memory = '64.GB'
    outdir = '/scratch/results'
}

process {
    withName: 'CLAIR3' {
        cpus = 8
        memory = '32.GB'
    }
}
```
Run with:
```bash
nextflow run main.nf -c custom.config -profile docker
```
---

## Test Data

The pipeline includes test data for validation:

- Location: assets/test_data/
- Genome: Chromosome 22 subset
- Samples: Simulated nanopore data
- Runtime: ~10-15 minutes

---

## Performance Optimization

**For Large Datasets**
- Increase resource limits: --max_cpus 64 --max_memory 256.GB
- Use faster storage: --outdir /fast_storage/results
- Enable process caching: -resume

**For Limited Resources**
- Reduce parallel processes: --max_cpus 4 --max_memory 16.GB
- Disable resource-intensive analyses: --use_deepvariant false --cnv false

---

## Troubleshooting

**Common Issues**

- Out of Memory Errors:
  Increase memory limits, e.g. --max_memory 64.GB
- File Not Found Errors:
  Check file paths and permissions (ls -la /path/to/input/files)
- Container Issues:
  Try different container engine (-profile singularity)
- JASMINE Filename Collisions:
  Ensure BAM files have unique prefixes
  Check that filter_sv_calls is properly configured

**Getting Help**
- Check the .nextflow.log file for detailed error messages
- Use -resume to restart from the last successful step
- Enable debug mode:
```bash
nextflow run main.nf -profile test,docker --debug
```
---

## Citation

If you use longraredisease in your research, please cite:


---

## Contributing

We welcome contributions! Please see our Contributing Guidelines for details.

---

## License

This project is licensed under the MIT License – see the LICENSE file for details.

---

This pipeline integrates several tools for variant calling:
Sniffles, CuteSV, SVIM, JASMINESV, Clair3, DeepVariant, LongPhase, Spectre, STRaglr
