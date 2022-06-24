Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6E1CCA473
	for <linux-s390@archiver.kernel.org>; Fri, 24 Jun 2022 05:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiFXFJq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 24 Jun 2022 01:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiFXFJp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 24 Jun 2022 01:09:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD292BB0C;
        Thu, 23 Jun 2022 22:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tZ8LkmyBAtnykRzYGYg49Rqa9UPNSMXU6tU+2gOJDvM=; b=cCUlw5tMKjA7tpyeYmlc1ERkJa
        ckf4+aN3hEH0XCskIGjCoiOXbG/eaOHif+X+4wD4wUoGeeukP8mi+q13hfpsaYp4g0soi6gzXhEx1
        PpezxbivaQbnsmkilzPYqbCwMv7DF8gmG62CU1v84YZsYJIxP7ph/D9ymTFr2wg7GPJPzhYsTfT2o
        FtgxLrKn5v8y5kF54+4wuLTtWHxvlH+E/pRlSDlDD9a9kT1sJ5kvyaKgOkvO0HAWSyrXGUVOcgrsN
        dgSjko4uGfXPAbLp5BBlssWPJVsa+fsSvw8+d2FvD0U2hguXGnTjZkoAPYnfBeCAHIlB4+9lYA/SH
        DDooLKwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4bZb-000UJf-9K; Fri, 24 Jun 2022 05:09:39 +0000
Date:   Thu, 23 Jun 2022 22:09:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, hch@infradead.org, christophe.leroy@csgroup.eu,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        x86@kernel.org, openrisc@lists.librecores.org,
        linux-xtensa@linux-xtensa.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-um@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 02/26] mm/mmap: Define DECLARE_VM_GET_PAGE_PROT
Message-ID: <YrVHEw6bjUf62Eh5@infradead.org>
References: <20220624044339.1533882-1-anshuman.khandual@arm.com>
 <20220624044339.1533882-3-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624044339.1533882-3-anshuman.khandual@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jun 24, 2022 at 10:13:15AM +0530, Anshuman Khandual wrote:
> This just converts the generic vm_get_page_prot() implementation into a new
> macro i.e DECLARE_VM_GET_PAGE_PROT which later can be used across platforms
> when enabling them with ARCH_HAS_VM_GET_PAGE_PROT. This does not create any
> functional change.

mm.h is a huhe header included by almost everything in the kernel.
I'd rather have it in something only included in a few files.  If we
can't find anything suitable it might be worth to add a header just
for this even.
