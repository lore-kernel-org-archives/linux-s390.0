Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 26 Sep 2010 18:56:15 -0700 (PDT)
Message-Id: <20100926.185615.212684376.davem@davemloft.net>
Subject: Re: [PATCH 4/9] s390: use free_netdev(netdev) instead of kfree()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1285495090-22002-1-git-send-email-segooon@gmail.com>
References: <1285495090-22002-1-git-send-email-segooon@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: segooon@gmail.com
Cc: kernel-janitors@vger.kernel.org, ursula.braun@de.ibm.com, blaschka@linux.vnet.ibm.com, linux390@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, julia@diku.dk, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Vasiliy Kulikov <segooon@gmail.com>
Date: Sun, 26 Sep 2010 13:58:09 +0400

> Freeing netdev without free_netdev() leads to net, tx leaks.
> I might lead to dereferencing freed pointer.
> 
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> @@
> struct net_device* dev;
> @@
> 
> -kfree(dev)
> +free_netdev(dev)

Applied.
