Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA48EB64DC
	for <linux-s390@archiver.kernel.org>; Thu, 29 Jun 2023 05:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjF2FMr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 29 Jun 2023 01:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjF2FMp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 29 Jun 2023 01:12:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702A7194;
        Wed, 28 Jun 2023 22:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=31mXj0LrDJBbkDjYY0JkRdmBEMX8kHpGdSb2KzkvoJQ=; b=XLK3Lbg/zIF8PgmNRjDb4LeAqM
        dhWKbW4uqaBS6nyCgIOc5Z4o/AdTb7Jr23+7eQkotQCYbg/o4bfsR29Qao6H95J9RbmbI4Rh1loxf
        F5wsj7fJegKx1Ucvlkk53tt+OjxNpMsJACzmOR3eF2MdKVeGsEW+3M7qwiM0e4VQIdC5y+q1s3Kfy
        6P54xmH+SGD79V+E/9HNUPSymGimv1XntcL6gGpJ7rJdTXQ8BFkS+I+1Yy4iZVZ0Ns1Y2XpGBKCmY
        Ji274SUByvkipntcYcoqzg03tSSUnM9EvLJ2YpXWtQgp8xIi+GGgTW5B66AIKvHLRFZhHVVQtGLAH
        vb+CthVg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEjxJ-00HZxc-1y;
        Thu, 29 Jun 2023 05:12:33 +0000
Message-ID: <3135e933-09cb-e397-972b-d66c48bbf772@infradead.org>
Date:   Wed, 28 Jun 2023 22:12:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] s390/lcs: Remove FDDI option
Content-Language: en-US
To:     Alexandra Winter <wintera@linux.ibm.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     Simon Horman <simon.horman@corigine.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
References: <20230628135736.13339-1-wintera@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230628135736.13339-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 6/28/23 06:57, Alexandra Winter wrote:
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


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/s390/net/Kconfig |  5 ++---
>  drivers/s390/net/lcs.c   | 39 ++++++---------------------------------
>  2 files changed, 8 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
> index 9c67b97faba2..74760c1a163b 100644
> --- a/drivers/s390/net/Kconfig
> +++ b/drivers/s390/net/Kconfig
> @@ -5,12 +5,11 @@ menu "S/390 network device drivers"
>  config LCS
>  	def_tristate m
>  	prompt "Lan Channel Station Interface"
> -	depends on CCW && NETDEVICES && (ETHERNET || FDDI)
> +	depends on CCW && NETDEVICES && ETHERNET
>  	help
>  	  Select this option if you want to use LCS networking on IBM System z.
> -	  This device driver supports FDDI (IEEE 802.7) and Ethernet.
>  	  To compile as a module, choose M. The module name is lcs.
> -	  If you do not know what it is, it's safe to choose Y.
> +	  If you do not use LCS, choose N.
>  
>  config CTCM
>  	def_tristate m
> diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
> index 9fd8e6f07a03..a1f2acd6fb8f 100644
> --- a/drivers/s390/net/lcs.c
> +++ b/drivers/s390/net/lcs.c
> @@ -17,7 +17,6 @@
>  #include <linux/if.h>
>  #include <linux/netdevice.h>
>  #include <linux/etherdevice.h>
> -#include <linux/fddidevice.h>
>  #include <linux/inetdevice.h>
>  #include <linux/in.h>
>  #include <linux/igmp.h>
> @@ -36,10 +35,6 @@
>  #include "lcs.h"
>  
>  
> -#if !defined(CONFIG_ETHERNET) && !defined(CONFIG_FDDI)
> -#error Cannot compile lcs.c without some net devices switched on.
> -#endif
> -
>  /*
>   * initialization string for output
>   */
> @@ -1601,19 +1596,11 @@ lcs_startlan_auto(struct lcs_card *card)
>  	int rc;
>  
>  	LCS_DBF_TEXT(2, trace, "strtauto");
> -#ifdef CONFIG_ETHERNET
>  	card->lan_type = LCS_FRAME_TYPE_ENET;
>  	rc = lcs_send_startlan(card, LCS_INITIATOR_TCPIP);
>  	if (rc == 0)
>  		return 0;
>  
> -#endif
> -#ifdef CONFIG_FDDI
> -	card->lan_type = LCS_FRAME_TYPE_FDDI;
> -	rc = lcs_send_startlan(card, LCS_INITIATOR_TCPIP);
> -	if (rc == 0)
> -		return 0;
> -#endif
>  	return -EIO;
>  }
>  
> @@ -1806,22 +1793,16 @@ lcs_get_frames_cb(struct lcs_channel *channel, struct lcs_buffer *buffer)
>  			card->stats.rx_errors++;
>  			return;
>  		}
> -		/* What kind of frame is it? */
> -		if (lcs_hdr->type == LCS_FRAME_TYPE_CONTROL) {
> -			/* Control frame. */
> +		if (lcs_hdr->type == LCS_FRAME_TYPE_CONTROL)
>  			lcs_get_control(card, (struct lcs_cmd *) lcs_hdr);
> -		} else if (lcs_hdr->type == LCS_FRAME_TYPE_ENET ||
> -			   lcs_hdr->type == LCS_FRAME_TYPE_TR ||
> -			   lcs_hdr->type == LCS_FRAME_TYPE_FDDI) {
> -			/* Normal network packet. */
> +		else if (lcs_hdr->type == LCS_FRAME_TYPE_ENET)
>  			lcs_get_skb(card, (char *)(lcs_hdr + 1),
>  				    lcs_hdr->offset - offset -
>  				    sizeof(struct lcs_header));
> -		} else {
> -			/* Unknown frame type. */
> -			; // FIXME: error message ?
> -		}
> -		/* Proceed to next frame. */
> +		else
> +			dev_info_once(&card->dev->dev,
> +				      "Unknown frame type %d\n",
> +				      lcs_hdr->type);
>  		offset = lcs_hdr->offset;
>  		lcs_hdr->offset = LCS_ILLEGAL_OFFSET;
>  		lcs_hdr = (struct lcs_header *) (buffer->data + offset);
> @@ -2140,18 +2121,10 @@ lcs_new_device(struct ccwgroup_device *ccwgdev)
>  		goto netdev_out;
>  	}
>  	switch (card->lan_type) {
> -#ifdef CONFIG_ETHERNET
>  	case LCS_FRAME_TYPE_ENET:
>  		card->lan_type_trans = eth_type_trans;
>  		dev = alloc_etherdev(0);
>  		break;
> -#endif
> -#ifdef CONFIG_FDDI
> -	case LCS_FRAME_TYPE_FDDI:
> -		card->lan_type_trans = fddi_type_trans;
> -		dev = alloc_fddidev(0);
> -		break;
> -#endif
>  	default:
>  		LCS_DBF_TEXT(3, setup, "errinit");
>  		pr_err(" Initialization failed\n");

-- 
~Randy
