From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 0/6] smc: fixes 2017-12-07
Date: Thu, 07 Dec 2017 15:06:39 -0500 (EST)
Message-ID: <20171207.150639.244369131731587209.davem@davemloft.net>
References: <20171207123849.52910-1-ubraun@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171207123849.52910-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Thu,  7 Dec 2017 13:38:43 +0100

> here are some smc-patches. The initial 4 patches are cleanups.
> Patch 5 gets rid of ib_post_sends in tasklet context to avoid peer drops due
> to out-of-order receivals.
> Patch 6 makes sure, the Linux SMC code understands variable sized CLC proposal
> messages built according to RFC7609.

Series applied to net-next.
