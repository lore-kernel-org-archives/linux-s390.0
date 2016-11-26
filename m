From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH V3 net-next 05/15] smc: CLC handshake (incl.
 preparation steps)
Date: Fri, 25 Nov 2016 20:53:50 -0500 (EST)
Message-ID: <20161125.205350.1040136769411513088.davem@davemloft.net>
References: <20161124150645.90881-1-ubraun@linux.vnet.ibm.com>
        <20161124150645.90881-6-ubraun@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20161124150645.90881-6-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, utz.bacher@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Thu, 24 Nov 2016 16:06:35 +0100

> +struct smc_clc_msg_hdr {	/* header1 of clc messages */
> +	u8 eyecatcher[4];	/* eye catcher */
> +	u8 type;		/* proposal / accept / confirm / decline */
> +	__be16 length;
> +#if defined(__BIG_ENDIAN_BITFIELD)
> +	u8 version : 4,
> +	   flag    : 1,
> +	   rsvd	   : 3;
> +#elif defined(__LITTLE_ENDIAN_BITFIELD)
> +	u8 rsvd    : 3,
> +	   flag    : 1,
> +	   version : 4;
> +#endif
> +} __packed;

Please get rid of all of these __packed attributes.  They are likely
completely unnecessary and the code generated for this construct on
certain architectures is amazingly inefficient.

Describe the on-wire datastructures properly with fixed sized types
and any padding or overlapping, as needed.
