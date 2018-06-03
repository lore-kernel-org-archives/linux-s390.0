From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] net/smc: fix error return code in
 smc_setsockopt()
Date: Sun, 03 Jun 2018 10:39:15 -0400 (EDT)
Message-ID: <20180603.103915.1786492119200211803.davem@davemloft.net>
References: <1527733882-149144-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1527733882-149144-1-git-send-email-weiyongjun1@huawei.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: weiyongjun1@huawei.com
Cc: ubraun@linux.ibm.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Thu, 31 May 2018 02:31:22 +0000

> Fix to return error code -EINVAL instead of 0 if optlen is invalid.
> 
> Fixes: 01d2f7e2cdd3 ("net/smc: sockopts TCP_NODELAY and TCP_CORK")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Although the TCP code should be checking this in the previous lines,
it's not good practice to depend so tightly upon that.

And it makes this code easier to audit if the check exists here
explicitly too.

So I'll apply this, thanks.
