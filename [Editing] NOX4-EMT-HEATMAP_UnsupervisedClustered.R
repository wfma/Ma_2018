### Libraries ----
library(ggplot2)
library(reshape2)
library(tidyr)
library(stringr)
library(survival)
library(RTCGAToolbox)
library(survminer)
library(readr)
library(tibble)
library(ggforce)
library(superheat) 
# custom install from github, 
# install.packages("devtools")
# devtools::install_github("rlbarter/superheat")
library(dplyr)

### Set Working Directory PLEASE ADJUST TO YOUR COMPUTER ----
# suggestion: create a new folder called R_Cache on desktop. It will save time
setwd("~/Desktop/R_Cache")
### Gene Lists----
Gene.list <- c(
  "FN1",
  "VIM",
  "CDH2",
  "ZEB1",
  "ZEB2",
  "MMP9",
  "MMP2",
  "TWIST1",
  "SNAI1",
  "SNAI2",
  "ACTA2",
  "CLDN1",
  "DSP",
  "PKP1",
  "CDH1",
  "NOX1",
  "NOX4",
  "CYBB",
  # CYBB= NOX2
  "NOX3",
  "NOX5",
  "CYBA",
  # p22phox
  "NOX4",
  "DUOX1",
  "DUOX2",
  ### recently added list
  "VTN",
  # vitronectin, valid
  "CXCL8",
  # IL8
  "COL1A1",
  # collagen type 1 alpha 1 chain, valid
  "ITGA5",
  # alpha 5 subunit of integrin, valid
  "AGXT",
  # angiotensin, IPA
  "AKT1",
  # alcohol binding phosphotransferase
  "AKT2",
  "TGFB1",
  "TGFB2",
  "TGFB3",
  "MMP3",
  "WNT5A",
  "WNT5B",
  "COL1A2",
  # collagen type I alpha 2 chain
  "COL3A1",
  "COL5A2",
  "ILK",
  # integrin linked kinase
  "CXCR4",
  "CXCL12",
  # chemokine, also known as SDF1
  "ITGAV",
  "TGFBR1",
  "TJP1",
  # zonuli1
  "CRB1",
  # cell polarity complex crumbs1, valid
  "KRT18",
  "TLR4",
  # keratin 18, valid
  ### below are from SABIoscience EMT array ###
  "AHNAK",
  "BMP1",
  "CALD1",
  "CAMK2N1",
  #notfound
  "FOXC2",
  "GNG11",
  "GSC",
  "IGFBP4",
  "ITGA5",
  "MSN",
  "SERPINE1",
  "SNAI1",
  "SNAI2",
  "SNAI3",
  "SOX10",
  "SPARC",
  "STEAP1",
  "TCF7L2",
  "TIMP1",
  "TMEFF1",
  "TMEM132A",
  "TWIST1",
  "VCAN",
  "VIM",
  "VPS13A",
  "WNT5A",
  "WNT5B",
  #EMT-downregulated:
  "CAV2",
  "CDH1",
  "DSP",
  "FGFBP1",
  "IL1RN",
  "KRT19",
  "MITF",
  "MST1R",
  "NUDT13",
  "OCLN",
  "DESI1",
  "RGS2",
  "SPP1",
  "TFPI2",
  "TSPAN13",
  #MigrationandDevelopment:
  "CALD1",
  "CAV2",
  "EGFR",
  "FN1",
  "ITGB1",
  "JAG1",
  "MSN",
  "MST1R",
  "NODAL",
  "PDGFRB",
  "RAC1",
  "STAT3",
  "TGFB1",
  "VIM",
  #Adhesionandextracellularmatrix
  "BMP1",
  "BMP7",
  "CDH1",
  "CDH2",
  "COL1A1",
  "COL1A2",
  "COL3A1",
  "COL5A2",
  "CTNNB1",
  "DSC2",
  "EGFR",
  "ERBB3",
  "F11R",
  "FN1",
  "FOXC2",
  "ILK",
  "ITGA5",
  "ITGAV",
  "ITGB1",
  "MMP2",
  "MMP3",
  "MMP9",
  "PTK2",
  "RAC1",
  "SERPINE1",
  "SPP1",
  "TGFB1",
  "TGFB2",
  "TIMP1",
  "VCAN",
  "CDH1",
  "LMNA", #lamin 1
  "OCLN",
  "COL5A1",
  "MUC1", # mucin 1
  "DSG1", # desmoglein 1 
  "SDC1", # syndecan
  "KRT1",
  "KRT18",
  "CHD1",
  "CDH2",
  "CDH15",
  "CDH4",
  "CDH5",
  "DSC1", 
  "DSC2", 
  "DSG1", 
  "DSG2", 
  "DSG3", 
  "DSG4",
  "NECTIN1",
  "NECTIN2",
  "NECTIN3",
  "NECTIN4",
  "TJP1",
  "AJAP1",
  "CTNND1",
  "P2RX6",
  "VEZT",
  "ANG", # angiogensis
  "ANGPT1", # angiopoietin1
  "ANGPT2",
  "ANPEP", # alanyl aminopeptidase
  "TYMP", # thymidine phosphorylase 
  "FGF1", # fibroblast growth factor1
  "FGF2",
  "VEGFD", # vascular endothelial growth factor D
  "FLT1", # fms related tyrosine kinase1 interacts with VEGFRA/b
  "KDR", # encodes one of the two receptors of VEGF
  "NRP2", # neuropilin2
  "PGF", # placental growth factor
  "VEGFA",
  "VEGFB",
  "VEGFC",
  "ADGRB1", # bai1, bines to p53 and induced by wtp53
  "ANGPTL1",# angiopoietin like 4
  "HIF1A",
  "NANOS3",
  "NANOS2",
  "AGT",
  "ACTA2",
  "CCL11",
  "CCL2",
  "CCL3",
  "CTGF",
  "GREM1",
  "IL13",
  "IL13RA2",
  "IL4",
  "IL5",
  "CHD1",
  "CDH2",
  "CDH15",
  "CDH4",
  "CDH5",
  "DSC1", 
  "DSC2", 
  "DSG1", 
  "DSG2", 
  "DSG3", 
  "DSG4",
  "NECTIN1",
  "NECTIN2",
  "NECTIN3",
  "NECTIN4",
  "TJP1",
  "AJAP1",
  "CTNND1",
  "P2RX6",
  "VEZT",
  "NOX4", "CYBB", "NOX3", "NOX5", "DUOX1", "DUOX2", "CYBA", "NOX1"
  
  
)
#belowisfromSABioScience
#EMT-upregulated:
EMT.SAbiosci.genes <-
  c(
    "AHNAK",
    "BMP1",
    "CALD1",
    "CAMK2N1",
    "CDH2",
    "COL1A2",
    "COL3A1",
    "COL5A2",
    "FN1",
    "FOXC2",
    "GNG11",
    "GSC",
    "IGFBP4",
    "ITGA5",
    "ITGAV",
    "MMP2",
    "MMP3",
    "MMP9",
    "MSN",
    "SERPINE1",
    "SNAI1",
    "SNAI2",
    "SNAI3",
    "SOX10",
    "SPARC",
    "STEAP1",
    "TCF7L2",
    "TIMP1",
    "TMEFF1",
    "TMEM132A",
    "TWIST1",
    "VCAN",
    "VIM",
    "VPS13A",
    "WNT5A",
    "WNT5B",
    "NOX4", "CYBB", "NOX3", "NOX5", "DUOX1", "DUOX2", "CYBA", "NOX1"
  )
#EMT-downregulated:
MET.SAbiosci.genes <-
  c(
    
    "CDH1",
    "LMNA", #lamin 1
    "OCLN",
    "COL5A1",
    "MUC1", # mucin 1
    "DSG1", # desmoglein 1 
    "SDC1", # syndecan
    "KRT1",
    "KRT18",
    "NOX4", "CYBB", "NOX3", "NOX5", "DUOX1", "DUOX2", "CYBA", "NOX1"
  )
#Adherant Junctions:
Adh.Junctions.SAbiosci.genes <- 
  c(
    "CHD1",
    "CDH2",
    "CDH15",
    "CDH4",
    "CDH5",
    "DSC1", 
    "DSC2", 
    "DSG1", 
    "DSG2", 
    "DSG3", 
    "DSG4",
    "NECTIN1",
    "NECTIN2",
    "NECTIN3",
    "NECTIN4",
    "TJP1",
    "AJAP1",
    "CTNND1",
    "P2RX6",
    "VEZT",
    "NOX4", "CYBB", "NOX3", "NOX5", "DUOX1", "DUOX2", "CYBA", "NOX1"
    
  )
#Angiogenesis:
Angiogensis.SAbiosci.genes <- 
  c(
    "ANG", # angiogensis
    "ANGPT1", # angiopoietin1
    "ANGPT2",
    "ANPEP", # alanyl aminopeptidase
    "TYMP", # thymidine phosphorylase 
    "FGF1", # fibroblast growth factor1
    "FGF2",
    "VEGFD", # vascular endothelial growth factor D
    "FLT1", # fms related tyrosine kinase1 interacts with VEGFRA/b
    "KDR", # encodes one of the two receptors of VEGF
    "NRP2", # neuropilin2
    "PGF", # placental growth factor
    "VEGFA",
    "VEGFB",
    "VEGFC",
    "ADGRB1", # bai1, bines to p53 and induced by wtp53
    "ANGPTL1",# angiopoietin like 4
    "HIF1A",
    "NOX4", "CYBB", "NOX3", "NOX5", "DUOX1", "DUOX2", "CYBA", "NOX1"
    
  )
#MigrationandDevelopment:
Migration.SAbiosci.genes <-
  c(
    "CALD1",
    "CAV2",
    "EGFR",
    "FN1",
    "ITGB1",
    "JAG1",
    "MSN",
    "MST1R",
    "NODAL",
    "PDGFRB",
    "RAC1",
    "STAT3",
    "TGFB1",
    "VIM",
    "NOX4", "CYBB", "NOX3", "NOX5", "DUOX1", "DUOX2", "CYBA", "NOX1"
  )
#Adhesionandextracellularmatrix
Adhesion.SAbiosci.genes <-
  c(
    "BMP1",
    "BMP7",
    "CDH1",
    "CDH2",
    "COL1A1",
    "COL1A2",
    "COL3A1",
    "COL5A2",
    "CTNNB1",
    "DSC2",
    "EGFR",
    "ERBB3",
    "F11R",
    "FN1",
    "FOXC2",
    "ILK",
    "ITGA5",
    "ITGAV",
    "ITGB1",
    "MMP2",
    "MMP3",
    "MMP9",
    "PTK2",
    "RAC1",
    "SERPINE1",
    "SPP1",
    "TGFB1",
    "TGFB2",
    "TIMP1",
    "VCAN",
    "NOX4", "CYBB", "NOX3", "NOX5", "DUOX1", "DUOX2", "CYBA", "NOX1"
  )

# PRO.Fibrosis genes
PRO.Fibrosis.SAbiosci.genes <- c(
  "NOX4", "CYBB", "NOX3", "NOX5", "DUOX1", "DUOX2", "CYBA", "NOX1",
  "AGT",
  "ACTA2",
  "CCL11",
  "CCL2",
  "CCL3",
  "CTGF",
  "GREM1",
  "IL13",
  "IL13RA2",
  "IL4",
  "IL5"
  
)

### Functions to download data ----
# Download Complete Sets of Data
dl.full <- function(x) {
  getFirehoseData(
    dataset = x,
    runDate = "20160128",
    gistic2_Date = "20160128",
    # gistic2 is CNA
    RNAseq_Gene = TRUE,
    # gene level expression data from RNA-seq [raw values]
    Clinic = TRUE,
    # clinical information of patient sample
    mRNA_Array = TRUE,
    # gene level expression data by array platform
    Mutation = TRUE,
    # Gene level mutation information matrix
    CNA_SNP = T, # copy number alterations in somatic cells provided by segmented sequecing
    CNA_Seq = T, # copy number alterations provided by NGS sequences
    CNA_CGH = T, # copy number alternations provided by CGH platform
    CNV_SNP = T, # copy number alterantion in germline cells
    # Methylation = T, # methylation provided by array platform
    # RPPA = T, # reverse phase protein array expression
    RNAseq2_Gene_Norm = TRUE,
    # normalized count
    fileSizeLimit = 99999,
    # getUUIDs = T,
    destdir = "FireHose Data",
    forceDownload = F
  )
}
# this S4 object can be extracted for dataframe containing information that can be plotted

# Gather mRNA in long form
dl.RNA.select <- function(y) {
  set <- getFirehoseData(
    dataset = y,
    runDate = "20160128",
    gistic2_Date = "20160128",
    # gistic2 is CNA``
    RNAseq_Gene = TRUE,
    # gene level expression data from RNA-seq [raw values]
    Clinic = F,
    # clinical information of patient sample
    mRNA_Array = F,
    # gene level expression data by array platform
    Mutation = TRUE,
    # Gene level mutation information matrix
    # CNA_SNP = T, # copy number alterations in somatic cells provided by segmented sequecing
    # CNA_Seq = T, # copy number alterations provided by NGS sequences
    # CNA_CGH = T, # copy number alternations provided by CGH platform
    # CNV_SNP = T, # copy number alterantion in germline cells
    # Methylation = T, # methylation provided by array platform
    # RPPA = T, # reverse phase protein array expression
    RNAseq2_Gene_Norm = TRUE,
    # normalized count
    fileSizeLimit = 99999,
    # getUUIDs = T,
    destdir = "FireHose Data",
    forceDownload = F
  )
  edit <- gather(rownames_to_column(as.data.frame(getData(set, type = "RNASeq2GeneNorm")), var = "Gene.Symbol"), 
                 key = "Patient.ID", value = "mRNA.Value", -Gene.Symbol) # extract RNAseq, transform row name as a colmn, then transform into long form
  edit$Patient.ID <- str_sub(edit$Patient.ID, start = 1, end = 15) # we remove the trailing barcodes so we can cross match the data later to patients
  # now remove RNA-expressions of genes we dont need
  edit2 <- edit[edit$Gene.Symbol %in% Gene.list,]
  rm(edit)
  rm(set)
  edit2
}

# Gather Clinical Data in long form
# we will use days to death for the survival
dl.surv <- function(z) {
  full.set <- getFirehoseData(
    dataset = z,
    runDate = "20160128",
    #gistic2_Date = "20160128",
    # gistic2 is CNA
    #RNAseq_Gene = TRUE,
    # gene level expression data from RNA-seq [raw values]
    Clinic = TRUE,
    # clinical information of patient sample
    # mRNA_Array = TRUE,
    # gene level expression data by array platform
    # Mutation = TRUE,
    # Gene level mutation information matrix
    # CNA_SNP = T, # copy number alterations in somatic cells provided by segmented sequecing
    # CNA_Seq = T, # copy number alterations provided by NGS sequences
    # CNA_CGH = T, # copy number alternations provided by CGH platform
    # CNV_SNP = T, # copy number alterantion in germline cells
    # Methylation = T, # methylation provided by array platform
    # RPPA = T, # reverse phase protein array expression
    # RNAseq2_Gene_Norm = TRUE,
    # normalized count
    fileSizeLimit = 99999,
    # getUUIDs = T,
    destdir = "FireHose Data",
    forceDownload = F
  )
  clin <- getData(full.set, type = "Clinical")
  # to obtain overall survival (OS) we combine three columns: vital status and days to last fol up OR days to death
  # if patient is still living (vital status = 0) we use days to last follow up
  # if patient is dead (vital status = 1) we use days to death
  clin1 <- rownames_to_column(as.data.frame(clin), var = "Patient.ID")
  clin1$Patient.ID <-
    str_replace_all(clin1$Patient.ID, "[.]", "-") # change divider to dash
  clin1$Patient.ID <- toupper(clin1$Patient.ID) # change to upper case
  
  # here we create a new column call time (time to event). 
  # since the days to last follow up and time to death given
  # are mutually exclusive, we can merge them together to get one column
  sur <- clin1 %>% 
    mutate(time = days_to_death,
           time = as.numeric(time),
           days_to_last_followup = as.numeric(days_to_last_followup)) %>% 
    select(Patient.ID, vital_status, time, everything()) # now time to event is only time to death
  # because they are mutally exclusive, we replace where NA in time to death with last follow up
  # to get full time to event
  sur$time[is.na(sur$time)] <- sur$days_to_last_followup[is.na(sur$time)]
  sur1 <- select(sur, Patient.ID, vital_status, time)
  sur1
}

### Pan-Cancer mRNA of NOX4 download ----
BLCA <- dl.RNA.select("BLCA") # bladder car
BRCA <- dl.RNA.select("BRCA") # breast car
CESC <- dl.RNA.select("CESC")
COAD <- dl.RNA.select("COAD") # colon adeno
COADREAD <- dl.RNA.select("COADREAD") # colorectal adenocarcinoma
ESCA <- dl.RNA.select("ESCA")

gc() # garbage collection

GBM  <- dl.RNA.select("GBM")  # gliblastoma multiform
HNSC <- dl.RNA.select("HNSC") # head and neck sq carc
KIRC <- dl.RNA.select("KIRC") # kidney renal clear cell car
KIRP <- dl.RNA.select("KIRP") # kidney renal pap cell car

gc()

LGG  <- dl.RNA.select("LGG")
LIHC <- dl.RNA.select("LIHC") # liver hep car
LUSC <- dl.RNA.select("LUSC") # lung squ cell car
LUAD <- dl.RNA.select("LUAD") # lung adeno
MESO <- dl.RNA.select("MESO")
OV   <- dl.RNA.select("OV")   # ovarian ser cyst
PRAD <- dl.RNA.select("PRAD") # prostate adeno
PAAD <- dl.RNA.select("PAAD")

gc() 

PCPG <- dl.RNA.select("PCPG")
READ <- dl.RNA.select("READ")
SARC <- dl.RNA.select("SARC") # sarcoma
#SKCM <- dl.RNA.select("SKCM")
STAD <- dl.RNA.select("STAD") # stomach adeno
THCA <- dl.RNA.select("THCA") # thyroid carcinoma
gc()
THCA <- dl.RNA.select("THCA")
UCEC <- dl.RNA.select("UCEC") # uterine corpus endometrial carcinoma
UCS  <- dl.RNA.select("UCS")

gc()

#rbind for PanCan
Pan.RNA  <- rbind( BLCA, # bladder car
                   BRCA, # breast car
                   CESC,
                   COAD, # colon adeno
                   COADREAD, # colorectal adenocarcinoma
                   ESCA,
                   GBM,  # gliblastoma multiform
                   HNSC, # head and neck sq carc
                   KIRC, # kidney renal clear cell car
                   KIRP, # kidney renal pap cell car
                   LGG,
                   LIHC, # liver hep car
                   LUSC, # lung squ cell car
                   LUAD, # lung adeno
                   MESO,
                   OV,   # ovarian ser cyst
                   PRAD, # prostate adeno
                   PAAD,
                   PCPG,
                   READ,
                   SARC, # sarcoma
                   # SKCM,
                   STAD, # stomach adeno
                   THCA, # thyroid carcinoma
                   THCA,
                   UCEC, # uterine corpus endometrial carcinoma
                   UCS
)

Pan.RNA$Patient.ID <- str_sub(Pan.RNA$Patient.ID, start = 1, end = 15) # 13 and beyond are samples id
Pan.RNA$Gene.Symbol <- as.character(Pan.RNA$Gene.Symbol)
### Read p53 Mutation Files from cBioPortal ----
P53_exp  <-
  read.delim(file = "TP53_Expression_All.txt",
             header = T,
             na.strings = "NA")   # p53 with Expression Data
P53_exp <-
  P53_exp %>% dplyr::select(P53.Mutation = Mutation, Cancer.Study, Sample.Id)
P53_exp <-
  na.omit(P53_exp) # important to remove missing values now to avoid mixing with 'no mutation'

P53_mut <-
  read.delim("mutation_table_TP53_02022017.tsv",
             header = T,
             na.strings = "NA")
P53_mut <-
  P53_mut %>% dplyr::select(P53.Mutation = AA.change, Cancer.Study, Sample.Id = Sample.ID)
P53_mut <- na.omit(P53_mut)
### Data Clean Up p53 
#'Not Sequenced' data is now designated as NA
P53_mut$P53.Mutation[(P53_mut$P53.Mutation == "Not Sequenced")]   <-
  NA
P53_mut$P53.Mutation[(P53_mut$P53.Mutation == "[Not Available]")] <-
  NA

P53_exp$P53.Mutation[(P53_exp$P53.Mutation == "Not Sequenced")]   <-
  NA
P53_exp$P53.Mutation[(P53_exp$P53.Mutation == "[Not Available]")] <-
  NA

# Merging two p53 Data Files to get more mutant reads on all ID's
P53_com <-
  full_join(P53_mut,
            P53_exp,
            by = "Sample.Id",
            suffix = c(".mut_file" , ".exp_file"))
P53_com <- dplyr::select(P53_com, Sample.Id, everything())
# mut: 6623 NO sequence
# exp: 8075 NO sequence

# Now, if from the exp file it is NA, copy p53 mutation status from mut file
# first convert mutation from factors to characters to allow replacement operation
P53_com$P53.Mutation.mut_file <-
  as.character(P53_com$P53.Mutation.mut_file)
P53_com$P53.Mutation.exp_file <-
  as.character(P53_com$P53.Mutation.exp_file)
# replace missing mutation status
P53_com$P53.Mutation.exp_file[is.na(P53_com$P53.Mutation.exp_file)] <-
  P53_com$P53.Mutation.mut_file[is.na(P53_com$P53.Mutation.exp_file)]
# "check where exp is NA, and replace with mut where there is NA'
# mut: 2006 NO sequence
# exp: 6623 NO sequence, leaving 10013 obs at this level

# renaming NA as WT, assuming no mutation is equal to wild-type
# because we know that NA in the exp are WT, we can assume those NA in the mut are also WT
P53_com$P53.Mutation.mut_file[is.na(P53_com$P53.Mutation.mut_file)] <-
  "WT"
P53_com$P53.Mutation.exp_file[is.na(P53_com$P53.Mutation.exp_file)] <-
  "WT"

# removing non-matched mutation status rows via subsetting
P53_com.sub <-
  subset(P53_com, P53.Mutation.exp_file == P53.Mutation.mut_file)
P53.final <-
  dplyr::select(P53_com.sub,
                Patient.ID = Sample.Id,
                P53.Mutation = P53.Mutation.exp_file,
                Case.Study = Cancer.Study.mut_file) # reordering columns and mut mutation column

gc()
### NOX4-4;DUOX1-2 EMT/MET corrl: w/o p53 designation ----

# this function will extract NOX4 and a gene (fa) from the df = Pan.final and create a matrix 
# of correlation grouped by p53 mutation status
# and also create a column of
calc.rho.unclustered.no_p53 <-
  function(list, wid = 0.5, hei = 0.5, dpi = 100, low.rho = -1, high.rho = 1) {
    df <- Pan.final[Pan.final$Gene.Symbol %in% list,] 
    
    # use this  function to calculate the spearman rank corrl in a matrix
    temp <- select(df, # this object is created later after filtering for selected p53 mutations
                   -Case.Study, -P53.Mutation)
    temp.unique <- unique(temp, nmax = 2 ) # removes duplicates
    temp.wide <- spread(data = temp.unique, key = Gene.Symbol, value = mRNA.Value)
    
    rownames(temp.wide) <- temp.wide$Patient.ID
    temp.wide.IDRow <- select(temp.wide, -Patient.ID) # remove IDrow
    cor.table <- cor(temp.wide.IDRow, method = "spearman", use = "pairwise.complete.obs")
  
    noxes.unsorted <- c("NOX4", "NOX1", "CYBB", "NOX3", "NOX5", "DUOX1", "DUOX2", "CYBA") # unsorted, ordered by alphabet
    noxes.vector <- c("NOX4", "NOX1", "CYBB", "CYBA", "NOX3", "NOX5", "DUOX1", "DUOX2") # specified order
    noxes <- factor(noxes.unsorted, levels = noxes.vector) # ordered in my specific
    # just want NOX rows
    cor.select.1 <- cor.table[rownames(cor.table) %in% noxes,]
    # rm NOX from column (rho = 1's)
    cor.select.2 <- cor.select.1[, !colnames(cor.select.1) %in% noxes]
    # need to remove NOX'es from heatmap
    
    # now create a heatmap
    png(paste(deparse(substitute(list)), # deparse(substitute()) calls the name of the df as character string
              "_nogrouping.png"), width = wid, height = hei, units = 'in', res = dpi)
    
    superheat(
      cor.select.2,
      bottom.label.text.angle = 90,
      bottom.label.text.size = 4,
      scale = F,
      grid.hline.col = "white",
      grid.vline.col = "white",
      grid.hline.size = 1,
      grid.vline.size = 1,
      pretty.order.rows = TRUE,
      pretty.order.cols = TRUE,
      left.label.text.alignment = "right",
      bottom.label.text.alignment = "right",
      heat.pal = c("turquoise", "white", "violetred1"),
      heat.lim = c(-0.8,0.8))
    
       dev.off()
  }    

    
# frequency of p53 mutation in selected patients
# P53_com.sub will then be merged with pan-cancer set to obtain p53 mutation for each patient
RNA.joined.p53 <- inner_join(P53.final, Pan.RNA, by = "Patient.ID")

# Now, Name the mutations of interest 
mut.interest <- c(
  "R175H",
  "R248Q",
  "R273H",
  "R273C",
  "R248W",
  "Y220C",
  "R249S",
  "G245D",
  "R273C",
  "R248Q",
  "H179R",
  "R282W",
  "V157F",
  "H193R",
  "R158L",
  "R273L",
  # "G248S", # very few of these
  "R158L",
  # "C175F", # very few of these
  "H179R",
  "G245S",
  "WT"
)

Pan.final <- RNA.joined.p53[RNA.joined.p53$P53.Mutation %in% mut.interest,]
head(Pan.final)

#### NADPHoxidase correlations to genepanels faceted by p53 ----


Make.heatmap.p53 <- function(NOX.master = "NOX4", gene_list_master = EMT.SAbiosci.genes, dpi = 600, wid = 9, hei = 4) {
  
  filter.nox <- function(NOX = NOX.master, mutation, gene_list = gene_list_master) {
    # outputs the rho of the specificed NOX to the specified genes in the specific p53 mutant group
    # I chosed not to use piping operator on purpose to examine each df created
    df.0 <-
      Pan.final[Pan.final$P53.Mutation %in% mutation,] # isolate an individual mutant
    df.1 <- select(df.0, -Case.Study) # removes case study column
     df.2 <- unique(df.1, nmax = 2)
    df.3 <-
      spread(data = df.2,
             key = Gene.Symbol,
             value = mRNA.Value) # change to wide format to make matrix
    rownames(df.3) <- df.3$Patient.ID
    df.4 <- select(df.3, -Patient.ID, -P53.Mutation)
    df.cor <-
      cor(df.4, method = "spearman", use = "pairwise.complete.obs")
    df.5 <- t(as.matrix(df.cor[NOX, ]))
    rownames(df.5) <- mutation
    
    # so now df.5 is the defined row with rho values
    
    df.6 <- df.5[, gene_list]
    df.6
  }
  
  R175H <- filter.nox(mutation = "R175H")
  R248Q <- filter.nox(mutation = "R248Q")
  R273H <- filter.nox(mutation = "R273H")
  R273C <- filter.nox(mutation = "R273C")
  R248W <- filter.nox(mutation = "R248W")
  Y220C <- filter.nox(mutation = "Y220C")
  R249S <- filter.nox(mutation = "R249S")
  G245D <- filter.nox(mutation = "G245D")
  R273C <- filter.nox(mutation = "R273C")
  R248Q <- filter.nox(mutation = "R248Q")
  H179R <- filter.nox(mutation = "H179R")
  R282W <- filter.nox(mutation = "R282W")
  V157F <- filter.nox(mutation = "V157F")
  H193R <- filter.nox(mutation = "H193R")
  R158L <- filter.nox(mutation = "R158L")
  R273L <- filter.nox(mutation = "R273L")
  R158L <- filter.nox(mutation = "R158L")
  H179R <- filter.nox(mutation = "H179R")
  G245S <- filter.nox(mutation = "G245S")
  WT <- filter.nox(mutation = "WT")

  all_grouping <- rbind(
    R175H,
    R248Q,
    R273H,
    R273C,
    R248W,
    Y220C,
    R249S,
    G245D,
    R273C,
    R248Q,
    H179R,
    R282W,
    V157F,
    H193R,
    R158L,
    R273L,
    # G248S, # very few of these
    R158L,
    # C175F, # very few of these
    H179R,
    G245S,
    WT
  )
  
  combined.rho <- unique(as.data.frame(all_grouping))
  
  # noxes tha should no tbe included into the heatmap 
  noxes.vector <- c("NOX4", "NOX1", "CYBB", "CYBA", "NOX3", "NOX5", "DUOX1", "DUOX2") # specified order
  
  combined.rho.final <- combined.rho[, !colnames(combined.rho) %in% noxes.vector]
  
  png(paste(deparse(substitute(gene_list_master)), NOX.master, # deparse(substitute()) calls the name of the df as character string
            "_byp53.png"), width = wid, height = hei, units = 'in', res = dpi)
  
  superheat(
    combined.rho.final,
    bottom.label.text.angle = 90,
    bottom.label.text.size = 3,
    scale = F,
    grid.hline.col = "white",
    grid.vline.col = "white",
    grid.hline.size = 1,
    grid.vline.size = 1,
    pretty.order.rows = T, # unspervised clustering for rows, t= true
    pretty.order.cols = T,
    left.label.text.alignment = "right",
    bottom.label.text.alignment = "right",
    heat.pal = c("turquoise", "white", "violetred1"),
    heat.lim = c(-1,1),
    legend.breaks = c(-0.8,0,0.8))
  
  
  dev.off()
  
  png(paste(deparse(substitute(gene_list_master)), NOX.master, # deparse(substitute()) calls the name of the df as character string
            "_byp53_withdendogram.png"), width = wid, height = hei, units = 'in', res = dpi)
  
  superheat(
    combined.rho.final,
    bottom.label.text.angle = 90,
    bottom.label.text.size = 3,
    scale = F,
    grid.hline.col = "white",
    grid.vline.col = "white",
    grid.hline.size = 1,
    grid.vline.size = 1,
    col.dendrogram = T,
    row.dendrogram = T,
    left.label.text.alignment = "right",
    bottom.label.text.alignment = "right",
    heat.pal = c("turquoise", "white", "violetred1"),
    heat.lim = c(-1,1),
    legend.breaks = c(-0.8,0,0.8))
  
  
  dev.off()
}
Make.heatmap.p53.n <- function(NOX.master = "NOX4", gene_list_master = EMT.SAbiosci.genes, dpi = 600, wid = 9, hei = 4) {
  # this function will attach a yplot with n to the heatmap
  filter.nox <- function(NOX = NOX.master, mutation, gene_list = gene_list_master) {
    # outputs the rho of the specificed NOX to the specified genes in the specific p53 mutant group
    # I chosed not to use piping operator on purpose to examine each df created
    df.0 <-
      Pan.final[Pan.final$P53.Mutation %in% mutation,] # isolate an individual mutant
    df.1 <- select(df.0, -Case.Study) # removes case study column
    df.2 <- unique(df.1, nmax = 2)
    df.3 <-
      spread(data = df.2,
             key = Gene.Symbol,
             value = mRNA.Value) # change to wide format to make matrix
    rownames(df.3) <- df.3$Patient.ID
    df.4 <- select(df.3, -Patient.ID, -P53.Mutation)
    df.cor <-
      cor(df.4, method = "spearman", use = "pairwise.complete.obs")
    df.5 <- t(as.matrix(df.cor[NOX, ]))
    rownames(df.5) <- mutation
    
    # so now df.5 is the defined row with rho values
    
    df.6 <- df.5[, gene_list]
    df.6
  }
  
  R175H <- filter.nox(mutation = "R175H")
  R248Q <- filter.nox(mutation = "R248Q")
  R273H <- filter.nox(mutation = "R273H")
  R273C <- filter.nox(mutation = "R273C")
  R248W <- filter.nox(mutation = "R248W")
  Y220C <- filter.nox(mutation = "Y220C")
  R249S <- filter.nox(mutation = "R249S")
  G245D <- filter.nox(mutation = "G245D")
  R273C <- filter.nox(mutation = "R273C")
  R248Q <- filter.nox(mutation = "R248Q")
  H179R <- filter.nox(mutation = "H179R")
  R282W <- filter.nox(mutation = "R282W")
  V157F <- filter.nox(mutation = "V157F")
  H193R <- filter.nox(mutation = "H193R")
  R158L <- filter.nox(mutation = "R158L")
  R273L <- filter.nox(mutation = "R273L")
  R158L <- filter.nox(mutation = "R158L")
  H179R <- filter.nox(mutation = "H179R")
  G245S <- filter.nox(mutation = "G245S")
  WT <- filter.nox(mutation = "WT")
  
  all_grouping <- rbind(
    R175H,
    R248Q,
    R273H,
    R273C,
    R248W,
    Y220C,
    R249S,
    G245D,
    R273C,
    R248Q,
    H179R,
    R282W,
    V157F,
    H193R,
    R158L,
    R273L,
    # G248S, # very few of these
    R158L,
    # C175F, # very few of these
    H179R,
    G245S,
    WT
  )
  
  combined.rho <- unique(as.data.frame(all_grouping))
  combined.n <- Pan.final %>% 
    group_by(P53.Mutation) %>% 
    summarise(count = (length(P53.Mutation)/138)) # 138 genes per person
  
  # noxes tha should no tbe included into the heatmap 
  noxes.vector <- c("NOX4", "NOX1", "CYBB", "CYBA", "NOX3", "NOX5", "DUOX1", "DUOX2") # specified order
  
  combined.rho.final <- combined.rho[, !colnames(combined.rho) %in% noxes.vector]
  
  png(paste(deparse(substitute(gene_list_master)), NOX.master, # deparse(substitute()) calls the name of the df as character string
            "_byp53_n.png"), width = wid, height = hei, units = 'in', res = dpi)
  
  superheat(
    combined.rho.final,
    bottom.label.text.angle = 90,
    bottom.label.text.size = 3,
    scale = F,
    grid.hline.col = "white",
    grid.vline.col = "white",
    grid.hline.size = 1,
    grid.vline.size = 1,
    pretty.order.rows = T, # unspervised clustering for rows, t= true
    pretty.order.cols = T,
    left.label.text.alignment = "right",
    bottom.label.text.alignment = "right",
    heat.pal = c("turquoise", "white", "violetred1"),
    heat.lim = c(-1,1),
    yr = (combined.n$count),
    yr.axis.name = "n of samples",
    yr.plot.type = "bar",
    legend.breaks = c(-0.8,0,0.8))
  
  
  dev.off()
  

}

# for NOX4
Make.heatmap.p53(NOX.master = "NOX4", gene_list_master = EMT.SAbiosci.genes, dpi = 900, wid = 10.5, hei = 6.5)
Make.heatmap.p53.n(NOX.master = "NOX4", gene_list_master = EMT.SAbiosci.genes, dpi = 900, wid = 10.5, hei = 6.5)

#### NADPHoxidase correlations to genepanels faceted by WT OR MUT (generalized) ----


Make.heatmap.p53.generalized <- function(NOX.master = "NOX4", gene_list_master = EMT.SAbiosci.genes, dpi = 600, wid = 9, hei = 6.5) {
  
  filter.nox.WT <- function(NOX = NOX.master, mutation, gene_list = gene_list_master) {
    # outputs the rho of the specificed NOX to the specified genes in the specific p53 mutant group
    # I chosed not to use piping operator on purpose to examine each df created
    df.0 <-
      Pan.final[Pan.final$P53.Mutation %in% mutation,] # isolate an individual mutant
    df.1 <- select(df.0, -Case.Study) # removes case study column
    df.2 <- unique(df.1, nmax = 2)
    df.3 <-
      spread(data = df.2,
             key = Gene.Symbol,
             value = mRNA.Value) # change to wide format to make matrix
    rownames(df.3) <- df.3$Patient.ID
    df.4 <- select(df.3, -Patient.ID, -P53.Mutation)
    df.cor <-
      cor(df.4, method = "spearman", use = "pairwise.complete.obs")
    df.5 <- t(as.matrix(df.cor[NOX, ]))
    rownames(df.5) <- mutation
    
    # so now df.5 is the defined row with rho values
    
    df.6 <- df.5[, gene_list]
    df.6
  }
  filter.nox.MT <- function(NOX = NOX.master, mutation, gene_list = gene_list_master) {
      # outputs the rho of the specificed NOX to the specified genes in the specific p53 mutant group
      # I chosed not to use piping operator on purpose to examine each df created
      df.0 <-
        Pan.final[Pan.final$P53.Mutation %in% mutation,]
      df.1 <- select(df.0, -Case.Study) # removes case study column
      df.2 <- unique(df.1, nmax = 2)
      df.3 <-
        spread(data = df.2,
               key = Gene.Symbol,
               value = mRNA.Value) # change to wide format to make matrix
      df.4 <- select(df.3, -P53.Mutation) # since all are going to be designated as mutant, we remove the p53 annotation
      df.5 <- unique(df.4)
      rownames(df.5) <- df.5$Patient.ID
      df.6 <- select(df.5, -Patient.ID)
      df.cor <-
        cor(df.6, method = "spearman", use = "pairwise.complete.obs")
      df.7 <- t(as.matrix(df.cor[NOX, ])) #t() transposes the matrix and get it in format we want
      rownames(df.7) <- "Mut"
      
      # so now df.5 is the defined row with rho values
      
      df.8 <- df.7[, gene_list]
      df.8
  }
  
  
  WT <- filter.nox.WT(mutation = "WT")
  MUT <- filter.nox.MT(mutation = c("R175H",
                                    "R248Q",
                                    "R273H",
                                    "R273C",
                                    "R248W",
                                    "Y220C",
                                    "R249S",
                                    "G245D",
                                    "R273C",
                                    "R248Q",
                                    "H179R",
                                    "R282W",
                                    "V157F",
                                    "H193R",
                                    "R158L",
                                    "R273L",
                                    # G248S, # very few of these
                                    "R158L",
                                    # C175F, # very few of these
                                    "H179R",
                                    "G245S"))
  Blank = as.table(1)
  all_grouping <- rbind(
    MUT,
    WT,
    Blank,
    Blank,
    Blank,
    Blank,
    Blank,
    Blank,
    Blank,
    Blank,
    Blank,
    Blank,
    Blank,
    Blank)
  
  combined.rho <- (as.data.frame(all_grouping))
  
  # noxes tha should no tbe included into the heatmap 
  noxes.vector <- c("NOX4", "NOX1", "CYBB", "CYBA", "NOX3", "NOX5", "DUOX1", "DUOX2") # specified order
  
  combined.rho.final <- combined.rho[, !colnames(combined.rho) %in% noxes.vector]
  
  png(paste(deparse(substitute(gene_list_master)), NOX.master, # deparse(substitute()) calls the name of the df as character string
            "_byp53.png"), width = wid, height = hei, units = 'in', res = dpi)
  
  superheat(
    combined.rho.final,
    bottom.label.text.angle = 90,
    bottom.label.text.size = 3,
    scale = F,
    grid.hline.col = "white",
    grid.vline.col = "white",
    grid.hline.size = 1,
    grid.vline.size = 1,
    pretty.order.rows = T, # unspervised clustering for rows, t= true
    pretty.order.cols = T,
    left.label.text.alignment = "right",
    bottom.label.text.alignment = "right",
    heat.pal = c("turquoise", "white", "violetred1"),
    heat.lim = c(-1,1),
    legend = F)
  
  
  dev.off()
  
 
  ##
  png(paste(deparse(substitute(gene_list_master)), NOX.master, # deparse(substitute()) calls the name of the df as character string
            "_byp53_withdendogram.png"), width = wid, height = hei, units = 'in', res = dpi)
  
  superheat(
    combined.rho.final,
    bottom.label.text.angle = 90,
    bottom.label.text.size = 3,
    scale = F,
    grid.hline.col = "white",
    grid.vline.col = "white",
    grid.hline.size = 1,
    grid.vline.size = 1,
    col.dendrogram = T,
    row.dendrogram = F,
    left.label.text.alignment = "right",
    bottom.label.text.alignment = "right",
    heat.pal = c("turquoise", "white", "violetred1"),
    heat.lim = c(-1,1),
    legend = F)
  
  
  dev.off()
}


# for NOX4
Make.heatmap.p53.generalized(NOX.master = "NOX4", gene_list_master = EMT.SAbiosci.genes, dpi = 900, wid = 10.5, hei = 6.5)

