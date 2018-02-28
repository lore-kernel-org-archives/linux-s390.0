Return-Path: <netdev-owner@vger.kernel.org>
Date: Wed, 28 Feb 2018 12:30:43 -0500 (EST)
Message-Id: <20180228.123043.1302715086977512992.davem@davemloft.net>
Subject: Re: [PATCH net 0/3] net/smc: fixes 2018-02-28
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180228114409.33645-1-ubraun@linux.vnet.ibm.com>
References: <20180228114409.33645-1-ubraun@linux.vnet.ibm.com>
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
Date: Wed, 28 Feb 2018 12:44:06 +0100

> here are 3 smc bug fixes for the net-tree. Karsten's first patch is
> the reworked version of last week's
>    "[PATCH net-next 2/5] net/smc: fix structure size"
> patch, now solved without using __packed, and now targetted for net
> instead of net-next.

Series applied, thank you.
