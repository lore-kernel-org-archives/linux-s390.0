Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA310C7EE22
	for <linux-s390@archiver.kernel.org>; Wed, 10 May 2023 04:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbjEJEvZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 May 2023 00:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjEJEvY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 May 2023 00:51:24 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD301FEB
        for <linux-s390@vger.kernel.org>; Tue,  9 May 2023 21:51:21 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-55a8019379fso62630547b3.0
        for <linux-s390@vger.kernel.org>; Tue, 09 May 2023 21:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683694281; x=1686286281;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7UlqbgxG6/xaVRAtCCqUssmJjUq670TXTguXR1OYLA=;
        b=5cXf/P6BxU1x2jWAw1XE7lRFR5Hz1XREgrw/VEMhvVcJnXcjM36N/6ukWbrtQrBqKA
         zSa2Sv7JIhhIHw0jqecJCQ0I3KFtNtFTtcWEm3Dd1ej1SIUJwcKbmfe+obSPbeDZo8gC
         6xQBKG42nA4UxjHlH/bbWapoijTCEdQ0FWMFygpKibtGLht3vBtUJrxtZLXSikEjAohO
         9Mt4H98I/XZmLwWtASWfmWRRB+ep6DPhrFoxb6sbiSMAPWqCSJ6PoFgtTXczonMbB8CK
         fEydvLzJU1eBlheYQjHQZRb6dlhSRwpD8khHEgpaWJ2Nq+jcZ1v9u6pbHABwaFooYDMC
         SQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683694281; x=1686286281;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7UlqbgxG6/xaVRAtCCqUssmJjUq670TXTguXR1OYLA=;
        b=C2VlEIvEyMPwfUJz4PSI+J9Ng1igU+AdOlCtbz/3xGkRwz9ACvSFdDkDv+ZvZp3lEy
         D/Zr6NyfbRSMMHgndqoiGfP/KVO3wgXYr6C6EMzE5FTS6Yy42ctD4icTjfUGwz3RUwam
         2b3O9Mv2KMWKJLM+BXMAamLlx304b48pAr0ey2j/7pOzSIH0ZOsojjPdBdFKop1XRxcd
         PmhFC0aOhb5j7ubG3rQDc+oxeNtsZy+OsUFZAYOMf8dG3HVprvZ00KJCdmP5U/6TWJuM
         /544wLrKIwY2/XR04jlHGkwxkHixjz6qgl5DMCVB5C061UWh1V1Q7ZcA8ujTCoQ8seao
         Dv4A==
X-Gm-Message-State: AC+VfDzV3e6IOUGdd4CofAnszmrBPgrkVN0FtfQm0Nm8WvP8eClUsgyN
        uIZGr+UPQJNY4a9FYj8tPEZ61A==
X-Google-Smtp-Source: ACHHUZ4qY6ip5x2yFLoBtebXka29+LgP7DYegkav9AGhNOLhqnLW12B3RwfHAHhI/1xbUzIiGo2rmQ==
X-Received: by 2002:a0d:f347:0:b0:556:1065:e6a8 with SMTP id c68-20020a0df347000000b005561065e6a8mr19687163ywf.2.1683694280881;
        Tue, 09 May 2023 21:51:20 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x186-20020a81a0c3000000b0054eff15530asm3831597ywg.90.2023.05.09.21.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 21:51:20 -0700 (PDT)
Date:   Tue, 9 May 2023 21:51:16 -0700 (PDT)
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
Subject: [PATCH 07/23] mips: update_mmu_cache() can replace __update_tlb()
In-Reply-To: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
Message-ID: <e7e6758b-d952-c96f-37b0-814cc3a22bc6@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Don't make update_mmu_cache() a wrapper around __update_tlb(): call it
directly, and use the ptep (or pmdp) provided by the caller, instead of
re-calling pte_offset_map() - which would raise a question of whether a
pte_unmap() is needed to balance it.

Check whether the "ptep" provided by the caller is actually the pmdp,
instead of testing pmd_huge(): or test pmd_huge() too and warn if it
disagrees?  This is "hazardous" territory: needs review and testing.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/mips/include/asm/pgtable.h | 15 +++------------
 arch/mips/mm/tlb-r3k.c          |  5 +++--
 arch/mips/mm/tlb-r4k.c          |  9 +++------
 3 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 574fa14ac8b2..9175dfab08d5 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -565,15 +565,8 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 }
 #endif
 
-extern void __update_tlb(struct vm_area_struct *vma, unsigned long address,
-	pte_t pte);
-
-static inline void update_mmu_cache(struct vm_area_struct *vma,
-	unsigned long address, pte_t *ptep)
-{
-	pte_t pte = *ptep;
-	__update_tlb(vma, address, pte);
-}
+extern void update_mmu_cache(struct vm_area_struct *vma,
+	unsigned long address, pte_t *ptep);
 
 #define	__HAVE_ARCH_UPDATE_MMU_TLB
 #define update_mmu_tlb	update_mmu_cache
@@ -581,9 +574,7 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
 	unsigned long address, pmd_t *pmdp)
 {
-	pte_t pte = *(pte_t *)pmdp;
-
-	__update_tlb(vma, address, pte);
+	update_mmu_cache(vma, address, (pte_t *)pmdp);
 }
 
 /*
diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
index 53dfa2b9316b..e5722cd8dd6d 100644
--- a/arch/mips/mm/tlb-r3k.c
+++ b/arch/mips/mm/tlb-r3k.c
@@ -176,7 +176,8 @@ void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 	}
 }
 
-void __update_tlb(struct vm_area_struct *vma, unsigned long address, pte_t pte)
+void update_mmu_cache(struct vm_area_struct *vma,
+		      unsigned long address, pte_t *ptep)
 {
 	unsigned long asid_mask = cpu_asid_mask(&current_cpu_data);
 	unsigned long flags;
@@ -203,7 +204,7 @@ void __update_tlb(struct vm_area_struct *vma, unsigned long address, pte_t pte)
 	BARRIER;
 	tlb_probe();
 	idx = read_c0_index();
-	write_c0_entrylo0(pte_val(pte));
+	write_c0_entrylo0(pte_val(*ptep));
 	write_c0_entryhi(address | pid);
 	if (idx < 0) {					/* BARRIER */
 		tlb_write_random();
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 1b939abbe4ca..c96725d17cab 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -290,14 +290,14 @@ void local_flush_tlb_one(unsigned long page)
  * updates the TLB with the new pte(s), and another which also checks
  * for the R4k "end of page" hardware bug and does the needy.
  */
-void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
+void update_mmu_cache(struct vm_area_struct *vma,
+		      unsigned long address, pte_t *ptep)
 {
 	unsigned long flags;
 	pgd_t *pgdp;
 	p4d_t *p4dp;
 	pud_t *pudp;
 	pmd_t *pmdp;
-	pte_t *ptep;
 	int idx, pid;
 
 	/*
@@ -326,10 +326,9 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 	idx = read_c0_index();
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 	/* this could be a huge page  */
-	if (pmd_huge(*pmdp)) {
+	if (ptep == (pte_t *)pmdp) {
 		unsigned long lo;
 		write_c0_pagemask(PM_HUGE_MASK);
-		ptep = (pte_t *)pmdp;
 		lo = pte_to_entrylo(pte_val(*ptep));
 		write_c0_entrylo0(lo);
 		write_c0_entrylo1(lo + (HPAGE_SIZE >> 7));
@@ -344,8 +343,6 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 	} else
 #endif
 	{
-		ptep = pte_offset_map(pmdp, address);
-
 #if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
 #ifdef CONFIG_XPA
 		write_c0_entrylo0(pte_to_entrylo(ptep->pte_high));
-- 
2.35.3

