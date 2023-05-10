Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B48C77B7C
	for <linux-s390@archiver.kernel.org>; Wed, 10 May 2023 04:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbjEJEnP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 May 2023 00:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbjEJEm6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 May 2023 00:42:58 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F157440FE
        for <linux-s390@vger.kernel.org>; Tue,  9 May 2023 21:42:55 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b9a879cd49cso8811491276.0
        for <linux-s390@vger.kernel.org>; Tue, 09 May 2023 21:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683693775; x=1686285775;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1YvWeTkG3kfP7WDkFLxY3Kk7w85fUEyISH4lFagFGGw=;
        b=ATuPznBP6lohY0dnWFYXaaNOQNunJEFtD7eF3OFa8KJJUXbFYwyofisXF7mtL2ymFH
         oTBz56agCcLhFx8YonoqBW6ZmAtrhlvPrmdJAcSpRqyP2mLR5Z/WoSQhVEg2s8MVqDuy
         Ip95cEIMx73t6Gdt8YSQEVRJTa89FntSD+Di4V6VUK9+4KRIMxTr8+RCmD6ANZu4Rjel
         BJF/aQ9/sAdSWOQreL897UcsYcMJJWTONr2aX5YmKG/bIAxUtAEn1GX4Jh5f4y/r990Z
         htjctO7o35ZbKLLksPTYN1h3aK5mSo9ZrVIIV1mS/G/Fv32O9W6ivMXImV5mGNDY0z+m
         21CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683693775; x=1686285775;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YvWeTkG3kfP7WDkFLxY3Kk7w85fUEyISH4lFagFGGw=;
        b=KBPCYJyEHp+ICW0lVt5HDVz6EHCbj/7VITLleNqu/l6iLeQ6O75v64KQ7+VHeqgW9L
         tctUYlW2V90BjM/FEZVQZE0muEQ4dPfoajjgu4RtRUUkMRJ5RFZ7Ymgpv5XH9HQqfFbm
         aThJuhl24VYa8Ncy8Wraah6YOUx7uFOG9JNVB1IjH79aFIO0bnfPOZY+GysrjNRxkX28
         6oSp/YQk4CVIdCfk+gaeOc0bbl8f3ItezcJ+8aYslSch/Bvjx/fc2JiNHejkyTD9NkY4
         /k3lNqaqZ8uVLmQLHCpfgYpbjS5SzHczzD152EVZTEPDxFoXPYpg8F7FEMpWym3DqWdd
         bXyw==
X-Gm-Message-State: AC+VfDwbVLqSx3E+1NWwv1NHhKdnuyCMBe88MC5rbyoMBbxhYCAolzj1
        nnjDglUwkMI98fHrM7zpU8S3eA==
X-Google-Smtp-Source: ACHHUZ7fYX2z0RAKmyNqdeM/8QuAhHW9rcUGOaUpv5crEQfaAc/gCUyRWpV2+01J2c8XG3m8+G8szg==
X-Received: by 2002:a25:ad98:0:b0:b9d:a8fa:fd6d with SMTP id z24-20020a25ad98000000b00b9da8fafd6dmr17660831ybi.12.1683693775053;
        Tue, 09 May 2023 21:42:55 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x4-20020a056902102400b00b9def138173sm3425234ybt.1.2023.05.09.21.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 21:42:54 -0700 (PDT)
Date:   Tue, 9 May 2023 21:42:44 -0700 (PDT)
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
Subject: [PATCH 01/23] arm: allow pte_offset_map[_lock]() to fail
In-Reply-To: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
Message-ID: <5011977-d876-6a24-a3fc-c7e6a02877b8@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

In rare transient cases, not yet made possible, pte_offset_map() and
pte_offset_map_lock() may not find a page table: handle appropriately.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/arm/lib/uaccess_with_memcpy.c | 3 +++
 arch/arm/mm/fault-armv.c           | 5 ++++-
 arch/arm/mm/fault.c                | 3 +++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
index e4c2677cc1e9..2f6163f05e93 100644
--- a/arch/arm/lib/uaccess_with_memcpy.c
+++ b/arch/arm/lib/uaccess_with_memcpy.c
@@ -74,6 +74,9 @@ pin_page_for_write(const void __user *_addr, pte_t **ptep, spinlock_t **ptlp)
 		return 0;
 
 	pte = pte_offset_map_lock(current->mm, pmd, addr, &ptl);
+	if (unlikely(!pte))
+		return 0;
+
 	if (unlikely(!pte_present(*pte) || !pte_young(*pte) ||
 	    !pte_write(*pte) || !pte_dirty(*pte))) {
 		pte_unmap_unlock(pte, ptl);
diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index 0e49154454a6..ca5302b0b7ee 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -117,8 +117,11 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 	 * must use the nested version.  This also means we need to
 	 * open-code the spin-locking.
 	 */
-	ptl = pte_lockptr(vma->vm_mm, pmd);
 	pte = pte_offset_map(pmd, address);
+	if (!pte)
+		return 0;
+
+	ptl = pte_lockptr(vma->vm_mm, pmd);
 	do_pte_lock(ptl);
 
 	ret = do_adjust_pte(vma, address, pfn, pte);
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 2418f1efabd8..83598649a094 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -85,6 +85,9 @@ void show_pte(const char *lvl, struct mm_struct *mm, unsigned long addr)
 			break;
 
 		pte = pte_offset_map(pmd, addr);
+		if (!pte)
+			break;
+
 		pr_cont(", *pte=%08llx", (long long)pte_val(*pte));
 #ifndef CONFIG_ARM_LPAE
 		pr_cont(", *ppte=%08llx",
-- 
2.35.3

