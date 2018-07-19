Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 19 Jul 2018 16:40:51 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390/tape: replace PTR_RET with PTR_ERR_OR_ZERO
In-Reply-To: <20180719044653.GA24968@embeddedor.com>
References: <20180719044653.GA24968@embeddedor.com>
MIME-Version: 1.0
Message-Id: <20180719164051.2908125c@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 18 Jul 2018 23:46:53 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> PTR_RET is deprecated, use PTR_ERR_OR_ZERO instead.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/s390/char/tape_class.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/char/tape_class.c b/drivers/s390/char/tape_class.c
> index e403edf..b58df0d 100644
> --- a/drivers/s390/char/tape_class.c
> +++ b/drivers/s390/char/tape_class.c
> @@ -77,7 +77,7 @@ struct tape_class_device *register_tape_dev(
>  	tcd->class_device = device_create(tape_class, device,
>  					  tcd->char_device->dev, NULL,
>  					  "%s", tcd->device_name);
> -	rc = PTR_RET(tcd->class_device);
> +	rc = PTR_ERR_OR_ZERO(tcd->class_device);
>  	if (rc)
>  		goto fail_with_cdev;
>  	rc = sysfs_create_link(

Applied to the s390/linux tree for the next merge window. Thanks.


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
