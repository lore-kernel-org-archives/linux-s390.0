Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:14780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731146AbfIJMTT (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Sep 2019 08:19:19 -0400
Subject: Re: [kvm-unit-tests PATCH v2 4/6] s390x: Add initial smp code
References: <20190905103951.36522-1-frankja@linux.ibm.com>
 <20190905103951.36522-5-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c502505d-09ab-b91e-8596-1290f48b9c1b@redhat.com>
Date: Tue, 10 Sep 2019 14:19:11 +0200
MIME-Version: 1.0
In-Reply-To: <20190905103951.36522-5-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 05/09/2019 12.39, Janosch Frank wrote:
> Let's add a rudimentary SMP library, which will scan for cpus and has
> helper functions that manage the cpu state.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm/arch_def.h |   8 ++
>  lib/s390x/asm/sigp.h     |  28 +++-
>  lib/s390x/io.c           |   5 +-
>  lib/s390x/sclp.h         |   1 +
>  lib/s390x/smp.c          | 276 +++++++++++++++++++++++++++++++++++++++
>  lib/s390x/smp.h          |  51 ++++++++
>  s390x/Makefile           |   1 +
>  s390x/cstart64.S         |   7 +
>  8 files changed, 371 insertions(+), 6 deletions(-)
>  create mode 100644 lib/s390x/smp.c
>  create mode 100644 lib/s390x/smp.h
> 
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 5f8f45e..d5a7f51 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -157,6 +157,14 @@ struct cpuid {
>  	uint64_t reserved : 15;
>  };
>  
> +static inline unsigned short stap(void)
> +{
> +	unsigned short cpu_address;
> +
> +	asm volatile("stap %0" : "=Q" (cpu_address));
> +	return cpu_address;
> +}
> +
>  static inline int tprot(unsigned long addr)
>  {
>  	int cc;
> diff --git a/lib/s390x/asm/sigp.h b/lib/s390x/asm/sigp.h
> index fbd94fc..2d52313 100644
> --- a/lib/s390x/asm/sigp.h
> +++ b/lib/s390x/asm/sigp.h
> @@ -46,14 +46,32 @@
>  
>  #ifndef __ASSEMBLER__
>  
> -static inline void sigp_stop(void)
> +
> +static inline int sigp(uint16_t addr, uint8_t order, unsigned long parm,
> +		       uint32_t *status)
>  {
> -	register unsigned long status asm ("1") = 0;
> -	register unsigned long cpu asm ("2") = 0;
> +	register unsigned long reg1 asm ("1") = parm;
> +	int cc;
>  
>  	asm volatile(
> -		"	sigp %0,%1,0(%2)\n"
> -		: "+d" (status)  : "d" (cpu), "d" (SIGP_STOP) : "cc");
> +		"	sigp	%1,%2,0(%3)\n"
> +		"	ipm	%0\n"
> +		"	srl	%0,28\n"
> +		: "=d" (cc), "+d" (reg1) : "d" (addr), "a" (order) : "cc");
> +	if (status)
> +		*status = reg1;
> +	return cc;
> +}
> +
> +static inline int sigp_retry(uint16_t addr, uint8_t order, unsigned long parm,
> +			     uint32_t *status)
> +{
> +	int cc;
> +
> +	do {
> +		cc = sigp(addr, order, parm, status);
> +	} while (cc == 2);
> +	return cc;
>  }
>  
>  #endif /* __ASSEMBLER__ */
> diff --git a/lib/s390x/io.c b/lib/s390x/io.c
> index becadfc..32f09b5 100644
> --- a/lib/s390x/io.c
> +++ b/lib/s390x/io.c
> @@ -16,6 +16,7 @@
>  #include <asm/facility.h>
>  #include <asm/sigp.h>
>  #include "sclp.h"
> +#include "smp.h"
>  
>  extern char ipl_args[];
>  uint8_t stfl_bytes[NR_STFL_BYTES] __attribute__((aligned(8)));
> @@ -37,12 +38,14 @@ void setup(void)
>  	setup_facilities();
>  	sclp_console_setup();
>  	sclp_memory_setup();
> +	smp_setup();
>  }
>  
>  void exit(int code)
>  {
> +	smp_teardown();
>  	printf("\nEXIT: STATUS=%d\n", ((code) << 1) | 1);
>  	while (1) {
> -		sigp_stop();
> +		sigp(0, SIGP_STOP, 0, NULL);
>  	}
>  }
> diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
> index 98c482a..4e69845 100644
> --- a/lib/s390x/sclp.h
> +++ b/lib/s390x/sclp.h
> @@ -19,6 +19,7 @@
>  #define SCLP_CMD_CODE_MASK                      0xffff00ff
>  
>  /* SCLP command codes */
> +#define SCLP_READ_CPU_INFO			0x00010001
>  #define SCLP_CMDW_READ_SCP_INFO                 0x00020001
>  #define SCLP_CMDW_READ_SCP_INFO_FORCED          0x00120001
>  #define SCLP_READ_STORAGE_ELEMENT_INFO          0x00040001
> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
> new file mode 100644
> index 0000000..40c43ef
> --- /dev/null
> +++ b/lib/s390x/smp.c
> @@ -0,0 +1,276 @@
> +/*
> + * s390x smp
> + * Based on Linux's arch/s390/kernel/smp.c and
> + * arch/s390/include/asm/sigp.h
> + *
> + * Copyright (c) 2019 IBM Corp
> + *
> + * Authors:
> + *  Janosch Frank <frankja@linux.ibm.com>
> + *
> + * This code is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2.
> + */
> +#include <libcflat.h>
> +#include <errno.h>

This breaks building on Travis:

 https://travis-ci.com/huth/kvm-unit-tests/jobs/232679058

I don't think that you can use the errno.h header from the system
library in kvm-unit-tests in a save way. It's likely better if you
define your own error codes instead.

 Thomas
