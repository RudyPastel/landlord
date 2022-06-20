# Librairy
library(ggplot2)
# Parameter
bien = 140
travaux = 5
notaire = bien * 0.08
agent = 0
achat = bien + travaux + notaire + agent
cout = 4
zins = 1 / 100
tilgung = 4 / 100
interet = zins + tilgung
mensualiteMax = 650 

# Pret
apport = 1:achat
annuite = (achat - apport) * interet
calculeDuree = function(capital, zins, tilgung){
  capitalDu = capital
  annuite = capital * (zins + tilgung)
  annee = 0
  while (capitalDu > 0){
    capitalDu = capitalDu - (annuite - zins * capitalDu)
    annee = annee + 1
  }
  return(annee)
}
calculeDuree(capital = achat, zins = zins, tilgung = tilgung)

calculeMensualite = function(capital, zins, tilgung){
  capitalDu = capital
  annuite = capital * (zins + tilgung)
  mensualite = annuite / 12 * 1000
  return(mensualite)
}
calculeMensualite(capital = achat, zins = zins, tilgung = tilgung)
# Acheter pour louer
loyer = 1 * 12

rendement = (loyer - cout) / (achat + annuite)
roi = (loyer - cout - annuite) / apport
bilan = (loyer - cout - annuite) 
breakpoint = apport[min(which(roi >= 0))]
plot(x = apport, y = rendement * 100, type = 'l', 
     main = 'Rendement net de frais et charges', 
     xlab = 'Apport en kEUR', ylab = 'Rendement en %', 
     sub = 'rendement = (loyer - cout) / (achat + annuite)')

plot(x = apport, y = annuite, type = 'l', 
     main = 'Annuité', 
     xlab = 'Apport en kEUR', ylab = 'annuite en kEUR', 
     sub = sprintf('interet = %s%%', interet * 100))
par(mfrow = c(2, 1))
plot(x = apport, y = bilan, type = 'l', 
     main = 'Bilan annuel', 
     xlab = 'Apport en kEUR', 
     ylab = 'Bialn en kEUR', 
     sub = 'bilan = (loyer - cout - annuite) '
)
abline(h = 0, col = 'red')
abline(v = breakpoint , col = 'green')

plot(x = apport, y = roi * 100, type = 'l', 
     main = 'Retour sur investissement annuel', 
     xlab = 'Apport en kEUR', ylab = 'ROI en %', 
     sub = sprintf('roi = (loyer - cout - annuite) / apport, breakpoint = %sk, max(roi) = %s%%', 
                   breakpoint, 
                   round(max(roi * 100),2))
)
abline(h = 0, col = 'red')
abline(v = breakpoint , col = 'green')


par(mfrow = c(1, 1))
# Acheter pour vivre

credit = expand.grid(
  interet = seq(from = 0, to = interet, by = 0.001),
  apport = apport,
  achat = achat)
credit$capital = with(credit, (achat - apport))
credit$annuite = with(credit, capital * interet)
credit$mensualite = credit$annuite / 12 * 1000
credit$acceptable = ifelse(test = credit$mensualite <= mensualiteMax, yes = 'oui', no = 'non')

ggplot(data = credit, mapping = aes(x = interet * 100, y = apport, z = mensualite)) +
  geom_contour_filled(breaks = pretty(x = credit$mensualite, n = 20)) +
  labs(title = sprintf('Mensualités pour un coût total de %sk', achat),
       x = 'Intérêt en %',
       y = 'Apport en kEUR', fill = 'Mensulité en EUR')




# ggplot(data = credit, mapping = aes(x = interet, y = apport, fill = acceptable)) +
#   geom_tile() +
#   labs(title = "Combinaison acceptable d'apport et d'intérêt",
#        subtitle = sprintf( "Acceptable = Mensualité inférieure à %sEUR", mensualiteMax), 
#        x = 'Intérêt en %',
#        y = 'Apport en kEUR', 
#        fill = 'Acceptable'
#   )