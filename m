Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729639AbfHTNVs (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 20 Aug 2019 09:21:48 -0400
Subject: Re: [kvm-unit-tests PATCH 3/3] s390x: STSI tests
References: <20190820105550.4991-1-frankja@linux.ibm.com>
 <20190820105550.4991-4-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ef4faf31-e9db-f984-94ec-f3c332823b6f@redhat.com>
Date: Tue, 20 Aug 2019 15:21:43 +0200
MIME-Version: 1.0
In-Reply-To: <20190820105550.4991-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 8/20/19 12:55 PM, Janosch Frank wrote:
> For now let's concentrate on the error conditions.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/Makefile      |   1 +
>  s390x/stsi.c        | 123 ++++++++++++++++++++++++++++++++++++++++++++
>  s390x/unittests.cfg |   5 +-
>  3 files changed, 128 insertions(+), 1 deletion(-)
>  create mode 100644 s390x/stsi.c
> 
> diff --git a/s390x/Makefile b/s390x/Makefile
> index b654c56..311ab77 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -12,6 +12,7 @@ tests += $(TEST_DIR)/vector.elf
>  tests += $(TEST_DIR)/gs.elf
>  tests += $(TEST_DIR)/iep.elf
>  tests += $(TEST_DIR)/diag288.elf
> +tests += $(TEST_DIR)/stsi.elf
>  tests_binary = $(patsubst %.elf,%.bin,$(tests))
>  
>  all: directories test_cases test_cases_binary
> diff --git a/s390x/stsi.c b/s390x/stsi.c
> new file mode 100644
> index 0000000..005f337
> --- /dev/null
> +++ b/s390x/stsi.c
> @@ -0,0 +1,123 @@
> +/*
> + * Store System Information tests
> + *
> + * Copyright (c) 2019 IBM Corp
> + *
> + * Authors:
> + *  Janosch Frank <frankja@linux.ibm.com>
> + *
> + * This code is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU Library General Public License version 2.
> + */
> +
> +#include <libcflat.h>
> +#include <asm/page.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/interrupt.h>
> +
> +static uint8_t pagebuf[PAGE_SIZE * 2] __attribute__((aligned(PAGE_SIZE * 2)));
> +
> +static inline unsigned long stsi(unsigned long *addr,
> +				 unsigned long fc, uint8_t sel1, uint8_t sel2)

Return code should be "int", not "long".

I'd also suggest to use "void *addr" instead of "unsigned long *addr",
then you don't have to cast the pagebuf when you're calling this function.

> +{
> +	register unsigned long r0 asm("0") = (fc << 28) | sel1;
> +	register unsigned long r1 asm("1") = sel2;
> +	int cc;
> +
> +	asm volatile("stsi	0(%3)\n"
> +		     "ipm	 %[cc]\n"
> +		     "srl	 %[cc],28\n"
> +		     : "+d" (r0), [cc] "=d" (cc)
> +		     : "d" (r1), "a" (addr)
> +		     : "cc", "memory");
> +	return cc;
> +}

Bonus points for putting that function into a header and re-use it in
skey.c (maybe in a separate patch, though).

> +static inline void stsi_zero_r0(unsigned long *addr,
> +				unsigned long fc, uint8_t sel1, uint8_t sel2)
> +{
> +	register unsigned long r0 asm("0") = (fc << 28) | (1 << 8) | sel1;
> +	register unsigned long r1 asm("1") = sel2;
> +
> +

Please remove one empty line.

> +	asm volatile("stsi	0(%2)"
> +		     : "+d" (r0)
> +		     : "d" (r1), "a" (addr)
> +		     : "cc", "memory");
> +}
> +
> +static inline void stsi_zero_r1(unsigned long *addr,
> +				unsigned long fc, uint8_t sel1, uint8_t sel2)
> +{
> +	register unsigned long r0 asm("0") = (fc << 28) | sel1;
> +	register unsigned long r1 asm("1") = (1 << 16) | sel2;
> +
> +

dito

> +	asm volatile("stsi	0(%2)"
> +		     : "+d" (r0)
> +		     : "d" (r1), "a" (addr)
> +		     : "cc", "memory");
> +}

Also not sure whether you need separate functions for these tests ...
you could also change the type of sel1 and sel2  from "uint8_t" to "int"
in the stsi() function and then pass the invalid types to that function
instead?

> +static inline unsigned long stsi_get_fc(unsigned long *addr)
> +{
> +	register unsigned long r0 asm("0") = 0;
> +	register unsigned long r1 asm("1") = 0;
> +
> +

Superfluous empty line again.

> +	asm volatile("stsi	0(%2)"
> +		     : "+d" (r0)
> +		     : "d" (r1), "a" (addr)
> +		     : "cc", "memory");

Maybe assert that the CC is 0 after the call?

> +	return r0 >> 28;
> +}
> +
> +static void test_specs(void)
> +{
> +	report_prefix_push("spec ex");

s/spec ex/specification/ please

> +	report_prefix_push("inv r0");
> +	expect_pgm_int();
> +	stsi_zero_r0((void *)pagebuf, 1, 0, 0);
> +	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
> +	report_prefix_pop();
> +
> +	report_prefix_push("inv r1");
> +	expect_pgm_int();
> +	stsi_zero_r1((void *)pagebuf, 1, 0, 0);
> +	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
> +	report_prefix_pop();
> +
> +	report_prefix_push("unaligned");
> +	expect_pgm_int();
> +	stsi((void *)pagebuf + 42, 1, 0, 0);
> +	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
> +	report_prefix_pop();
> +
> +	report_prefix_pop();
> +}
> +
> +static void test_priv(void)
> +{
> +	report_prefix_push("privileged");
> +	expect_pgm_int();
> +	enter_pstate();
> +	stsi((void *)pagebuf, 0, 0, 0);
> +	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
> +	report_prefix_pop();
> +}
> +
> +static void test_fc(void)
> +{
> +	report("cc == 3", stsi((void *)pagebuf, 7, 0, 0));

Shouldn't that line look like this instead:

    	report("cc == 3", stsi((void *)pagebuf, 7, 0, 0) == 3);

?

> +	report("r0 == 3", stsi_get_fc((void *)pagebuf));

    report("r0 >= 3", stsi_get_fc((void *)pagebuf) >= 3);

?

> +}
> +
> +int main(void)
> +{
> +	report_prefix_push("stsi");
> +	test_priv();
> +	test_specs();
> +	test_fc();
> +	return report_summary();
> +}

How about adding another test for access exceptions? Activate low
address protection, then store to address 4096 ... and/or check
"stsi((void *)-0xdeadadd, 1, 0, 0);" ?

 Thomas
