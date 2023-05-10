Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30467C77B7C
	for <linux-s390@archiver.kernel.org>; Wed, 10 May 2023 05:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbjEJFAF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 May 2023 01:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbjEJFAE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 May 2023 01:00:04 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BE11FE8
        for <linux-s390@vger.kernel.org>; Tue,  9 May 2023 22:00:02 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-ba1911d60f5so10147465276.2
        for <linux-s390@vger.kernel.org>; Tue, 09 May 2023 22:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683694801; x=1686286801;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMaWjOOzBzTq25y2V3ItGl/gYmS8RRtg1cvEbj+mQng=;
        b=v/0fedI97pPSEeG4JjmhWFM2zERS146SPiMJXKFktyRt8gcu3XnU9flpdOBzk+uwM5
         s0LxqY4B95aIsZsh2mJFZGGaGczJQ5vlt2ZTVgohuP0YCEpkq6BqvaluTpoYqvCHZPxl
         zKN6HOjwjx0yrNqF5dlqaMyYDGE2Vrd5Uv3cHsjFUAt+EAmeWDDRNYI0YlpbNo86b8bG
         Aipz8AqM9zEa9JBFP7+dKHJaNOyMjOSxB2cpapkuH6PjkheDE/u4eOtK4ivf5fV5d230
         xxAVZ1lBfR2A1vI9J151/+XOuCwLBzeq8s5a10eXtHtu5Hbfr7aLXi+072D/bPReNYVX
         IS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683694801; x=1686286801;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMaWjOOzBzTq25y2V3ItGl/gYmS8RRtg1cvEbj+mQng=;
        b=HDyihHgDS7dqDheb5x7D+hBICroDkrG81sb/Dc+IVpv0jxg5VVBGdzeeHEaaXQAgeU
         b40zP7khiahIIXify/8cDP9S4vohnQ+lMHt/OQmuU2RVqaacDYPPk44o2Vz4fUTn1imq
         firI7B2sU5psMfPEiAorzLbWXfmsnyl2k9tyf37QsRsNe4tUFTiHFvgLe7BZ8ym8PT6z
         JoeAlCP81n9DwJht8/UfjVVZIVsadLevc3Wkz01VRiNCN6cCwPpt+h7VH8pCwR6bDJTo
         gFEdTC6oqrQuqVCzE3/gsNVIA7N8x8xip2SEpS+13UT/Cp4fgLEXFnd0DdcPkHKgWDDE
         8laQ==
X-Gm-Message-State: AC+VfDwgIxRWO5EgdmiqiOzRk+Lv4Qtz6H4nU/lFOCxmrCA2RUxThFpw
        XhdWh4K20yWlxi+PmicBLEOAlQ==
X-Google-Smtp-Source: ACHHUZ52JqpHXNjwopV1qONCz4ZhxlIYDhhrgvgpvQjGO/cy7NhTIg/35E50jddhJVH/CVSemNKwJA==
X-Received: by 2002:a25:a1c8:0:b0:b9d:9500:9d29 with SMTP id a66-20020a25a1c8000000b00b9d95009d29mr17308461ybi.45.1683694801383;
        Tue, 09 May 2023 22:00:01 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b4-20020a256704000000b00ba2da98431fsm1603597ybc.56.2023.05.09.21.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 22:00:01 -0700 (PDT)
Date:   Tue, 9 May 2023 21:59:57 -0700 (PDT)
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
Subject: [PATCH 14/23] riscv/hugetlb: pte_alloc_huge() pte_offset_huge()
In-Reply-To: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
Message-ID: <d1e54510-9ea2-edf-3851-fa7635ce1e5e@google.com>
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
 arch/riscv/mm/hugetlbpage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index a163a3e0f0d4..80926946759f 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -43,7 +43,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 
 	for_each_napot_order(order) {
 		if (napot_cont_size(order) == sz) {
-			pte = pte_alloc_map(mm, pmd, addr & napot_cont_mask(order));
+			pte = pte_alloc_huge(mm, pmd, addr & napot_cont_mask(order));
 			break;
 		}
 	}
@@ -90,7 +90,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 
 	for_each_napot_order(order) {
 		if (napot_cont_size(order) == sz) {
-			pte = pte_offset_kernel(pmd, addr & napot_cont_mask(order));
+			pte = pte_offset_huge(pmd, addr & napot_cont_mask(order));
 			break;
 		}
 	}
-- 
2.35.3

