Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390545AbfHWKbB (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Aug 2019 06:31:01 -0400
Subject: Re: [kvm-unit-tests PATCH v2 2/4] s390x: Diag288 test
References: <20190821104736.1470-1-frankja@linux.ibm.com>
 <20190821104736.1470-3-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ac96277b-f2ae-3855-639e-9a4e7273aaba@redhat.com>
Date: Fri, 23 Aug 2019 12:30:58 +0200
MIME-Version: 1.0
In-Reply-To: <20190821104736.1470-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 8/21/19 12:47 PM, Janosch Frank wrote:
> A small test for the watchdog via diag288.
> 
> Minimum timer value is 15 (seconds) and the only supported action with
> QEMU is restart.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm/arch_def.h |   1 +
>  s390x/Makefile           |   1 +
>  s390x/diag288.c          | 131 +++++++++++++++++++++++++++++++++++++++
>  s390x/unittests.cfg      |   4 ++
>  4 files changed, 137 insertions(+)
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
> index 0000000..c129b6a
> --- /dev/null
> +++ b/s390x/diag288.c
[...]
> +static void test_specs(void)
> +{
> +	report_prefix_push("specification");
> +
> +	report_prefix_push("uneven");
> +	expect_pgm_int();
> +	asm volatile("diag %r1,%r2,0x288");

Don't you have to use "%%" in that case? ... well, if it also works
without, I don't mind, but in case you respin better play safe:

    asm volatile("diag %%r1,%%r2,0x288");

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
> +{
> +	char clk[16];
> +
> +	get_tod_clock_ext(clk);
> +	return *((unsigned long long *)&clk[1]);

You could use uint64_t instead of "unsigned long long".

> +}
> +
> +static void test_bite(void)
> +{
> +	unsigned long time;
> +	uint64_t mask;
> +
> +	/* If watchdog doesn't bite, the cpu timer does */
> +	time = get_tod_clock();
> +	time += (uint64_t)(16000 * 1000) << 12;
> +	asm volatile("sckc %0" : : "Q" (time));
> +	ctl_set_bit(0, 11);
> +	mask = extract_psw_mask();
> +	mask |= PSW_MASK_EXT;
> +	load_psw_mask(mask);
> +
> +	/* Arm watchdog */
> +	lc->restart_new_psw.mask = extract_psw_mask() & ~PSW_MASK_EXT;
> +	diag288(CODE_INIT, 15, ACTION_RESTART);
> +	asm volatile("		larl	%r0, 1f\n"
> +		     "		stg	%r0, 424\n"
> +		     "0:	nop\n"
> +		     "		j	0b\n"
> +		     "1:");
> +	report("restart", true);
> +	return;

Superfluous return statement.

> +}
> +
> +int main(void)
> +{
> +	report_prefix_push("diag288");
> +	test_priv();
> +	test_specs();
> +	test_bite();
> +	return report_summary();
> +}
> diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
> index db58bad..9dd288a 100644
> --- a/s390x/unittests.cfg
> +++ b/s390x/unittests.cfg
> @@ -64,3 +64,7 @@ file = iep.elf
>  
>  [cpumodel]
>  file = cpumodel.elf
> +
> +[diag288]
> +file = diag288.elf
> +extra_params=-device diag288,id=watchdog0 --watchdog-action inject-nmi
> 

Apart from the cosmetic nits, looks fine to me.

Reviewed-by: Thomas Huth <thuth@redhat.com>
