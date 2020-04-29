Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbgD2PQO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Apr 2020 11:16:14 -0400
Subject: Re: [PATCH net-next] net/smc: remove unused inline function
 smc_curs_read
References: <20200429132623.48608-1-yuehaibing@huawei.com>
From: Karsten Graul <kgraul@linux.ibm.com>
Message-ID: <039d6d59-5dd5-c89a-c174-72f4de3d0098@linux.ibm.com>
Date: Wed, 29 Apr 2020 17:15:55 +0200
MIME-Version: 1.0
In-Reply-To: <20200429132623.48608-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: YueHaibing <yuehaibing@huawei.com>, ubraun@linux.ibm.com, davem@davemloft.net, kuba@kernel.org
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 29/04/2020 15:26, YueHaibing wrote:
> commit bac6de7b6370 ("net/smc: eliminate cursor read and write calls")
> left behind this.
> 

Thanks, good catch. Your patch will be part of our next patch submission.

Regards, Karsten


> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/smc/smc_cdc.h | 17 -----------------
>  1 file changed, 17 deletions(-)
> 
> diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
> index 861dc24c588c..5a19e5e2280e 100644
> --- a/net/smc/smc_cdc.h
> +++ b/net/smc/smc_cdc.h
> @@ -97,23 +97,6 @@ static inline void smc_curs_add(int size, union smc_host_cursor *curs,
>  	}
>  }
>  
> -/* SMC cursors are 8 bytes long and require atomic reading and writing */
> -static inline u64 smc_curs_read(union smc_host_cursor *curs,
> -				struct smc_connection *conn)
> -{
> -#ifndef KERNEL_HAS_ATOMIC64
> -	unsigned long flags;
> -	u64 ret;
> -
> -	spin_lock_irqsave(&conn->acurs_lock, flags);
> -	ret = curs->acurs;
> -	spin_unlock_irqrestore(&conn->acurs_lock, flags);
> -	return ret;
> -#else
> -	return atomic64_read(&curs->acurs);
> -#endif
> -}
> -
>  /* Copy cursor src into tgt */
>  static inline void smc_curs_copy(union smc_host_cursor *tgt,
>  				 union smc_host_cursor *src,
> 
