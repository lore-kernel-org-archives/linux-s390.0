Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E77C4743F
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 12:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 519F461208
	for <linux-s390@archiver.kernel.org>; Mon,  7 Jun 2021 12:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhFGMeF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:34:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230241AbhFGMeE (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 7 Jun 2021 08:34:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87DF3610E7;
        Mon,  7 Jun 2021 12:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623069133;
        bh=T4Z14wIFK7gWUQjB62xSZCX/tmsIcTCzew9mUok/E2c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FTJjQLzFbWiOTBIXQdtOhHbpc4nwI6xdVDWxdGul9Uc3onX/+qQHoaGwVCf/QGJJD
         L6jg7CAj2Wu6GCL5FbehCdmGRxATzPVdGfAJmdmQ1SbFMARhaUXUZ6/mbB+LJWZflC
         K0m5jW82PSxt8QVEVHHLYDE9XBNs2bZstM2ZAZia56XywdOWzyhT5JbJ00sSZdKSWi
         6DRPScorVyEgCsM+8R6Qjx926ZcHnTq3ET4ZTclKgNOZ51AvGSX/ShVc+nNJNLco0Z
         9c4MVnP5Wj+7TL2d3DaTGtHbDQBUNUgT6RpbWYM86b3BVSsUKNGr+/LRe6jNStVzsZ
         UcDQtAFhhkrMw==
Date:   Mon, 7 Jun 2021 21:32:08 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     <akpm@linux-foundation.org>, <hpa@zytor.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hca@linux.ibm.com>,
        <gor@linux.ibm.com>, <borntraeger@de.ibm.com>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <linux-s390@vger.kernel.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2] kprobes: remove duplicated strong free_insn_page in
 x86 and s390
Message-Id: <20210607213208.b6d4bbda578a1f3aea93a9cb@kernel.org>
In-Reply-To: <20210607091854.31580-1-song.bao.hua@hisilicon.com>
References: <20210607091854.31580-1-song.bao.hua@hisilicon.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 7 Jun 2021 21:18:54 +1200
Barry Song <song.bao.hua@hisilicon.com> wrote:

> free_insn_page() in x86 and s390 are same with the common weak function
> in kernel/kprobes.c.
> Plus, the comment "Recover page to RW mode before releasing it" in x86
> seems insensible to be there since resetting mapping is done by common
> code in vfree() of module_memfree().
> So drop these two duplicated strong functions and related comment, then
> mark the common one in kernel/kprobes.c strong.

Hm, OK. Actually riscv and arm64 uses __vmalloc() but anyway
since module_memfree() calls vfree(). So it has no problem.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  -v2:
>  remove free_insn_page in s390 as well and remove the __weak in common
>  code according to Christoph's comment;
> 
>  arch/s390/kernel/kprobes.c     | 5 -----
>  arch/x86/kernel/kprobes/core.c | 6 ------
>  kernel/kprobes.c               | 2 +-
>  3 files changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
> index aae24dc75df6..60cfbd24229b 100644
> --- a/arch/s390/kernel/kprobes.c
> +++ b/arch/s390/kernel/kprobes.c
> @@ -44,11 +44,6 @@ void *alloc_insn_page(void)
>  	return page;
>  }
>  
> -void free_insn_page(void *page)
> -{
> -	module_memfree(page);
> -}
> -
>  static void *alloc_s390_insn_page(void)
>  {
>  	if (xchg(&insn_page_in_use, 1) == 1)
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index d3d65545cb8b..3bce67d3a03c 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -422,12 +422,6 @@ void *alloc_insn_page(void)
>  	return page;
>  }
>  
> -/* Recover page to RW mode before releasing it */
> -void free_insn_page(void *page)
> -{
> -	module_memfree(page);
> -}
> -
>  /* Kprobe x86 instruction emulation - only regs->ip or IF flag modifiers */
>  
>  static void kprobe_emulate_ifmodifiers(struct kprobe *p, struct pt_regs *regs)
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 745f08fdd7a6..ddb643f3879f 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -106,7 +106,7 @@ void __weak *alloc_insn_page(void)
>  	return module_alloc(PAGE_SIZE);
>  }
>  
> -void __weak free_insn_page(void *page)
> +void free_insn_page(void *page)
>  {
>  	module_memfree(page);
>  }
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
