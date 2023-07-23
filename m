Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B617FC001B0
	for <linux-s390@archiver.kernel.org>; Sun, 23 Jul 2023 22:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjGWW3l (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 23 Jul 2023 18:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjGWW3k (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 23 Jul 2023 18:29:40 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20451B0
        for <linux-s390@vger.kernel.org>; Sun, 23 Jul 2023 15:29:38 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a44fae863fso2522706b6e.0
        for <linux-s390@vger.kernel.org>; Sun, 23 Jul 2023 15:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690151378; x=1690756178;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sNTpJwF6903WETZaUR6RqWiM1FUDiqrdqTK5pWkvOlI=;
        b=HldvRjk0ys92jdNfeVWBvFtU170B3Sgl14twuVgU3PfgDSaDoMcHUhPaz6AeMDu2ht
         Uif+LfgB6gTAkrapwLoFohouFxezysGIwMIbWr79XgdEZv9T4Ta9JcXZ/xBgIhza5Wp6
         fGeIcGxiljkQ3KbjHflb2DqW6Ps1SdtwHA/t4H1ct7WpWFLF6Bv/l70pxlcxn5R0BUKr
         Iazbm5RkEcD8IGB87s3PXGfBT5AeBhyzBinqvCJhTdPqY/jJZS+FqXmJovfCB0tAmiod
         IWq1u2IAT6X27nS6190Pq6YJ8Hg+nIaVyTtHCpJcN+Q3aXVeneJaex1eWhS9PdC4bSB8
         ACrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690151378; x=1690756178;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNTpJwF6903WETZaUR6RqWiM1FUDiqrdqTK5pWkvOlI=;
        b=DpXFK9XWeCcFoLyw4rhPw60WRHAD9vxfTJF/1wmkU26oceeAWXNmD6Kbnco/HjMluw
         noCKBpFtLInwao0ZkGhfA/HLi9j+kUBACgK5TYXcJrmNAs29aDvjQdTH5NAEKkLQak+x
         DzT+GIr7BSXQ+f6hKjEVyXBgidOy3lEZHK9yyPiGQY6KrpVPQbOLl1EO5dP4Gm4sYw4O
         N7NPP9TaUPdS/QGshMWQsY+Bs87b4d3JmCwxBmwHV1Zhk3w/U3kLwUqpNSkWSRa229o5
         cs8ikPApbWy1hDwN2QLd/QDfAiPtVHp7djPhV8PFz+oFglaUYRXcZl5u3y/kIrUFrakU
         voAg==
X-Gm-Message-State: ABy/qLbYG7LY4tMkBbQprD8cNjl5CH/yUk47L2p9dlpxHpC97PC9rgy2
        VEO2v/jMQxKBCye0vPx8kAyUag==
X-Google-Smtp-Source: APBJJlGCOgtzl5Q2J86M2vQtJN89EUt0E/aCdYP/U+IucyQfogqdSTRUg5XhtlxwoMDwEEOnXDkYbw==
X-Received: by 2002:a05:6808:1b2b:b0:3a4:31ee:da6a with SMTP id bx43-20020a0568081b2b00b003a431eeda6amr7828406oib.55.1690151378127;
        Sun, 23 Jul 2023 15:29:38 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o5-20020a05680803c500b003a41484b23dsm3509589oie.46.2023.07.23.15.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 15:29:37 -0700 (PDT)
Date:   Sun, 23 Jul 2023 15:29:32 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 07/13 fix] s390: add pte_free_defer() for pgtables sharing
 page: fix
In-Reply-To: <20230719162506.235856eb@p-imbrenda>
Message-ID: <3bc095ba-a180-ce3b-82b1-2bfc64612f3@google.com>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com> <94eccf5f-264c-8abe-4567-e77f4b4e14a@google.com> <20230719162506.235856eb@p-imbrenda>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Claudio finds warning on mm_has_pgste() more useful than on mm_alloc_pgste().

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/s390/mm/pgalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 760b4ace475e..d7374add7820 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -459,7 +459,7 @@ void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
 	 * page_table_free() does not do the pgste gmap_unlink() which
 	 * page_table_free_rcu() does: warn us if pgste ever reaches here.
 	 */
-	WARN_ON_ONCE(mm_alloc_pgste(mm));
+	WARN_ON_ONCE(mm_has_pgste(mm));
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-- 
2.35.3

