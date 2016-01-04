Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 2/2] 390/qeth: Refactoring for qeth_core_set_online()
References: <566ABCD9.1060404@users.sourceforge.net>
 <5688F13A.70601@users.sourceforge.net>
 <5688F1D0.3090502@users.sourceforge.net> <20160104113046.GE4179@osiris>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <568A6F4A.1000206@users.sourceforge.net>
Date: Mon, 4 Jan 2016 14:10:34 +0100
MIME-Version: 1.0
In-Reply-To: <20160104113046.GE4179@osiris>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

>> +++ b/drivers/s390/net/qeth_core_main.c
>> @@ -5638,9 +5638,10 @@ static int qeth_core_set_online(struct ccwgroup_device *gdev)
>>  {
>>  	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
>>  	int rc;
>> -	int def_discipline;
>>  
>>  	if (!card->discipline) {
>> +		int def_discipline;
>> +
>>  		if (card->info.type == QETH_CARD_TYPE_IQD)
>>  			def_discipline = QETH_DISCIPLINE_LAYER3;
> 
> Same here: I don't think we want to start with patches like this.

Thanks for your feedback.


> This going to be a never ending story without much benefit.

Is the source code a bit clearer and safer if it will be expressed
directly that the use of a specific variable is not intended for
a complete function implementation but for the smaller scope
of an if branch?

Regards,
Markus
