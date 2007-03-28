Return-Path: <linux-kernel-owner+w=401wt.eu-S964935AbXC1Gyt@vger.kernel.org>
Date: Wed, 28 Mar 2007 08:54:43 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch 1/8] Processor degredation support.
Message-ID: <20070328065443.GA8146@osiris.boeblingen.de.ibm.com>
References: <20070326212459.711271424@de.ibm.com> <20070326212634.931820139@de.ibm.com> <20070327213529.GB5842@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070327213529.GB5842@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

> > +++ linux-2.6/drivers/s390/char/sclp_confmgm.c
> 
> Can we get less cyptic name?

Would you like to see sclp_configuration_management.c?

> > +static void sclp_conf_receiver_fn(struct evbuf_header *evbuf)
> > +{
> > +	struct conf_mgm_data *cdata;
> > +
> > +	cdata = (struct conf_mgm_data *)(evbuf + 1);
> > +	if (cdata->ev_qualifier == EV_QUAL_CAP_CHANGE)
> > +		/* Will be parsed. Don't change. */
> > +		printk(KERN_WARNING "sclp: CPU capability changed.\n");
> > +}
> 
> What's that? I do not think printk provides guaranteed delivery.

True. But which generic interface is currently used to notify user space
of state changes? Maybe a uevent for the cpu device..

> > +static struct sclp_register sclp_conf_register =
> > +{
> > +	.receive_mask = EvTyp_ConfMgmData_Mask,
> 
> NoCamelCasePlease.
> 
> > @@ -27,6 +27,7 @@
> >  #define EvTyp_CntlProgIdent	0x0B
> >  #define EvTyp_SigQuiesce	0x1D
> >  #define EvTyp_VT220Msg		0x1A
> > +#define EvTyp_ConfMgmData	0x04
> >  
> >  #define EvTyp_OpCmd_Mask	0x80000000
> >  #define EvTyp_Msg_Mask		0x40000000
> > @@ -36,6 +37,7 @@
> >  #define EvTyp_CtlProgIdent_Mask	0x00200000
> >  #define EvTyp_SigQuiesce_Mask	0x00000008
> >  #define EvTyp_VT220Msg_Mask	0x00000040
> > +#define EvTyp_ConfMgmData_Mask	0x10000000
> >  
> >  #define GnrlMsgFlgs_DOM		0x8000
> >  #define GnrlMsgFlgs_SndAlrm	0x4000
> 
> Yep, you have more CamelCases to fix.

Yes, you're definately right. But I wanted to stick with the current
coding style of the sclp device driver and didn't feel like generating
a 1000+ line diff just to fix some coding style issues.
Will fix this when I'm bored.
