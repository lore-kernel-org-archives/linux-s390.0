Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731507AbgKIPEQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Nov 2020 10:04:16 -0500
Date: Mon, 9 Nov 2020 16:03:14 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH seccomp 5/8] s390: Enable seccomp architecture tracking
Message-ID: <20201109150314.GA16690@osiris>
References: <cover.1604410035.git.yifeifz2@illinois.edu>
 <0fbe0c14d598e18effad3b648ab4808f9cd95eba.1604410035.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fbe0c14d598e18effad3b648ab4808f9cd95eba.1604410035.git.yifeifz2@illinois.edu>
List-ID: <linux-s390.vger.kernel.org>
To: YiFei Zhu <zhuyifei1999@gmail.com>
Cc: containers@lists.linux-foundation.org, YiFei Zhu <yifeifz2@illinois.edu>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>, Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, David Laight <David.Laight@aculab.com>, Dimitrios Skarlatos <dskarlat@cs.cmu.edu>, Giuseppe Scrivano <gscrivan@redhat.com>, Hubertus Franke <frankeh@us.ibm.com>, Jack Chen <jianyan2@illinois.edu>, Jann Horn <jannh@google.com>, Josep Torrellas <torrella@illinois.edu>, Kees Cook <keescook@chromium.org>, Tianyin Xu <tyxu@illinois.edu>, Tobin Feldman-Fitzthum <tobin@ibm.com>, Tycho Andersen <tycho@tycho.pizza>, Valentin Rothberg <vrothber@redhat.com>, Will Drewry <wad@chromium.org>

On Tue, Nov 03, 2020 at 07:43:01AM -0600, YiFei Zhu wrote:
> From: YiFei Zhu <yifeifz2@illinois.edu>
> 
> To enable seccomp constant action bitmaps, we need to have a static
> mapping to the audit architecture and system call table size. Add these
> for s390.
> 
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
> ---
>  arch/s390/include/asm/seccomp.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/s390/include/asm/seccomp.h b/arch/s390/include/asm/seccomp.h
> index 795bbe0d7ca6..71d46f0ba97b 100644
> --- a/arch/s390/include/asm/seccomp.h
> +++ b/arch/s390/include/asm/seccomp.h
> @@ -16,4 +16,13 @@
>  
>  #include <asm-generic/seccomp.h>
>  
> +#define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_S390X
> +#define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
> +#define SECCOMP_ARCH_NATIVE_NAME	"s390x"
> +#ifdef CONFIG_COMPAT
> +# define SECCOMP_ARCH_COMPAT		AUDIT_ARCH_S390
> +# define SECCOMP_ARCH_COMPAT_NR		NR_syscalls
> +# define SECCOMP_ARCH_COMPAT_NAME	"s390"
> +#endif
> +

Acked-by: Heiko Carstens <hca@linux.ibm.com>
