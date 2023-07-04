Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC08DEB64D9
	for <linux-s390@archiver.kernel.org>; Tue,  4 Jul 2023 16:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjGDQDp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 4 Jul 2023 12:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjGDQDo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Jul 2023 12:03:44 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545EAE49
        for <linux-s390@vger.kernel.org>; Tue,  4 Jul 2023 09:03:43 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-577412111f0so59442367b3.0
        for <linux-s390@vger.kernel.org>; Tue, 04 Jul 2023 09:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688486622; x=1691078622;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ThWaRfiQI9Y2zPB0jOGll+3lvvzwKEYuVB5/fEadW24=;
        b=1G5ZKRpQvMi6W+jmE8ub5dJeJlxbYBL30Dld2sGE0jGIh4pBJkparpgbY6X3koq/jZ
         9g+w0TuaYGHZl27XCXZmG+7CPzvq555V/M1u4Q1o6K8x8Ny1PLqYZEoRKCUHyb+Y70dI
         uBRHmI/rt4y3gkCQlfmPG1mrv6Vp0NRaNPnW3xuq6LBs3vpTAK9mFbzVtQjSJdhDF3gn
         OJOlc2lgtywf5qtUGf5eClnJ/DlUSgDiVgxe4+xMH66lLR9gKhagSbS7FM4N2TW1Ak9a
         q7fzTwEYYTKo4YcVc/r5tuNaJO9KBQwhVG9584Mvf2RQ2kUyvk+4ApeeGd9aS7kq6QuH
         tlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688486622; x=1691078622;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ThWaRfiQI9Y2zPB0jOGll+3lvvzwKEYuVB5/fEadW24=;
        b=EYQesNo3n9hYTr1Ow3LLQzQZ8tzs/icVDRyskPAYbKdA01fvmhxFimodRsobZxdEYp
         iUzkcR31IoPf6Ois/XfZixG7msawxTHy9cgQuqvNS6B8D6OxmzrT3JmQv/I3x6+X8Q9Y
         n10LAskqpAgne1du23lKhq9RT8+HaPUZ29vHH8KBFNhu2DTuDOfu9n8R0JOmbCKxIrpc
         xGhkBKg5+QMK7XWXfn3Khd061apvxJdihEK2vuh6ki39QWo0mHSpG7nF5Uuwe9v69dPh
         s/woNueDuVFUVbDEsbVmifwWuoJBEpgmaXKqyBtKRWfxri+Zy7jsEdrYKD624IDyf96Q
         g9rA==
X-Gm-Message-State: ABy/qLZy583n0020+Gkrf88jUezWtYb6Crq4j5uORPIyNcZsfXbDdRJY
        VP4R0GP8J8v3taBmPobQJvIy+A==
X-Google-Smtp-Source: APBJJlFQKEt+GJy0q7ZaawYolC37LR4/HdrndIBCrzGqd8RmTfZQfh9o4zEhy6GGc4uBo5NvU6StNw==
X-Received: by 2002:a25:2307:0:b0:c16:8d80:227d with SMTP id j7-20020a252307000000b00c168d80227dmr13176783ybj.65.1688486622226;
        Tue, 04 Jul 2023 09:03:42 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v11-20020a25848b000000b00bf3438d6301sm4519026ybk.0.2023.07.04.09.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:03:41 -0700 (PDT)
Date:   Tue, 4 Jul 2023 09:03:29 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Alexander Gordeev <agordeev@linux.ibm.com>
cc:     Hugh Dickins <hughd@google.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
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
        Zack Rusin <zackr@vmware.com>,
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
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 07/12] s390: add pte_free_defer() for pgtables sharing
 page
In-Reply-To: <ZKQhW2aHJHsnkJhv@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Message-ID: <c8aeb847-3d91-b5e5-48d1-20d411b58574@google.com>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com> <a722dbec-bd9e-1213-1edd-53cd547aa4f@google.com> <20230628211624.531cdc58@thinkpad-T15> <cd7c2851-1440-7220-6c53-16b343b1474@google.com> <ZJ2hsM5Tn+yUZ5ZV@ziepe.ca> <20230629175645.7654d0a8@thinkpad-T15>
 <edaa96f-80c1-1252-acbb-71c4f045b035@google.com> <7bef5695-fa4a-7215-7e9d-d4a83161c7ab@google.com> <ZKQhW2aHJHsnkJhv@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 4 Jul 2023, Alexander Gordeev wrote:
> On Sat, Jul 01, 2023 at 09:32:38PM -0700, Hugh Dickins wrote:
> > On Thu, 29 Jun 2023, Hugh Dickins wrote:
> 
> Hi Hugh,
> 
> ...
> > No, not quite the same rules as before: I came to realize that using
> > list_add_tail() for the HH pages would be liable to put a page on the
> > list which forever blocked reuse of PP list_add_tail() pages after it
> > (could be solved by a list_move() somewhere, but we have agreed to
> > prefer simplicity).
> 
> Just to make things more clear for me: do I understand correctly that this
> was an attempt to add HH fragments to pgtable_list from pte_free_defer()?

Yes, from page_table_free() called from pte_free_defer(): I had claimed
they could be put on the list (or not) without needing to consider their
HH-ness, apart from wanting to list_add_tail() rather than list_add() them.

But then realized that this category of list_add_tail() pages would block
access to the others.

But I think I was mistaken then to say "could be solved by a list_move()
somewhere"; because "somewhere" would have had to be __tlb_remove_table()
when it removes PP-bits, which would bring us back to the issues of
getting a spinlock from an mm which might already be freed.

Hugh
