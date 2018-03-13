Return-Path: <netdev-owner@vger.kernel.org>
Date: Tue, 13 Mar 2018 11:10:49 -0400 (EDT)
Message-Id: <20180313.111049.166541727870833774.davem@davemloft.net>
Subject: Re: [PATCH V2 net 1/1] net/smc: simplify wait when closing listen
 socket
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180313094154.65533-2-ubraun@linux.vnet.ibm.com>
References: <20180313094154.65533-1-ubraun@linux.vnet.ibm.com>
        <20180313094154.65533-2-ubraun@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Tue, 13 Mar 2018 10:41:54 +0100

> Closing of a listen socket wakes up kernel_accept() of
> smc_tcp_listen_worker(), and then has to wait till smc_tcp_listen_worker()
> gives up the internal clcsock. The wait logic introduced with
> commit 127f49705823 ("net/smc: release clcsock from tcp_listen_worker")
> might wait longer than necessary. This patch implements the idea to
> implement the wait just with flush_work(), and gets rid of the extra
> smc_close_wait_listen_clcsock() function.
> 
> Fixes: 127f49705823 ("net/smc: release clcsock from tcp_listen_worker")
> Reported-by: Hans Wippel <hwippel@linux.vnet.ibm.com>
> Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>

This looks a lot better, applied, thank you.
