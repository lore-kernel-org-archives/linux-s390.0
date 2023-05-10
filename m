Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD77C7EE25
	for <linux-s390@archiver.kernel.org>; Wed, 10 May 2023 04:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbjEJE64 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 May 2023 00:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbjEJE6z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 May 2023 00:58:55 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8151BF7
        for <linux-s390@vger.kernel.org>; Tue,  9 May 2023 21:58:53 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-55a10577911so98140157b3.0
        for <linux-s390@vger.kernel.org>; Tue, 09 May 2023 21:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683694732; x=1686286732;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i7vs80eeAHoowuGiB3IXr1R0pQ52ZVhylKFRPge1iSc=;
        b=P9kK3Ha7kM6a70P/N9uB2lWXrssqQgUHBWNV/ZpJwPmg2mPzx8gUi6+Y5U3HPMDHz9
         0fAlFOi/bTART9baPPENUGYRX+MazYzuiDcAIMOosxi9lXkJsm3mNsaLjOWtnLwgcry5
         sP0r/lFyFBNCqz3voFtKwARlNZyj767HfljqLFdQYp3UaORt42cJzHdk0VN4kJ5NQH/7
         DWlXvI97puE4OaBtmUgMd/qH5Lin+XJ2aRjT13gN8vWtWVfPYNVNo8e918/mLGqALa1y
         O7U3+kDK92dAzqxBb57AmVgMsRrk/0cmMw+aKo8waotZHzpB3mgtMwAgWyIj42FB5uoU
         5erQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683694732; x=1686286732;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7vs80eeAHoowuGiB3IXr1R0pQ52ZVhylKFRPge1iSc=;
        b=Y7XmOdr+rwCZObbqQgYQW1zVlEdNI7bCMAZj+vsm2N5kNgZunlqFZMuQd4Xi57rAic
         urs/+VujgrelmZffIfRdG7cc7Fq64pUwIwOQMuEnlucEWWFI9Q73g0Oe8yFkf304akt8
         jyvka19Mjknk1A1jsyofOZ8NDuhhlaptFi2U202ktck/MEmLeMDQ3bomMf3s2aTlcbRv
         tgfxZNzL54SsO4L5nxWXSvZftI1shkN0ht2WQX0pfMD96cKtQjB4ky5ht6wzt0gFU3k6
         AlBLX0/ZHFKY5X7Rq/VZF1oYHg5tLvtnfRKk7BWGHrzQrcXCxdZ4BZl2uslpz+nfdbcK
         9Yag==
X-Gm-Message-State: AC+VfDwglyaC/6gFJ1IhUCEntCXAHD9bZ5hFuOdn12utq+bzR8u74wpD
        ts+n0mzq3uLI9x8Bvzq4VIx9Tw==
X-Google-Smtp-Source: ACHHUZ6HrZAnm+aaG2sOhULY3F7mb+ht2GRzSsBKsJ/KT5tYwkiRpQQy7lJKEHctJdijcfVx9gaq3w==
X-Received: by 2002:a25:d352:0:b0:ba2:16b6:b11e with SMTP id e79-20020a25d352000000b00ba216b6b11emr16144172ybf.0.1683694732647;
        Tue, 09 May 2023 21:58:52 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h66-20020a252145000000b00b9550fcb12fsm3461906ybh.64.2023.05.09.21.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 21:58:52 -0700 (PDT)
Date:   Tue, 9 May 2023 21:58:48 -0700 (PDT)
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
Subject: [PATCH 13/23] powerpc/hugetlb: pte_alloc_huge()
In-Reply-To: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
Message-ID: <1a3ee4d4-a829-35d4-d94e-885d5d4d6a8a@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

pte_alloc_map() expects to be followed by pte_unmap(), but hugetlb omits
that: to keep balance in future, use the recently added pte_alloc_huge()
instead.  huge_pte_offset() is using __find_linux_pte(), which is using
pte_offset_kernel() - don't rename that to _huge, it's more complicated.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/powerpc/mm/hugetlbpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index b900933507da..f7c683b672c1 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -183,7 +183,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 		return NULL;
 
 	if (IS_ENABLED(CONFIG_PPC_8xx) && pshift < PMD_SHIFT)
-		return pte_alloc_map(mm, (pmd_t *)hpdp, addr);
+		return pte_alloc_huge(mm, (pmd_t *)hpdp, addr);
 
 	BUG_ON(!hugepd_none(*hpdp) && !hugepd_ok(*hpdp));
 
-- 
2.35.3

