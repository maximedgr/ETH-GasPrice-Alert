#!/bin/bash
#intervalle de confiance à 95%
mean=$(sqlite3 gas_tab.db "SELECT avg(USD_price) from GasPrice;")
taille=$(sqlite3 gas_tab.db "SELECT COUNT(*) from GasPrice;")
sqrttaille=$(sqlite3 gas_tab.db "SELECT sqrt($taille);")
coeff=1.96
variance=$(sqlite3 gas_tab.db "SELECT SUM((GasPrice.USD_price-(SELECT AVG(GasPrice.USD_price) FROM GasPrice))*(GasPrice.USD_price-(SELECT AVG(GasPrice.USD_price) FROM GasPrice)) ) / (COUNT(GasPrice.USD_price)-1) AS Variance FROM GasPrice;")
std=$(sqlite3 gas_tab.db "SELECT sqrt($variance);")
icu=$(sqlite3 gas_tab.db "SELECT $mean+$coeff*($std/$sqrttaille);")
icd=$(sqlite3 gas_tab.db "SELECT $mean-$coeff*($std/$sqrttaille);")
echo "Moyenne : "$mean
echo "Taille échantillon : "$taille
echo "LN coeff: "$coeff
echo "Variance : "$variance
echo "Std : "$std
echo "IC : "
echo "["$icd" ; "$icu"]"

outsidevalue=$(sqlite3 gas_tab.db "SELECT GasPrice.USD_price FROM GasPrice WHERE GasPrice.blocktime=( SELECT MAX(GasPrice.blocktime) FROM GasPrice WHERE GasPrice.USD_price NOT BETWEEN $icd AND $icu) ;")
echo "Anomalie : "$outsidevalue


# Variance : 
# SELECT SUM((GasPrice.USD_price-(SELECT AVG(GasPrice.USD_price) FROM GasPrice))*(GasPrice.USD_price-(SELECT AVG(GasPrice.USD_price) FROM GasPrice)) ) / (COUNT(GasPrice.USD_price)-1) AS Variance FROM GasPrice;