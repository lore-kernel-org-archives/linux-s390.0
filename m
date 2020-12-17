Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725871AbgLQPB6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Dec 2020 10:01:58 -0500
Date: Thu, 17 Dec 2020 15:48:15 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v3 6/8] s390x: sie: Add first SIE test
Message-ID: <20201217154815.2b961dc9@ibm-vm>
In-Reply-To: <20201211100039.63597-7-frankja@linux.ibm.com>
References: <20201211100039.63597-1-frankja@linux.ibm.com>
        <20201211100039.63597-7-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On Fri, 11 Dec 2020 05:00:37 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Let's check if we get the correct interception data on a few
> diags. This commit is more of an addition of boilerplate code than a
> real test.

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/Makefile      |   1 +
>  s390x/sie.c         | 113
> ++++++++++++++++++++++++++++++++++++++++++++ s390x/unittests.cfg |
> 3 ++ 3 files changed, 117 insertions(+)
>  create mode 100644 s390x/sie.c
> 
> diff --git a/s390x/Makefile b/s390x/Makefile
> index fb62e87..8e1b4e9 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -19,6 +19,7 @@ tests += $(TEST_DIR)/smp.elf
>  tests += $(TEST_DIR)/sclp.elf
>  tests += $(TEST_DIR)/css.elf
>  tests += $(TEST_DIR)/uv-guest.elf
> +tests += $(TEST_DIR)/sie.elf
>  
>  tests_binary = $(patsubst %.elf,%.bin,$(tests))
>  ifneq ($(HOST_KEY_DOCUMENT),)
> diff --git a/s390x/sie.c b/s390x/sie.c
> new file mode 100644
> index 0000000..cfc746f
> --- /dev/null
> +++ b/s390x/sie.c
> @@ -0,0 +1,113 @@
> +#include <libcflat.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/arch_def.h>
> +#include <asm/interrupt.h>
> +#include <asm/page.h>
> +#include <alloc_page.h>
> +#include <vmalloc.h>
> +#include <asm/facility.h>
> +#include <mmu.h>
> +#include <sclp.h>
> +#include <sie.h>
> +
> +static u8 *guest;
> +static u8 *guest_instr;
> +static struct vm vm;
> +
> +static void handle_validity(struct vm *vm)
> +{
> +	report(0, "VALIDITY: %x", vm->sblk->ipb >> 16);
> +}
> +
> +static void sie(struct vm *vm)
> +{
> +	while (vm->sblk->icptcode == 0) {
> +		sie64a(vm->sblk, &vm->save_area);
> +		if (vm->sblk->icptcode == ICPT_VALIDITY)
> +			handle_validity(vm);
> +	}
> +	vm->save_area.guest.grs[14] = vm->sblk->gg14;
> +	vm->save_area.guest.grs[15] = vm->sblk->gg15;
> +}
> +
> +static void sblk_cleanup(struct vm *vm)
> +{
> +	vm->sblk->icptcode = 0;
> +}
> +
> +static void test_diag(u32 instr)
> +{
> +	vm.sblk->gpsw.addr = PAGE_SIZE * 2;
> +	vm.sblk->gpsw.mask = 0x0000000180000000ULL;
> +
> +	memset(guest_instr, 0, PAGE_SIZE);
> +	memcpy(guest_instr, &instr, 4);
> +	sie(&vm);
> +	report(vm.sblk->icptcode == ICPT_INST &&
> +	       vm.sblk->ipa == instr >> 16 && vm.sblk->ipb == instr
> << 16,
> +	       "Intercept data");
> +	sblk_cleanup(&vm);
> +}
> +
> +static struct {
> +	const char *name;
> +	u32 instr;
> +} tests[] = {
> +	{ "10", 0x83020010 },
> +	{ "44", 0x83020044 },
> +	{ "9c", 0x8302009c },
> +	{ NULL, 0 }
> +};
> +
> +static void test_diags(void)
> +{
> +	int i;
> +
> +	for (i = 0; tests[i].name; i++) {
> +		report_prefix_push(tests[i].name);
> +		test_diag(tests[i].instr);
> +		report_prefix_pop();
> +	}
> +}
> +
> +static void setup_guest(void)
> +{
> +	setup_vm();
> +
> +	/* Allocate 1MB as guest memory */
> +	guest = alloc_pages(8);
> +	/* The first two pages are the lowcore */
> +	guest_instr = guest + PAGE_SIZE * 2;
> +
> +	vm.sblk = alloc_page();
> +
> +	vm.sblk->cpuflags = CPUSTAT_ZARCH | CPUSTAT_RUNNING;
> +	vm.sblk->prefix = 0;
> +	/*
> +	 * Pageable guest with the same ASCE as the test programm,
> but
> +	 * the guest memory 0x0 is offset to start at the allocated
> +	 * guest pages and end after 1MB.
> +	 *
> +	 * It's not pretty but faster and easier than managing guest
> ASCEs.
> +	 */
> +	vm.sblk->mso = (u64)guest;
> +	vm.sblk->msl = (u64)guest;
> +	vm.sblk->ihcpu = 0xffff;
> +
> +	vm.sblk->crycbd = (uint64_t)alloc_page();
> +}
> +
> +int main(void)
> +{
> +	report_prefix_push("sie");
> +	if (!sclp_facilities.has_sief2) {
> +		report_skip("SIEF2 facility unavailable");
> +		goto done;
> +	}
> +
> +	setup_guest();
> +	test_diags();
> +done:
> +	report_prefix_pop();
> +	return report_summary();
> +}
> diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
> index 3feb8bc..2298be6 100644
> --- a/s390x/unittests.cfg
> +++ b/s390x/unittests.cfg
> @@ -96,3 +96,6 @@ smp = 2
>  
>  [uv-guest]
>  file = uv-guest.elf
> +
> +[sie]
> +file = sie.elf
