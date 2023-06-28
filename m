Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D2FEB64D7
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jun 2023 14:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjF1OCw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Jun 2023 10:02:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35700 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232512AbjF1OB2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Jun 2023 10:01:28 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SDwCaC011560;
        Wed, 28 Jun 2023 14:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=/wLhX1HyhLq2YcKKsuaTl/6E5npNMHyTZmuJ0bSjbvA=;
 b=oMd5EMLNVJBrRqU8ky7kByuIDSJmGbDOfUV9dda2l+f4pR0Lyj3T6jYBAD/W31rWB3Qk
 EUxRgbFITs/Fh5tjpt1SFolCytpu4HuKv3efmuFmJT1djfH1ATG0ouAye15ahWenh0u1
 yyGIur2BCBINgG615TLKgeqBwJlPkzQVuHVFXB0y0M/4ngtSoV+AtiiUUmwMSHRzLMRY
 CMp0Q5hENjcl3v1OydpVrkDFzkeNMpR4AIhLFW7w0Ya60u33pZ1SD0sFnmgSH/XrAlHu
 2y4jtV01e6SWEgCgcrsZwwjPYnL4N0nB8gAu7XH62Me/6mp9QwZQpD4pgTpxX3lq7S7/ Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgp3nga5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 14:01:15 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35SDpv9G025098;
        Wed, 28 Jun 2023 14:01:15 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgp3nga44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 14:01:15 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35SAt8Q5001850;
        Wed, 28 Jun 2023 14:01:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3rdr451y2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 14:01:13 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35SE198W20841206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 14:01:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1A5120043;
        Wed, 28 Jun 2023 14:01:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DFC82004D;
        Wed, 28 Jun 2023 14:01:09 +0000 (GMT)
Received: from [9.155.198.239] (unknown [9.155.198.239])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jun 2023 14:01:09 +0000 (GMT)
Message-ID: <6282d9ad-59b0-5648-74da-7923b07843b4@linux.ibm.com>
Date:   Wed, 28 Jun 2023 16:01:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] s390/lcs: Remove FDDI option
To:     Alexandra Winter <wintera@linux.ibm.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
References: <20230628135736.13339-1-wintera@linux.ibm.com>
Content-Language: en-US
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20230628135736.13339-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Z_QObUGkYSLknpdyq1kgbDzZldOQsaev
X-Proofpoint-GUID: t6AR6Q4nkHAxKXyyyY6hc-3BSwEMBOXq
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_09,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306280120
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Am 28.06.23 um 15:57 schrieb Alexandra Winter:
> The last s390 machine that supported FDDI was z900 ('7th generation',
> released in 2000). The oldest machine generation currently supported by
> the Linux kernel is MARCH_Z10 (released 2008). If there is still a usecase
> for connecting a Linux on s390 instance to a LAN Channel Station (LCS), it
> can only do so via Ethernet.
> 
> Randy Dunlap[1] found that LCS over FDDI has never worked, when FDDI
> was compiled as module. Instead of fixing that, remove the FDDI option
> from the lcs driver.
> 
> While at it, make the CONFIG_LCS description a bit more helpful.
> 
> References:
> [1] https://lore.kernel.org/netdev/20230621213742.8245-1-rdunlap@infradead.org/
> 
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

Makes perfect sense given the complexity.

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>


> ---
>   drivers/s390/net/Kconfig |  5 ++---
>   drivers/s390/net/lcs.c   | 39 ++++++---------------------------------
>   2 files changed, 8 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
> index 9c67b97faba2..74760c1a163b 100644
> --- a/drivers/s390/net/Kconfig
> +++ b/drivers/s390/net/Kconfig
> @@ -5,12 +5,11 @@ menu "S/390 network device drivers"
>   config LCS
>   	def_tristate m
>   	prompt "Lan Channel Station Interface"
> -	depends on CCW && NETDEVICES && (ETHERNET || FDDI)
> +	depends on CCW && NETDEVICES && ETHERNET
>   	help
>   	  Select this option if you want to use LCS networking on IBM System z.
> -	  This device driver supports FDDI (IEEE 802.7) and Ethernet.
>   	  To compile as a module, choose M. The module name is lcs.
> -	  If you do not know what it is, it's safe to choose Y.
> +	  If you do not use LCS, choose N.
>   
>   config CTCM
>   	def_tristate m
> diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
> index 9fd8e6f07a03..a1f2acd6fb8f 100644
> --- a/drivers/s390/net/lcs.c
> +++ b/drivers/s390/net/lcs.c
> @@ -17,7 +17,6 @@
>   #include <linux/if.h>
>   #include <linux/netdevice.h>
>   #include <linux/etherdevice.h>
> -#include <linux/fddidevice.h>
>   #include <linux/inetdevice.h>
>   #include <linux/in.h>
>   #include <linux/igmp.h>
> @@ -36,10 +35,6 @@
>   #include "lcs.h"
>   
>   
> -#if !defined(CONFIG_ETHERNET) && !defined(CONFIG_FDDI)
> -#error Cannot compile lcs.c without some net devices switched on.
> -#endif
> -
>   /*
>    * initialization string for output
>    */
> @@ -1601,19 +1596,11 @@ lcs_startlan_auto(struct lcs_card *card)
>   	int rc;
>   
>   	LCS_DBF_TEXT(2, trace, "strtauto");
> -#ifdef CONFIG_ETHERNET
>   	card->lan_type = LCS_FRAME_TYPE_ENET;
>   	rc = lcs_send_startlan(card, LCS_INITIATOR_TCPIP);
>   	if (rc == 0)
>   		return 0;
>   
> -#endif
> -#ifdef CONFIG_FDDI
> -	card->lan_type = LCS_FRAME_TYPE_FDDI;
> -	rc = lcs_send_startlan(card, LCS_INITIATOR_TCPIP);
> -	if (rc == 0)
> -		return 0;
> -#endif
>   	return -EIO;
>   }
>   
> @@ -1806,22 +1793,16 @@ lcs_get_frames_cb(struct lcs_channel *channel, struct lcs_buffer *buffer)
>   			card->stats.rx_errors++;
>   			return;
>   		}
> -		/* What kind of frame is it? */
> -		if (lcs_hdr->type == LCS_FRAME_TYPE_CONTROL) {
> -			/* Control frame. */
> +		if (lcs_hdr->type == LCS_FRAME_TYPE_CONTROL)
>   			lcs_get_control(card, (struct lcs_cmd *) lcs_hdr);
> -		} else if (lcs_hdr->type == LCS_FRAME_TYPE_ENET ||
> -			   lcs_hdr->type == LCS_FRAME_TYPE_TR ||
> -			   lcs_hdr->type == LCS_FRAME_TYPE_FDDI) {
> -			/* Normal network packet. */
> +		else if (lcs_hdr->type == LCS_FRAME_TYPE_ENET)
>   			lcs_get_skb(card, (char *)(lcs_hdr + 1),
>   				    lcs_hdr->offset - offset -
>   				    sizeof(struct lcs_header));
> -		} else {
> -			/* Unknown frame type. */
> -			; // FIXME: error message ?
> -		}
> -		/* Proceed to next frame. */
> +		else
> +			dev_info_once(&card->dev->dev,
> +				      "Unknown frame type %d\n",
> +				      lcs_hdr->type);
>   		offset = lcs_hdr->offset;
>   		lcs_hdr->offset = LCS_ILLEGAL_OFFSET;
>   		lcs_hdr = (struct lcs_header *) (buffer->data + offset);
> @@ -2140,18 +2121,10 @@ lcs_new_device(struct ccwgroup_device *ccwgdev)
>   		goto netdev_out;
>   	}
>   	switch (card->lan_type) {
> -#ifdef CONFIG_ETHERNET
>   	case LCS_FRAME_TYPE_ENET:
>   		card->lan_type_trans = eth_type_trans;
>   		dev = alloc_etherdev(0);
>   		break;
> -#endif
> -#ifdef CONFIG_FDDI
> -	case LCS_FRAME_TYPE_FDDI:
> -		card->lan_type_trans = fddi_type_trans;
> -		dev = alloc_fddidev(0);
> -		break;
> -#endif
>   	default:
>   		LCS_DBF_TEXT(3, setup, "errinit");
>   		pr_err(" Initialization failed\n");
