Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35702 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbgK3KrJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Nov 2020 05:47:09 -0500
Date: Mon, 30 Nov 2020 11:45:32 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 5/7] s390x: sie: Add first SIE test
Message-ID: <20201130114532.6fea10ac.cohuck@redhat.com>
In-Reply-To: <20201127130629.120469-6-frankja@linux.ibm.com>
References: <20201127130629.120469-1-frankja@linux.ibm.com>
        <20201127130629.120469-6-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, linux-s390@vger.kernel.org

On Fri, 27 Nov 2020 08:06:27 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

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

(...)

> +static void sie(struct vm *vm)
> +{
> +	while (vm->sblk->icptcode == 0) {
> +		sie64a(vm->sblk, &vm->save_area);
> +		if (vm->sblk->icptcode == 32)

Can you maybe add #defines for the intercept codes you're checking for?

> +		    handle_validity(vm);
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

Again, some #defines might help here, making clear that 0x8302 means
diag. (The ipb value is clear enough :) Maybe you can also assemble
instr out of pre-made pieces? Or factor out some code to a common
function?

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

(...)
