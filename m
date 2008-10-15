From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Wed, 15 Oct 2008 11:32:55 +0000
Subject: Re: [PATCH] [S390] unsigned ops->size cannot be negative
Message-Id: <20081015113255.GA6934@osiris.boeblingen.de.ibm.com>
In-Reply-To: <48F54009.6080605@gmail.com>
References: <48F54009.6080605@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Oct 14, 2008 at 08:57:45PM -0400, roel kluin wrote:
> unsigned ops->size cannot be negative

True.

> N.B. It could be possible that a different fix is needed.

Why fix? Does it fix a problem for you?
To me it looks like you removed a pointless check. If this is supposed
to fix any real problem then we need to take closer look.

> diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
> index a7f8979..a06a47c 100644
> --- a/arch/s390/appldata/appldata_base.c
> +++ b/arch/s390/appldata/appldata_base.c
> @@ -424,7 +424,7 @@ out:
>   */
>  int appldata_register_ops(struct appldata_ops *ops)
>  {
> -	if ((ops->size > APPLDATA_MAX_REC_SIZE) || (ops->size < 0))
> +	if (ops->size > APPLDATA_MAX_REC_SIZE)
>  		return -EINVAL;
