Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66243C7EE29
	for <linux-s390@archiver.kernel.org>; Mon, 29 May 2023 06:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjE2GTY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 29 May 2023 02:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjE2GTP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 29 May 2023 02:19:15 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304D3E69
        for <linux-s390@vger.kernel.org>; Sun, 28 May 2023 23:18:49 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-565ee3d14c2so13378337b3.2
        for <linux-s390@vger.kernel.org>; Sun, 28 May 2023 23:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685341128; x=1687933128;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7tbEFbFk5pzLjwVra+37SCseEW8dJexk2Np2YDtZH+c=;
        b=1iA4YfG+l9uCrVK/VfGes1VI6E6dNElNmfH0Ym6MNMAOfLc3iDqikpG9Fh1kd0GZyN
         S2vDJSr0c2W4FoH5DTwBlYn9D4ysTNQfO/tuIIGYNqiQ41PKjRspMrJoqD8nN+1AW+Ll
         ZG2b3ePp7JtiTJ6Eed3Cy8FX00RyB15yPBCU8A7XIPIx+RIeQ7MpGS9HzfE/9OdJpx+S
         pAKYTbnfjluypjHVFpFATeSkHhnhYcVPl6qM+K8dkTFH6eXbpsYJ5LutgoPOrieOlSV3
         oZuduBLXP+Ip6U8GW3EdevUfmC5f9cH9uaENaWd8adKsUbZ/byUTAk7/38rOHk1lVCDe
         TGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685341128; x=1687933128;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7tbEFbFk5pzLjwVra+37SCseEW8dJexk2Np2YDtZH+c=;
        b=X/15AnZ1uuB4lyUMKe6xi0lQXFS3Q704raqLpkp/MWNGF+zc5yFgbmrNReODXFhgu6
         JZ2LENYcRqhsQbdZf1rvLE10sWuxqxO4N1VLb29TSlp0RjutKQUwElH5odJ4tcErMqDn
         ajxWXYT4oB+DQzxt+vqD+Oy38rgPC0JF6UFiSF0OF71QHOo1BIYQAK8LY1sIpK832LGw
         PVDWLMctKh9diUVl4X25nKEnrIUoitw7HjHOQO++dTKtFb18W35aKe5yTCfLYSudZ/gX
         dLgh5H3RxsSeMHGQimqU2JLu+rbX3GF8BqBnD91REdigJziEZbWTOBuJLFdzj4HbIgPv
         iOaA==
X-Gm-Message-State: AC+VfDxMWeWx1BUGIrV2fJSdmQRgApXf5Qf1xAXTlmFh7wCx2V2GfPPg
        qAma1dOr6FXn4y01/YlHhXq69Q==
X-Google-Smtp-Source: ACHHUZ5wa1HnlGmpMM6V73fepd9odIlgE0K/gNhr4bUAPSedVjgsksTyRpOUN3YO0dkzYJPD3+qKCw==
X-Received: by 2002:a81:6b09:0:b0:561:c147:1d46 with SMTP id g9-20020a816b09000000b00561c1471d46mr12682711ywc.9.1685341127900;
        Sun, 28 May 2023 23:18:47 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m19-20020a819e13000000b00560c648ef1esm3382356ywj.72.2023.05.28.23.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 23:18:47 -0700 (PDT)
Date:   Sun, 28 May 2023 23:18:43 -0700 (PDT)
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
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 04/12] powerpc: assert_pte_locked() use
 pte_offset_map_nolock()
In-Reply-To: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
Message-ID: <e51ac0fd-4f96-4728-925-bc54f09ec013@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Instead of pte_lockptr(), use the recently added pte_offset_map_nolock()
in assert_pte_locked().  BUG if pte_offset_map_nolock() fails: this is
stricter than the previous implementation, which skipped when pmd_none()
(with a comment on khugepaged collapse transitions): but wouldn't we want
to know, if an assert_pte_locked() caller can be racing such transitions?

This mod might cause new crashes: which either expose my ignorance, or
indicate issues to be fixed, or limit the usage of assert_pte_locked().

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/powerpc/mm/pgtable.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index cb2dcdb18f8e..16b061af86d7 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -311,6 +311,8 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
+	pte_t *pte;
+	spinlock_t *ptl;
 
 	if (mm == &init_mm)
 		return;
@@ -321,16 +323,10 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 	pud = pud_offset(p4d, addr);
 	BUG_ON(pud_none(*pud));
 	pmd = pmd_offset(pud, addr);
-	/*
-	 * khugepaged to collapse normal pages to hugepage, first set
-	 * pmd to none to force page fault/gup to take mmap_lock. After
-	 * pmd is set to none, we do a pte_clear which does this assertion
-	 * so if we find pmd none, return.
-	 */
-	if (pmd_none(*pmd))
-		return;
-	BUG_ON(!pmd_present(*pmd));
-	assert_spin_locked(pte_lockptr(mm, pmd));
+	pte = pte_offset_map_nolock(mm, pmd, addr, &ptl);
+	BUG_ON(!pte);
+	assert_spin_locked(ptl);
+	pte_unmap(pte);
 }
 #endif /* CONFIG_DEBUG_VM */
 
-- 
2.35.3

