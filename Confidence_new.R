require(tcltk)
dirChar <- "S:"
pfad <- tclvalue(tkchooseDirectory("-title", 'Bitte Arbeitsverzeichnis auswählen'))
pfad <- gsub("//Charite.de/Centren", dirChar, pfad)
setwd(pfad)
pfadNeuProg <- "S:/Fakultaet/MFAL/PTM/Progress Test Medizin/3_Auswertung/Neuprogrammierung"
source(paste(pfadNeuProg, '/standard/standardFunktionen.r', sep = ""))
test_nr<-askPTNummer()
path1<- paste(pfad, "\\Rohdaten", sep = "")
files<- dir(path1, pattern=glob2rx("export*csv"), full.names=TRUE, recursive=TRUE)
All2 <- lapply(files,function(i){
  read.csv2(i)
})
df <- do.call("rbind", All2)
df<-df[-c(6,207,208,209)]
id1<-df[c(1)]
matrikel<-floor(((id1-1)/2)+195879)
names(matrikel)<-c("matrikel")
id2 <- which(names(df)=="ID2")
df<-data.frame(df[1:id2],matrikel=matrikel,df[(id2+1):ncol(df)])
df<-df[!df$ID2<100,]
df<-as.data.frame(df[!c(TRUE,FALSE), ])
path2<- paste(pfad, "\\überarbeitete Rohdaten\\Confidence_2.csv", sep = "")
write.table(df,path2,sep=";", row.names=FALSE, col.names=TRUE)
id1<-df[c(1)]
names(test_nr)<-c("test_nr")
id3 <- which(names(df)=="matrikel")
dg<-data.frame(df[1:id3],test_nr=test_nr,df[(id3+1):ncol(df)])
write.table(dg, "E:/Progress Test Medizin/Confidence/gesamt_code_confidence_2.csv", sep = ";", row.names=FALSE,col.names = TRUE, append=TRUE)
dh<-data.frame(read.csv2("E:/Progress Test Medizin/Confidence/gesamt_code_confidence_2.csv"))
dj<-dh[!duplicated(dh[c(3,4)]),]
colnames(dj)[1] <- "ID 1"
colnames(dj)[2] <- "ID 2"
dj$Zyklus <- " " 
write.table(dj, "E:/Progress Test Medizin/Confidence/gesamt_code_confidence_2.csv", sep = ";", row.names=FALSE,col.names = TRUE)