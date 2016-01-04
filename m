Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 4 Jan 2016 15:04:47 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/2] 390/qeth: Refactoring for qeth_core_set_online()
Message-ID: <20160104140447.GG4179@osiris>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5688F13A.70601@users.sourceforge.net>
 <5688F1D0.3090502@users.sourceforge.net>
 <20160104113046.GE4179@osiris>
 <568A6F4A.1000206@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <568A6F4A.1000206@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 04, 2016 at 02:10:34PM +0100, SF Markus Elfring wrote:
> >> +++ b/drivers/s390/net/qeth_core_main.c
> >> @@ -5638,9 +5638,10 @@ static int qeth_core_set_online(struct ccwgroup_device *gdev)
> >>  {
> >>  	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
> >>  	int rc;
> >> -	int def_discipline;
> >>  
> >>  	if (!card->discipline) {
> >> +		int def_discipline;
> >> +
> >>  		if (card->info.type == QETH_CARD_TYPE_IQD)
> >>  			def_discipline = QETH_DISCIPLINE_LAYER3;
> > 
> > Same here: I don't think we want to start with patches like this.
> 
> Thanks for your feedback.
> 
> 
> > This going to be a never ending story without much benefit.
> 
> Is the source code a bit clearer and safer if it will be expressed
> directly that the use of a specific variable is not intended for
> a complete function implementation but for the smaller scope
> of an if branch?

This depends on the function and what the author prefers. In this case the
function body is very small so I don't see any benefit at all.
