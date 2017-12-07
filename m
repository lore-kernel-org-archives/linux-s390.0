Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 7 Dec 2017 13:55:07 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390/decompressor: add fortify_panic as x86 has.
In-Reply-To: <20171207103727.9461-1-msuchanek@suse.de>
References: <20171207103727.9461-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20171207135507.275c5809@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Michal Suchanek <msuchanek@suse.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Marcelo Henrique Cerri <marcelo.cerri@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu,  7 Dec 2017 11:37:27 +0100
Michal Suchanek <msuchanek@suse.de> wrote:

> Fix following error:
> 
>   LD      arch/s390/boot/compressed/vmlinux
> drivers/s390/char/sclp_early_core.o: In function `memcpy':
> ../include/linux/string.h:340: undefined reference to `fortify_panic'
> make[4]: *** [../arch/s390/boot/compressed/Makefile:29: arch/s390/boot/compressed/vmlinux] Error 1
> 
> Fixes: 79962038dffa ("s390: add support for FORTIFY_SOURCE")
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  arch/s390/boot/compressed/misc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/s390/boot/compressed/misc.c b/arch/s390/boot/compressed/misc.c
> index cecf38b9ec82..e79c4499c548 100644
> --- a/arch/s390/boot/compressed/misc.c
> +++ b/arch/s390/boot/compressed/misc.c
> @@ -174,3 +174,7 @@ unsigned long decompress_kernel(void)
>  	return (unsigned long) output;
>  }
> 
> +void fortify_panic(const char *name)
> +{
> +	error("detected buffer overflow");
> +}

Odd, the current linux master tree builds just fine with CONFIG_FORTIFY_SOURCE=y.
There *is* a reference to fortify_panic in drivers/s390/char/sclp_early.o.
This object is included in the link for the compressed vmlinux, but the
function  that contains the call to fortify_panic is not included in the
compressed image. I wonder what causes this difference in behavior.

The patch makes sense though and I will add it to the queue.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
