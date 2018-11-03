From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net 0/6] s390/qeth: fixes 2018-11-02
Date: Sat, 03 Nov 2018 10:44:23 -0700 (PDT)
Message-ID: <20181103.104423.164937572040750291.davem@davemloft.net>
References: <20181102180413.53020-1-jwi@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181102180413.53020-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jwi@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Fri,  2 Nov 2018 19:04:07 +0100

> please apply one round of qeth fixes for -net.
> 
> Patch 1 is rather large and removes a use-after-free hazard from many of our
> debug trace entries.
> Patch 2 is yet another fix-up for the L3 subdriver's new IP address management
> code.
> Patch 3 and 4 resolve some fallout from the recent changes wrt how/when qeth
> allocates its net_device.
> Patch 5 makes sure we don't set reserved bits when building HW commands from
> user-provided data.
> And finally, patch 6 allows ethtool to play nice with new HW.

Series applied.
