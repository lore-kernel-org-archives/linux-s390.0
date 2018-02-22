Return-Path: <netdev-owner@vger.kernel.org>
Date: Thu, 22 Feb 2018 14:10:34 -0500 (EST)
Message-Id: <20180222.141034.147310516964522686.davem@davemloft.net>
Subject: Re: [PATCH net-next 2/5] net/smc: fix structure size
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180221113235.46702-3-ubraun@linux.vnet.ibm.com>
References: <20180221113235.46702-1-ubraun@linux.vnet.ibm.com>
        <20180221113235.46702-3-ubraun@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Wed, 21 Feb 2018 12:32:32 +0100

> diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
> index ab240b37ad11..d2012fd22100 100644
> --- a/net/smc/smc_cdc.h
> +++ b/net/smc/smc_cdc.h
> @@ -48,7 +48,7 @@ struct smc_cdc_msg {
>  	struct smc_cdc_producer_flags	prod_flags;
>  	struct smc_cdc_conn_state_flags	conn_state_flags;
>  	u8				reserved[18];
> -} __aligned(8);
> +} __packed;					/* format defined in RFC7609 */

Hold on, __packed should only be used as the absolute last possible
option to fix structure layout problems.

Also, a sub-structure of smc_cdc_msg, union smc_cdc_cursor, is still
marked with __aligned(8).  That makes no sense at all.

Please fix this without using __packed, as __packed has a severe
detrimental effect on code generation for accessing such structure
on several cpu architectures.

Also, if this these are legitimate bug fixes you should target those
at 'net' not 'net-next'.

Thank you.
