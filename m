Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55542C7EE25
	for <linux-s390@archiver.kernel.org>; Wed, 10 May 2023 04:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjEJErT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 May 2023 00:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjEJErS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 May 2023 00:47:18 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4461FC1
        for <linux-s390@vger.kernel.org>; Tue,  9 May 2023 21:47:16 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-b9e2b65d006so10149155276.3
        for <linux-s390@vger.kernel.org>; Tue, 09 May 2023 21:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683694036; x=1686286036;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hqbvyW6crf6toTfKG311uSxHzLZVjYgM3m9zpPIhyDA=;
        b=o+pw/FxefUIAOoasXSGcewgZKtzCiK6gey4asLS52yE6RcSKCLcg/5+Oke4t4tL5mt
         WY+uEeh7LusBVdVQVoeJLXBzhVEJAgg/+wrnr5YnLWD3Y+xgGcCb1JLs6JvP8/f0rR6I
         tOIJAEnPqeFziCHRIMxBgLXFbcRpC1yoUKiEwz+VxRsKMOaCzI+eqG6JH5jyJ802ZkSp
         N+BiAknrKD5ka0lvzxWcjKQzAZAWQASg3Zoa2F4mVxsPlzCTR7qCguvvguU/AtX+AHcL
         WDe1lJ7cP45MCFknO9sG2YoZVBoQ/kny4LfOudEYqHVSkK2nfJ78GhDEjEHbvmzj6Rt9
         PQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683694036; x=1686286036;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hqbvyW6crf6toTfKG311uSxHzLZVjYgM3m9zpPIhyDA=;
        b=QzYAw5CUN8al3RmlYYK7tnnvZKdMZodpZl4GwmVU6J0cWaWenAuIiJhw5qx+b0p6DT
         101Mp3m277tWZNCAMdK/0Q7g16MPgmku69xlszqMc1JGcvVNK0mGHg6CGRLBpj8Np/6s
         YERTMI53AtYf31NuNjWLTLhkT29Ngc7S1XQMjMz09bR18MGAbPPMKFqqd2IVEI1m0C8J
         QfjfnWlvUFwLcO9/l5J5MiZY+bAVT6bY8AfxiFFwbmSeCJkESkS2MPlLAH01l+kcxHS9
         GiCRe0+ZgoLfIQtzUx3laN/kR9UJxl+2CsxiaOTGkpxB0YKiYGaLRr0VvX97f3ObeJYk
         Sy2w==
X-Gm-Message-State: AC+VfDz1SyXh8UqRAzp36ONDMkwd7t+CEdFf9DCqP6UU2y1rp6CZ6SmV
        2l/knYViJG34nrWRq95sHe7AUQ==
X-Google-Smtp-Source: ACHHUZ7chwpqHYv2bkU0Ao/t6DWECrNjxiYg/IB0spMttiifVb5o/XZ8DrM/lCVX0msD4U/PtCIM9g==
X-Received: by 2002:a05:6902:1883:b0:b9d:58d9:8c with SMTP id cj3-20020a056902188300b00b9d58d9008cmr22251628ybb.11.1683694035986;
        Tue, 09 May 2023 21:47:15 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 185-20020a2506c2000000b00b9dc4620f95sm3505720ybg.6.2023.05.09.21.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 21:47:15 -0700 (PDT)
Date:   Tue, 9 May 2023 21:47:11 -0700 (PDT)
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
Subject: [PATCH 04/23] ia64/hugetlb: pte_alloc_huge() pte_offset_huge()
In-Reply-To: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
Message-ID: <baef2acf-7368-79a-a27-a87c2f2dfcb@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

pte_alloc_map() expects to be followed by pte_unmap(), but hugetlb omits
that: to keep balance in future, use the recently added pte_alloc_huge()
instead; with pte_offset_huge() a better name for pte_offset_kernel().

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/ia64/mm/hugetlbpage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
index 78a02e026164..adc49f2d22e8 100644
--- a/arch/ia64/mm/hugetlbpage.c
+++ b/arch/ia64/mm/hugetlbpage.c
@@ -41,7 +41,7 @@ huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (pud) {
 		pmd = pmd_alloc(mm, pud, taddr);
 		if (pmd)
-			pte = pte_alloc_map(mm, pmd, taddr);
+			pte = pte_alloc_huge(mm, pmd, taddr);
 	}
 	return pte;
 }
@@ -64,7 +64,7 @@ huge_pte_offset (struct mm_struct *mm, unsigned long addr, unsigned long sz)
 			if (pud_present(*pud)) {
 				pmd = pmd_offset(pud, taddr);
 				if (pmd_present(*pmd))
-					pte = pte_offset_map(pmd, taddr);
+					pte = pte_offset_huge(pmd, taddr);
 			}
 		}
 	}
-- 
2.35.3

