Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:39052 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgKTIbw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 Nov 2020 03:31:52 -0500
Date: Fri, 20 Nov 2020 09:31:49 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 3/6] s390/ctcm: Avoid temporary allocation of struct
 pdu.
Message-ID: <20201120083149.vwqpkufo7ddmkrlz@linutronix.de>
References: <20201119135719.983170-1-bigeasy@linutronix.de>
 <20201119135719.983170-4-bigeasy@linutronix.de>
 <a20c5577-b217-68b1-f433-51dc0843aa37@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a20c5577-b217-68b1-f433-51dc0843aa37@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>

On 2020-11-20 10:05:45 [+0200], Julian Wiedmann wrote:
> > diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
> > index a3a74ebfee635..0cb130c280031 100644
> > --- a/drivers/s390/net/ctcm_main.c
> > +++ b/drivers/s390/net/ctcm_main.c
> > @@ -666,24 +666,16 @@ static int ctcmpc_transmit_skb(struct channel *ch, struct sk_buff *skb)
> >  	if ((fsm_getstate(ch->fsm) != CTC_STATE_TXIDLE) || grp->in_sweep) {
> >  		spin_lock_irqsave(&ch->collect_lock, saveflags);
> >  		refcount_inc(&skb->users);
> > -		p_header = kmalloc(PDU_HEADER_LENGTH, gfp_type());
> > -
> > -		if (!p_header) {
> > -			spin_unlock_irqrestore(&ch->collect_lock, saveflags);
> > -				goto nomem_exit;
> > -		}
> >  
> > +		p_header = skb_push(skb, PDU_HEADER_LENGTH);
> >  		p_header->pdu_offset = skb->len;
> 
> I mentioned this in my reply to v1 - here we now need to adjust skb->len
> for the pushed length. Will fix up while applying (also below).

I'm sorry. It took me a while to understand what you meant and then I
forgot about it while I was here.
Thank you for taking care of it.

Sebastian
