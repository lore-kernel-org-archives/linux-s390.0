Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC15BC4743E
	for <linux-s390@archiver.kernel.org>; Sun,  6 Jun 2021 21:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D45B361380
	for <linux-s390@archiver.kernel.org>; Sun,  6 Jun 2021 21:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhFFVbJ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 6 Jun 2021 17:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230270AbhFFVbJ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 6 Jun 2021 17:31:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 953E4613B6;
        Sun,  6 Jun 2021 21:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623014959;
        bh=4t5DawWhLmQPAFGRKhX1jFE4WEqbArxXgmERWe2C0xQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wu/fyJA4UR/3OsXx5PdnZuKJmqUDl6cQ0I5qOPmOobYB/YwD3loa7CHDMxmjDs7+O
         /+vTonUI3DKMDg+OJCEqqvIqeoGeqCBaFfCM6MGkwmW6KvTZO5CLkleOMNy5KmfR4d
         PteqC/M3+gPE1uiUsTSHvYSMYrpSkJ75a30BXywU3cSKzUfAv/A0+aJ76/IGuUYyhl
         S6LUi9EmnHUL5lEcDnAewWs8EsYomaOBUCef/cImLCqjaabNrEeHJoCWkyMWvCEGV1
         9+bVS1xXN0QGlOiLh2r3UXefQeesEuK/PQnscumw1S0RmHISk2eF6NrfUP8ytWcSpP
         sTzKK7DJdkKEw==
Date:   Mon, 7 Jun 2021 00:29:09 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 00/15] init_mm: cleanup ARCH's text/data/brk setup code
Message-ID: <YL0+Jargm+y9aqx1@kernel.org>
References: <20210604070633.32363-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604070633.32363-1-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello Kefeng,

On Fri, Jun 04, 2021 at 03:06:18PM +0800, Kefeng Wang wrote:
> Add setup_initial_init_mm() helper, then use it
> to cleanup the text, data and brk setup code.
> 
> v2:
> - change argument from "char *" to "void *" setup_initial_init_mm()
>   suggested by Geert Uytterhoeven
> - use NULL instead of (void *)0 on h8300 and m68k
> - collect ACKs
> 
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-csky@vger.kernel.org
> Cc: uclinux-h8-devel@lists.sourceforge.jp
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: openrisc@lists.librecores.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-sh@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Kefeng Wang (15):
>   mm: add setup_initial_init_mm() helper
>   arc: convert to setup_initial_init_mm()
>   arm: convert to setup_initial_init_mm()
>   arm64: convert to setup_initial_init_mm()
>   csky: convert to setup_initial_init_mm()
>   h8300: convert to setup_initial_init_mm()
>   m68k: convert to setup_initial_init_mm()
>   nds32: convert to setup_initial_init_mm()
>   nios2: convert to setup_initial_init_mm()
>   openrisc: convert to setup_initial_init_mm()
>   powerpc: convert to setup_initial_init_mm()
>   riscv: convert to setup_initial_init_mm()
>   s390: convert to setup_initial_init_mm()
>   sh: convert to setup_initial_init_mm()
>   x86: convert to setup_initial_init_mm()

I might be missing something, but AFAIU the init_mm.start_code and other
fields are not used really early so the new setup_initial_init_mm()
function can be called in the generic code outside setup_arch(), e.g in
mm_init().
 
>  arch/arc/mm/init.c                 | 5 +----
>  arch/arm/kernel/setup.c            | 5 +----
>  arch/arm64/kernel/setup.c          | 5 +----
>  arch/csky/kernel/setup.c           | 5 +----
>  arch/h8300/kernel/setup.c          | 5 +----
>  arch/m68k/kernel/setup_mm.c        | 5 +----
>  arch/m68k/kernel/setup_no.c        | 5 +----
>  arch/nds32/kernel/setup.c          | 5 +----
>  arch/nios2/kernel/setup.c          | 5 +----
>  arch/openrisc/kernel/setup.c       | 5 +----
>  arch/powerpc/kernel/setup-common.c | 5 +----
>  arch/riscv/kernel/setup.c          | 5 +----
>  arch/s390/kernel/setup.c           | 5 +----
>  arch/sh/kernel/setup.c             | 5 +----
>  arch/x86/kernel/setup.c            | 5 +----
>  include/linux/mm_types.h           | 8 ++++++++
>  16 files changed, 23 insertions(+), 60 deletions(-)
> 
> -- 
> 2.26.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

-- 
Sincerely yours,
Mike.
