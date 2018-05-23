From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 0/4] patches 2018-05-23
Date: Wed, 23 May 2018 16:02:53 -0400 (EDT)
Message-ID: <20180523.160253.2213994546075292867.davem@davemloft.net>
References: <20180523143812.25824-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180523143812.25824-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Wed, 23 May 2018 16:38:08 +0200

> here are more smc-patches for net-next:
> 
> Patch 1 fixes an ioctl problem detected by syzbot.
> 
> Patch 2 improves smc_lgr_list locking in case of abnormal link
> group termination. If you want to receive a version for the net-tree,
> please let me know. It would look somewhat different, since the port
> terminate code has been moved to smc_core.c on net-next.
> 
> Patch 3 enables SMC to deal with urgent data.
> 
> Patch 4 is a minor improvement to avoid out-of-sync linkgroups
> between 2 peers.

Series applied, thanks.
