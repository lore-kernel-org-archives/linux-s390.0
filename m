Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EDEC7EE25
	for <linux-s390@archiver.kernel.org>; Wed, 10 May 2023 05:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbjEJFFD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 May 2023 01:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235830AbjEJFEy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 May 2023 01:04:54 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F141FEE
        for <linux-s390@vger.kernel.org>; Tue,  9 May 2023 22:04:51 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-55a010774a5so104213477b3.3
        for <linux-s390@vger.kernel.org>; Tue, 09 May 2023 22:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683695090; x=1686287090;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LRrENG7fj4nSEA3qiqmp7KZ6RwcG7U0j5SldGyBNlNI=;
        b=QuBkLiQNgKJXlZ/XtUu/Zcc1TO/yNvtmxeCEZWPuo0Ut+/Dr2uj7N/fYaVeLSLWaoT
         dm0LsrTZl+fdsuIU70XZlX8Jdat219pOrdD5tmXxlOJq6I9xvJ8OBX2I3sC2/GzC7pIG
         XUtWl6K8CddosokWCD5JWnq8C0Qt/Y0GNquPBcUW8sOkTJGqV76KRSYlIi1jOPSqgjjT
         xhQu7yGeLyA8b6NgZMivw3GAn6e1+z3lgr3LgyDkQncSxt5H12sTmgDyT6BBdhQ0rxwG
         mDoCtTBYmNMU6XzQs1MJn/66oGLzS3WRb3BIObV6fJVnQHGlEpGSXCP7I8vkrI+sg4mt
         TgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683695090; x=1686287090;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LRrENG7fj4nSEA3qiqmp7KZ6RwcG7U0j5SldGyBNlNI=;
        b=UjWhIAS6QyHzx+mYwZfGtah8++YNYQl2gnCQMl4w8M9j1GhegO7sur+N4HHNTt89im
         EnlsFILrMubklQthyrhsunNRB6X169t2M71Ot5Zoypi3kEuzmEb4RZ3fl4PABbAgs+5K
         pGEZ3pS98gSUYXB2YRUBvloTypEjk7wU2nr4GvDLqUqsoAhgI2cP5hbGK/+FuuGPK4aO
         Fe7ObSgfN23I5NM9v24QCXJsG7thmSttbeUG/LDi2SNX2iacXsu1hXD8bIpLHHvI0KbU
         cfQ6UkUPkY/I5mLIXVYjji4i2S8/QQa1CFcdvFKE06+S5Po4dFRPpvW2VxJItF/X1PdC
         TpDg==
X-Gm-Message-State: AC+VfDwP2kYACpyn/PYvnhOHT9IIRPkEry7s6voaVIudYjozsC3awr+N
        zvkE6/CSPLEXQQ93qfXdzlOavA==
X-Google-Smtp-Source: ACHHUZ53GGioj5bo+FVmOpbhwfbbVyWZfbgJBuIz6ozNT3hKZWLtYauVGFRQKbnj4naBNbfMS7YmUw==
X-Received: by 2002:a81:488c:0:b0:55a:6769:1197 with SMTP id v134-20020a81488c000000b0055a67691197mr18307004ywa.41.1683695090358;
        Tue, 09 May 2023 22:04:50 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z184-20020a8189c1000000b00560beb1c97bsm948270ywf.97.2023.05.09.22.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 22:04:50 -0700 (PDT)
Date:   Tue, 9 May 2023 22:04:46 -0700 (PDT)
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
Subject: [PATCH 18/23] sparc/hugetlb: pte_alloc_huge() pte_offset_huge()
In-Reply-To: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
Message-ID: <da29d71e-111-65d5-eb7f-5ad97e406e70@google.com>
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
 arch/sparc/mm/hugetlbpage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index d8e0e3c7038d..d7018823206c 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -298,7 +298,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 		return NULL;
 	if (sz >= PMD_SIZE)
 		return (pte_t *)pmd;
-	return pte_alloc_map(mm, pmd, addr);
+	return pte_alloc_huge(mm, pmd, addr);
 }
 
 pte_t *huge_pte_offset(struct mm_struct *mm,
@@ -325,7 +325,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 		return NULL;
 	if (is_hugetlb_pmd(*pmd))
 		return (pte_t *)pmd;
-	return pte_offset_map(pmd, addr);
+	return pte_offset_huge(pmd, addr);
 }
 
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-- 
2.35.3

