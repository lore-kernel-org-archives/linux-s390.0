Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:53808 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfKPVEX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 16 Nov 2019 16:04:23 -0500
Date: Sat, 16 Nov 2019 13:04:22 -0800 (PST)
Message-Id: <20191116.130422.2084572901433723641.davem@davemloft.net>
Subject: Re: [PATCH net] net/smc: fix fastopen for non-blocking connect()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20191115113930.38684-1-kgraul@linux.ibm.com>
References: <20191115113930.38684-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Fri, 15 Nov 2019 12:39:30 +0100

> From: Ursula Braun <ubraun@linux.ibm.com>
> 
> FASTOPEN does not work with SMC-sockets. Since SMC allows fallback to
> TCP native during connection start, the FASTOPEN setsockopts trigger
> this fallback, if the SMC-socket is still in state SMC_INIT.
> But if a FASTOPEN setsockopt is called after a non-blocking connect(),
> this is broken, and fallback does not make sense.
> This change complements
> commit cd2063604ea6 ("net/smc: avoid fallback in case of non-blocking connect")
> and fixes the syzbot reported problem "WARNING in smc_unhash_sk".
> 
> Reported-by: syzbot+8488cc4cf1c9e09b8b86@syzkaller.appspotmail.com
> Fixes: e1bbdd570474 ("net/smc: reduce sock_put() for fallback sockets")
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>

Applied and queued up for -stable, thanks.
