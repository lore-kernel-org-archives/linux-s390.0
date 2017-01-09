From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH V4 net-next 00/15] net/smc: Shared Memory
 Communications - RDMA
Date: Mon, 09 Jan 2017 16:23:30 -0500 (EST)
Message-ID: <20170109.162330.756630479255257312.davem@davemloft.net>
References: <20170109155526.10961-1-ubraun@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170109155526.10961-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, utz.bacher@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Mon,  9 Jan 2017 16:55:11 +0100

> here is now V4 of the SMC-R patches having processed your feedback from end
> of November. The most important change is the replacement of sysfs by a
> generic netlink solution in patch 04. And I tried to get rid of the __packed
> attributes. There are still a few usages left due to SMC-R protocol defined
> structures.

Series applied.
