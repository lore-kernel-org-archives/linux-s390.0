Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2] net: iucv: Free memory obtained by kzalloc
References: <1519881952-6663-1-git-send-email-arvind.yadav.cs@gmail.com>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Thu, 1 Mar 2018 10:45:08 +0100
MIME-Version: 1.0
In-Reply-To: <1519881952-6663-1-git-send-email-arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <8f90da04-d059-648a-0b45-e3a381e4342d@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: jwi@linux.vnet.ibm.com, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 03/01/2018 06:25 AM, Arvind Yadav wrote:
> Free memory, if afiucv_iucv_init is not successful. So calling
> put_device() before kfree(). This will decrement the last reference.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> changes in v2:
>              Calling put_device() before kfree().
> 
>  net/iucv/af_iucv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 1e8cc7b..a07943f 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -2433,9 +2433,12 @@ static int afiucv_iucv_init(void)
>  	af_iucv_dev->driver = &af_iucv_driver;
>  	err = device_register(af_iucv_dev);
>  	if (err)
> -		goto out_driver;
> +		goto out_iucv_dev;
>  	return 0;
> 
> +out_iucv_dev:
> +	put_device(af_iucv_dev);
> +	kfree(af_iucv_dev);
>  out_driver:
>  	driver_unregister(&af_iucv_driver);
>  out_iucv:
>

Just put_device() should be sufficient here; please get rid of the kfree() call.
 
