Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 22 Jan 2019 17:24:54 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: kernel: no need to check return value of
 debugfs_create functions
References: <20190122152151.16139-3-gregkh@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <20190122152151.16139-3-gregkh@linuxfoundation.org>
Message-Id: <20190122162454.GA31034@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Kees Cook <keescook@chromium.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jan 22, 2019 at 04:21:02PM +0100, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/s390/kernel/debug.c    | 6 ------
>  arch/s390/kernel/kdebugfs.c | 2 --
>  arch/s390/kernel/sysinfo.c  | 2 --
>  3 files changed, 10 deletions(-)
> diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
> index 12f80d1f0415..2ac3c9b56a13 100644
> --- a/arch/s390/kernel/sysinfo.c
> +++ b/arch/s390/kernel/sysinfo.c
> @@ -545,8 +545,6 @@ static __init int stsi_init_debugfs(void)
>  	int lvl, i;
> 
>  	stsi_root = debugfs_create_dir("stsi", arch_debugfs_dir);
> -	if (IS_ERR_OR_NULL(stsi_root))
> -		return 0;

No objections, however will you also change the odd behaviour that
e.g. debugfs_create_file() returns -ENODEV instead of (the expected)
NULL pointer if CONFIG_DEBUGFS is disabled?

I do remember this since it caused at least one crash ;)

19cdd08ba155 ("[S390] qdio: fix broken pointer in case of CONFIG_DEBUG_FS is disabled").
