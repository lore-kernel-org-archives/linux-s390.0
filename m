Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 20 Apr 2015 10:32:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390: char: con3215: Free memory in error path
Message-ID: <20150420103207.7491723c@mschwide>
In-Reply-To: <1429449456-4050-1-git-send-email-christophe.jaillet@wanadoo.fr>
References: <1429449456-4050-1-git-send-email-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Cc: heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, 19 Apr 2015 15:17:36 +0200
Christophe Jaillet <christophe.jaillet@wanadoo.fr> wrote:

> If one memory allocation fails, there is a memory leak.
> 
> Signed-off-by: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/s390/char/con3215.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
> index c43aca6..0fc3fe5 100644
> --- a/drivers/s390/char/con3215.c
> +++ b/drivers/s390/char/con3215.c
> @@ -667,6 +667,8 @@ static struct raw3215_info *raw3215_alloc_info(void)
>  	info->buffer = kzalloc(RAW3215_BUFFER_SIZE, GFP_KERNEL | GFP_DMA);
>  	info->inbuf = kzalloc(RAW3215_INBUF_SIZE, GFP_KERNEL | GFP_DMA);
>  	if (!info->buffer || !info->inbuf) {
> +		kfree(info->inbuf);
> +		kfree(info->buffer);
>  		kfree(info);
>  		return NULL;
>  	}

Applied, thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
