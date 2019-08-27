Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727683AbfH0R6t (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 27 Aug 2019 13:58:49 -0400
Subject: Re: [kvm-unit-tests PATCH 3/3] s390x: Add storage key removal
 facility
References: <20190827134936.1705-1-frankja@linux.ibm.com>
 <20190827134936.1705-4-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ea6d114c-9025-2e15-89b8-52b938efc129@redhat.com>
Date: Tue, 27 Aug 2019 19:58:40 +0200
MIME-Version: 1.0
In-Reply-To: <20190827134936.1705-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 27/08/2019 15.49, Janosch Frank wrote:
> The storage key removal facility (stfle bit 169) makes all key related
> instructions result in a special operation exception if they handle a
> key.
> 
> Let's make sure that the skey and pfmf tests only run non key code
> (pfmf) or not at all (skey).
> 
> Also let's test this new facility. As lots of instructions are
> affected by this, only some of them are tested for now.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/Makefile |   1 +
>  s390x/pfmf.c   |  10 ++++
>  s390x/skey.c   |   5 ++
>  s390x/skrf.c   | 130 +++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 146 insertions(+)
>  create mode 100644 s390x/skrf.c
> 
> diff --git a/s390x/Makefile b/s390x/Makefile
> index 76db0bb..007611e 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -14,6 +14,7 @@ tests += $(TEST_DIR)/iep.elf
>  tests += $(TEST_DIR)/cpumodel.elf
>  tests += $(TEST_DIR)/diag288.elf
>  tests += $(TEST_DIR)/stsi.elf
> +tests += $(TEST_DIR)/skrf.elf
>  tests_binary = $(patsubst %.elf,%.bin,$(tests))
>  
>  all: directories test_cases test_cases_binary
> diff --git a/s390x/pfmf.c b/s390x/pfmf.c
> index 2840cf5..78b4a73 100644
> --- a/s390x/pfmf.c
> +++ b/s390x/pfmf.c
> @@ -34,6 +34,10 @@ static void test_4k_key(void)
>  	union skey skey;
>  
>  	report_prefix_push("4K");
> +	if (test_facility(169)) {
> +		report_skip("storage key removal facility is active");
> +		goto out;
> +	}
>  	r1.val = 0;
>  	r1.reg.sk = 1;
>  	r1.reg.fsc = PFMF_FSC_4K;
> @@ -42,6 +46,7 @@ static void test_4k_key(void)
>  	skey.val = get_storage_key(pagebuf);
>  	skey.val &= SKEY_ACC | SKEY_FP;
>  	report("set storage keys", skey.val == 0x30);
> +out:
>  	report_prefix_pop();
>  }
>  
> @@ -54,6 +59,10 @@ static void test_1m_key(void)
>  	void *addr = pagebuf;
>  
>  	report_prefix_push("1M");
> +	if (test_facility(169)) {
> +		report_skip("storage key removal facility is active");
> +		goto out;
> +	}
>  	r1.val = 0;
>  	r1.reg.sk = 1;
>  	r1.reg.fsc = PFMF_FSC_1M;
> @@ -70,6 +79,7 @@ static void test_1m_key(void)
>  		}
>  	}
>  	report("set storage keys", rp);
> +out:
>  	report_prefix_pop();
>  }
>  
> diff --git a/s390x/skey.c b/s390x/skey.c
> index efc4eca..5020e99 100644
> --- a/s390x/skey.c
> +++ b/s390x/skey.c
> @@ -126,10 +126,15 @@ static void test_priv(void)
>  int main(void)
>  {
>  	report_prefix_push("skey");
> +	if (test_facility(169)) {
> +		report_skip("storage key removal facility is active");
> +		goto done;
> +	}
>  	test_priv();
>  	test_set();
>  	test_set_mb();
>  	test_chg();
> +done:
>  	report_prefix_pop();
>  	return report_summary();
>  }
> diff --git a/s390x/skrf.c b/s390x/skrf.c
> new file mode 100644
> index 0000000..8e5baea
> --- /dev/null
> +++ b/s390x/skrf.c
> @@ -0,0 +1,130 @@
> +/*
> + * Storage key removal facility tests
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
> +#include <asm/asm-offsets.h>
> +#include <asm/interrupt.h>
> +#include <asm/page.h>
> +#include <asm/facility.h>
> +#include <asm/mem.h>
> +
> +static uint8_t pagebuf[PAGE_SIZE * 2] __attribute__((aligned(PAGE_SIZE * 2)));
> +
> +static void test_facilities(void)
> +{
> +	report_prefix_push("facilities");
> +	report("!10", !test_facility(10));
> +	report("!14", !test_facility(14));
> +	report("!66", !test_facility(66));
> +	report("!145", !test_facility(145));
> +	report("!149", !test_facility(140));
> +	report_prefix_pop();
> +}
> +
> +static void test_skey(void)
> +{
> +	report_prefix_push("(i|s)ske");
> +	expect_pgm_int();
> +	set_storage_key(pagebuf, 0x30, 0);
> +	check_pgm_int_code(PGM_INT_CODE_SPECIAL_OPERATION);
> +	expect_pgm_int();
> +	get_storage_key(pagebuf);
> +	check_pgm_int_code(PGM_INT_CODE_SPECIAL_OPERATION);
> +	report_prefix_pop();

Wouldn't it be better to have distinct prefixes for the two tests?

> +}
> +
> +static void test_pfmf(void)
> +{
> +	union pfmf_r1 r1;
> +
> +	report_prefix_push("pfmf");
> +	r1.val = 0;
> +	r1.reg.sk = 1;
> +	r1.reg.fsc = PFMF_FSC_4K;
> +	r1.reg.key = 0x30;
> +	expect_pgm_int();
> +	pfmf(r1.val, pagebuf);
> +	check_pgm_int_code(PGM_INT_CODE_SPECIAL_OPERATION);
> +	report_prefix_pop();
> +}
> +
> +static void test_psw_key(void)
> +{
> +	uint64_t psw_mask = extract_psw_mask() | 0xF0000000000000UL;
> +
> +	report_prefix_push("psw key");
> +	expect_pgm_int();
> +	load_psw_mask(psw_mask);
> +	check_pgm_int_code(PGM_INT_CODE_SPECIAL_OPERATION);
> +	report_prefix_pop();
> +}
> +
> +static void test_mvcos(void)
> +{
> +	uint64_t r3 = 64;
> +	uint8_t *src = pagebuf;
> +	uint8_t *dst = pagebuf + PAGE_SIZE;
> +	/* K bit set, as well as keys */
> +	register unsigned long oac asm("0") = 0xf002f002;
> +
> +	report_prefix_push("mvcos");
> +	expect_pgm_int();
> +	asm volatile(".machine \"z10\"\n"
> +		     ".machine \"push\"\n"

Shouldn't that be the other way round? first push the current one, then
set the new one?

Anyway, I've now also checked this patch in the CI:

diff a/s390x/Makefile b/s390x/Makefile
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -25,7 +25,7 @@ CFLAGS += -std=gnu99
 CFLAGS += -ffreestanding
 CFLAGS += -I $(SRCDIR)/lib -I $(SRCDIR)/lib/s390x -I lib
 CFLAGS += -O2
-CFLAGS += -march=z900
+CFLAGS += -march=z10
 CFLAGS += -fno-delete-null-pointer-checks
 LDFLAGS += -nostdlib -Wl,--build-id=none

... and it also seems to work fine with the TCG there:

https://gitlab.com/huth/kvm-unit-tests/-/jobs/281450598

So I think you can simply change it in the Makefile instead.

 Thomas

> +		     "mvcos	%[dst],%[src],%[len]\n"
> +		     ".machine \"pop\"\n"
> +		     : [dst] "+Q" (*(dst))
> +		     : [src] "Q" (*(src)), [len] "d" (r3), "d" (oac)
> +		     : "cc", "memory");
> +	check_pgm_int_code(PGM_INT_CODE_SPECIAL_OPERATION);
> +	report_prefix_pop();
> +}
