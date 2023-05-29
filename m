Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D18C77B7A
	for <linux-s390@archiver.kernel.org>; Mon, 29 May 2023 06:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjE2Gbe (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 29 May 2023 02:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjE2Gbd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 29 May 2023 02:31:33 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AD11AD
        for <linux-s390@vger.kernel.org>; Sun, 28 May 2023 23:31:01 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bad1ae90c2eso3893724276.2
        for <linux-s390@vger.kernel.org>; Sun, 28 May 2023 23:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685341829; x=1687933829;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aa5HWe45UW6rQUJiJNVLC4MPu6AngULI5k321Sbm9Ew=;
        b=UNKL1Q0Pec+L5oOba/99kxWNjcCwq8SenPXFdijAb/ObswMKjM7OUUmz2ZEICNHgFi
         Qv4ppRRcA3yebk/gcCjK1B/b31tItw1kcbI5MNnORL3Ys8OpaxJh/WEpZJ/SInbs7OtQ
         pID86tFe1+AG4qmsZJbOnM+7iKwXNWky09aARIe2tetg2zR8PTrceT/1TSWkarzFIet1
         8YIKNPCa18G6ke7Me2QA0b5ztYnbCNDIOf/BDmkOzEl5UNMMd2c3BAGItXCN3K8DkXAw
         E9u7Ntp2cVwujFtJI7hoKruoONwfQaLYMkiR2S/Hp/B93RwLn01nkmija5yTld6gsNK0
         YpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685341829; x=1687933829;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aa5HWe45UW6rQUJiJNVLC4MPu6AngULI5k321Sbm9Ew=;
        b=K0yESu+qvqW/HDBG89l1ud1H9lu6HyKYeMgV12Ra6Mm3Rt95FTGjNJYz7R066PDy1T
         zqRn6qleINJI4vJxT41APKMyxN4Q+EwOsTOv86LETi9naeMLuDp304r3gyK1kbpHvWQ9
         UMOePzFJ2FZ+CqWLKS+matTGVOwlcRTIYzlD5J1ohQqFCKjK8dtjihjWZBdDIwQFhlUM
         jYURcax4OWkADpmxsOjnEL3fpCiGQCKZdDIThW/ou2LAACmd3dNsmupw74WQB2rSD89R
         OtkEp1aCvAsQ37aXtMeKx7gFymCD5fKUli2bOHozfiAJa09gwBEg+HzmEjwRYvh05fR8
         LxOQ==
X-Gm-Message-State: AC+VfDyC2Iuvfc3xZals/qWSweb+7ehPIfIHkAPBX5zo4OkW159gmdOW
        6/D+JRf8treCzcw9mQpAOkdjbw==
X-Google-Smtp-Source: ACHHUZ6M1tOYR5IzxCkUxy+sUt0Djeqr4hN+mskEbw3iamyUciaGMEXp/45S6Zcf95QTtDJx+FPlXA==
X-Received: by 2002:a81:b40c:0:b0:544:9180:3104 with SMTP id h12-20020a81b40c000000b0054491803104mr11920044ywi.34.1685341828878;
        Sun, 28 May 2023 23:30:28 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a7-20020a818a07000000b00555c30ec361sm3363238ywg.143.2023.05.28.23.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 23:30:28 -0700 (PDT)
Date:   Sun, 28 May 2023 23:30:24 -0700 (PDT)
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
Subject: [PATCH 12/12] mm: delete mmap_write_trylock() and
 vma_try_start_write()
In-Reply-To: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
Message-ID: <c1cdf65f-74f5-7a2b-8918-2d48873d6814@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

mmap_write_trylock() and vma_try_start_write() were added just for
khugepaged, but now it has no use for them: delete.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/mm.h        | 17 -----------------
 include/linux/mmap_lock.h | 10 ----------
 2 files changed, 27 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3c2e56980853..9b24f8fbf899 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -690,21 +690,6 @@ static inline void vma_start_write(struct vm_area_struct *vma)
 	up_write(&vma->vm_lock->lock);
 }
 
-static inline bool vma_try_start_write(struct vm_area_struct *vma)
-{
-	int mm_lock_seq;
-
-	if (__is_vma_write_locked(vma, &mm_lock_seq))
-		return true;
-
-	if (!down_write_trylock(&vma->vm_lock->lock))
-		return false;
-
-	vma->vm_lock_seq = mm_lock_seq;
-	up_write(&vma->vm_lock->lock);
-	return true;
-}
-
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 {
 	int mm_lock_seq;
@@ -730,8 +715,6 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 		{ return false; }
 static inline void vma_end_read(struct vm_area_struct *vma) {}
 static inline void vma_start_write(struct vm_area_struct *vma) {}
-static inline bool vma_try_start_write(struct vm_area_struct *vma)
-		{ return true; }
 static inline void vma_assert_write_locked(struct vm_area_struct *vma) {}
 static inline void vma_mark_detached(struct vm_area_struct *vma,
 				     bool detached) {}
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index aab8f1b28d26..d1191f02c7fa 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -112,16 +112,6 @@ static inline int mmap_write_lock_killable(struct mm_struct *mm)
 	return ret;
 }
 
-static inline bool mmap_write_trylock(struct mm_struct *mm)
-{
-	bool ret;
-
-	__mmap_lock_trace_start_locking(mm, true);
-	ret = down_write_trylock(&mm->mmap_lock) != 0;
-	__mmap_lock_trace_acquire_returned(mm, true, ret);
-	return ret;
-}
-
 static inline void mmap_write_unlock(struct mm_struct *mm)
 {
 	__mmap_lock_trace_released(mm, true);
-- 
2.35.3

