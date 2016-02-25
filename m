Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 25 Feb 2016 09:49:43 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/5] all: introduce COMPAT_WRAPPER option and enable it
 for s390
Message-ID: <20160225084943.GB3980@osiris>
References: <1456338854-14901-1-git-send-email-ynorov@caviumnetworks.com>
 <1456338854-14901-3-git-send-email-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456338854-14901-3-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160225084943.ZpfrJ6W7U0h855DYm2O7Wqn3rOAZwwACqQUBXZBdaoc@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: arnd@arndb.de, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, Prasun.Kapoor@caviumnetworks.com, pinskia@gmail.com, agraf@suse.de, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, Nathan_Lynch@mentor.com, klimov.linux@gmail.com, bamvor.zhangjian@huawei.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, Feb 24, 2016 at 09:34:11PM +0300, Yury Norov wrote:
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  arch/Kconfig      | 4 ++++
>  arch/s390/Kconfig | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index f6b649d..6393093 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -583,6 +583,10 @@ config HAVE_COPY_THREAD_TLS
>  	  normal C parameter passing, rather than extracting the syscall
>  	  argument from pt_regs.
> 
> +config COMPAT_WRAPPER
> +	bool
> +	depends on COMPAT
> +
>  #
>  # ABI hall of shame
>  #
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 3be9c83..082b861 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -333,6 +333,7 @@ config COMPAT
>  	select COMPAT_BINFMT_ELF if BINFMT_ELF
>  	select ARCH_WANT_OLD_COMPAT_IPC
>  	select COMPAT_OLD_SIGACTION
> +	select COMPAT_WRAPPER
>  	depends on MULTIUSER
>  	help
>  	  Select this option if you want to enable your system kernel to

Maybe merge this into patch 4/5?
