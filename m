From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: remove no-op macro VMLINUX_SYMBOL()
Date: Wed, 9 May 2018 10:32:22 +0200
Message-ID: <20180509083222.GC3698@osiris>
References: <1525852299-29134-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525852299-29134-1-git-send-email-yamada.masahiro@socionext.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, May 09, 2018 at 04:51:39PM +0900, Masahiro Yamada wrote:
> VMLINUX_SYMBOL() is no-op unless CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
> is defined.  It has ever been selected only by BLACKFIN and METAG.
> VMLINUX_SYMBOL() is unneeded for s390-specific code.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/s390/kernel/vmlinux.lds.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
> index 08d12cf..f0414f5 100644
> --- a/arch/s390/kernel/vmlinux.lds.S
> +++ b/arch/s390/kernel/vmlinux.lds.S
> @@ -82,10 +82,10 @@ SECTIONS
>  
>  	. = ALIGN(PAGE_SIZE);
>  	.init.text : AT(ADDR(.init.text) - LOAD_OFFSET) {
> -		VMLINUX_SYMBOL(_sinittext) = . ;
> +		_sinittext = .;
>  		INIT_TEXT
>  		. = ALIGN(PAGE_SIZE);
> -		VMLINUX_SYMBOL(_einittext) = . ;
> +		_einittext = .;

Applied, thanks.
