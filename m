From: David Miller <davem@davemloft.net>
Subject: Re: qeth_l3 build broken in net-next
Date: Mon, 19 Dec 2011 15:05:25 -0500 (EST)
Message-ID: <20111219.150525.11219431434126110.davem@davemloft.net>
References: <20111219132010.GA10345@tuxmaker.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20111219132010.GA10345@tuxmaker.boeblingen.de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: blaschka@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Frank Blaschka <blaschka@linux.vnet.ibm.com>
Date: Mon, 19 Dec 2011 14:20:10 +0100

> qeth_l3 build is broken in net-next
> 
> drivers/s390/net/qeth_l3_main.c: In function 'qeth_l3_neigh_setup':
> drivers/s390/net/qeth_l3_main.c:3277: error: 'struct neigh_parms' has no member named 'neigh_setup'
> make[2]: *** [drivers/s390/net/qeth_l3_main.o] Error 1
> make[1]: *** [drivers/s390/net] Error 2
> make: *** [drivers/s390] Error 2
> 
> commit 5c3ddec73d01a1fae9409c197078cb02c42238c3
>     net: Remove unused neighbour layer ops.
> 
> cause the problem. Actually qeth_l3 uses neigh_setup.
> Can you revert commit 5c3ddec73d01a1fae9409c197078cb02c42238c3 ?

Done, sorry about that.
