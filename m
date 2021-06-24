Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C435AC49EA5
	for <linux-s390@archiver.kernel.org>; Thu, 24 Jun 2021 16:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9211613C7
	for <linux-s390@archiver.kernel.org>; Thu, 24 Jun 2021 16:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhFXQaH (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 24 Jun 2021 12:30:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51456 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230116AbhFXQaG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Jun 2021 12:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624552066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nTsZTxnUAYpgv+Pn8Bi/9PkBqEiS+w2KemBYyfSrknk=;
        b=fe/HcpI/IliRc84zxFzO58v4Z0089j83pmfyeutBQN9w1uxQpeNJmDLDZ/RGtWNqGeZSdb
        VAixCI5v91SHZlBTRyYTibnq2FEFp+gOzYVcVidteLxmg7bKIRMkXfw781zhEc0F836Mmm
        UamKcpvtntQ4PIx+3IXfWUz1hpbMNJw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-_xX7ilhBNHSNzfhCmduSLA-1; Thu, 24 Jun 2021 12:27:45 -0400
X-MC-Unique: _xX7ilhBNHSNzfhCmduSLA-1
Received: by mail-wr1-f69.google.com with SMTP id h104-20020adf90710000b029010de8455a3aso2385250wrh.12
        for <linux-s390@vger.kernel.org>; Thu, 24 Jun 2021 09:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nTsZTxnUAYpgv+Pn8Bi/9PkBqEiS+w2KemBYyfSrknk=;
        b=SZ6FvKdJCH9RPRboU0dhjDj4jw7kXrmuW9kVyHUn4jrkxRsXRjd2ptuB9TR654FIb7
         o3293MVX6x+zmEvtdIqJ5ZuDJihJvchcrkeZ7SduL5cBuSFDusrsyHwE4IEVjvhBaZ9m
         odwWP3OnpE7uT/1Vw4EKxeRrLv96HJ6u4GXoPNnMqrHzXKrHtd87mnDAY1Q2a6FGrDCs
         OmlJJZDD04pz+hZTc0bFvWT8pV64r/xTVPTPghpZzoUzYhg/wCIzw6n1TE/kSPlqQcRo
         ID2+1szsm/OQNv8Oj+GuPNDyBm6+y3QMCuGmGpgDt7xvJokLZ81M/GJMWlbXgS7W2gg+
         OZ4g==
X-Gm-Message-State: AOAM532dG/MHLesnkKzIwvcpKQXMAK2MajEcKv4SSoBejhQNb1FbS9o6
        NDdh4NzICYFcEmPCVBmlwIkbPKya2Er0E6UlIevwmgu9a/v4Kxal2r7SvQUHrERDoqUIhc8CE0n
        OxtWDVnGVY/7zrRw/QzLhQA==
X-Received: by 2002:a5d:4044:: with SMTP id w4mr5539670wrp.201.1624552064413;
        Thu, 24 Jun 2021 09:27:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1SylGokXaxKc23i9femtDaRq8PSi2vB5a2RrDNHPI11Ezm0BYb/grp3HJDK6J3lIH1KA1GQ==
X-Received: by 2002:a5d:4044:: with SMTP id w4mr5539644wrp.201.1624552064102;
        Thu, 24 Jun 2021 09:27:44 -0700 (PDT)
Received: from thuth.remote.csb (pd9575c8c.dip0.t-ipconnect.de. [217.87.92.140])
        by smtp.gmail.com with ESMTPSA id m7sm3960636wrv.35.2021.06.24.09.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 09:27:43 -0700 (PDT)
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com, seiden@linux.ibm.com
References: <20210624120152.344009-1-frankja@linux.ibm.com>
 <20210624120152.344009-4-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 3/3] s390x: mvpg: Add SIE mvpg test
Message-ID: <725852b8-d24d-9429-b4bc-7c5d6a07ef63@redhat.com>
Date:   Thu, 24 Jun 2021 18:27:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624120152.344009-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 24/06/2021 14.01, Janosch Frank wrote:
> Let's also check the PEI values to make sure our VSIE implementation
> is correct.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   s390x/Makefile                  |   2 +
>   s390x/mvpg-sie.c                | 150 ++++++++++++++++++++++++++++++++
>   s390x/snippets/c/mvpg-snippet.c |  33 +++++++
>   s390x/unittests.cfg             |   3 +
>   4 files changed, 188 insertions(+)
>   create mode 100644 s390x/mvpg-sie.c
>   create mode 100644 s390x/snippets/c/mvpg-snippet.c
> 
> diff --git a/s390x/Makefile b/s390x/Makefile
> index ba32f4c..07af26d 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -23,6 +23,7 @@ tests += $(TEST_DIR)/sie.elf
>   tests += $(TEST_DIR)/mvpg.elf
>   tests += $(TEST_DIR)/uv-host.elf
>   tests += $(TEST_DIR)/edat.elf
> +tests += $(TEST_DIR)/mvpg-sie.elf
>   
>   tests_binary = $(patsubst %.elf,%.bin,$(tests))
>   ifneq ($(HOST_KEY_DOCUMENT),)
> @@ -82,6 +83,7 @@ snippet_asmlib = $(SNIPPET_DIR)/c/cstart.o
>   
>   # perquisites (=guests) for the snippet hosts.
>   # $(TEST_DIR)/<snippet-host>.elf: snippets = $(SNIPPET_DIR)/<c/asm>/<snippet>.gbin
> +$(TEST_DIR)/mvpg-sie.elf: snippets = $(SNIPPET_DIR)/c/mvpg-snippet.gbin
>   
>   $(SNIPPET_DIR)/asm/%.gbin: $(SNIPPET_DIR)/asm/%.o $(FLATLIBS)
>   	$(OBJCOPY) -O binary $(patsubst %.gbin,%.o,$@) $@
> diff --git a/s390x/mvpg-sie.c b/s390x/mvpg-sie.c
> new file mode 100644
> index 0000000..a18c1b0
> --- /dev/null
> +++ b/s390x/mvpg-sie.c
> @@ -0,0 +1,150 @@
> +#include <libcflat.h>
> +#include <asm/asm-offsets.h>
> +#include <asm-generic/barrier.h>
> +#include <asm/interrupt.h>
> +#include <asm/pgtable.h>
> +#include <mmu.h>
> +#include <asm/page.h>
> +#include <asm/facility.h>
> +#include <asm/mem.h>
> +#include <asm/sigp.h>
> +#include <smp.h>
> +#include <alloc_page.h>
> +#include <bitops.h>
> +#include <vm.h>
> +#include <sclp.h>
> +#include <sie.h>

The list of headers that get included here is rather long for this file that 
is rather short ... e.g. do we really need such headers like sigp.h and 
sclp.h here?

> +static u8 *guest;
> +static u8 *guest_instr;
> +static struct vm vm;
> +
> +static uint8_t *src;
> +static uint8_t *dst;
> +static uint8_t *cmp;
> +
> +extern const char _binary_s390x_snippets_c_mvpg_snippet_gbin_start[];
> +extern const char _binary_s390x_snippets_c_mvpg_snippet_gbin_end[];
> +int binary_size;
> +
> +static void sie(struct vm *vm)
> +{
> +	/* Reset icptcode so we don't trip below */
> +	vm->sblk->icptcode = 0;
> +
> +	while (vm->sblk->icptcode == 0) {
> +		sie64a(vm->sblk, &vm->save_area);
> +		if (vm->sblk->icptcode == ICPT_VALIDITY)
> +			assert(0);


                 assert(vm->sblk->icptcode != ICPT_VALIDITY)

?

> +	}
> +	vm->save_area.guest.grs[14] = vm->sblk->gg14;
> +	vm->save_area.guest.grs[15] = vm->sblk->gg15;
> +}
> +
> +static void test_mvpg_pei(void)
> +{
> +	uint64_t **pei_dst = (uint64_t **)((uintptr_t) vm.sblk + 0xc0);
> +	uint64_t **pei_src = (uint64_t **)((uintptr_t) vm.sblk + 0xc8);

Hmm, magic values ... according to the public SA22-7095-0 from 1984, the 
array at offset 0xc0 is called "Interruption parameters" ... could we maybe 
at least use a similar name in our
kvm_s390_sie_block?

> +	report_prefix_push("pei");
> +
> +	report_prefix_push("src");
> +	memset(dst, 0, PAGE_SIZE);
> +	protect_page(src, PAGE_ENTRY_I);
> +	sie(&vm);
> +	report(vm.sblk->icptcode == ICPT_PARTEXEC, "Partial execution");
> +	report((uintptr_t)**pei_src == ((uintptr_t)vm.sblk->mso) + 0x6000 + PAGE_ENTRY_I, "PEI_SRC correct");
> +	report((uintptr_t)**pei_dst == vm.sblk->mso + 0x5000, "PEI_DST correct");
> +	unprotect_page(src, PAGE_ENTRY_I);
> +	report(!memcmp(cmp, dst, PAGE_SIZE), "Destination intact");
> +	/* Jump over the diag44 */
> +	sie(&vm);
> +	assert(vm.sblk->icptcode == ICPT_INST &&
> +	       vm.sblk->ipa == 0x8300 && vm.sblk->ipb == 0x440000);

Maybe add a comment about the magic values?

> +	report_prefix_pop();
> +
> +	/* Clear PEI data for next check */
> +	report_prefix_push("dst");
> +	memset((uint64_t *)((uintptr_t) vm.sblk + 0xc0), 0, 16);
> +	memset(dst, 0, PAGE_SIZE);
> +	protect_page(dst, PAGE_ENTRY_I);
> +	sie(&vm);
> +	report(vm.sblk->icptcode == ICPT_PARTEXEC, "Partial execution");
> +	report((uintptr_t)**pei_src == vm.sblk->mso + 0x6000, "PEI_SRC correct");
> +	report((uintptr_t)**pei_dst == vm.sblk->mso + 0x5000 + PAGE_ENTRY_I, "PEI_DST correct");
> +	/* Needed for the memcmp and general cleanup */
> +	unprotect_page(dst, PAGE_ENTRY_I);
> +	report(!memcmp(cmp, dst, PAGE_SIZE), "Destination intact");
> +	report_prefix_pop();
> +
> +	report_prefix_pop();
> +}
> +
> +static void test_mvpg(void)
> +{
> +	int binary_size = ((uintptr_t)_binary_s390x_snippets_c_mvpg_snippet_gbin_end -
> +			   (uintptr_t)_binary_s390x_snippets_c_mvpg_snippet_gbin_start);
> +
> +	memcpy(guest, _binary_s390x_snippets_c_mvpg_snippet_gbin_start, binary_size);
> +	memset(src, 0x42, PAGE_SIZE);
> +	memset(dst, 0x43, PAGE_SIZE);
> +	sie(&vm);
> +	mb();
> +	report(!memcmp(src, dst, PAGE_SIZE) && *dst == 0x42, "Page moved");
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
> +	 * Pageable guest with the same ASCE as the test programm, but
> +	 * the guest memory 0x0 is offset to start at the allocated
> +	 * guest pages and end after 1MB.
> +	 *
> +	 * It's not pretty but faster and easier than managing guest ASCEs.
> +	 */
> +	vm.sblk->mso = (u64)guest;
> +	vm.sblk->msl = (u64)guest;
> +	vm.sblk->ihcpu = 0xffff;
> +
> +	vm.sblk->crycbd = (uint64_t)alloc_page();
> +
> +	vm.sblk->gpsw.addr = PAGE_SIZE * 4;
> +	vm.sblk->gpsw.mask = 0x0000000180000000ULL;
> +	vm.sblk->ictl = ICTL_OPEREXC | ICTL_PINT;
> +	/* Enable MVPG interpretation as we want to test KVM and not ourselves */
> +	vm.sblk->eca = ECA_MVPGI;
> +
> +	src = guest + PAGE_SIZE * 6;
> +	dst = guest + PAGE_SIZE * 5;
> +	cmp = alloc_page();
> +	memset(cmp, 0, PAGE_SIZE);
> +}
> +
> +int main(void)
> +{
> +	report_prefix_push("mvpg-sie");
> +	if (!sclp_facilities.has_sief2) {
> +		report_skip("SIEF2 facility unavailable");
> +		goto done;
> +	}
> +
> +	setup_guest();
> +	test_mvpg();
> +	test_mvpg_pei();
> +
> +done:
> +	report_prefix_pop();
> +	return report_summary();
> +
> +}
> diff --git a/s390x/snippets/c/mvpg-snippet.c b/s390x/snippets/c/mvpg-snippet.c
> new file mode 100644
> index 0000000..96b70c9
> --- /dev/null
> +++ b/s390x/snippets/c/mvpg-snippet.c
> @@ -0,0 +1,33 @@
> +#include <libcflat.h>
> +
> +static inline void force_exit(void)
> +{
> +	asm volatile("	diag	0,0,0x44\n");
> +}
> +
> +static inline int mvpg(unsigned long r0, void *dest, void *src)
> +{
> +	register unsigned long reg0 asm ("0") = r0;
> +	int cc;
> +
> +	asm volatile("	mvpg    %1,%2\n"
> +		     "	ipm     %0\n"
> +		     "	srl     %0,28"
> +		     : "=&d" (cc) : "a" (dest), "a" (src), "d" (reg0)

Why is cc marked with "&" here?

  Thomas

