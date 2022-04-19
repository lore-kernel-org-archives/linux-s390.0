Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6276C433FE
	for <linux-s390@archiver.kernel.org>; Tue, 19 Apr 2022 12:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352410AbiDSMtp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 19 Apr 2022 08:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbiDSMto (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Apr 2022 08:49:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D6C93700C
        for <linux-s390@vger.kernel.org>; Tue, 19 Apr 2022 05:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650372420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JIdJvCM/nzvVsX3gP8Of74a/GoE/TyZ8c3A83vketQk=;
        b=XCQ0o5g0eJSyWeBaQl9XN7sb20WivvdX3ywJptX9VPF9y/e88VUR5rc4IK35vi2vu21Kb/
        Z/diSP6xSvbIkwVsVCwEmdhS363ip3HE5mlPrhRB2FiQsXfQi7Yj+ToFnZGUaMqSYbOhPr
        l2Fo+uCV+Uv4Qs9+JXvIy+Q6z1ySg/k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-YKq0SpByNX6e2axqmsDopQ-1; Tue, 19 Apr 2022 08:46:56 -0400
X-MC-Unique: YKq0SpByNX6e2axqmsDopQ-1
Received: by mail-wm1-f69.google.com with SMTP id c125-20020a1c3583000000b0038e3f6e871aso9236534wma.8
        for <linux-s390@vger.kernel.org>; Tue, 19 Apr 2022 05:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=JIdJvCM/nzvVsX3gP8Of74a/GoE/TyZ8c3A83vketQk=;
        b=eFvGeicUhjcLjS9oz8vfVT4w7+SOpc3Oy01YfKg95TKaOxEoOu4AFhEMhOotSeisCr
         jk2qG+jRC1587TeJs6jzH8txMjcyC5NNdblhZg5UMILJfbEMf6ezcpR9HzgUKUGKzSMV
         WB+5T/mI4Shzf78eEIhe0cSjHdOTCHSvtkf/mCTY5Xo6ExS5PMnk9NFDzTxq4Q0jV72o
         fLKsjjL2BA6H4YlimyztemnOwGvQoWHbl0EeVlOwU/Bn02CVmBepq2DML+6aAMLgWmsg
         RaDmXRA1EHrn2poA8dt5w7nnw+HAnKhq+cbYPF5oysLOv4zQAvrngepfmylxUoUzsCEJ
         ewlQ==
X-Gm-Message-State: AOAM533vDvPA9y4+Qo9CC7auGWRIXwgqDcD0FnabD2vEbXtKOKqcF/gI
        M6+Jrm7nlFShX6Eog4JpB8L6ef0vvoFTV7xWNEoXEsfKU5krTHxH44mS3udQId99Ey0Q4j6b+ON
        BoE4Mua1BXI/YiIgAG0YYDQ==
X-Received: by 2002:a5d:6c61:0:b0:20a:a261:876a with SMTP id r1-20020a5d6c61000000b0020aa261876amr3888818wrz.251.1650372414462;
        Tue, 19 Apr 2022 05:46:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdMM5QdzCOMem9yase7YYuZlZxCCL7y7FebP52SLMHsNQ3htbJhnS/K27BEXI5r4m/9jMYRg==
X-Received: by 2002:a5d:6c61:0:b0:20a:a261:876a with SMTP id r1-20020a5d6c61000000b0020aa261876amr3888803wrz.251.1650372414247;
        Tue, 19 Apr 2022 05:46:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5d00:d8c2:fbf6:a608:957a? (p200300cbc7045d00d8c2fbf6a608957a.dip0.t-ipconnect.de. [2003:cb:c704:5d00:d8c2:fbf6:a608:957a])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d6a87000000b00207aad420c4sm12434616wru.101.2022.04.19.05.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 05:46:53 -0700 (PDT)
Message-ID: <d875c292-46b3-f281-65ae-71d0b0c6f592@redhat.com>
Date:   Tue, 19 Apr 2022 14:46:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
References: <20220329164329.208407-1-david@redhat.com>
 <20220329164329.208407-4-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 3/8] x86/pgtable: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
In-Reply-To: <20220329164329.208407-4-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 29.03.22 18:43, David Hildenbrand wrote:
> Let's use bit 3 to remember PG_anon_exclusive in swap ptes.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Looks like I ignored that 32bit uses a different (undocumented) swap layout
and bit 3 falls into the swp type. We'll restrict this to x86-64 for now, just
like for the other architectures.

The following seems to fly. @Andrew, let me know if you prefer a v3.


From bafb5ba914e89ad20c46f4e841a36909e610b81e Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 9 Mar 2022 09:47:29 +0100
Subject: [PATCH] x86/pgtable: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE on x86_64

Let's use bit 3 to remember PG_anon_exclusive in swap ptes.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/include/asm/pgtable.h          | 17 +++++++++++++++++
 arch/x86/include/asm/pgtable_64.h       |  4 +++-
 arch/x86/include/asm/pgtable_64_types.h |  5 +++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 62ab07e24aef..a1c555abed26 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1291,6 +1291,23 @@ static inline void update_mmu_cache_pud(struct vm_area_struct *vma,
 		unsigned long addr, pud_t *pud)
 {
 }
+#ifdef _PAGE_SWP_EXCLUSIVE
+#define __HAVE_ARCH_PTE_SWP_EXCLUSIVE
+static inline pte_t pte_swp_mkexclusive(pte_t pte)
+{
+	return pte_set_flags(pte, _PAGE_SWP_EXCLUSIVE);
+}
+
+static inline int pte_swp_exclusive(pte_t pte)
+{
+	return pte_flags(pte) & _PAGE_SWP_EXCLUSIVE;
+}
+
+static inline pte_t pte_swp_clear_exclusive(pte_t pte)
+{
+	return pte_clear_flags(pte, _PAGE_SWP_EXCLUSIVE);
+}
+#endif /* _PAGE_SWP_EXCLUSIVE */
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 56d0399a0cd1..e479491da8d5 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -186,7 +186,7 @@ static inline void native_pgd_clear(pgd_t *pgd)
  *
  * |     ...            | 11| 10|  9|8|7|6|5| 4| 3|2| 1|0| <- bit number
  * |     ...            |SW3|SW2|SW1|G|L|D|A|CD|WT|U| W|P| <- bit names
- * | TYPE (59-63) | ~OFFSET (9-58)  |0|0|X|X| X| X|F|SD|0| <- swp entry
+ * | TYPE (59-63) | ~OFFSET (9-58)  |0|0|X|X| X| E|F|SD|0| <- swp entry
  *
  * G (8) is aliased and used as a PROT_NONE indicator for
  * !present ptes.  We need to start storing swap entries above
@@ -203,6 +203,8 @@ static inline void native_pgd_clear(pgd_t *pgd)
  * F (2) in swp entry is used to record when a pagetable is
  * writeprotected by userfaultfd WP support.
  *
+ * E (3) in swp entry is used to rememeber PG_anon_exclusive.
+ *
  * Bit 7 in swp entry should be 0 because pmd_present checks not only P,
  * but also L and G.
  *
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 91ac10654570..70e360a2e5fb 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -163,4 +163,9 @@ extern unsigned int ptrs_per_p4d;
 
 #define PGD_KERNEL_START	((PAGE_SIZE / 2) / sizeof(pgd_t))
 
+/*
+ * We borrow bit 3 to remember PG_anon_exclusive.
+ */
+#define _PAGE_SWP_EXCLUSIVE	_PAGE_PWT
+
 #endif /* _ASM_X86_PGTABLE_64_DEFS_H */
-- 
2.35.1





-- 
Thanks,

David / dhildenb

