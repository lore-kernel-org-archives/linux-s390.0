Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:49096 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfKLURv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 12 Nov 2019 15:17:51 -0500
Date: Tue, 12 Nov 2019 12:17:49 -0800 (PST)
Message-Id: <20191112.121749.1249383492212187557.davem@davemloft.net>
Subject: Re: [PATCH net] net/smc: fix refcount non-blocking connect() -part
 2
From: David Miller <davem@davemloft.net>
In-Reply-To: <20191112150341.90681-1-kgraul@linux.ibm.com>
References: <20191112150341.90681-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Tue, 12 Nov 2019 16:03:41 +0100

> From: Ursula Braun <ubraun@linux.ibm.com>
> 
> If an SMC socket is immediately terminated after a non-blocking connect()
> has been called, a memory leak is possible.
> Due to the sock_hold move in
> commit 301428ea3708 ("net/smc: fix refcounting for non-blocking connect()")
> an extra sock_put() is needed in smc_connect_work(), if the internal
> TCP socket is aborted and cancels the sk_stream_wait_connect() of the
> connect worker.
> 
> Reported-by: syzbot+4b73ad6fc767e576e275@syzkaller.appspotmail.com
> Fixes: 301428ea3708 ("net/smc: fix refcounting for non-blocking connect()")
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>

Applied.

And since 301428ea3708 went to -stable, I'll queue this up too.

Thanks.
