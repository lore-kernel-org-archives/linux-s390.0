Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4D2C07E9A
	for <linux-s390@archiver.kernel.org>; Mon,  5 Jul 2021 07:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4407C613F1
	for <linux-s390@archiver.kernel.org>; Mon,  5 Jul 2021 07:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhGEH1P (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 5 Jul 2021 03:27:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35218 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230087AbhGEH1P (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 5 Jul 2021 03:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625469878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8+VVgy1P6n3WNEWs9KwW6riooXDdLjJZV8VUE8nZQUg=;
        b=Wr6d6u0K1vNl+8gPPBmCMtPOVgyYVW0r6bBNHK0711l3Yaepl7EeBEYol6Y1D1bPExyRGs
        GC5ufev13EYyWqCskvdHe3Gnz8I5nqGttB4OmcSMdbtCmppTl6RNgjkcNObaeMt3acMaEM
        XPEn75rcLgWb7couOaaJI6a1twRzur8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-WzL-vzx9MXCJPNR1yFXytQ-1; Mon, 05 Jul 2021 03:24:37 -0400
X-MC-Unique: WzL-vzx9MXCJPNR1yFXytQ-1
Received: by mail-wm1-f69.google.com with SMTP id j18-20020a05600c1c12b029020a5514128fso415387wms.7
        for <linux-s390@vger.kernel.org>; Mon, 05 Jul 2021 00:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8+VVgy1P6n3WNEWs9KwW6riooXDdLjJZV8VUE8nZQUg=;
        b=eE8eXG0F9Rq/dDqChkwAYcfm0wiLeR+H6SvGA4FYpoXJe4RaO1WYY52B7Ld2btcpL1
         7sVIxPa2rzBBFQCjZG0TyhRf5aaWMRjjZ31AuTA8D1q3ZGLAuWY3rezjEKJiMtZ9YJXR
         5ny8JA4xUp8wwNcHTLLDH0P4JeI3ICxdgKypLIG0KIxhBuCCzUMgA+rEVP+JDXGmraWi
         YD7rId10ojRHBkphyo5PYofVQBMDm4O1A6eNQLlHUyTXnpKZRZA0ZoBiihauvuWpbOrK
         N6cVEUxq/DRr55TVpeRPlseE9WHDDZkwf+zqr3hJmIQ480G2NbQtwTS2k/i/4aieABi+
         ouZQ==
X-Gm-Message-State: AOAM530TY81Zm3iUAbUog5CyxcnIVH4i5GhRS6LEyRVRAnMiLvHcKGHy
        lLf2RNiC9oH16E8o15ur8OGi01ZSfD+NCYvQjvO+okHEe54Kl0wVy15xBfm7606zGOPGaemjhvU
        /4RxPBBsAcAJPOOobY/xkzg==
X-Received: by 2002:a05:600c:4ba9:: with SMTP id e41mr13269210wmp.72.1625469876210;
        Mon, 05 Jul 2021 00:24:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFG5VgxGGhu5Y3eqUo/7jO5LYJtV4P71h66RCR4WX1MFLXxZO3QyC8HPhjzkSMPx+FFr21/A==
X-Received: by 2002:a05:600c:4ba9:: with SMTP id e41mr13269184wmp.72.1625469875941;
        Mon, 05 Jul 2021 00:24:35 -0700 (PDT)
Received: from thuth.remote.csb (pd9575e1e.dip0.t-ipconnect.de. [217.87.94.30])
        by smtp.gmail.com with ESMTPSA id t17sm11739410wrs.61.2021.07.05.00.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 00:24:35 -0700 (PDT)
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <20210629131841.17319-1-frankja@linux.ibm.com>
 <20210629131841.17319-4-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 3/3] s390x: mvpg: Add SIE mvpg test
Message-ID: <d4966f2c-89b4-94b7-0dc7-df69534c2d7a@redhat.com>
Date:   Mon, 5 Jul 2021 09:24:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629131841.17319-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 29/06/2021 15.18, Janosch Frank wrote:
> Let's also check the PEI values to make sure our VSIE implementation
> is correct.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   s390x/Makefile                  |   2 +
>   s390x/mvpg-sie.c                | 151 ++++++++++++++++++++++++++++++++
>   s390x/snippets/c/mvpg-snippet.c |  33 +++++++
>   s390x/unittests.cfg             |   3 +
>   4 files changed, 189 insertions(+)
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
> index 0000000..3536c6a
> --- /dev/null
> +++ b/s390x/mvpg-sie.c
> @@ -0,0 +1,151 @@
> +#include <libcflat.h>
> +#include <asm/asm-offsets.h>
> +#include <asm-generic/barrier.h>
> +#include <asm/pgtable.h>
> +#include <mmu.h>
> +#include <asm/page.h>
> +#include <asm/facility.h>
> +#include <asm/mem.h>
> +#include <alloc_page.h>
> +#include <vm.h>
> +#include <sclp.h>
> +#include <sie.h>
> +
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
> +	/* Reset icptcode so we don't trip over it below */
> +	vm->sblk->icptcode = 0;
> +
> +	while (vm->sblk->icptcode == 0) {
> +		sie64a(vm->sblk, &vm->save_area);
> +		if (vm->sblk->icptcode == ICPT_VALIDITY)
> +			assert(0);

Please replace the above two lines with:

		assert(vm->sblk->icptcode != ICPT_VALIDITY);

> +	}
> +	vm->save_area.guest.grs[14] = vm->sblk->gg14;
> +	vm->save_area.guest.grs[15] = vm->sblk->gg15;
> +}
> +
> +static void test_mvpg_pei(void)
> +{
> +	uint64_t **pei_dst = (uint64_t **)((uintptr_t) vm.sblk + 0xc0);
> +	uint64_t **pei_src = (uint64_t **)((uintptr_t) vm.sblk + 0xc8);
> +
> +	report_prefix_push("pei");
> +
> +	report_prefix_push("src");
> +	memset(dst, 0, PAGE_SIZE);
> +	protect_page(src, PAGE_ENTRY_I);
> +	sie(&vm);
> +	report(vm.sblk->icptcode == ICPT_PARTEXEC, "Partial execution");
> +	report((uintptr_t)**pei_src == (uintptr_t)src + PAGE_ENTRY_I, "PEI_SRC correct");
> +	report((uintptr_t)**pei_dst == (uintptr_t)dst, "PEI_DST correct");
> +	unprotect_page(src, PAGE_ENTRY_I);
> +	report(!memcmp(cmp, dst, PAGE_SIZE), "Destination intact");
> +	/*
> +	 * We need to execute the diag44 which is used as a blocker
> +	 * behind the mvpg. It makes sure we fail the tests above if
> +	 * the mvpg wouldn't have intercepted.
> +	 */
> +	sie(&vm);
> +	/* Make sure we intercepted for the diag44 and nothing else */
> +	assert(vm.sblk->icptcode == ICPT_INST &&
> +	       vm.sblk->ipa == 0x8300 && vm.sblk->ipb == 0x440000);
> +	report_prefix_pop();
> +
> +	/* Clear PEI data for next check */
> +	report_prefix_push("dst");
> +	memset((uint64_t *)((uintptr_t) vm.sblk + 0xc0), 0, 16);
> +	memset(dst, 0, PAGE_SIZE);
> +	protect_page(dst, PAGE_ENTRY_I);
> +	sie(&vm);
> +	report(vm.sblk->icptcode == ICPT_PARTEXEC, "Partial execution");
> +	report((uintptr_t)**pei_src == (uintptr_t)src, "PEI_SRC correct");
> +	report((uintptr_t)**pei_dst == (uintptr_t)dst + PAGE_ENTRY_I, "PEI_DST correct");
> +	/* Needed for the memcmp and general cleanup */
> +	unprotect_page(dst, PAGE_ENTRY_I);
> +	report(!memcmp(cmp, dst, PAGE_SIZE), "Destination intact");
> +	report_prefix_pop();
> +
> +	report_prefix_pop();
> +}

Still quite a lot of magic values in above code ... any chance to introduce 
some #defines finally?

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

I think you don't need the mb() here.

> +	report(!memcmp(src, dst, PAGE_SIZE) && *dst == 0x42, "Page moved");
> +}

  Thomas

