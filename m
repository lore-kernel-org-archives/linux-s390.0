From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net 0/5] s390/qeth: fixes 2018-06-29
Date: Sat, 30 Jun 2018 21:20:47 +0900 (KST)
Message-ID: <20180630.212047.1245813575108390306.davem@davemloft.net>
References: <20180629174554.53718-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180629174554.53718-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Fri, 29 Jun 2018 19:45:49 +0200

> please apply a few qeth fixes for -net and your 4.17 stable queue.
> 
> Patches 1-3 fix several issues wrt to MAC address management that were
> introduced during the 4.17 cycle.
> Patch 4 tackles a long-standing issue with busy multi-connection workloads
> on devices in af_iucv mode.
> Patch 5 makes sure to re-enable all active HW offloads, after a card was
> previously set offline and thus lost its HW context.

Series applied and queued up for -stable.
