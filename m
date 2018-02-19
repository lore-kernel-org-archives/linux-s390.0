From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 19 Feb 2018 06:29:09 +0000
Subject: Re: [PATCH] s390: Replace IS_ENABLED(EXPOLINE_*) with IS_ENABLED(CONFIG_EXPOLINE_*)
Message-Id: <20180219072909.4199211e@mschwideX1>
In-Reply-To: <20180217231029.32111-1-rosca.eugeniu@gmail.com>
References: <20180217231029.32111-1-rosca.eugeniu@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, 18 Feb 2018 00:10:29 +0100
Eugeniu Rosca <roscaeugeniu@gmail.com> wrote:

> From: Eugeniu Rosca <erosca@de.adit-jv.com>
> 
> I've accidentally stumbled upon the IS_ENABLED(EXPOLINE_*) lines, which
> obviously always evaluate to false. Fix this.
> 
> Fixes: f19fbd5ed642 ("s390: introduce execute-trampolines for branches")
> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> ---
>  arch/s390/kernel/nospec-branch.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/nospec-branch.c b/arch/s390/kernel/nospec-branch.c
> index 69d7fcf48158..9aff72d3abda 100644
> --- a/arch/s390/kernel/nospec-branch.c
> +++ b/arch/s390/kernel/nospec-branch.c
> @@ -2,8 +2,8 @@
>  #include <linux/module.h>
>  #include <asm/nospec-branch.h>
> 
> -int nospec_call_disable = IS_ENABLED(EXPOLINE_OFF);
> -int nospec_return_disable = !IS_ENABLED(EXPOLINE_FULL);
> +int nospec_call_disable = IS_ENABLED(CONFIG_EXPOLINE_OFF);
> +int nospec_return_disable = !IS_ENABLED(CONFIG_EXPOLINE_FULL);
> 
>  static int __init nospectre_v2_setup_early(char *str)
>  {

Applied, thank you!

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
