Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:33720 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbfHEUYF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 5 Aug 2019 16:24:05 -0400
Date: Mon, 05 Aug 2019 13:24:03 -0700 (PDT)
Message-Id: <20190805.132403.543467679705520777.davem@davemloft.net>
Subject: Re: [PATCH net] net/smc: do not schedule tx_work in SMC_CLOSED
 state
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190802081638.56207-1-kgraul@linux.ibm.com>
References: <20190802081638.56207-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Fri,  2 Aug 2019 10:16:38 +0200

> From: Ursula Braun <ubraun@linux.ibm.com>
> 
> The setsockopts options TCP_NODELAY and TCP_CORK may schedule the
> tx worker. Make sure the socket is not yet moved into SMC_CLOSED
> state (for instance by a shutdown SHUT_RDWR call).
> 
> Reported-by: syzbot+92209502e7aab127c75f@syzkaller.appspotmail.com
> Reported-by: syzbot+b972214bb803a343f4fe@syzkaller.appspotmail.com
> Fixes: 01d2f7e2cdd31 ("net/smc: sockopts TCP_NODELAY and TCP_CORK")
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>

Applied and queued up for -stable.
