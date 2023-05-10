Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF41DC7EE24
	for <linux-s390@archiver.kernel.org>; Wed, 10 May 2023 05:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjEJFHU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 May 2023 01:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbjEJFHT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 May 2023 01:07:19 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4D14EEE
        for <linux-s390@vger.kernel.org>; Tue,  9 May 2023 22:07:16 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-ba1815e12efso5848680276.3
        for <linux-s390@vger.kernel.org>; Tue, 09 May 2023 22:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683695235; x=1686287235;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tza8VZpBdDATlz3Dj70XvbHnC1ZhEpBq1MlG3gUrqGw=;
        b=S6w9KIHhVJNT1kfpH+CUQlKS0lqLbNW2sjOBWirezocHkXz48EoJrIXM28PJV5vm9/
         2IKW7KEx40R4sNFdhRCA79Q4DhbKDdFLB3FgyR3tFeJ93PW/6Nj70i7kVvMQyXQV/Eg6
         g+52YfmHhke7+sazfpIRwUSNXlxrgB0TXY5awNjnSJrSmQkBkwlsZpKuYTtxmU5X5rbM
         qMqKwQoK0rcCOG5LK7I/q4x4RfW+gqW8hxUEuUs6WrZ6huYWyzA0eBrWurtLVkyq8+rs
         BH6Tq3wNedbL7gmT0QCOruJR/a85R9e5ddGQi0eR0moWYsK+a+xYsl7ixIrgRtJQdod3
         eejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683695235; x=1686287235;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tza8VZpBdDATlz3Dj70XvbHnC1ZhEpBq1MlG3gUrqGw=;
        b=UVDXmwHnTjuskI3tnjR1W8Z0aHt7M/14tYzVxw+MWFB19zPKiZHK9PuZUlYLdXAWBJ
         t+wFPPyh/IcWwNt04mqoKGYJuFTNaGpH5Ud94DKz8gwhi75L01eBwZj2dx5A3Gb8PIGW
         svsBQdmLE7opaTLhQj7UcA0Jmk2+0cQONVQRbd4rTBjaRaKLDs1+ns9fBtsI594CtKbF
         LJtX2w4fJFw2WSqWgcA1Ko6uQ+JRaPdxZVbp7dKA+N66wLym7AXmK3EcOzam6R12v91A
         J60Bn+fH0oElncqyfhT26GPPNaiOINsv2Cl7pmA/IlUZdfDTBD99fKgziuuG/R59SdeR
         Lxug==
X-Gm-Message-State: AC+VfDyoJXIyHcSb5lsIfjjwJDt+YomAqMTyWpMID2i8g1n/gGqAIIFN
        8Y+uLYNFJbeko3U69Yhlsya7hA==
X-Google-Smtp-Source: ACHHUZ7O+RQwO6EUyGZuwP0aiZ///c7pXxA4KLKL9a6yKbaYGakuuwEnBLT515Jc9UpNtzb0LrlfGg==
X-Received: by 2002:a25:6c4:0:b0:ba2:6aea:2ba with SMTP id 187-20020a2506c4000000b00ba26aea02bamr10201500ybg.23.1683695235431;
        Tue, 09 May 2023 22:07:15 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k142-20020a252494000000b00b8bcaf1e660sm3553476ybk.4.2023.05.09.22.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 22:07:15 -0700 (PDT)
Date:   Tue, 9 May 2023 22:07:11 -0700 (PDT)
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
Subject: [PATCH 20/23] sparc: iounit and iommu use pte_offset_kernel()
In-Reply-To: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
Message-ID: <43c7b4b1-3719-93de-dc3e-33625fa2ad@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

iounit_alloc() and sbus_iommu_alloc() are working from pmd_off_k(),
so should use pte_offset_kernel() instead of pte_offset_map(), to avoid
the question of whether a pte_unmap() will be needed to balance.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/sparc/mm/io-unit.c | 2 +-
 arch/sparc/mm/iommu.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index bf3e6d2fe5d9..133dd42570d6 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -244,7 +244,7 @@ static void *iounit_alloc(struct device *dev, size_t len,
 			long i;
 
 			pmdp = pmd_off_k(addr);
-			ptep = pte_offset_map(pmdp, addr);
+			ptep = pte_offset_kernel(pmdp, addr);
 
 			set_pte(ptep, mk_pte(virt_to_page(page), dvma_prot));
 
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 9e3f6933ca13..3a6caef68348 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -358,7 +358,7 @@ static void *sbus_iommu_alloc(struct device *dev, size_t len,
 				__flush_page_to_ram(page);
 
 			pmdp = pmd_off_k(addr);
-			ptep = pte_offset_map(pmdp, addr);
+			ptep = pte_offset_kernel(pmdp, addr);
 
 			set_pte(ptep, mk_pte(virt_to_page(page), dvma_prot));
 		}
-- 
2.35.3

