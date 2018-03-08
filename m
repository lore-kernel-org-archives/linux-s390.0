Return-Path: <netdev-owner@vger.kernel.org>
Date: Thu, 08 Mar 2018 12:43:57 -0500 (EST)
Message-Id: <20180308.124357.718414383801823111.davem@davemloft.net>
Subject: Re: [PATCH net 1/1] net/smc: wakeup closing listen socket
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180307125931.42248-2-ubraun@linux.vnet.ibm.com>
References: <20180307125931.42248-1-ubraun@linux.vnet.ibm.com>
        <20180307125931.42248-2-ubraun@linux.vnet.ibm.com>
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
Date: Wed,  7 Mar 2018 13:59:31 +0100

> Closing of a listen socket wakes up kernel_accept() of
> smc_tcp_listen_worker(), and then has to wait till
> smc_tcp_listen_worker() gives up the internal clcsock. This wait is
> non-interruptible, and does not fit to the interruptible wakeup in
> smc_tcp_listen_worker().

I am having a hard time understanding this.

A non-interruptible sleep just means that the sleeper can only be
woken up by the event itself.  Said another way, signals and other
unrelated events do not wake up the sleeper.

So as long as the socket close emits the wakeup event, the
non-interruptible sleeper will wake up.

It is also a huge red flag that you feel that you need custom handling
in this area and can't use the generic infrastructure and routines for
this.

Without a better understanding and explanation, there is no way I am
applying this.  It seems that you guys do a lot of things in custom
ways that really should follow the methods and mechanisms used by
other protocol families in the tree.

Thank you.
