Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgHTTJl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 20 Aug 2020 15:09:41 -0400
Date: Thu, 20 Aug 2020 12:09:40 -0700 (PDT)
Message-Id: <20200820.120940.1305816593609644793.davem@davemloft.net>
Subject: Re: [PATCH net 1/1] net/smc: Prevent kernel-infoleak in
 __smc_diag_dump()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200820143052.99114-1-ubraun@linux.ibm.com>
References: <20200820143052.99114-1-ubraun@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, kgraul@linux.ibm.com, raspl@linux.ibm.com, yepeilin.cs@gmail.com

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Thu, 20 Aug 2020 16:30:52 +0200

> From: Peilin Ye <yepeilin.cs@gmail.com>
> 
> __smc_diag_dump() is potentially copying uninitialized kernel stack memory
> into socket buffers, since the compiler may leave a 4-byte hole near the
> beginning of `struct smcd_diag_dmbinfo`. Fix it by initializing `dinfo`
> with memset().
> 
> Cc: stable@vger.kernel.org

Please do not CC: stable for networking patches as per the netdev FAQ.

> Fixes: 4b1b7d3b30a6 ("net/smc: add SMC-D diag support")
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>

Applied and queued up for -stable, thank you.
