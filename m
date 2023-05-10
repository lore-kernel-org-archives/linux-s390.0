Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8ECC77B7C
	for <linux-s390@archiver.kernel.org>; Wed, 10 May 2023 05:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbjEJFLL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 May 2023 01:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjEJFLJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 May 2023 01:11:09 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B224ED3
        for <linux-s390@vger.kernel.org>; Tue,  9 May 2023 22:11:08 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-55c939fb24dso62575607b3.2
        for <linux-s390@vger.kernel.org>; Tue, 09 May 2023 22:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683695467; x=1686287467;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5t5YV0zKgmgEyAUPKTSjojlBVWu7n9Z5EbrT7MCf/bI=;
        b=2vB4gHPvdrYwpepEfO1nF7s17T93hgvovaDeIEtq/j7tZEKBAX6MfSFdULN3s1RrSv
         XbcEaHE4RfnjNOR2bGTDUPbkUVKLAEh7Z60FKXcJrN5AB5F5sDrBlIYfucGi5YFq3CRE
         x2J76JMa1KrQtFzkek9dhFVhgpBZ4hkaFn0t/tEhn6Lp6XTc2qq6OFMsvbIv1u0qf83/
         DuPOrKKE39rYYW8ERQAhpQjY3kAUjmEo/2XpafFM5jSnKHS+15Ix6XCgfH0XnW/sjbs8
         PlPBuW0lMaTsO4yfeYWj+it6wzwQ+thFBn+MFXcJGic5E+ghFwv9VEoF4ainQyun9oWL
         kbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683695467; x=1686287467;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5t5YV0zKgmgEyAUPKTSjojlBVWu7n9Z5EbrT7MCf/bI=;
        b=kmR0sizmO6BEf2LijWKwVba/nf6f+h2Wn36Wtt9d7hpOoikblrkCEGe2CY0OldgvTe
         2n9sCSkzXy9pk3cfocQWKYBblNdzXgb568sSJu6+tEZE/0VhJu4iVaVfCdcwVO7LkR/9
         dI/D0bEZ8IAlFxbcRtxrHFmNh80cNut3igKe7xnAPdI+A+8pmTFbQpI80T/2KJvf+wTP
         qUs1XqOMzf+8B6VvT/2rULvPumHfVrVcURhIFddqAA562m4ujYguXXUL9PVONdEmU3V1
         59ORCNPTdFFdnfjFJkS+eGibxODSCqDOtmYAvgwo4hzhpexXx5HZneIkp8+4TcyJi36V
         WVrA==
X-Gm-Message-State: AC+VfDyId+RZt9/PqexO1YQ0RAbrV4S7Bm3UgbmUAjeuTig7Am4n/jLd
        G5Oj87M8m3ibzvUmOJcoTRKjoQ==
X-Google-Smtp-Source: ACHHUZ5S12uJTV3RgA8xdSJdxWq0jDZ0XleloV6/dK1s9NkYAdupH7Dq2nQz0anegdxAtAS1U2ZfRQ==
X-Received: by 2002:a0d:d4c3:0:b0:55a:9d84:2e4e with SMTP id w186-20020a0dd4c3000000b0055a9d842e4emr17689769ywd.18.1683695467357;
        Tue, 09 May 2023 22:11:07 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l65-20020a0dfb44000000b005461671a79csm978797ywf.138.2023.05.09.22.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 22:11:07 -0700 (PDT)
Date:   Tue, 9 May 2023 22:11:03 -0700 (PDT)
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
Subject: [PATCH 23/23] xtensa: add pte_unmap() to balance pte_offset_map()
In-Reply-To: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
Message-ID: <ff6b25c6-f537-6b5c-8743-c9fc2bd81f91@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

To keep balance in future, remember to pte_unmap() after a successful
pte_offset_map().  And (might as well) pretend that get_pte_for_vaddr()
really needed a map there, to read the pteval before "unmapping".

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/xtensa/mm/tlb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/mm/tlb.c b/arch/xtensa/mm/tlb.c
index 27a477dae232..0a11fc5f185b 100644
--- a/arch/xtensa/mm/tlb.c
+++ b/arch/xtensa/mm/tlb.c
@@ -179,6 +179,7 @@ static unsigned get_pte_for_vaddr(unsigned vaddr)
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	unsigned int pteval;
 
 	if (!mm)
 		mm = task->active_mm;
@@ -197,7 +198,9 @@ static unsigned get_pte_for_vaddr(unsigned vaddr)
 	pte = pte_offset_map(pmd, vaddr);
 	if (!pte)
 		return 0;
-	return pte_val(*pte);
+	pteval = pte_val(*pte);
+	pte_unmap(pte);
+	return pteval;
 }
 
 enum {
-- 
2.35.3

