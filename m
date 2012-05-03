From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: skb_set_dev do not unconditionally drop ref to dst
Date: Thu, 03 May 2012 02:28:37 -0400 (EDT)
Message-ID: <20120503.022837.2021054007853235758.davem@davemloft.net>
References: <1335765093.2296.4.camel@edumazet-glaptop>
	<20120502055018.GA50959@tuxmaker.boeblingen.de.ibm.com>
	<1335941961.22133.48.camel@edumazet-glaptop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1335941961.22133.48.camel@edumazet-glaptop>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: eric.dumazet@gmail.com
Cc: blaschka@linux.vnet.ibm.com, netdev@vger.kernel.org, arnd@arndb.de, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Wed, 02 May 2012 08:59:21 +0200

> If Arnd doesnt care to even reply, we can just revert his buggy
> patch, instead of trying to understand and fix all issues.

Agreed, it's the best sounding solution by far.
