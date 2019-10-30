Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:34030 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfJ3BKj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 29 Oct 2019 21:10:39 -0400
Date: Tue, 29 Oct 2019 18:10:38 -0700 (PDT)
Message-Id: <20191029.181038.1190737298290626895.davem@davemloft.net>
Subject: Re: [PATCH net 1/1] net/smc: fix refcounting for non-blocking
 connect()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20191029114126.59907-1-ubraun@linux.ibm.com>
References: <20191029114126.59907-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Tue, 29 Oct 2019 12:41:26 +0100

> If a nonblocking socket is immediately closed after connect(),
> the connect worker may not have started. This results in a refcount
> problem, since sock_hold() is called from the connect worker.
> This patch moves the sock_hold in front of the connect worker
> scheduling.
> 
> Reported-by: syzbot+4c063e6dea39e4b79f29@syzkaller.appspotmail.com
> Fixes: 50717a37db03 ("net/smc: nonblocking connect rework")
> Reviewed-by: Karsten Graul <kgraul@linux.ibm.com>
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>

Applied and queued up for -stable, thank you.
