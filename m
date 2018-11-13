From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net 4/5] net/smc: atomic SMCD cursor handling
Date: Tue, 13 Nov 2018 14:53:47 -0800 (PST)
Message-ID: <20181113.145347.202584017982412625.davem@davemloft.net>
References: <20181112160133.16058-1-ubraun@linux.ibm.com>
        <20181112160133.16058-5-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181112160133.16058-5-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Mon, 12 Nov 2018 17:01:32 +0100

> +/* SMC-D cursor format */
> +union smcd_cdc_cursor {
 ...
> +} __aligned(8);

>  struct smcd_cdc_msg {
 ...
> +	union smcd_cdc_cursor	prod;
> +	union smcd_cdc_cursor	cons;
>  	u8 res3[8];
>  } __packed;

You're asking for 8-byte alignment of an object you only embed in a
__packed structure, which therefore has arbitary alignment.

It's not going to work.
