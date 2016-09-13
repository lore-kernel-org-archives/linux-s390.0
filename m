Return-Path: <linux-kbuild-owner@vger.kernel.org>
Date: Tue, 13 Sep 2016 08:46:22 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/2] ubsan: allow to disable the null sanitizer
References: <1473683840-8700-1-git-send-email-borntraeger@de.ibm.com>
 <1473683840-8700-2-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1473683840-8700-2-git-send-email-borntraeger@de.ibm.com>
Message-Id: <20160913064622.GA4047@osiris>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michal Marek <mmarek@suse.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Yang Shi <yang.shi@linaro.org>, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Sep 12, 2016 at 02:37:19PM +0200, Christian Borntraeger wrote:
> Some architectures use a hardware defined struct at address zero.
> Checking for a null pointer will result in many ubsan reports.
> Let users disable the null sanitizer.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  lib/Kconfig.ubsan      | 11 +++++++++++
>  scripts/Makefile.ubsan |  5 ++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index 39494af..851c3f2 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -1,6 +1,9 @@
>  config ARCH_HAS_UBSAN_SANITIZE_ALL
>  	bool
> 
> +config ARCH_WANTS_UBSAN_NO_NULL
> +	def_bool n
> +
>  config UBSAN
>  	bool "Undefined behaviour sanity checker"
>  	help
> @@ -34,3 +37,11 @@ config UBSAN_ALIGNMENT
>  	  This option enables detection of unaligned memory accesses.
>  	  Enabling this option on architectures that support unaligned
>  	  accesses may produce a lot of false positives.
> +
> +config UBSAN_NULL
> +	bool "Enable checking of null pointers"
> +	depends on UBSAN
> +	default y if UBSAN && !ARCH_WANTS_UBSAN_NO_NULL

I removed the not needed UBSAN from the "default y" and applied both
patches to the s390 tree.

Thanks!
