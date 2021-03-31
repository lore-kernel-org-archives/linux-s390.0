Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C1FC433E2
	for <linux-s390@archiver.kernel.org>; Wed, 31 Mar 2021 09:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D9B7619E4
	for <linux-s390@archiver.kernel.org>; Wed, 31 Mar 2021 09:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbhCaJ3f (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 31 Mar 2021 05:29:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234718AbhCaJ3N (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 31 Mar 2021 05:29:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3578661606;
        Wed, 31 Mar 2021 09:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617182952;
        bh=aMxacYx0WSuYSq+RvcHg7XLnuWTcQHWfWM2hCy7hYJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZilpE/CgLvY3Nm3hLeCdPrSzQ0bka0Q/xAMzoDxoKT2sksg/+xdgw70lbIQlKRH9q
         HQM7q1tR3SOaufoC3EF8clnG+n8fTsUXBRqFIqRReR3kDRE9b5+HETaEN2azemUCyN
         +dywdbjbEuNLM1pOQ9fKcI8/BlabXbx6EDZQjXTlXZiHlwJBGfmHuNxznBzTG2bJFd
         nNykz3YpDvfjp1B8PgDSj0QLp5Bc0UJEz3WtQfw8cmvL2FnE443FSPWgxCOoGmWTX7
         urjc5s1XzZrXM3ARPcSSDIS4mEkSxEnbcwd3SAssAB5TkbJXQ91S3vF7J6sARmo8bJ
         QvnQEWfFitvHA==
Date:   Wed, 31 Mar 2021 12:28:57 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Richard Henderson <rth@twiddle.net>,
        Guo Ren <guoren@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: Move mem_init_print_info() into mm_init()
Message-ID: <YGRA2SU28yciN9xU@kernel.org>
References: <4d488195-7281-9238-b30d-9f89a6100fb9@csgroup.eu>
 <20210317015210.33641-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317015210.33641-1-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Mar 17, 2021 at 09:52:10AM +0800, Kefeng Wang wrote:
> mem_init_print_info() is called in mem_init() on each architecture,
> and pass NULL argument, so using void argument and move it into mm_init().
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
> v2:
> - Cleanup 'str' line suggested by Christophe and ACK
> 
