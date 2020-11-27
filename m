Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29983 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726889AbgK0QXA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Nov 2020 11:23:00 -0500
Subject: Re: [kvm-unit-tests PATCH v2 5/7] s390x: sie: Add first SIE test
References: <20201127130629.120469-1-frankja@linux.ibm.com>
 <20201127130629.120469-6-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6490b11c-23e3-5b20-c7e8-ac7fed489ad5@redhat.com>
Date: Fri, 27 Nov 2020 17:22:48 +0100
MIME-Version: 1.0
In-Reply-To: <20201127130629.120469-6-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 27/11/2020 14.06, Janosch Frank wrote:
> Let's check if we get the correct interception data on a few
> diags. This commit is more of an addition of boilerplate code than a
> real test.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/Makefile      |   1 +
>  s390x/sie.c         | 125 ++++++++++++++++++++++++++++++++++++++++++++
>  s390x/unittests.cfg |   3 ++
>  3 files changed, 129 insertions(+)
>  create mode 100644 s390x/sie.c
> 
> diff --git a/s390x/Makefile b/s390x/Makefile
> index b079a26..7a95092 100644
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
> index 0000000..41b429a
> --- /dev/null
> +++ b/s390x/sie.c
> @@ -0,0 +1,125 @@
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
> +		if (vm->sblk->icptcode == 32)
> +		    handle_validity(vm);

Indent with TABs, not spaces, please.

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
> +static void intercept_diag_10(void)
> +{
> +	u32 instr = 0x83020010;
> +
> +	vm.sblk->gpsw.addr = PAGE_SIZE * 2;
> +	vm.sblk->gpsw.mask = 0x0000000180000000ULL;
> +
> +	memset(guest_instr, 0, PAGE_SIZE);
> +	memcpy(guest_instr, &instr, 4);
> +	sie(&vm);
> +	report(vm.sblk->icptcode == 4 && vm.sblk->ipa == 0x8302 && vm.sblk->ipb == 0x100000,
> +	       "Diag 10 intercept");
> +	sblk_cleanup(&vm);
> +}
> +
> +static void intercept_diag_44(void)
> +{
> +	u32 instr = 0x83020044;
> +
> +	vm.sblk->gpsw.addr = PAGE_SIZE * 2;
> +	vm.sblk->gpsw.mask = 0x0000000180000000ULL;
> +
> +	memset(guest_instr, 0, PAGE_SIZE);
> +	memcpy(guest_instr, &instr, 4);
> +	sie(&vm);
> +	report(vm.sblk->icptcode == 4 && vm.sblk->ipa == 0x8302 && vm.sblk->ipb == 0x440000,
> +	       "Diag 44 intercept");
> +	sblk_cleanup(&vm);
> +}
> +
> +static void intercept_diag_9c(void)
> +{
> +	u32 instr = 0x8302009c;
> +
> +	vm.sblk->gpsw.addr = PAGE_SIZE * 2;
> +	vm.sblk->gpsw.mask = 0x0000000180000000ULL;
> +
> +	memset(guest_instr, 0, PAGE_SIZE);
> +	memcpy(guest_instr, &instr, 4);
> +	sie(&vm);
> +	report(vm.sblk->icptcode == 4 && vm.sblk->ipa == 0x8302 && vm.sblk->ipb == 0x9c0000,
> +	       "Diag 9c intercept");
> +	sblk_cleanup(&vm);
> +}

All three functions are pretty much the same code, except for the diag
number. I think you could use a unified function for this and then just call
it three times with the wanted diagnose code? Or do you plan to extend these
functions later in different ways?

 Thomas
