###
### Preparação ####
library(tidyverse)
library(lme4)
library(parameters)
library(splines)

df2<- readRDS("ENEM_merged.rds")

df2[,1:7] <- lapply(df2[,1:7], as.numeric)
df2[,8:13] <- lapply(df2[,8:13], as.factor)

boxplot(as.numeric(df2$NU_NOTA_REDACAO)~df2$NU_ANO)
df2<-df2 %>% mutate(periodo=if_else(as.numeric(NU_ANO)>2009,"pré=2008","pós-2008"))

#rm(df2)
Poluente<- c( "no2_ppb", "o3_ppb", "pm25_ugm3")# Definir Variavel Preditora
for (x in Poluente) {
  print(x)
}
Notas<- c("NU_NOTA_REDACAO","NU_NOTA_OBJETIVA")# definir Variavel Resposta
for (y in Notas) {
  print(y)
}
proporçao<- 1.0
#subset<- "nulo"

subset<-unique(df2$periodo)
for (k in subset) {
  print(k)
}


repetições <- 1:1
for (z in repetições) {
  print(z)
}
a<-0
Resultado.temp<-data.frame()
resultado<-data.frame()
#df1<-df2 #%>% drop_na(Q15)

### loop ####
for (k in subset) {
  df1<-df2 %>%  filter(periodo==k) 
  for (x in Poluente) {
    for (y in Notas) {
      for (z in repetições) {
        gc()
        b<-length(Poluente)*length(Notas)*length(repetições)*length(subset)
        print(paste("start",x,y,z,proporçao))
        print(Sys.time())
        samp<-df1 %>%
          group_by(SG_UF_RESIDENCIA) %>%
          slice_sample(prop = proporçao)# amostragem
        #mod_A<-lmer(samp[[y]]~samp[[x]]+(1+samp[[x]]|SG_UF_RESIDENCIA),samp)#modelo
        mod_A<- lmer(
          #samp[[y]] ~ samp[[x]] +Q15 +Q10+ TP_DEPENDENCIA_ADM_ESC +(1+samp[[x]]|NU_ANO)+ TP_SEXO+TP_LOCALIZACAO_ESC + (1+samp[[x]]|SG_UF_RESIDENCIA),
          #samp[[y]] ~ samp[[x]] +Q15 +Q10+ TP_DEPENDENCIA_ADM_ESC +NU_ANO+ TP_SEXO+TP_LOCALIZACAO_ESC + (1+samp[[x]]|SG_UF_RESIDENCIA),
          #samp[[y]] ~ samp[[x]]+TP_SEXO +Q15 +Q10+ TP_DEPENDENCIA_ADM_ESC +bs(as.numeric(NU_ANO))+ TP_SEXO+TP_LOCALIZACAO_ESC + (1+samp[[x]]|SG_UF_RESIDENCIA),
          samp[[y]] ~ samp[[x]] +Q15 +
            Q10+IDHM+ TP_DEPENDENCIA_ADM_ESC +
            bs(as.numeric(NU_ANO))+ TP_SEXO+
            TP_LOCALIZACAO_ESC +
            (1+samp[[x]]|SG_UF_RESIDENCIA),
          #samp[[y]] ~ samp[[x]] +Q15 +Q10+ TP_DEPENDENCIA_ADM_ESC +bs(as.numeric(NU_ANO))+ TP_LOCALIZACAO_ESC + (1+samp[[x]]|SG_UF_RESIDENCIA),
          #samp[[y]] ~ samp[[x]]  +Q10+ Q15 +bs(as.numeric(NU_ANO))+ TP_SEXO +TP_LOCALIZACAO_ESC+ (1+samp[[x]]|SG_UF_RESIDENCIA),
          data =samp)
        print("modelo rodou")
        samp$TP_SEXO
        n_obs <- as.numeric(nrow(samp))
        n_group <- as.numeric(sapply(ranef(mod_A),nrow))
        
        coefficients <- fixef(mod_A)#extração de coeficientes de efeito fixo
        beta <- coefficients[2]
        
        # Extract SE and 95%CI
        Vcov <- vcov(mod_A, useScale = FALSE)
        Std_Errors <- sqrt(diag(Vcov))
        se <- Std_Errors[2]
        upperCI <-  beta + 1.96*se
        lowerCI <-  beta - 1.96*se
        # Extract P-value
        zval <- coefficients / Std_Errors
        pval <- 2 * pnorm(abs(zval), lower.tail = FALSE)
        
        pvalue <- pval[2]
        # Extract Variance of Random effects
        variances <- as.data.frame(VarCorr(mod_A))
        variance_slope <- variances[2,4]
        variance_intercept <- variances[1,4]
        
        #Extração de efeitos aleatórios
        random_efect<-coef(mod_A)[[1]][1:2]
        colnames(random_efect) <- c("Intercept_rand", "Slope_rand")
        SE<-(standard_error(mod_A, effects = "random")[[1]])
        colnames(SE) <- c("SE_Intercept_rand", "SE_Slope_rand")
        fator<-rownames(random_efect)
        fator
        Resultado.temp <-data.frame()
        Resultado.temp<-cbind(random_efect,SE,fator)
        
        names(Resultado.temp)[2] <-"slope"
        Resultado.temp$efeito_fixo<-beta
        Resultado.temp$poluente<-x
        Resultado.temp$nota<-y
        Resultado.temp$subset<-k
        Resultado.temp$amostragem<- n_obs
        Resultado.temp$N_grupos<- n_group[1]
        Resultado.temp$lowerCI_efx<- lowerCI
        Resultado.temp$upperCI_efx<- upperCI
        Resultado.temp$pvalue_efx<- pvalue
        Resultado.temp$variance_slope_efx<- variance_slope
        Resultado.temp$teste<-paste(x,y,z,sep = ".")
        Resultado.temp$modelo<-paste(x,y,sep = ".")
        Resultado.temp$formula<-as.character(summary(mod_A)[[15]])[2]
        
        
        resultado <- rbind.data.frame(resultado, Resultado.temp)
        a<-a+1
        print(paste("end",x,y,z,",repeat:",round(a/b*100,digits = 3),"%"))
      }
            }
  }
}
table(is.na(df1$IDHM))
♣rm(x,y,z)
### salvar ####
saveRDS(resultado,paste("Resultado_idh","TP_2009","prop",proporçao,"rep",length(repetições),"modelo_bs_sex",sep = "_"))

#saveRDS(resultado,paste("Resultado","prop",proporçao,"rep",length(repetições),"modelo_base",sep = "_"))
### Analise do resultado ####
R <-resultado %>% mutate(lowerCI=slope-1.96*SE_Slope_rand,upperCI=slope+1.96*SE_Slope_rand) %>% 
  mutate(sinal=ifelse(lowerCI>0,"Positivo",ifelse(upperCI<0,"Negativo","null")))
table(R$sinal,R$poluente)
table(R$modelo,R$sinal)
table(R$subset,R$sinal)

R %>%   ggplot(aes(x=slope,y=fator,xmin=lowerCI,xmax=upperCI,col=sinal))+
  #geom_point(alpha=0.5)+
  geom_pointrange(alpha=0.5)+facet_grid(nota*subset~poluente,scales = "free")+
  geom_vline(xintercept = 0, color = "red", size=0.1,alpha=0.5)+
  geom_errorbar(alpha=0.5)+
  labs(title = "Modelo mistos",
       subtitle = R$formula,
       caption = "EPPG FGV")+xlab("Slope")+ylab("Estado")

R %>%   ggplot(aes(x=slope,y=nota,xmin=lowerCI,xmax=upperCI,col=sinal))+
  #geom_point(alpha=0.5)+
  geom_pointrange(alpha=0.5)+facet_grid(fator~poluente,scales = "free")+
  geom_vline(xintercept = 0, color = "red", size=0.1,alpha=0.5)+
  geom_errorbar(alpha=0.5)+
  labs(title = "Modelo mistos",
       subtitle = R$formula,
       caption = "EPPG FGV")+xlab("Slope")+ylab("Estado")

resultado$sinal<-ifelse(resultado$lowerCI_efx>0,"Positivo",ifelse(resultado$upperCI_efx<0,"Negativo","null"))
summary(mod_A)
R2<-resultado[6:19] %>% distinct() 
table(R2$modelo,R2$sinal,R2$subset)
table(R2$sinal)
R2 %>%   ggplot(aes(x=efeito_fixo,y=teste,xmin=lowerCI_efx,xmax=upperCI_efx,col=sinal))+geom_point(alpha=0.3)+
  geom_pointrange(alpha=0.5)+
  facet_grid(subset*nota~poluente,scales = "free")+
  geom_vline(xintercept = 0, color = "red", size=0.1,alpha=0.5)+
  
  #geom_errorbar(alpha=0.5)+
  labs(title = "Modelo mistos",
       subtitle =R$formula,
       caption = "EPPG FGV")+xlab("Slope")+ylab("Estado")
summary(mod_A)

summary(resultado$amostragem)

saveRDS(resultado,paste0("Resultado principal sem ano"))
summary(resultado$pvalue_efx)
