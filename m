From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net 1/1] net/smc: fix shutdown in state SMC_LISTEN
Date: Thu, 19 Apr 2018 16:39:11 -0400 (EDT)
Message-ID: <20180419.163911.695170658014127807.davem@davemloft.net>
References: <20180419135640.2907-1-ubraun@linux.ibm.com>
        <20180419135640.2907-2-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180419135640.2907-2-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, stephen@networkplumber.org, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Thu, 19 Apr 2018 15:56:40 +0200

> From: Ursula Braun <ubraun@linux.vnet.ibm.com>
> 
> Calling shutdown with SHUT_RD and SHUT_RDWR for a listening SMC socket
> crashes, because
>    commit 127f49705823 ("net/smc: release clcsock from tcp_listen_worker")
> releases the internal clcsock in smc_close_active() and sets smc->clcsock
> to NULL.
> For SHUT_RD the smc_close_active() call is removed.
> For SHUT_RDWR the kernel_sock_shutdown() call is omitted, since the
> clcsock is already released.
> 
> Fixes: 127f49705823 ("net/smc: release clcsock from tcp_listen_worker")
> Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
> Reported-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thank you.
