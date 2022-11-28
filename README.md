# Ethereum - Gas Price Alert & Analysis 
Application alerting a user via console and web visualization of abnormal variations in the ETH GasPrice datas.

You can host it directly on your machine or on a remote server to host your front-end app.

# Bot Configuration 
Clone this repo :
```
git clone <repo_url>
```

Enable script execution :
```
chmod u+x init.sh
chmod u+x ic.sh
chmod u+x bot.sh
chmod u+x insert.sh
chmod u+x read.sh
```

Install sqlite3 :
```
sudo apt-get install sqlite3
```

Then run init.sh to setup the database : 
```
./init.sh
```

Finally try bot.sh and verify console output : 
```
./bot.sh
```

# Linux / Cron Job configuration

On your linux instance, after cloning this repo you can setup a cron job to get Telegram notification every 30min for example.
Go into the project folder and run :
```
$ crontab –e
```
In the crontab terminal edit and write :
```
* * * * *  <PATH_TO_bot.sh>
* * * * *  sleep 30; <PATH_TO_bot.sh>
```
Close the terminal and you should get a sucess message.

```
> crontab: installing new crontab
```

In the above configuration, we have scheduled the script twice. The first cron runs every 1 minute and the second cron also starts at the same time but waits for 30 seconds before execution. So the entire cycle runs every 30 seconds.

# Front-end App
soon.
# Etherscan API :
[Gas Price API](https://api.etherscan.io/api?module=gastracker&action=gasoracle)
