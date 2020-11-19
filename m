Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58374 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726287AbgKSH43 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Nov 2020 02:56:29 -0500
Subject: Re: [PATCH 2/6] s390/ctcm: Put struct qllc on stack.
References: <20201118105317.605671-1-bigeasy@linutronix.de>
 <20201118105317.605671-3-bigeasy@linutronix.de>
From: Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <8dd75a21-0e50-d445-9532-9a0950b884ea@linux.ibm.com>
Date: Thu, 19 Nov 2020 09:56:20 +0200
MIME-Version: 1.0
In-Reply-To: <20201118105317.605671-3-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-s390@vger.kernel.org
Cc: Karsten Graul <kgraul@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>

On 18.11.20 12:53, Sebastian Andrzej Siewior wrote:
> The size of struct qllc is 2 byte. The memory for is allocated, initialized,
> used and deallocated a few lines later.
> 
> It is more efficient to avoid the allocation/free dance and keeping the
> variable on stack. Especially since the compiler is smart enough to not
> allocate the memory on stack but assign the values directly.
> 
> Rename `qllcptr' to `qllc' and use it on stack.
> 

Can we please shrink this down to

qllcptr = (struct qllc *) skb_put(...);
qllcptr->foo = bar;
...


> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/s390/net/ctcm_mpc.c | 24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
> index 04a51cc89e74c..4ff51af44d338 100644
> --- a/drivers/s390/net/ctcm_mpc.c
> +++ b/drivers/s390/net/ctcm_mpc.c
> @@ -2049,11 +2049,10 @@ static void mpc_action_rcvd_xid7(fsm_instance *fsm, int event, void *arg)
>   */
>  static int mpc_send_qllc_discontact(struct net_device *dev)
>  {
> -	__u32	new_len	= 0;
>  	struct sk_buff   *skb;
> -	struct qllc      *qllcptr;
>  	struct ctcm_priv *priv = dev->ml_priv;
>  	struct mpc_group *grp = priv->mpcg;
> +	struct qllc	qllc;
>  
>  	CTCM_PR_DEBUG("%s: GROUP STATE: %s\n",
>  		__func__, mpcg_state_names[grp->saved_state]);
> @@ -2080,31 +2079,20 @@ static int mpc_send_qllc_discontact(struct net_device *dev)
>  	case MPCG_STATE_FLOWC:
>  	case MPCG_STATE_READY:
>  		grp->send_qllc_disc = 2;
> -		new_len = sizeof(struct qllc);
> -		qllcptr = kzalloc(new_len, gfp_type() | GFP_DMA);
> -		if (qllcptr == NULL) {
> -			CTCM_DBF_TEXT_(MPC_ERROR, CTC_DBF_ERROR,
> -				"%s(%s): qllcptr allocation error",
> -						CTCM_FUNTAIL, dev->name);
> -			return -ENOMEM;
> -		}
> -
> -		qllcptr->qllc_address = 0xcc;
> -		qllcptr->qllc_commands = 0x03;
> -
> -		skb = __dev_alloc_skb(new_len, GFP_ATOMIC);
>  
> +		skb = __dev_alloc_skb(sizeof(struct qllc), GFP_ATOMIC);
>  		if (skb == NULL) {
>  			CTCM_DBF_TEXT_(MPC_ERROR, CTC_DBF_ERROR,
>  				"%s(%s): skb allocation error",
>  						CTCM_FUNTAIL, dev->name);
>  			priv->stats.rx_dropped++;
> -			kfree(qllcptr);
>  			return -ENOMEM;
>  		}
>  
> -		skb_put_data(skb, qllcptr, new_len);
> -		kfree(qllcptr);
> +		qllc.qllc_address = 0xcc;
> +		qllc.qllc_commands = 0x03;
> +
> +		skb_put_data(skb, &qllc, sizeof(struct qllc));
>  
>  		if (skb_headroom(skb) < 4) {
>  			CTCM_DBF_TEXT_(MPC_ERROR, CTC_DBF_ERROR,
> 
