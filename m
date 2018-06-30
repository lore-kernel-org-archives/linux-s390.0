From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 00/10] pnetid and SMC-D support
Date: Sat, 30 Jun 2018 20:46:13 +0900 (KST)
Message-ID: <20180630.204613.1236220486650210183.davem@davemloft.net>
References: <20180628170513.5089-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180628170513.5089-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, hwippel@linux.ibm.com, sebott@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Thu, 28 Jun 2018 19:05:03 +0200

> SMC requires a configured pnet table to map Ethernet interfaces to
> RoCE adapter ports. For s390 there exists hardware support to group
> such devices. The first three patches cover the s390 pnetid support,
> enabling SMC-R usage on s390 without configuring an extra pnet table.
> 
> SMC currently requires RoCE adapters, and uses RDMA-techniques
> implemented with IB-verbs. But s390 offers another method for
> intra-CEC Shared Memory communication. The following seven patches
> implement a solution to run SMC traffic based on intra-CEC DMA,
> called SMC-D.

Series applied.
