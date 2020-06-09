Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21630 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728184AbgFIOqa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Jun 2020 10:46:30 -0400
Date: Tue, 9 Jun 2020 16:46:08 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v6] s390: Fix vDSO clock_getres()
Message-ID: <20200609144608.GB4575@osiris>
References: <20200324121027.21665-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324121027.21665-1-vincenzo.frascino@arm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>

Hello Vincenzo,

sorry it took such a long time to answer!

> clock_getres in the vDSO library has to preserve the same behaviour
> of posix_get_hrtimer_res().
> 
> In particular, posix_get_hrtimer_res() does:
>     sec = 0;
>     ns = hrtimer_resolution;
> and hrtimer_resolution depends on the enablement of the high
> resolution timers that can happen either at compile or at run time.
> 
> Fix the s390 vdso implementation of clock_getres keeping a copy of
> hrtimer_resolution in vdso data and using that directly.
> 
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
>  arch/s390/include/asm/vdso.h           |  1 +
>  arch/s390/kernel/asm-offsets.c         |  2 +-
>  arch/s390/kernel/time.c                |  1 +
>  arch/s390/kernel/vdso64/clock_getres.S | 10 +++++-----
>  4 files changed, 8 insertions(+), 6 deletions(-)
...

> diff --git a/arch/s390/kernel/vdso64/clock_getres.S b/arch/s390/kernel/vdso64/clock_getres.S
> index 081435398e0a..022b58c980db 100644
> --- a/arch/s390/kernel/vdso64/clock_getres.S
> +++ b/arch/s390/kernel/vdso64/clock_getres.S
> @@ -17,12 +17,14 @@
>  	.type  __kernel_clock_getres,@function
>  __kernel_clock_getres:
>  	CFI_STARTPROC
> -	larl	%r1,4f
> +	larl	%r1,3f
> +	lg	%r0,0(%r1)
>  	cghi	%r2,__CLOCK_REALTIME_COARSE
>  	je	0f
>  	cghi	%r2,__CLOCK_MONOTONIC_COARSE
>  	je	0f
> -	larl	%r1,3f
> +	larl	%r1,_vdso_data
> +	l	%r0,__VDSO_CLOCK_REALTIME_RES(%r1)

This should be llgf for proper zero extension. The code works anyway,
since the upper lg would clear the high order bits, however this looks
like it works more or less by accident ;)

I changed it and applied your patch. Thanks a lot!
