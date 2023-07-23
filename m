Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06804C001B0
	for <linux-s390@archiver.kernel.org>; Sun, 23 Jul 2023 22:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjGWWck (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 23 Jul 2023 18:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGWWcj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 23 Jul 2023 18:32:39 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628171B7
        for <linux-s390@vger.kernel.org>; Sun, 23 Jul 2023 15:32:35 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5768a7e3adbso71437067b3.0
        for <linux-s390@vger.kernel.org>; Sun, 23 Jul 2023 15:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690151554; x=1690756354;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6mJ5yjUa61OKtsotomDyQc7p3NQ997kyi3UbHr9vQck=;
        b=6TW6tzdCv/zJZetW3at30hfzlMddap7Z7fj+GldyzIgigr6T/xHW6mjhCM4pvSj3Q5
         h5TyPuiLMyS54ezUO7aFMsJB86VYDD1vKE694/gkNGbdnL9iY77JcmkcNUGvyjawJaIq
         BjAE9MN2ZbLEq/LNBLIFuF2Ek09JgxgKNG9cXLscgacxJQ5lJbuWKmjJuALrca8xMAt3
         5DroplM2hCTuaQrXESdTEpiFCx+/8R7A51nPLTYCGWcc5xPkH47MNRHi+ctmstGgrSf9
         eVsau7CwzmMa2SBw+NS5ElWiu1xHP1FxRVmTB4ePG0Chh3dV63YJC00zhVrRRqL4zgXj
         HBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690151554; x=1690756354;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mJ5yjUa61OKtsotomDyQc7p3NQ997kyi3UbHr9vQck=;
        b=dRw2csgBJn/tRw6ADDiX51/lElrfVMBAUyIxoNObK1fmBbPPlCOFjhurDwUonFPA6N
         qDQyE5UbGDhoux+vv98QGbo3sd1fiZuaaLhazILraAmx2yUutXqggtsJbzRaWIsaY18+
         VHQk7MvV7nrv5O8+BxWdDV1Vva0z32ev8YaXJjEUA1UYfrdi6kjhKQDQlVsAJKDKPSnC
         yBOOFW3C8zTpCz8c04eaNWmgZHF7++2paEdBI/3yB8xcoWF0SkGhXIUuWSUYZWbUEyu7
         uPpoEyWHJAQfjYUilQ4zejngH5IPOi8c/tMCOBg3E+jBTk6xl9KkQepXUhd4YO/SOx81
         bvIg==
X-Gm-Message-State: ABy/qLa2oRJPLv36K9pkgeiGNatJHEr9LCVC3TbdeRlaC/Uw//lITFcW
        5Zmhut/3Ok43s/GuYC9iKx3M4A==
X-Google-Smtp-Source: APBJJlHufBlazAq/Jg+6fKB/G5aofMpIvebr8HbzAqYoBP3QAOOO5H84n4F6vZlA+flxU3ygHkBQcw==
X-Received: by 2002:a0d:e211:0:b0:583:4064:a35f with SMTP id l17-20020a0de211000000b005834064a35fmr4569918ywe.23.1690151554487;
        Sun, 23 Jul 2023 15:32:34 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n189-20020a8172c6000000b005771bb5a25dsm2391276ywc.61.2023.07.23.15.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 15:32:34 -0700 (PDT)
Date:   Sun, 23 Jul 2023 15:32:27 -0700 (PDT)
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
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
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
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 10/13 fix] mm/khugepaged: collapse_pte_mapped_thp() with
 mmap_read_lock(): fix
In-Reply-To: <b53be6a4-7715-51f9-aad-f1347dcb7c4@google.com>
Message-ID: <d3d9ff14-ef8-8f84-e160-bfa1f5794275@google.com>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com> <b53be6a4-7715-51f9-aad-f1347dcb7c4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

madvise_collapse() setting "mmap_locked = true" after calling
collapse_pte_mapped_thp() looked good but was wrong.  If the loop then
moves on to the next extent, mmap_locked assures it that "vma" has been
revalidated under mmap_lock, which was not the case: and led to UAFs,
crashes in __fput() or task_work_run(), even collapse_file()'s
VM_BUG_ON(start & (HPAGE_PMD_NR - 1)) - all detected by syzbot.

(collapse_pte_mapped_thp() does validate the vma that it works on:
but it's not passed in as an argument, collapse_pte_mapped_thp() finds
the vma for mm and addr by itself - which may by this time have changed
from the vma saved in madvise_collapse().)

Reported-by: syzbot+fe7b1487405295d29268@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/000000000000f9de430600ae05db@google.com/
Reported-by: syzbot+173cc8cfdfbbef6dd755@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/000000000000e4b0f0060123ca40@google.com/
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6bad69c0e4bd..1c773db26e88 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2747,7 +2747,7 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
 			BUG_ON(*prev);
 			mmap_read_lock(mm);
 			result = collapse_pte_mapped_thp(mm, addr, true);
-			mmap_locked = true;
+			mmap_read_unlock(mm);
 			goto handle_result;
 		/* Whitelisted set of results where continuing OK */
 		case SCAN_PMD_NULL:
-- 
2.35.3

