Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH] net/smc: Fix error path in smc_init
References: <20190514063921.41088-1-yuehaibing@huawei.com>
From: Ursula Braun <ubraun@linux.ibm.com>
Date: Tue, 14 May 2019 13:13:20 +0200
MIME-Version: 1.0
In-Reply-To: <20190514063921.41088-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <73b00d55-dbab-a4d0-97e9-121ce810f012@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net, kgraul@linux.ibm.com, hwippel@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 5/14/19 8:39 AM, YueHaibing wrote:
> If register_pernet_subsys success in smc_init,
> we should cleanup it in case any other error.
> 

Thanks, looks good. Your patch will be part of our next patch
submission.

Regards, Ursula

> Fixes: 64e28b52c7a6 (net/smc: add pnet table namespace support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/smc/af_smc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 6f869ef..7d3207f 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -2019,7 +2019,7 @@ static int __init smc_init(void)
>  
>  	rc = smc_pnet_init();
>  	if (rc)
> -		return rc;
> +		goto out_pernet_subsys;
>  
>  	rc = smc_llc_init();
>  	if (rc) {
> @@ -2070,6 +2070,9 @@ static int __init smc_init(void)
>  	proto_unregister(&smc_proto);
>  out_pnet:
>  	smc_pnet_exit();
> +out_pernet_subsys:
> +	unregister_pernet_subsys(&smc_net_ops);
> +
>  	return rc;
>  }
>  
> 
