Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH] s390/ap_bus: replace PTR_RET with PTR_ERR_OR_ZERO
References: <20180719044205.GA24764@embeddedor.com>
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Thu, 19 Jul 2018 16:40:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180719044205.GA24764@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <9b1b260f-0caa-a199-3d22-a4c1d62e89f2@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 19.07.2018 06:42, Gustavo A. R. Silva wrote:
> PTR_RET is deprecated, use PTR_ERR_OR_ZERO instead.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/s390/crypto/ap_bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
> index c0a6723..bf27fc4 100644
> --- a/drivers/s390/crypto/ap_bus.c
> +++ b/drivers/s390/crypto/ap_bus.c
> @@ -474,7 +474,7 @@ static int ap_poll_thread_start(void)
>  		return 0;
>  	mutex_lock(&ap_poll_thread_mutex);
>  	ap_poll_kthread = kthread_run(ap_poll_thread, NULL, "appoll");
> -	rc = PTR_RET(ap_poll_kthread);
> +	rc = PTR_ERR_OR_ZERO(ap_poll_kthread);
>  	if (rc)
>  		ap_poll_kthread = NULL;
>  	mutex_unlock(&ap_poll_thread_mutex);
> @@ -1242,7 +1242,7 @@ static int __init ap_module_init(void)
>  
>  	/* Create /sys/devices/ap. */
>  	ap_root_device = root_device_register("ap");
> -	rc = PTR_RET(ap_root_device);
> +	rc = PTR_ERR_OR_ZERO(ap_root_device);
>  	if (rc)
>  		goto out_bus;
>  

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
