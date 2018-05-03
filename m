From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net 0/3] net/smc: fixes 2018/05/03
Date: Thu, 03 May 2018 14:47:45 -0400 (EDT)
Message-ID: <20180503.144745.790200805404367847.davem@davemloft.net>
References: <20180503155739.55616-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180503155739.55616-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Thu,  3 May 2018 17:57:36 +0200

> From: Ursula Braun <ursula.braun@de.ibm.com>
> 
> Dave,
> 
> here are smc fixes for 2 problems:
>  * receive buffers in SMC must be registered. If registration fails
>    these buffers must not be kept within the link group for reuse.
>    Patch 1 is a preparational patch; patch 2 contains the fix.
>  * sendpage: do not hold the sock lock when calling kernel_sendpage()
>              or sock_no_sendpage()

Series applied, thanks.
