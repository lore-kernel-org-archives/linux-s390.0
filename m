Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEA7C7EE24
	for <linux-s390@archiver.kernel.org>; Wed, 10 May 2023 04:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbjEJE5x (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 May 2023 00:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjEJE5v (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 May 2023 00:57:51 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025491BF7
        for <linux-s390@vger.kernel.org>; Tue,  9 May 2023 21:57:49 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-b9246a5f3feso10163595276.1
        for <linux-s390@vger.kernel.org>; Tue, 09 May 2023 21:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683694668; x=1686286668;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9SgMoVTm6P3R+1xCqI0Wv3sobczW81YJURPfTY0JVMk=;
        b=i6tseWUgvEolfXZtL5Oh35hld4r7UV7sxfAxp1Wi6J/AehneZgxtbpNMAbNVTBMmUI
         qj7UvqeEgFSQZ2qZW0AaYuuFH6wgQTMaPrP4VLoxCobR28SZjACKnu9c6qIW0PnqI4Hr
         Cld1tJ0wYqRvaAQ5bpmGPde8cyPQwKjxVNuL2CFu9bbXCawQw2nI4D6D+XCv12mgx2PV
         ij2tQ1g5xq9+W7BXEvJIwPrFkB6RWDWF/jzluSASWAsWg+TJDk0nuDAAmqQM+N4N23X5
         wmyc1MG831sFfWvE1Fo8gZjKKd7Tp0yVdZJzwu/TKEXh0IxxU0wZHa09QO6ZhQjWluyJ
         QdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683694668; x=1686286668;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9SgMoVTm6P3R+1xCqI0Wv3sobczW81YJURPfTY0JVMk=;
        b=S3b8lveHsUWCrZOfPPJAVa/EInk/aDWI7fP/kS18UQjjE9DdoGRujUS7zB+sIO/CWJ
         +OS47Fm+ZVcej8OWhPBGzDT25fxMOANaoFMgSpOn37OazktqMn+Sw5T+ymr/fAJIlaEX
         h3nfHb+/5O/gqdmOIMxkrL0gtZx1xVCpVaQn8CFyg3WReiMswBzs7tU7bKQyXZ6+nSlX
         ukcAEOMhkzhcqPawskDpaQd1VHYhI75qSLji0AjBMSKX8PeupPbpzkbD+W1lyLaefQPJ
         vYhUHG21fo1gdLVSacHvUSmYNsIJHJRbX+qbz52Sz0Yp6zDbxS//iITbjymJsHi6LitH
         gD7g==
X-Gm-Message-State: AC+VfDxoEix1gGoP2GGgCjmXcXe+BugYtshzAukayAPKNRitp4G3MNEj
        vgwQCt3e+q5xwKhYlaHaBL/Qzw==
X-Google-Smtp-Source: ACHHUZ65a43Tqu6pm6F2C+WJXeNuyd8nzb4UZ4DSWVXhBJktpHLfzKFfcKlkmv0fFRrnRgtDBOnq8Q==
X-Received: by 2002:a25:4d87:0:b0:b9d:5691:3ef6 with SMTP id a129-20020a254d87000000b00b9d56913ef6mr14812915ybb.27.1683694668013;
        Tue, 09 May 2023 21:57:48 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 23-20020a250d17000000b00b9e4a9b91b9sm3508848ybn.30.2023.05.09.21.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 21:57:47 -0700 (PDT)
Date:   Tue, 9 May 2023 21:57:44 -0700 (PDT)
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
Subject: [PATCH 12/23] powerpc: allow pte_offset_map[_lock]() to fail
In-Reply-To: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
Message-ID: <b384fc5-c2d-2a20-4025-ac748e3fb9@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

In rare transient cases, not yet made possible, pte_offset_map() and
pte_offset_map_lock() may not find a page table: handle appropriately.
Balance successful pte_offset_map() with pte_unmap() where omitted.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/powerpc/mm/book3s64/hash_tlb.c     | 4 ++++
 arch/powerpc/mm/book3s64/subpage_prot.c | 2 ++
 arch/powerpc/xmon/xmon.c                | 5 ++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/hash_tlb.c b/arch/powerpc/mm/book3s64/hash_tlb.c
index a64ea0a7ef96..21fcad97ae80 100644
--- a/arch/powerpc/mm/book3s64/hash_tlb.c
+++ b/arch/powerpc/mm/book3s64/hash_tlb.c
@@ -239,12 +239,16 @@ void flush_hash_table_pmd_range(struct mm_struct *mm, pmd_t *pmd, unsigned long
 	local_irq_save(flags);
 	arch_enter_lazy_mmu_mode();
 	start_pte = pte_offset_map(pmd, addr);
+	if (!start_pte)
+		goto out;
 	for (pte = start_pte; pte < start_pte + PTRS_PER_PTE; pte++) {
 		unsigned long pteval = pte_val(*pte);
 		if (pteval & H_PAGE_HASHPTE)
 			hpte_need_flush(mm, addr, pte, pteval, 0);
 		addr += PAGE_SIZE;
 	}
+	pte_unmap(start_pte);
+out:
 	arch_leave_lazy_mmu_mode();
 	local_irq_restore(flags);
 }
diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book3s64/subpage_prot.c
index b75a9fb99599..0dc85556dec5 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -71,6 +71,8 @@ static void hpte_flush_range(struct mm_struct *mm, unsigned long addr,
 	if (pmd_none(*pmd))
 		return;
 	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	if (!pte)
+		return;
 	arch_enter_lazy_mmu_mode();
 	for (; npages > 0; --npages) {
 		pte_update(mm, addr, pte, 0, 0, 0);
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 728d3c257e4a..69447bdf0bcf 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3376,12 +3376,15 @@ static void show_pte(unsigned long addr)
 	printf("pmdp @ 0x%px = 0x%016lx\n", pmdp, pmd_val(*pmdp));
 
 	ptep = pte_offset_map(pmdp, addr);
-	if (pte_none(*ptep)) {
+	if (!ptep || pte_none(*ptep)) {
+		if (ptep)
+			pte_unmap(ptep);
 		printf("no valid PTE\n");
 		return;
 	}
 
 	format_pte(ptep, pte_val(*ptep));
+	pte_unmap(ptep);
 
 	sync();
 	__delay(200);
-- 
2.35.3

