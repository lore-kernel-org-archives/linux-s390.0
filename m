Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgIRBEX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 17 Sep 2020 21:04:23 -0400
Date: Thu, 17 Sep 2020 18:04:21 -0700 (PDT)
Message-Id: <20200917.180421.267575960727747646.davem@davemloft.net>
Subject: Re: [PATCH net-next 1/1] net/smc: fix double kfree in
 smc_listen_work()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200917204602.14586-2-kgraul@linux.ibm.com>
References: <20200917204602.14586-1-kgraul@linux.ibm.com>
        <20200917204602.14586-2-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Thu, 17 Sep 2020 22:46:02 +0200

> From: Ursula Braun <ubraun@linux.ibm.com>
> 
> If smc_listen_rmda_finish() returns with an error, the storage
> addressed by 'buf' is freed a second time.
> Consolidate freeing under a common label and jump to that label.
> 
> Fixes: 6bb14e48ee8d ("net/smc: dynamic allocation of CLC proposal buffer")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>

Applied.
