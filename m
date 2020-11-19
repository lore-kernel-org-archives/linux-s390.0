Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59802 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726205AbgKSHwy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Nov 2020 02:52:54 -0500
Subject: Re: [PATCH 3/6] s390/ctcm: Put struct pdu on stack.
References: <20201118105317.605671-1-bigeasy@linutronix.de>
 <20201118105317.605671-4-bigeasy@linutronix.de>
From: Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <02a2b745-03e1-f9a3-915a-fcd4d2ed00d4@linux.ibm.com>
Date: Thu, 19 Nov 2020 09:52:44 +0200
MIME-Version: 1.0
In-Reply-To: <20201118105317.605671-4-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-s390@vger.kernel.org
Cc: Karsten Graul <kgraul@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>

On 18.11.20 12:53, Sebastian Andrzej Siewior wrote:
> The size of struct pdu is 8 byte. The memory is allocated, initialized,
> used and deallocated a few lines later.
> 
> It is more efficient to avoid the allocation/free dance and keeping the
> variable on stack. Especially since the compiler is smart enough to not
> allocate the memory on stack but assign the values directly.
> 
> Add a variable pdu_hdr on stack and use it instead of p_header. p_header
> is used later as a pointer without an allocation.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Same comment, can we do a 

p_header = (struct pdu *) skb_push(...);
p_header->foo = bar;

instead? Adjusting skb->len for the length that we pushed of course.

> ---
>  drivers/s390/net/ctcm_main.c | 41 ++++++++++++------------------------
>  1 file changed, 13 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
> index 6c7d6bbd27406..b56f51806b3d0 100644
> --- a/drivers/s390/net/ctcm_main.c
> +++ b/drivers/s390/net/ctcm_main.c
> @@ -649,6 +649,7 @@ static void ctcmpc_send_sweep_req(struct channel *rch)
>  static int ctcmpc_transmit_skb(struct channel *ch, struct sk_buff *skb)
>  {
>  	struct pdu *p_header;
> +	struct pdu pdu_hdr;
>  	struct net_device *dev = ch->netdev;
>  	struct ctcm_priv *priv = dev->ml_priv;
>  	struct mpc_group *grp = priv->mpcg;
> @@ -666,23 +667,16 @@ static int ctcmpc_transmit_skb(struct channel *ch, struct sk_buff *skb)
>  	if ((fsm_getstate(ch->fsm) != CTC_STATE_TXIDLE) || grp->in_sweep) {
>  		spin_lock_irqsave(&ch->collect_lock, saveflags);
>  		refcount_inc(&skb->users);
> -		p_header = kmalloc(PDU_HEADER_LENGTH, gfp_type());
>  
> -		if (!p_header) {
> -			spin_unlock_irqrestore(&ch->collect_lock, saveflags);
> -				goto nomem_exit;
> -		}
> -
> -		p_header->pdu_offset = skb->len;
> -		p_header->pdu_proto = 0x01;
> -		p_header->pdu_flag = 0x00;
> +		pdu_hdr.pdu_offset = skb->len;
> +		pdu_hdr.pdu_proto = 0x01;
>  		if (be16_to_cpu(skb->protocol) == ETH_P_SNAP) {
> -			p_header->pdu_flag |= PDU_FIRST | PDU_CNTL;
> +			pdu_hdr.pdu_flag = PDU_FIRST | PDU_CNTL;
>  		} else {
> -			p_header->pdu_flag |= PDU_FIRST;
> +			pdu_hdr.pdu_flag = PDU_FIRST;
>  		}
> -		p_header->pdu_seq = 0;
> -		memcpy(skb_push(skb, PDU_HEADER_LENGTH), p_header,
> +		pdu_hdr.pdu_seq = 0;
> +		memcpy(skb_push(skb, PDU_HEADER_LENGTH), &pdu_hdr,
>  		       PDU_HEADER_LENGTH);
>  
>  		CTCM_PR_DEBUG("%s(%s): Put on collect_q - skb len: %04x \n"
> @@ -692,7 +686,6 @@ static int ctcmpc_transmit_skb(struct channel *ch, struct sk_buff *skb)
>  
>  		skb_queue_tail(&ch->collect_queue, skb);
>  		ch->collect_len += skb->len;
> -		kfree(p_header);
>  
>  		spin_unlock_irqrestore(&ch->collect_lock, saveflags);
>  			goto done;
> @@ -722,23 +715,15 @@ static int ctcmpc_transmit_skb(struct channel *ch, struct sk_buff *skb)
>  		}
>  	}
>  
> -	p_header = kmalloc(PDU_HEADER_LENGTH, gfp_type());
> -
> -	if (!p_header)
> -		goto nomem_exit;
> -
> -	p_header->pdu_offset = skb->len;
> -	p_header->pdu_proto = 0x01;
> -	p_header->pdu_flag = 0x00;
> -	p_header->pdu_seq = 0;
> +	pdu_hdr.pdu_offset = skb->len;
> +	pdu_hdr.pdu_proto = 0x01;
> +	pdu_hdr.pdu_seq = 0;
>  	if (be16_to_cpu(skb->protocol) == ETH_P_SNAP) {
> -		p_header->pdu_flag |= PDU_FIRST | PDU_CNTL;
> +		pdu_hdr.pdu_flag = PDU_FIRST | PDU_CNTL;
>  	} else {
> -		p_header->pdu_flag |= PDU_FIRST;
> +		pdu_hdr.pdu_flag = PDU_FIRST;
>  	}
> -	memcpy(skb_push(skb, PDU_HEADER_LENGTH), p_header, PDU_HEADER_LENGTH);
> -
> -	kfree(p_header);
> +	memcpy(skb_push(skb, PDU_HEADER_LENGTH), &pdu_hdr, PDU_HEADER_LENGTH);
>  
>  	if (ch->collect_len > 0) {
>  		spin_lock_irqsave(&ch->collect_lock, saveflags);
> 
