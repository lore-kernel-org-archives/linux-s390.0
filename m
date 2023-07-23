Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAFAC001B0
	for <linux-s390@archiver.kernel.org>; Sun, 23 Jul 2023 22:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjGWW0R (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 23 Jul 2023 18:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGWW0R (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 23 Jul 2023 18:26:17 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B7E1B0
        for <linux-s390@vger.kernel.org>; Sun, 23 Jul 2023 15:26:15 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-57a551ce7e9so46941077b3.3
        for <linux-s390@vger.kernel.org>; Sun, 23 Jul 2023 15:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690151175; x=1690755975;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xrAdJXY/DYoZ1QqZrxUyGx5Ypm1XnUOGUxRagKc/Az8=;
        b=iVLb6pAcMPMbH+sKIFDKrp13WE2BH14wgf0sfLLhG3EUD8G/hlzddsk9BjOLwwBDek
         i4tMCHQWviMOQirYDf83bTCcJPZWFHJR7xkFk3VHd5hC7xG8MCrz4NcetF3qgqDqKUnu
         xAsV+Rie6eGsL074ig7H7XBphUKKdrVVeh2TIH148CpPb1+P0n1+X7jZdveWNOjVJ6Ba
         Kp6B7SozJs02j+R5YidTAfbP/CCuxGe3VqDtLCHCvJZKMpIS4f/D4qj/sIim49FJ+8/T
         kdqRCusHGpxIPd559J2JIVCjJWnkF/KB5ylzgPVROKPwcB7Y5HxAlrSuCa01u6hWj0LC
         1Twg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690151175; x=1690755975;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xrAdJXY/DYoZ1QqZrxUyGx5Ypm1XnUOGUxRagKc/Az8=;
        b=OYFEhryF4l5od84BgLlX0cARJSsR82nfkwPae9Mp1kQNER2InznFpCTw00lWulnQkj
         bPMkIvWCZopjQPgtKij1qPHbrD4EsfNJMyt+pcQhAe1gcf4UIuXLHCGc3A7LHMARysKC
         JwsglfuG0GIm56xeTkvZqDv5NsSnOlL/ThMtxObYDA/OBvGPPPP4SeOebgSxHI2djvO8
         VXLGpsLibjRJaCI5tzdOuIrhSkgTns98Bg+jgBg1CZQI/4WxVNmRnlUrF1l+5iPfgtRB
         bKP0BBXfQ3DxTQ9A+nhA7XdDDqPppGTiOzrKnwu0aHLQE3RmnlIntY6J7ZmubYeKNyc0
         bAEg==
X-Gm-Message-State: ABy/qLZzcFz/EUdMFFnclFGsb4wx0+8YHeQ5AhIYLN2Fn6bTBfGlpxWk
        CveHg7Zns+HPVTlELVl5D5BAow==
X-Google-Smtp-Source: APBJJlG9iREnJulltCfWnEIqWXVGbxKFPc9M2vviU+KVFolzwpucWCLcuiZJ3CMHwTth2+2e2Ovuug==
X-Received: by 2002:a81:7d88:0:b0:583:9018:6fbb with SMTP id y130-20020a817d88000000b0058390186fbbmr5157782ywc.37.1690151174666;
        Sun, 23 Jul 2023 15:26:14 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n124-20020a817282000000b00573898fb12bsm78328ywc.82.2023.07.23.15.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 15:26:13 -0700 (PDT)
Date:   Sun, 23 Jul 2023 15:26:02 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Jay Patel <jaypatel@linux.ibm.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>,
        sparclinux@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Will Deacon <will@kernel.org>, linux-s390@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Ira Weiny <ira.weiny@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Steven Price <steven.price@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-arm-kernel@lists.infradead.org, Zi Yan <ziy@nvidia.com>,
        Huang Ying <ying.huang@intel.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Ralph Camp bell <rcampbell@nvidia.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Jann Horn <jannh@google.com>, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Zack Rusin <zackr@vmware.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 04/13 fix] powerpc: assert_pte_locked() use pte_offset_map_nolock():
 fix
In-Reply-To: <20230721131341.w5abuxcbohofpzwa@patel>
Message-ID: <c73d1543-532c-3da2-8cf2-a95363a14116@google.com>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com> <e8d56c95-c132-a82e-5f5f-7bb1b738b057@google.com> <87msztbiy8.fsf@linux.ibm.com> <392f311f-83ac-a5a2-d16e-2c7736d1b577@google.com> <6762c880-6d2b-233f-6786-7ad5b0472dc7@linux.ibm.com>
 <20230721131341.w5abuxcbohofpzwa@patel>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Aneesh points out that assert_pte_locked() still needs the pmd_none()
check, to stop crashing in khugepaged: restore that comment and check.

Andrew, when merging with original commit, please edit its 1st para to:

Instead of pte_lockptr(), use the recently added pte_offset_map_nolock()
in assert_pte_locked().  BUG if pte_offset_map_nolock() fails.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/powerpc/mm/pgtable.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 16b061af86d7..a3dcdb2d5b4b 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -323,6 +323,14 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 	pud = pud_offset(p4d, addr);
 	BUG_ON(pud_none(*pud));
 	pmd = pmd_offset(pud, addr);
+	/*
+	 * khugepaged to collapse normal pages to hugepage, first set
+	 * pmd to none to force page fault/gup to take mmap_lock. After
+	 * pmd is set to none, we do a pte_clear which does this assertion
+	 * so if we find pmd none, return.
+	 */
+	if (pmd_none(*pmd))
+		return;
 	pte = pte_offset_map_nolock(mm, pmd, addr, &ptl);
 	BUG_ON(!pte);
 	assert_spin_locked(ptl);
-- 
2.35.3

