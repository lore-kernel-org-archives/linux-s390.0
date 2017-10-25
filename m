From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH V2 net-next 2/3] tcp: TCP experimental option for SMC
Date: Wed, 25 Oct 2017 09:55:03 +0900 (KST)
Message-ID: <20171025.095503.1508889155137067392.davem@davemloft.net>
References: <20171018143000.23884-1-ubraun@linux.vnet.ibm.com>
        <20171018143000.23884-3-ubraun@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171018143000.23884-3-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Wed, 18 Oct 2017 16:29:59 +0200

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 3b3b9b968e2d..a2e87ac8cdc0 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -45,6 +45,7 @@
>  
>  #include <linux/seq_file.h>
>  #include <linux/memcontrol.h>
> +#include <linux/unaligned/access_ok.h>

Only tcp_input.c needs this include.  If you include it here, then the
rest of the kernel pays the price of this include.
