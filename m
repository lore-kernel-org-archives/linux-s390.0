Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392379AbfHWLAD (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Aug 2019 07:00:03 -0400
Subject: Re: [kvm-unit-tests PATCH] s390x: Add diag308 subcode 0 testing
References: <20190821104736.1470-1-frankja@linux.ibm.com>
 <20190822111100.4444-1-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <34c8d077-fc5e-1d62-f946-17d067573c23@redhat.com>
Date: Fri, 23 Aug 2019 13:00:01 +0200
MIME-Version: 1.0
In-Reply-To: <20190822111100.4444-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

On 22.08.19 13:11, Janosch Frank wrote:
> By adding a load reset routine to cstart.S we can also test the clear
> reset done by subcode 0, as we now can restore our registers again.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
> I managed to extract this from another bigger test, so let's add it to the bunch.
> I'd be very happy about assembly review :-)
> ---
>  s390x/cstart64.S | 27 +++++++++++++++++++++++++++
>  s390x/diag308.c  | 31 ++++++++++---------------------
>  2 files changed, 37 insertions(+), 21 deletions(-)
> 
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index dedfe80..47045e1 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -145,6 +145,33 @@ memsetxc:
>  	.endm
>  
>  .section .text
> +/*
> + * load_reset calling convention:
> + * %r2 subcode (0 or 1)
> + */
> +.globl load_reset
> +load_reset:
> +	SAVE_REGS
> +	/* Save the first PSW word to the IPL PSW */
> +	epsw	%r0, %r1
> +	st	%r0, 0
> +	/* Store the address and the bit for 31 bit addressing */
> +	larl    %r0, 0f
> +	oilh    %r0, 0x8000
> +	st      %r0, 0x4
> +	/* Do the reset */
> +	diag    %r0,%r2,0x308
> +	/* Failure path */
> +	xgr	%r2, %r2
> +	br	%r14
> +	/* Success path */
> +	/* We lost cr0 due to the reset */
> +0:	larl	%r1, initial_cr0
> +	lctlg	%c0, %c0, 0(%r1)
> +	RESTORE_REGS
> +	lhi	%r2, 1
> +	br	%r14
> +
>  pgm_int:
>  	SAVE_REGS
>  	brasl	%r14, handle_pgm_int
> diff --git a/s390x/diag308.c b/s390x/diag308.c
> index f085b1a..baf9fd3 100644
> --- a/s390x/diag308.c
> +++ b/s390x/diag308.c
> @@ -21,32 +21,20 @@ static void test_priv(void)
>  	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
>  }
>  
> +
>  /*
> - * Check that diag308 with subcode 1 loads the PSW at address 0, i.e.
> + * Check that diag308 with subcode 0 and 1 loads the PSW at address 0, i.e.
>   * that we can put a pointer into address 4 which then gets executed.
>   */
> +extern int load_reset(u64);
> +static void test_subcode0(void)
> +{
> +	report("load modified clear done", load_reset(0));
> +}
> +
>  static void test_subcode1(void)
>  {
> -	uint64_t saved_psw = *(uint64_t *)0;
> -	long subcode = 1;
> -	long ret, tmp;
> -
> -	asm volatile (
> -		"	epsw	%0,%1\n"
> -		"	st	%0,0\n"
> -		"	larl	%0,0f\n"
> -		"	oilh	%0,0x8000\n"
> -		"	st	%0,4\n"
> -		"	diag	0,%2,0x308\n"
> -		"	lghi	%0,0\n"
> -		"	j	1f\n"
> -		"0:	lghi	%0,1\n"
> -		"1:"
> -		: "=&d"(ret), "=&d"(tmp) : "d"(subcode) : "memory");
> -
> -	*(uint64_t *)0 = saved_psw;
> -
> -	report("load normal reset done", ret == 1);
> +	report("load normal reset done", load_reset(1));
>  }
>  
>  /* Expect a specification exception when using an uneven register */
> @@ -107,6 +95,7 @@ static struct {
>  	void (*func)(void);
>  } tests[] = {
>  	{ "privileged", test_priv },
> +	{ "subcode 0", test_subcode0 },
>  	{ "subcode 1", test_subcode1 },
>  	{ "subcode 5", test_subcode5 },
>  	{ "subcode 6", test_subcode6 },
> 

So, in general I am wondering if we should restore the original IPL_PSW
after we used it - is there any chance we might require the old value
again (I guess we're fine with cpu resets)?

-- 

Thanks,

David / dhildenb
