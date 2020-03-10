Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:43424 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgCJWlP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 10 Mar 2020 18:41:15 -0400
Date: Tue, 10 Mar 2020 15:41:14 -0700 (PDT)
Message-Id: <20200310.154114.1100646908686438492.davem@davemloft.net>
Subject: Re: [PATCH v2 net] net/smc: cancel event worker during device
 removal
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200310083330.90427-1-kgraul@linux.ibm.com>
References: <20200310083330.90427-1-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: leon@kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Tue, 10 Mar 2020 09:33:30 +0100

> During IB device removal, cancel the event worker before the device
> structure is freed.
> 
> Fixes: a4cf0443c414 ("smc: introduce SMC as an IB-client")
> Reported-by: syzbot+b297c6825752e7a07272@syzkaller.appspotmail.com
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
> Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>

Applied and queued up for -stable, thank you.
