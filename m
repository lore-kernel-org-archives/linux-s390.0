Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20640 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727077AbgKIIFl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Nov 2020 03:05:41 -0500
Subject: Re: [PATCH] s390/qeth: remove useless if/else
References: <1604817287-11258-1-git-send-email-kaixuxia@tencent.com>
From: Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <8390c0e9-d91c-91ff-11d0-4fe0b01a4722@linux.ibm.com>
Date: Mon, 9 Nov 2020 10:05:15 +0200
MIME-Version: 1.0
In-Reply-To: <1604817287-11258-1-git-send-email-kaixuxia@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: xiakaixu1987@gmail.com, hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>

On 08.11.20 08:34, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> Fix the following coccinelle report:
> 
> ./drivers/s390/net/qeth_l3_main.c:107:2-4: WARNING: possible condition with no effect (if == else)
> 
> Both branches are the same, so remove them.
> 

Indeed, missed that in commit
ab29c480b194 ("s390/qeth: replace deprecated simple_stroul()")

Applied, thanks!

> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> ---
>  drivers/s390/net/qeth_l3_main.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
> index b1c1d2510d55..264b6c782382 100644
> --- a/drivers/s390/net/qeth_l3_main.c
> +++ b/drivers/s390/net/qeth_l3_main.c
> @@ -104,10 +104,7 @@ static bool qeth_l3_is_addr_covered_by_ipato(struct qeth_card *card,
>  		qeth_l3_convert_addr_to_bits(ipatoe->addr, ipatoe_bits,
>  					  (ipatoe->proto == QETH_PROT_IPV4) ?
>  					  4 : 16);
> -		if (addr->proto == QETH_PROT_IPV4)
> -			rc = !memcmp(addr_bits, ipatoe_bits, ipatoe->mask_bits);
> -		else
> -			rc = !memcmp(addr_bits, ipatoe_bits, ipatoe->mask_bits);
> +		rc = !memcmp(addr_bits, ipatoe_bits, ipatoe->mask_bits);
>  		if (rc)
>  			break;
>  	}
> 
