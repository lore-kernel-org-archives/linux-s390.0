From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 3/4] s390/diag: add diag26c support
Date: Mon, 19 Jun 2017 13:37:43 -0400 (EDT)
Message-ID: <20170619.133743.1638444891079509192.davem@davemloft.net>
References: <20170619112225.30471-4-jwi@linux.vnet.ibm.com>
        <20170619.104726.1778743929564587843.davem@davemloft.net>
        <20170619173425.4d537667@mschwideX1>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170619173425.4d537667@mschwideX1>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: jwi@linux.vnet.ibm.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 19 Jun 2017 17:34:25 +0200

> We (as in the s390 guys) tend to add __packed to hardware and hypervisor
> structures even if the attribute is not strictly necessary. Most of the
> diagnose related structures look that way. Dunno if it is worth to change
> them.

It causes gcc to generate bad code on certain platforms (yes, probably not
yours) and is in general something to avoid.

Please do not use __packed unless absolutely necessary.

> The diag26c struct needs to be aligned on a doubleword boundary, the
> __aligned(8) is necessary.

That's fine.

> The __packed attribute is again superfluous but follows along the
> lines of the other diag structures.

Please remove it.
