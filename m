Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 8 Apr 2019 15:33:34 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 06/12] s390: ctcm: fix ctcm_new_device error return code
Message-ID: <20190408223334.GD18333@archlinux-i9>
References: <20190408212648.2407234-1-arnd@arndb.de>
 <20190408212648.2407234-6-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408212648.2407234-6-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Apr 08, 2019 at 11:26:19PM +0200, Arnd Bergmann wrote:
> clang points out that the return code from this function is
> undefined for one of the error paths:
> 
> ../drivers/s390/net/ctcm_main.c:1595:7: warning: variable 'result' is used uninitialized whenever 'if' condition is true
>       [-Wsometimes-uninitialized]
>                 if (priv->channel[direction] == NULL) {
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/s390/net/ctcm_main.c:1638:9: note: uninitialized use occurs here
>         return result;
>                ^~~~~~
> ../drivers/s390/net/ctcm_main.c:1595:3: note: remove the 'if' if its condition is always false
>                 if (priv->channel[direction] == NULL) {
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/s390/net/ctcm_main.c:1539:12: note: initialize the variable 'result' to silence this warning
>         int result;
>                   ^
> 
> Make it return -ENODEV here, as in the related failure cases.
> gcc has a known bug in underreporting some of these warnings
> when it has already eliminated the assignment of the return code
> based on some earlier optimization step.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/s390/net/ctcm_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
> index 7617d21cb296..f63c5c871d3d 100644
> --- a/drivers/s390/net/ctcm_main.c
> +++ b/drivers/s390/net/ctcm_main.c
> @@ -1595,6 +1595,7 @@ static int ctcm_new_device(struct ccwgroup_device *cgdev)
>  		if (priv->channel[direction] == NULL) {
>  			if (direction == CTCM_WRITE)
>  				channel_free(priv->channel[CTCM_READ]);
> +			result = -ENODEV;
>  			goto out_dev;
>  		}
>  		priv->channel[direction]->netdev = dev;
> -- 
> 2.20.0
> 
