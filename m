Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727521AbfH3MHs (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 30 Aug 2019 08:07:48 -0400
Subject: Re: [kvm-unit-tests PATCH v3 4/5] s390x: STSI tests
References: <20190826163502.1298-1-frankja@linux.ibm.com>
 <20190826163502.1298-5-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <72cc113e-63a2-d389-d1fb-b0b9e84fc863@redhat.com>
Date: Fri, 30 Aug 2019 14:07:45 +0200
MIME-Version: 1.0
In-Reply-To: <20190826163502.1298-5-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

On 26.08.19 18:35, Janosch Frank wrote:
> For now let's concentrate on the error conditions.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/Makefile      |  1 +
>  s390x/stsi.c        | 84 +++++++++++++++++++++++++++++++++++++++++++++
>  s390x/unittests.cfg |  3 ++
>  3 files changed, 88 insertions(+)
>  create mode 100644 s390x/stsi.c
> 
> diff --git a/s390x/Makefile b/s390x/Makefile
> index 3453373..76db0bb 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -13,6 +13,7 @@ tests += $(TEST_DIR)/gs.elf
>  tests += $(TEST_DIR)/iep.elf
>  tests += $(TEST_DIR)/cpumodel.elf
>  tests += $(TEST_DIR)/diag288.elf
> +tests += $(TEST_DIR)/stsi.elf
>  tests_binary = $(patsubst %.elf,%.bin,$(tests))
>  
>  all: directories test_cases test_cases_binary
> diff --git a/s390x/stsi.c b/s390x/stsi.c
> new file mode 100644
> index 0000000..b8195b2
> --- /dev/null
> +++ b/s390x/stsi.c
> @@ -0,0 +1,84 @@
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
> +static void test_specs(void)
> +{
> +	report_prefix_push("specification");
> +
> +	report_prefix_push("inv r0");
> +	expect_pgm_int();
> +	stsi(pagebuf, 0, 1 << 8, 0);
> +	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
> +	report_prefix_pop();
> +
> +	report_prefix_push("inv r1");
> +	expect_pgm_int();
> +	stsi(pagebuf, 1, 0, 1 << 16);
> +	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
> +	report_prefix_pop();
> +
> +	report_prefix_push("unaligned");
> +	expect_pgm_int();
> +	stsi(pagebuf + 42, 1, 0, 0);
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
> +	stsi(pagebuf, 0, 0, 0);
> +	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
> +	report_prefix_pop();
> +}
> +
> +static inline unsigned long stsi_get_fc(void *addr)
> +{
> +	register unsigned long r0 asm("0") = 0;
> +	register unsigned long r1 asm("1") = 0;
> +	int cc;
> +
> +	asm volatile("stsi	0(%3)\n"
> +		     "ipm	%[cc]\n"
> +		     "srl	%[cc],28\n"
> +		     : "+d" (r0), [cc] "=d" (cc)
> +		     : "d" (r1), "a" (addr)

maybe [addr], so you can avoid the %3 above

> +		     : "cc", "memory");
> +	assert(!cc);
> +	return r0 >> 28;

I think I'd prefer "get_configuration_level()" and move it to an header
- because the fc actually allows more values (0, 15 ...) - however the
level can be used as an fc.


> +}
> +
> +static void test_fc(void)
> +{
> +	report("invalid fc",  stsi(pagebuf, 7, 0, 0) == 3);
> +	report("query fc >= 2",  stsi_get_fc(pagebuf) >= 2);
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
> diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
> index 9dd288a..cc79a4e 100644
> --- a/s390x/unittests.cfg
> +++ b/s390x/unittests.cfg
> @@ -68,3 +68,6 @@ file = cpumodel.elf
>  [diag288]
>  file = diag288.elf
>  extra_params=-device diag288,id=watchdog0 --watchdog-action inject-nmi
> +
> +[stsi]
> +file = stsi.elf
> 

Apart from that

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
