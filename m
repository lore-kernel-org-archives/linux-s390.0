From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 0/7] s390/net: more updates for 4.14
Date: Fri, 18 Aug 2017 10:22:03 -0700 (PDT)
Message-ID: <20170818.102203.156780357331879436.davem@davemloft.net>
References: <20170818081910.48869-1-jwi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170818081910.48869-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jwi@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Date: Fri, 18 Aug 2017 10:19:03 +0200

> please apply another batch of qeth patches for net-next.
> This reworks the xmit path for L2 OSAs to use skb_cow_head() instead of
> skb_realloc_headroom().

Series applied, thanks Julian.
