From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH V5 net-next 1/2] net: introduce socket family constants
Date: Fri, 11 Sep 2015 15:07:27 -0700 (PDT)
Message-ID: <20150911.150727.1724015352215300943.davem@davemloft.net>
References: <1441973350-62517-1-git-send-email-ubraun@linux.vnet.ibm.com>
	<1441973350-62517-2-git-send-email-ubraun@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1441973350-62517-2-git-send-email-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.vnet.ibm.com
Cc: utz.bacher@de.ibm.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ursula.braun@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Fri, 11 Sep 2015 14:09:09 +0200

> @@ -0,0 +1,13 @@
> +/*
> + * SMC		Definitions for the SMC protocol.
> + *
> + * Author:	Ursula Braun <ursula.braun@de.ibm.com>
> + */
> +#ifndef _SMC_H
> +#define _SMC_H
> +
> +/* SMC socket options - disjunct with TCP socket options */
> +#define SMC_KEEPALIVE		99	/* start/stop keepalives */
> +
> +#endif /* _SMC_H */
> +

Trailing empty lines in files always generate warnings when such
patches are attempted to be applied by GIT.
