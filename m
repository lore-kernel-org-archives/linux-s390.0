Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731490AbfHZROu (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 26 Aug 2019 13:14:50 -0400
Subject: Re: [kvm-unit-tests PATCH v3 2/5] s390x: Diag288 test
References: <20190826163502.1298-1-frankja@linux.ibm.com>
 <20190826163502.1298-3-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4855e0bd-2808-ff44-482e-ecc96c7e69ed@redhat.com>
Date: Mon, 26 Aug 2019 19:14:44 +0200
MIME-Version: 1.0
In-Reply-To: <20190826163502.1298-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 26/08/2019 18.34, Janosch Frank wrote:
> A small test for the watchdog via diag288.
> 
> Minimum timer value is 15 (seconds) and the only supported action with
> QEMU is restart.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  lib/s390x/asm/arch_def.h |   1 +
>  s390x/Makefile           |   1 +
>  s390x/diag288.c          | 130 +++++++++++++++++++++++++++++++++++++++
>  s390x/unittests.cfg      |   4 ++
>  4 files changed, 136 insertions(+)
>  create mode 100644 s390x/diag288.c
> 
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index d2cd727..4bbb428 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -15,6 +15,7 @@ struct psw {
>  	uint64_t	addr;
>  };
>  
> +#define PSW_MASK_EXT			0x0100000000000000UL
>  #define PSW_MASK_DAT			0x0400000000000000UL
>  #define PSW_MASK_PSTATE			0x0001000000000000UL
>  
> diff --git a/s390x/Makefile b/s390x/Makefile
> index 574a9a2..3453373 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -12,6 +12,7 @@ tests += $(TEST_DIR)/vector.elf
>  tests += $(TEST_DIR)/gs.elf
>  tests += $(TEST_DIR)/iep.elf
>  tests += $(TEST_DIR)/cpumodel.elf
> +tests += $(TEST_DIR)/diag288.elf
>  tests_binary = $(patsubst %.elf,%.bin,$(tests))
>  
>  all: directories test_cases test_cases_binary
> diff --git a/s390x/diag288.c b/s390x/diag288.c
> new file mode 100644
> index 0000000..a784338
> --- /dev/null
> +++ b/s390x/diag288.c
> @@ -0,0 +1,130 @@
> +/*
> + * Timer Event DIAG288 test
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
> +#include <asm/asm-offsets.h>
> +#include <asm/interrupt.h>
> +
> +struct lowcore *lc = (struct lowcore *)0x0;
> +
> +#define CODE_INIT	0
> +#define CODE_CHANGE	1
> +#define CODE_CANCEL	2
> +
> +#define ACTION_RESTART	0
> +
> +static inline void diag288(unsigned long code, unsigned long time,
> +			   unsigned long action)
> +{
> +	register unsigned long fc asm("0") = code;
> +	register unsigned long tm asm("1") = time;
> +	register unsigned long ac asm("2") = action;
> +
> +	asm volatile("diag %0,%2,0x288"
> +		     : : "d" (fc), "d" (tm), "d" (ac));
> +}
> +
> +static void test_specs(void)
> +{
> +	report_prefix_push("specification");
> +
> +	report_prefix_push("uneven");
> +	expect_pgm_int();
> +	asm volatile("diag 1,2,0x288");
> +	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
> +	report_prefix_pop();
> +
> +	report_prefix_push("unsupported action");
> +	expect_pgm_int();
> +	diag288(CODE_INIT, 15, 42);
> +	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
> +	report_prefix_pop();
> +
> +	report_prefix_push("unsupported function");
> +	expect_pgm_int();
> +	diag288(42, 15, ACTION_RESTART);
> +	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
> +	report_prefix_pop();
> +
> +	report_prefix_push("no init");
> +	expect_pgm_int();
> +	diag288(CODE_CANCEL, 15, ACTION_RESTART);
> +	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
> +	report_prefix_pop();
> +
> +	report_prefix_push("min timer");
> +	expect_pgm_int();
> +	diag288(CODE_INIT, 14, ACTION_RESTART);
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
> +	diag288(CODE_INIT, 15, ACTION_RESTART);
> +	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
> +	report_prefix_pop();
> +}
> +
> +static inline void get_tod_clock_ext(char *clk)
> +{
> +	typedef struct { char _[16]; } addrtype;
> +
> +	asm volatile("stcke %0" : "=Q" (*(addrtype *) clk) : : "cc");
> +}
> +
> +static inline unsigned long long get_tod_clock(void)

Change the return type to uint64_t, too?

> +{
> +	char clk[16];
> +
> +	get_tod_clock_ext(clk);
> +	return *((uint64_t *)&clk[1]);
> +}

While this code seems to compile fine with recent versions of GCC, the
older version 4.8 complains here:

s390x/diag288.c: In function ‘get_tod_clock’:
s390x/diag288.c:95:2: error: dereferencing type-punned pointer will
break strict-aliasing rules [-Werror=strict-aliasing]
  return *((uint64_t *)&clk[1]);
  ^

Looking at the whole code again, I think it would be best to simply use
"stck" here instead of "stcke", what do you think?

 Thomas
