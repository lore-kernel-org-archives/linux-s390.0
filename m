Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732750AbfKHLui (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 Nov 2019 06:50:38 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA8Bl8Yb037112
        for <linux-s390@vger.kernel.org>; Fri, 8 Nov 2019 06:50:37 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w41w6asqk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 08 Nov 2019 06:50:36 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Fri, 8 Nov 2019 11:50:28 -0000
Subject: Re: [PATCH AUTOSEL 4.19 204/205] s390/qeth: limit csum offload
 erratum to L3 devices
References: <20191108113752.12502-1-sashal@kernel.org>
 <20191108113752.12502-204-sashal@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Fri, 8 Nov 2019 12:50:24 +0100
MIME-Version: 1.0
In-Reply-To: <20191108113752.12502-204-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2e4553d6-de1f-bb61-33e4-10a5c23f0aa7@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, linux-s390@vger.kernel.org

On 08.11.19 12:37, Sasha Levin wrote:
> From: Julian Wiedmann <jwi@linux.ibm.com>
> 
> [ Upstream commit f231dc9dbd789b0f98a15941e3cebedb4ad72ad5 ]
> 
> Combined L3+L4 csum offload is only required for some L3 HW. So for
> L2 devices, don't offload the IP header csum calculation.
> 

NACK, this has no relevance for stable.


> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
> Reference-ID: JUP 394553
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/s390/net/qeth_core.h    | 5 -----
>  drivers/s390/net/qeth_l3_main.c | 5 +++++
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
> index b2657582cfcfd..41a2f901ccee5 100644
> --- a/drivers/s390/net/qeth_core.h
> +++ b/drivers/s390/net/qeth_core.h
> @@ -902,11 +902,6 @@ static inline void qeth_tx_csum(struct sk_buff *skb, u8 *flags, int ipv)
>  	if ((ipv == 4 && ip_hdr(skb)->protocol == IPPROTO_UDP) ||
>  	    (ipv == 6 && ipv6_hdr(skb)->nexthdr == IPPROTO_UDP))
>  		*flags |= QETH_HDR_EXT_UDP;
> -	if (ipv == 4) {
> -		/* some HW requires combined L3+L4 csum offload: */
> -		*flags |= QETH_HDR_EXT_CSUM_HDR_REQ;
> -		ip_hdr(skb)->check = 0;
> -	}
>  }
>  
>  static inline void qeth_put_buffer_pool_entry(struct qeth_card *card,
> diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
> index 9c5e801b3f6cb..c60660cb5a031 100644
> --- a/drivers/s390/net/qeth_l3_main.c
> +++ b/drivers/s390/net/qeth_l3_main.c
> @@ -2054,6 +2054,11 @@ static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
>  
>  	if (!skb_is_gso(skb) && skb->ip_summed == CHECKSUM_PARTIAL) {
>  		qeth_tx_csum(skb, &hdr->hdr.l3.ext_flags, ipv);
> +		/* some HW requires combined L3+L4 csum offload: */
> +		if (ipv == 4) {
> +			hdr->hdr.l3.ext_flags |= QETH_HDR_EXT_CSUM_HDR_REQ;
> +			ip_hdr(skb)->check = 0;
> +		}
>  		if (card->options.performance_stats)
>  			card->perf_stats.tx_csum++;
>  	}
> 
