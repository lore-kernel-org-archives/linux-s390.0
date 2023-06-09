Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158F2C83005
	for <linux-s390@archiver.kernel.org>; Fri,  9 Jun 2023 08:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239315AbjFIIKX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 9 Jun 2023 04:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240176AbjFIIJ3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Jun 2023 04:09:29 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102BF3A82
        for <linux-s390@vger.kernel.org>; Fri,  9 Jun 2023 01:09:08 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-56974f42224so13683787b3.1
        for <linux-s390@vger.kernel.org>; Fri, 09 Jun 2023 01:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686298146; x=1688890146;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D+JG9ScbeIgWCoIoD1lrBSynxF7pZ7ZmtCOtSuAlDGQ=;
        b=RfeoHUBLwqk9vTTBDLCpOuzNXpllWDEkPYc6yjXtxGCPNmX/rvie991AU10lJs4XbF
         9RzbOtcSEpi5Rh8KstlxITQN3Ffo4ROyfYENBHFqs9HkcG3CFgO7j5lBQrxeeGMGBjp2
         NZdxOQon49qNf9HZ1Qgrz3xC18+gnVg36Hvk5SsHYUm7h4j5tszvUdFL2KV4ehwHCBOk
         gyj3AdqSIMMtQdGmRCxc7HYtfEU+n7ezPeWYkyEIY3KjdS94V8qvWswp+jF2hFiGMFim
         NoPZGExtzKBOx7SOm5zC/zUvIhzRSqstVSVI3uYZkXeW9ex9SLXGk6aLeA5PY5ojGjGB
         epOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686298146; x=1688890146;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+JG9ScbeIgWCoIoD1lrBSynxF7pZ7ZmtCOtSuAlDGQ=;
        b=gqfpL3ECKfw2ZXB517BcPA6NucRpg75R9sDcGUOJ7DWd/uRTUbtYoa0TJlqwOfbfsG
         5K9U1zbblt2y5De8I2zTro3dtBlkV0jcSoZtqrpyZR6RTn+R4UNW9//Nyt8UJ6yxzvsv
         HV2ovr/LI3Vr0KlKeWulFNx1gm0ZBQwq8ntGQX8TzdXtMLDPEzTeWplMf2F3SpLEiT2/
         HZ/EyuDQPxJwvT8k20+/9gNt3d2LRf6yW6P7XEnWSyPDBZzTjB/0NW5SrjUve45/fIg6
         fmcPgQCT9OKJgZKn0La6MbmPSoU+pfXu3ehmWD1VC3DHZ122nwfy985E2lU2fW0y63Jc
         2Sug==
X-Gm-Message-State: AC+VfDwItssdgIAhsLdnPJMvrpil2JIXC36ktOhm8QuxH24erILqzj3c
        6+HjK00Hz922OM2NiA1P/AAN4A==
X-Google-Smtp-Source: ACHHUZ5DQYcZ9JTl8EUp4l7QLImYygbjncdx8ql55YYe3IsFqc7F1XNEab87Po2zAxMo3TGE3P0BfA==
X-Received: by 2002:a0d:e684:0:b0:565:e87f:a78f with SMTP id p126-20020a0de684000000b00565e87fa78fmr500342ywe.25.1686298145738;
        Fri, 09 Jun 2023 01:09:05 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n19-20020a819c53000000b005688f7596ccsm453200ywa.78.2023.06.09.01.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 01:09:04 -0700 (PDT)
Date:   Fri, 9 Jun 2023 01:08:52 -0700 (PDT)
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
Subject: [PATCH v2 07/23 fix] mips: update_mmu_cache() can replace __update_tlb():
 fix
In-Reply-To: <178970b0-1539-8aac-76fd-972c6c46ec17@google.com>
Message-ID: <6852be98-64e6-6092-d1c-13124b97bc75@google.com>
References: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com> <178970b0-1539-8aac-76fd-972c6c46ec17@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

I expect this to fix the
arch/mips/mm/tlb-r4k.c:300:16: warning: variable 'pmdp' set but not used
reported by the kernel test robot; but I am uncomfortable rearranging
lines in this tlb_probe_hazard() area, and would be glad for review and
testing by someone familiar with mips - thanks in advance!

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306091304.cNVIspK0-lkp@intel.com/
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/mips/mm/tlb-r4k.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index c96725d17cab..80fc90d8d2f1 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -293,11 +293,13 @@ void local_flush_tlb_one(unsigned long page)
 void update_mmu_cache(struct vm_area_struct *vma,
 		      unsigned long address, pte_t *ptep)
 {
-	unsigned long flags;
+#ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 	pgd_t *pgdp;
 	p4d_t *p4dp;
 	pud_t *pudp;
 	pmd_t *pmdp;
+#endif
+	unsigned long flags;
 	int idx, pid;
 
 	/*
@@ -316,15 +318,15 @@ void update_mmu_cache(struct vm_area_struct *vma,
 		pid = read_c0_entryhi() & cpu_asid_mask(&current_cpu_data);
 		write_c0_entryhi(address | pid);
 	}
-	pgdp = pgd_offset(vma->vm_mm, address);
 	mtc0_tlbw_hazard();
 	tlb_probe();
 	tlb_probe_hazard();
+	idx = read_c0_index();
+#ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
+	pgdp = pgd_offset(vma->vm_mm, address);
 	p4dp = p4d_offset(pgdp, address);
 	pudp = pud_offset(p4dp, address);
 	pmdp = pmd_offset(pudp, address);
-	idx = read_c0_index();
-#ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 	/* this could be a huge page  */
 	if (ptep == (pte_t *)pmdp) {
 		unsigned long lo;
-- 
2.35.3

