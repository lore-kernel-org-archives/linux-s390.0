Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 5 Nov 2018 07:08:29 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390: numa: Export __node_distance
In-Reply-To: <1541366886-32127-1-git-send-email-linux@roeck-us.net>
References: <1541366886-32127-1-git-send-email-linux@roeck-us.net>
Message-Id: <20181105070829.74d7a4bf@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

On Sun,  4 Nov 2018 13:28:06 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> __node_distance is used by nvme, resulting in:
> 
> ERROR: "__node_distance" [drivers/nvme/host/nvme-core.ko] undefined!
> 
> when trying to build nvme as module.
> 
> Fixes: f333444708f8 ("nvme: take node locality into account when selecting a path")
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> I thought I had seen that patch already, but I don't find it anywhere.
> Maybe that was for another architecture. My apologies for the noise if it
> is already queued.
> 
>  arch/s390/numa/numa.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/numa/numa.c b/arch/s390/numa/numa.c
> index ae0d9e889534..d31bde0870d8 100644
> --- a/arch/s390/numa/numa.c
> +++ b/arch/s390/numa/numa.c
> @@ -53,6 +53,7 @@ int __node_distance(int a, int b)
>  {
>  	return mode->distance ? mode->distance(a, b) : 0;
>  }
> +EXPORT_SYMBOL(__node_distance);
> 
>  int numa_debug_enabled;
> 

That one is already queued. I'll do the __no_kasan_or_inline
change that Linus requested and then send a please pull.
Should be upstream in a few days.

For reference:

https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=for-linus&id=a541f0ebcc08ed8bc0cc492eec9a86cb280a9f24

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
