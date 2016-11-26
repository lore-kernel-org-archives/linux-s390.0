From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH V3 net-next 03/15] smc: establish pnet table management
Date: Fri, 25 Nov 2016 20:51:42 -0500 (EST)
Message-ID: <20161125.205142.972152411364122440.davem@davemloft.net>
References: <20161124150645.90881-1-ubraun@linux.vnet.ibm.com>
        <20161124150645.90881-4-ubraun@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20161124150645.90881-4-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, utz.bacher@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Thu, 24 Nov 2016 16:06:33 +0100

> Connection creation with SMC-R starts through an internal
> TCP-connection. The Ethernet interface for this TCP-connection is not
> restricted to the Ethernet interface of a RoCE device. Any existing
> Ethernet interface belonging to the same physical net can be used, as
> long as there is a defined relation between the Ethernet interface and
> some RoCE devices. This relation is defined with the help of an
> identification string called "Physical Net ID" or short "pnet ID".
> Information about defined pnet IDs and their related Ethernet
> interfaces and RoCE devices is stored in the SMC-R pnet table.
> 
> This patch adds pnet table configuration support as a set of
> sysfs files listed under /sys/kernel/smc. Attribute files
> exist to add and delete pnet IDs and to map RoCE devices and
> ethernet interfaces to an individual pnet ID.
> 
> There is no cross check if ethernet interfaces or infiniband
> devices really exist in the system. This enables the configuration of
> the pnet table after module load even if interfaces or devices might
> not yet be available.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>

Please do not use sysfs to configure your subsystems IB and eth
mappings.

Instead use a properly formed genetlink interface that will properly
integrate with other subsystems, and also allow for proper event
monitoring.

I also fundamentally disagree with allowing references to devices that
do not even exist yet.  It implies a string --> device conversion in
places where that cost should be avoided.
