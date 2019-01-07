From: David Hildenbrand <david@redhat.com>
Date: Mon, 07 Jan 2019 11:36:20 +0000
Subject: Re: [kvm-unit-tests PATCH v4 01/13] s390x: Add Sigp header file
Message-Id: <30eeeee9-f465-e425-fe38-e82e83f93694@redhat.com>
In-Reply-To: <c1a91446-f20c-9e05-2098-c73ff80d35eb@redhat.com>
References: <c1a91446-f20c-9e05-2098-c73ff80d35eb@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 03.01.19 11:07, Janosch Frank wrote:
> The magic numbers for SIGP are not nice to read, so let's put them in
> a new header file. Also move sigp_stop() there, it will later be
> joined by more sigp functions and definitions.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm/sigp.h | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  lib/s390x/io.c       | 11 +---------
>  2 files changed, 61 insertions(+), 10 deletions(-)
>  create mode 100644 lib/s390x/asm/sigp.h
> 
> diff --git a/lib/s390x/asm/sigp.h b/lib/s390x/asm/sigp.h
> new file mode 100644
> index 0000000..899a66b
> --- /dev/null
> +++ b/lib/s390x/asm/sigp.h
> @@ -0,0 +1,60 @@
> +/*
> + * SIGP related definitions.
> + *
> + * Copied from the Linux kernel file arch/s390/include/asm/sigp.h
> + *
> + * This work is licensed under the terms of the GNU GPL, version
> + * 2. See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef _ASM_S390X_SIGP_H_
> +#define _ASM_S390X_SIGP_H_
> +
> +/* SIGP order codes */
> +#define SIGP_SENSE			1
> +#define SIGP_EXTERNAL_CALL		2
> +#define SIGP_EMERGENCY_SIGNAL		3
> +#define SIGP_START			4
> +#define SIGP_STOP			5
> +#define SIGP_RESTART			6
> +#define SIGP_STOP_AND_STORE_STATUS	9
> +#define SIGP_INITIAL_CPU_RESET		11
> +#define SIGP_CPU_RESET			12
> +#define SIGP_SET_PREFIX			13
> +#define SIGP_STORE_STATUS_AT_ADDRESS	14
> +#define SIGP_SET_ARCHITECTURE		18
> +#define SIGP_COND_EMERGENCY_SIGNAL	19
> +#define SIGP_SENSE_RUNNING		21
> +#define SIGP_SET_MULTI_THREADING	22
> +#define SIGP_STORE_ADDITIONAL_STATUS	23
> +
> +/* SIGP condition codes */
> +#define SIGP_CC_ORDER_CODE_ACCEPTED 0
> +#define SIGP_CC_STATUS_STORED	    1
> +#define SIGP_CC_BUSY		    2
> +#define SIGP_CC_NOT_OPERATIONAL	    3
> +
> +/* SIGP cpu status bits */
> +
> +#define SIGP_STATUS_INVALID_ORDER	0x00000002UL
> +#define SIGP_STATUS_CHECK_STOP		0x00000010UL
> +#define SIGP_STATUS_STOPPED		0x00000040UL
> +#define SIGP_STATUS_EXT_CALL_PENDING	0x00000080UL
> +#define SIGP_STATUS_INVALID_PARAMETER	0x00000100UL
> +#define SIGP_STATUS_INCORRECT_STATE	0x00000200UL
> +#define SIGP_STATUS_NOT_RUNNING		0x00000400UL
> +
> +#ifndef __ASSEMBLER__
> +
> +static inline void sigp_stop(void)
> +{
> +	register unsigned long status asm ("1") = 0;
> +	register unsigned long cpu asm ("2") = 0;
> +
> +	asm volatile(
> +		"	sigp %0,%1,0(%2)\n"
> +		: "+d" (status)  : "d" (cpu), "d" (SIGP_STOP) : "cc");
> +}
> +
> +#endif /* __ASSEMBLER__ */
> +#endif /* _ASM_S390X_SIGP_H_ */
> diff --git a/lib/s390x/io.c b/lib/s390x/io.c
> index 7bca637..fd33623 100644
> --- a/lib/s390x/io.c
> +++ b/lib/s390x/io.c
> @@ -14,6 +14,7 @@
>  #include <argv.h>
>  #include <asm/spinlock.h>
>  #include <asm/facility.h>
> +#include <asm/sigp.h>
>  #include "sclp.h"
>  
>  extern char ipl_args[];
> @@ -30,16 +31,6 @@ void puts(const char *s)
>  	spin_unlock(&lock);
>  }
>  
> -static void sigp_stop(void)
> -{
> -	register unsigned long status asm ("1") = 0;
> -	register unsigned long cpu asm ("2") = 0;
> -
> -	asm volatile(
> -		"	sigp %0,%1,0(%2)\n"
> -		: "+d" (status)  : "d" (cpu), "d" (5) : "cc");
> -}
> -
>  void setup(void)
>  {
>  	setup_args_progname(ipl_args);
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
