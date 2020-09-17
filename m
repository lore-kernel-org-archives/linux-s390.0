Return-Path: <netdev-owner@vger.kernel.org>
Date: Wed, 16 Sep 2020 17:34:39 -0700 (PDT)
Message-Id: <20200916.173439.1724773929942352474.davem@davemloft.net>
Subject: Re: [PATCH net-next 1/1] net/smc: check variable before
 dereferencing in smc_close.c
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200915205709.50325-2-kgraul@linux.ibm.com>
References: <20200915205709.50325-1-kgraul@linux.ibm.com>
        <20200915205709.50325-2-kgraul@linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: kgraul@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>
Date: Tue, 15 Sep 2020 22:57:09 +0200

> smc->clcsock and smc->clcsock->sk are used before the check if they can
> be dereferenced. Fix this by checking the variables first.
> 
> Fixes: a60a2b1e0af1 ("net/smc: reduce active tcp_listen workers")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>

Applied, thank you.
