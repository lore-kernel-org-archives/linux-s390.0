Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55207EB64DA
	for <linux-s390@archiver.kernel.org>; Wed, 12 Jul 2023 04:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjGLEdU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 12 Jul 2023 00:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjGLEdQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 12 Jul 2023 00:33:16 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A070E139
        for <linux-s390@vger.kernel.org>; Tue, 11 Jul 2023 21:33:14 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-bff89873d34so5778070276.2
        for <linux-s390@vger.kernel.org>; Tue, 11 Jul 2023 21:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689136394; x=1691728394;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QJ3N9RNUACQk0rp/xTQEOUK2bEy9LceuxJNDbuu7Hdo=;
        b=oKpaowvQeaQUncOOMCvTBHmXQ/FtZl+zZp5+Fo04CzoCy9LRKSCy43wNQCF2w2abHG
         jYi2GRVb9SUA+cOJwBdOtClSXiZ2Z7OrQDz8b0C3ZKWCpyBSxxh9g0MDPDTlwWm1wpni
         MQq6dZQMaat5mVW33VG/Z/sJCOzOtM5JcugYkrHF0OjaZarDla2EabzCECYeLkptPTFA
         kvVOAdnkA+dARAIwQYkZ5QFG5BKKdFwsILzvRn8L6hIPQtsvNfCEpljLsKMHiBJ7Tb9i
         vvB9S1uM8vmPWQ9MN4Bos/RgNtKXVdLVIPeeQrun3EY+oUKy7MowWj11CHLrlgzQNYzJ
         ikwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689136394; x=1691728394;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJ3N9RNUACQk0rp/xTQEOUK2bEy9LceuxJNDbuu7Hdo=;
        b=gczs1qjKTmqg1V6NxXieAl1wnFBrRksdQeEX7Tyjc5u2SP0QiY1pAhotEKk73wdtNK
         UBTV+tkiSObnGF4JcLVZlThxYywdzhcQntFDo4hXz7k61hGVEIfjj0L+MBpXln9+56bY
         1EhiCce8oQvD9ApmnWRFt0bsw9aG2PT7xvXotwPKVw6kZ+kdTJPPGtHOJ5vaig5g9Dyx
         mf4LOxjpivuBHjBJXJ+lt+xQX73tuxs+rayHjVLn4qa7UqkQpkVoSvWiHow4dU7gj4iJ
         osAhZ8o03/9A/6J7zP5Od3xAiGwyw2FAenbEGH97ddxi4ZlpUEIjDoQwhLraNBZBliJk
         4sJA==
X-Gm-Message-State: ABy/qLaVjLONu0PQTlT+INslXkuEU/5b3WRcPLixuZRwJL2cFraUK4Dx
        rhKLRFY5qX7QEvXvVmNRY/TnyA==
X-Google-Smtp-Source: APBJJlHtqAOgfTEvtz6FEYsO4J7wfUGe8UB05ARnUaznX7yxHAtr1BNRbw9aWEHw4YhpidgoA6BFwQ==
X-Received: by 2002:a5b:70d:0:b0:c01:308a:44f2 with SMTP id g13-20020a5b070d000000b00c01308a44f2mr13992957ybq.57.1689136393735;
        Tue, 11 Jul 2023 21:33:13 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b8-20020a252e48000000b00c61af359b15sm751502ybn.43.2023.07.11.21.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 21:33:13 -0700 (PDT)
Date:   Tue, 11 Jul 2023 21:33:08 -0700 (PDT)
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
Subject: [PATCH v3 03/13] arm: adjust_pte() use pte_offset_map_nolock()
In-Reply-To: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
Message-ID: <4d5258bd-ffa0-018-253a-25f2c9b783f7@google.com>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Instead of pte_lockptr(), use the recently added pte_offset_map_nolock()
in adjust_pte(): because it gives the not-locked ptl for precisely that
pte, which the caller can then safely lock; whereas pte_lockptr() is not
so tightly coupled, because it dereferences the pmd pointer again.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/arm/mm/fault-armv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index ca5302b0b7ee..7cb125497976 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -117,11 +117,10 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 	 * must use the nested version.  This also means we need to
 	 * open-code the spin-locking.
 	 */
-	pte = pte_offset_map(pmd, address);
+	pte = pte_offset_map_nolock(vma->vm_mm, pmd, address, &ptl);
 	if (!pte)
 		return 0;
 
-	ptl = pte_lockptr(vma->vm_mm, pmd);
 	do_pte_lock(ptl);
 
 	ret = do_adjust_pte(vma, address, pfn, pte);
-- 
2.35.3

