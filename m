From: David Miller <davem@davemloft.net>
Subject: Re: [patch 1/1] iucv: fix build error on !SMP
Date: Mon, 03 Mar 2008 12:13:30 -0800 (PST)
Message-ID: <20080303.121330.28236620.davem@davemloft.net>
References: <20080303131610.405835000@linux.vnet.ibm.com>
	<20080303131924.416374000@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20080303131924.416374000@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: braunu@de.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, jeffpc@josefsipek.net
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <braunu@de.ibm.com>
Date: Mon, 03 Mar 2008 14:16:11 +0100

> Since a5fbb6d1064be885d2a6b82f625186753cf74848
> "KVM: fix !SMP build error" smp_call_function isn't a define anymore
> that folds into nothing but a define that calls up_smp_call_function
> with all parameters. Hence we cannot #ifdef out the unused code
> anymore...
> This seems to be the preferred method, so do this for s390 as well.
> 
> net/iucv/iucv.c: In function 'iucv_cleanup_queue':
> net/iucv/iucv.c:657: error: '__iucv_cleanup_queue' undeclared
> 
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
> Signed-off-by: Ursula Braun <braunu@de.ibm.com>

Applied, thanks.
