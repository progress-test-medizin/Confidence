require(tcltk)
dirChar <- "S:"
pfad <- tclvalue(tkchooseDirectory("-title", 'Bitte Arbeitsverzeichnis auswählen'))
pfad <- gsub("//Charite.de/Centren", dirChar, pfad)
setwd(pfad)
pfadNeuProg <-"S:/Fakultaet/MFAL/PTM/Progress Test Medizin/3_Auswertung/Neuprogrammierung"
source(paste(pfadNeuProg, '/standard/standardFunktionen.r', sep = ""))
source(paste(pfadNeuProg, '/standard/standardFunktionen(Confidence).r', sep = ""))
source(paste(pfadNeuProg, '/standard/unis.r', sep = ""))
pfadStandard <-"S:/Fakultaet/MFAL/PTM/Progress Test Medizin/3_Auswertung/Neuprogrammierung/standard"
test_nr<-askPTNummer()
uni_nummer<-getPTUni(pfadStandard)
uni_name<-uni.labels[as.numeric(uni_nummer)]
if (uni_name=="Berlin"){
  forBerlin()
}
if (uni_name=="Essen"){
  forEssen()
}
if (uni_name=="Witten"){
  forWitten()
}