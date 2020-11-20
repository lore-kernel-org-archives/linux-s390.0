Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726786AbgKTIFy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Nov 2020 03:05:54 -0500
Subject: Re: [PATCH v2 3/6] s390/ctcm: Avoid temporary allocation of struct
 pdu.
References: <20201119135719.983170-1-bigeasy@linutronix.de>
 <20201119135719.983170-4-bigeasy@linutronix.de>
From: Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <a20c5577-b217-68b1-f433-51dc0843aa37@linux.ibm.com>
Date: Fri, 20 Nov 2020 10:05:45 +0200
MIME-Version: 1.0
In-Reply-To: <20201119135719.983170-4-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-s390@vger.kernel.org
Cc: Karsten Graul <kgraul@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>

On 19.11.20 15:57, Sebastian Andrzej Siewior wrote:
> The size of struct pdu is 8 byte. The memory is allocated, initialized,
> used and deallocated a few lines later.
> 
> It is more efficient to avoid the allocation/free dance and assign the
> values directly to skb's data part instead of using memcpy() for it.
> 
> Avoid an allocation of struct pdu and use the resulting skb pointer instead.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/s390/net/ctcm_main.c | 29 ++++++-----------------------
>  1 file changed, 6 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
> index a3a74ebfee635..0cb130c280031 100644
> --- a/drivers/s390/net/ctcm_main.c
> +++ b/drivers/s390/net/ctcm_main.c
> @@ -666,24 +666,16 @@ static int ctcmpc_transmit_skb(struct channel *ch, struct sk_buff *skb)
>  	if ((fsm_getstate(ch->fsm) != CTC_STATE_TXIDLE) || grp->in_sweep) {
>  		spin_lock_irqsave(&ch->collect_lock, saveflags);
>  		refcount_inc(&skb->users);
> -		p_header = kmalloc(PDU_HEADER_LENGTH, gfp_type());
> -
> -		if (!p_header) {
> -			spin_unlock_irqrestore(&ch->collect_lock, saveflags);
> -				goto nomem_exit;
> -		}
>  
> +		p_header = skb_push(skb, PDU_HEADER_LENGTH);
>  		p_header->pdu_offset = skb->len;

I mentioned this in my reply to v1 - here we now need to adjust skb->len
for the pushed length. Will fix up while applying (also below).

>  		p_header->pdu_proto = 0x01;
> -		p_header->pdu_flag = 0x00;
>  		if (be16_to_cpu(skb->protocol) == ETH_P_SNAP) {
> -			p_header->pdu_flag |= PDU_FIRST | PDU_CNTL;
> +			p_header->pdu_flag = PDU_FIRST | PDU_CNTL;
>  		} else {
> -			p_header->pdu_flag |= PDU_FIRST;
> +			p_header->pdu_flag = PDU_FIRST;
>  		}
>  		p_header->pdu_seq = 0;
> -		memcpy(skb_push(skb, PDU_HEADER_LENGTH), p_header,
> -		       PDU_HEADER_LENGTH);
>  
>  		CTCM_PR_DEBUG("%s(%s): Put on collect_q - skb len: %04x \n"
>  				"pdu header and data for up to 32 bytes:\n",
> @@ -692,7 +684,6 @@ static int ctcmpc_transmit_skb(struct channel *ch, struct sk_buff *skb)
>  
>  		skb_queue_tail(&ch->collect_queue, skb);
>  		ch->collect_len += skb->len;
> -		kfree(p_header);
>  
>  		spin_unlock_irqrestore(&ch->collect_lock, saveflags);
>  			goto done;
> @@ -722,23 +713,15 @@ static int ctcmpc_transmit_skb(struct channel *ch, struct sk_buff *skb)
>  		}
>  	}
>  
> -	p_header = kmalloc(PDU_HEADER_LENGTH, gfp_type());
> -
> -	if (!p_header)
> -		goto nomem_exit;
> -
> +	p_header = skb_push(skb, PDU_HEADER_LENGTH);
>  	p_header->pdu_offset = skb->len;
>  	p_header->pdu_proto = 0x01;
> -	p_header->pdu_flag = 0x00;
>  	p_header->pdu_seq = 0;
>  	if (be16_to_cpu(skb->protocol) == ETH_P_SNAP) {
> -		p_header->pdu_flag |= PDU_FIRST | PDU_CNTL;
> +		p_header->pdu_flag = PDU_FIRST | PDU_CNTL;
>  	} else {
> -		p_header->pdu_flag |= PDU_FIRST;
> +		p_header->pdu_flag = PDU_FIRST;
>  	}
> -	memcpy(skb_push(skb, PDU_HEADER_LENGTH), p_header, PDU_HEADER_LENGTH);
> -
> -	kfree(p_header);
>  
>  	if (ch->collect_len > 0) {
>  		spin_lock_irqsave(&ch->collect_lock, saveflags);
> 
