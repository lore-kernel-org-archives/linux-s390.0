Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v3] net: iucv: Free memory obtained by kzalloc
References: <1519903917-11575-1-git-send-email-arvind.yadav.cs@gmail.com>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Thu, 1 Mar 2018 17:18:21 +0100
MIME-Version: 1.0
In-Reply-To: <1519903917-11575-1-git-send-email-arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <6335d05c-f87e-d5b5-f86b-2255ab0191b8@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: jwi@linux.vnet.ibm.com, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 03/01/2018 12:31 PM, Arvind Yadav wrote:
> Free memory by calling put_device(), if afiucv_iucv_init is not
> successful.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> changes in v2:
>              Calling put_device() before kfree().
> changes in v3:
>              No need to call kfree(). So removed kfree().
> 
>  net/iucv/af_iucv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 1e8cc7b..9e2643a 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -2433,9 +2433,11 @@ static int afiucv_iucv_init(void)
>  	af_iucv_dev->driver = &af_iucv_driver;
>  	err = device_register(af_iucv_dev);
>  	if (err)
> -		goto out_driver;
> +		goto out_iucv_dev;
>  	return 0;
> 
> +out_iucv_dev:
> +	put_device(af_iucv_dev);
>  out_driver:
>  	driver_unregister(&af_iucv_driver);
>  out_iucv:
> 

Thanks Arvind, I have added this patch version to our local repository; it will be part of a
coming patch submission to Dave Miller.

Regards, Ursula
