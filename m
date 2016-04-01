Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 1 Apr 2016 16:02:38 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: fix build failure
Message-ID: <20160401140238.GC3965@osiris>
References: <1459514116-24505-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1459514116-24505-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org, linux-s390@vger.kernel.org, Matt Redfearn <matt.redfearn@imgtec.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Apr 01, 2016 at 01:35:16PM +0100, Sudip Mukherjee wrote:
> s390 defconfig and allmodconfig fails with the error:
> kernel/seccomp.c: In function '__secure_computing_strict':
> kernel/seccomp.c:526:3: error: implicit declaration of function
> 				'get_compat_mode1_syscalls'
> 
> The retrieval of compat syscall numbers were moved into inline function
> defined in asm-generic header but the asm-generic header was not being
> used by s390.
> 
> Fixes: 5adddb612ca1 ("seccomp: Get compat syscalls from asm-generic header")
> Cc: Matt Redfearn <matt.redfearn@imgtec.com>
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
> 
> Tested with s390 defconfig and allmodconfig build.
> Build logs of next-20160401 are at:
> https://travis-ci.org/sudipm-mukherjee/parport/jobs/119983952 (allmodconfig)
> and
> https://travis-ci.org/sudipm-mukherjee/parport/jobs/119983909 (defconfig)
> 
>  arch/s390/include/asm/seccomp.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/s390/include/asm/seccomp.h b/arch/s390/include/asm/seccomp.h
> index 781a9cf..e10f833 100644
> --- a/arch/s390/include/asm/seccomp.h
> +++ b/arch/s390/include/asm/seccomp.h
> @@ -13,4 +13,6 @@
>  #define __NR_seccomp_exit_32	__NR_exit
>  #define __NR_seccomp_sigreturn_32 __NR_sigreturn
> 
> +#include <asm-generic/seccomp.h>
> +
>  #endif	/* _ASM_S390_SECCOMP_H */

Applied with a modified changelog, since it makes sense anyway to include
the generic header file.
