Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 8 Mar 2019 08:08:47 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390/mem_detect: Use IS_ENABLED(CONFIG_BLK_DEV_INITRD)
In-Reply-To: <d81a9133ad20d478dc8c14fbc8d1bacf4c8ffe94.camel@perches.com>
References: <d81a9133ad20d478dc8c14fbc8d1bacf4c8ffe94.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190308080847.70910d18@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 07 Mar 2019 15:51:45 -0800
Joe Perches <joe@perches.com> wrote:

> IS_ENABLED should generally use CONFIG_ prefaced symbols and
> it doesn't appear as if there is a BLK_DEV_INITRD define.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/s390/boot/mem_detect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/boot/mem_detect.c b/arch/s390/boot/mem_detect.c
> index 4cb771ba13fa..5d316fe40480 100644
> --- a/arch/s390/boot/mem_detect.c
> +++ b/arch/s390/boot/mem_detect.c
> @@ -25,7 +25,7 @@ static void *mem_detect_alloc_extended(void)
>  {
>  	unsigned long offset = ALIGN(mem_safe_offset(), sizeof(u64));
> 
> -	if (IS_ENABLED(BLK_DEV_INITRD) && INITRD_START && INITRD_SIZE &&
> +	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && INITRD_START && INITRD_SIZE &&
>  	    INITRD_START < offset + ENTRIES_EXTENDED_MAX)
>  		offset = ALIGN(INITRD_START + INITRD_SIZE, sizeof(u64));
> 
> 

With more than the 255 embedded entries and a initrd that sits in the
wrong location that would have resulted in a corrupted ramdisk.
Nice catch, thanks. I'll add the patch to my queue.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
