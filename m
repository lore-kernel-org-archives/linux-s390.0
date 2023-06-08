Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1846C87FDC
	for <linux-s390@archiver.kernel.org>; Thu,  8 Jun 2023 19:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236601AbjFHTRq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 8 Jun 2023 15:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236555AbjFHTRo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Jun 2023 15:17:44 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B7E30F6
        for <linux-s390@vger.kernel.org>; Thu,  8 Jun 2023 12:17:12 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-39a523e8209so41143b6e.0
        for <linux-s390@vger.kernel.org>; Thu, 08 Jun 2023 12:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686251779; x=1688843779;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fUQgmWpeb8XZ+Q95Ceu0Qoh2H5+Z0fgN6mScmqt4vh8=;
        b=Xts+xHOkrh/u1lklJ9jF3D7S9f/kLV8GPG892l7zD8MlHgN8wPrMqgrCwto/Q1X+Pk
         W1+dBhBpd/nxZGkRw7Je76Rv8ScIxWS7YhmGg7SCpWHyKB1Cka/5vVCHo+mJDQWdRl3m
         u500Id80G1EkjsXNB0mtCuxFaZBYzNUs8Dvvd2LdfZ44ADa4Y8aQBNX2j9WdcdQ881QF
         GqyzpCVHN9rDUPFg5SeHYjmoNQ/CJXz81UrJdT3zX813tHx7kBAl3bNlJp8cLIqFQaDy
         L3QDpbP/aGZ6VEQHFKJzDm28XHlRNu1JajJiE2WmrxtPA9CVcv6EWsa+OLyEs2Vz0giA
         l8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686251779; x=1688843779;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fUQgmWpeb8XZ+Q95Ceu0Qoh2H5+Z0fgN6mScmqt4vh8=;
        b=dft6LnZgiZGfGf+AVakCMgQ/TvCj0sMW2YKsR4hoghO5rWBSybkueMO5WZa7JONx9u
         Osb6P2J4I6Rn4yk3O2HgufkdwTL68NyZCZiN6PNJNAhxzxopVyVosyTp4sCp28GjbEbj
         fb1k6O5lP3yUpw7yTIHahZdv/hG4lvQZAAN+uOz1+MRNUFl+3NyZyVDcOoE5NeZL4cgp
         vwk/ifU7qSk0ljl1RzMcddv72y+R3gVghvk2fc8xqrsQgei5GHEuh89Uy5VkDJ41jgF2
         LHQQzMSYyl7wULh0Xe2r/7M0CCjX3qfesUCmjABVtxbXtBxjKGCLbnt5B/9u11QYRtlj
         zyBw==
X-Gm-Message-State: AC+VfDy5HntutJQLBfySXHjz+45qWiCyEcK6UDrTa6qg7wMjDbFJbCXb
        nK+kOtrr6TPbuCSAyjw6hXjFcQ==
X-Google-Smtp-Source: ACHHUZ7LNWBjev2z0u+SFnM7tyBRgdoNXbEUc0/f74NGgApbHQPTQerveZROpTXi1Z/8SDXbKzu99A==
X-Received: by 2002:aca:650c:0:b0:39b:da91:8749 with SMTP id m12-20020aca650c000000b0039bda918749mr6427430oim.50.1686251778936;
        Thu, 08 Jun 2023 12:16:18 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h200-20020a816cd1000000b0055aafcef659sm120593ywc.5.2023.06.08.12.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 12:16:18 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:16:14 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 06/23] microblaze: allow pte_offset_map() to fail
In-Reply-To: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
Message-ID: <eab66faf-c0ab-3a8f-47bf-8a7c5af638f@google.com>
References: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

In rare transient cases, not yet made possible, pte_offset_map() and
pte_offset_map_lock() may not find a page table: handle appropriately.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/microblaze/kernel/signal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
index c3aebec71c0c..c78a0ff48066 100644
--- a/arch/microblaze/kernel/signal.c
+++ b/arch/microblaze/kernel/signal.c
@@ -194,7 +194,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 
 	preempt_disable();
 	ptep = pte_offset_map(pmdp, address);
-	if (pte_present(*ptep)) {
+	if (ptep && pte_present(*ptep)) {
 		address = (unsigned long) page_address(pte_page(*ptep));
 		/* MS: I need add offset in page */
 		address += ((unsigned long)frame->tramp) & ~PAGE_MASK;
@@ -203,7 +203,8 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 		invalidate_icache_range(address, address + 8);
 		flush_dcache_range(address, address + 8);
 	}
-	pte_unmap(ptep);
+	if (ptep)
+		pte_unmap(ptep);
 	preempt_enable();
 	if (err)
 		return -EFAULT;
-- 
2.35.3

