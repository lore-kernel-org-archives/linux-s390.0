Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:33728 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfHEUZX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 5 Aug 2019 16:25:23 -0400
Date: Mon, 05 Aug 2019 13:25:22 -0700 (PDT)
Message-Id: <20190805.132522.1261096972203874719.davem@davemloft.net>
Subject: Re: [PATCH net] net/smc: avoid fallback in case of non-blocking
 connect
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190802084750.5518-1-kgraul@linux.ibm.com>
References: <20190802084750.5518-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Fri,  2 Aug 2019 10:47:50 +0200

> From: Ursula Braun <ubraun@linux.ibm.com>
> 
> FASTOPEN is not possible with SMC. sendmsg() with msg_flag MSG_FASTOPEN
> triggers a fallback to TCP if the socket is in state SMC_INIT.
> But if a nonblocking connect is already started, fallback to TCP
> is no longer possible, even though the socket may still be in state
> SMC_INIT.
> And if a nonblocking connect is already started, a listen() call
> does not make sense.
> 
> Reported-by: syzbot+bd8cc73d665590a1fcad@syzkaller.appspotmail.com
> Fixes: 50717a37db032 ("net/smc: nonblocking connect rework")
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>

Applied and queued up for -stable.
