#!/bin/bash

#Script that called another script but provided the module name that needed to be refreshed after installing changes while still in load.

cd /app/adm/bin/


#refreshconfigs for sso
echo "Refreshing sso.app..."
./refreshconfigs.sh sso.app


echo "Starting refreshment of Marketer..."
#refresh configs for Marketer
echo "Refreshing marketer.app..."
./refreshconfigs.sh marketer.app

echo "Refreshing marketer.bkgrnd..."
./refreshconfigs.sh marketer.bkgrnd

echo "Refreshing marketer.campaign..."
./refreshconfigs.sh marketer.campaign

echo "Refreshing marketer.content..."
./refreshconfigs.sh marketer.content

echo "Refreshing marketer.database..."
./refreshconfigs.sh marketer.database

echo "Refreshing marketer.mailgen..."
./refreshconfigs.sh marketer.mailgen

echo "Refreshing marketer.recp..."
./refreshconfigs.sh marketer.recp

echo "Refreshing marketer.reply..."
./refreshconfigs.sh marketer.reply

echo "Refreshing marketer.rollup..."
./refreshconfigs.sh marketer.rollup

echo "Refreshing marketer.utils..."
./refreshconfigs.sh marketer.utils

echo "Refreshing marketer.xmlapi..."
./refreshconfigs.sh marketer.xmlapi



echo "Starting refreshment of Campaigns..."
#refresh configs for campaigns
echo "Refreshing campaigns.app..."
./refreshconfigs.sh campaigns.app

echo "Refreshing campaigns.bkgrnd..."
./refreshconfigs.sh campaigns.bkgrnd

echo "Refreshing campaigns.database..."
./refreshconfigs.sh campaigns.database


echo "Starting refreshment of LandingPages..."
#refresh configs for lpages
echo "Refreshing lpages.app..."
./refreshconfigs.sh lpages.app

echo "Refreshing lpages.appcontent..."
./refreshconfigs.sh lpages.appcontent

echo "Refreshing lpages.database..."
./refreshconfigs.sh lpages.database

echo "Refreshing lpages.recp..."
./refreshconfigs.sh lpages.recp

echo "Refreshing lpages.recpcontent..."
./refreshconfigs.sh lpages.recpcontent



echo "Starting refreshment of Reporting..."
#refresh configs for reporting
echo "Refreshing reporting.app..."
./refreshconfigs.sh reporting.app

echo "Refreshing reporting.bkgrnd..."
./refreshconfigs.sh reporting.bkgrnd

echo "Refreshing reporting.charts..."
./refreshconfigs.sh reporting.charts

echo "Refreshing reporting.database..."
./refreshconfigs.sh reporting.database



echo "Starting refreshment of Transact..."
#refreshconfigs for transact
echo "Refreshing transact.batchserver..."
./refreshconfigs.sh transact.batchserver

echo "Refreshing transact.filefinder..."
./refreshconfigs.sh transact.filefinder

echo "Refreshing transact.httpprocessor..."
./refreshconfigs.sh transact.httpprocessor

echo "Refreshing transact.notifier..."
./refreshconfigs.sh transact.notifier

echo "Refreshing transact.smtpprocessor..."
./refreshconfigs.sh transact.smtpprocessor

echo "Refreshing transact.sync..."
./refreshconfigs.sh transact.sync

echo "Refreshconfigs: DONE"
