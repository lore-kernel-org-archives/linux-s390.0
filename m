Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18FAC77B7A
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jun 2023 18:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239025AbjFFSju (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Jun 2023 14:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239020AbjFFSjt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Jun 2023 14:39:49 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCA9121
        for <linux-s390@vger.kernel.org>; Tue,  6 Jun 2023 11:39:47 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-543c692db30so1949931a12.3
        for <linux-s390@vger.kernel.org>; Tue, 06 Jun 2023 11:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1686076787; x=1688668787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ipsTwHL47notmV/HGoey6MkAAn1uRiqZTtJAd3PLJL0=;
        b=K/ZrDlF8KMAnDS85fxZpm6YhX4Oph+uve2y/Y+MrmfyE2WE3XoTh1kngEqIpjeVuP4
         LYlM06s8Uw7AO+LzmDl6QeBr8o8xTQ7KHd5QRfYpgJLfaLmmaYC7+90/Qtagjikdbx65
         /aR2ImBqmnp+INz1P6qgonoJXcFcbcfyAyqaFe4FmJ6o+UJj8+nyeBNmhXxQJRYBU02N
         mr7S2Cz3HsMBapBOgAJWZ25UUc6Hza7XfixudL4IY/IY8VwHWaYmffzNpqaauIHjbZWC
         HkA175FUYWjYIoEjNPC+K1Df/J2BYZPiN+Y2bqFa66dNRJSl8SyRX9Hum7j9HK57QQUT
         7joA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686076787; x=1688668787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipsTwHL47notmV/HGoey6MkAAn1uRiqZTtJAd3PLJL0=;
        b=AaIjllyGiqVxQJjqsG5JoIpDAQ+67ucUfM1ijTljtQb25DHr+0s5ngSa/XAsKKo/B4
         ak60K1a5PRJxZvkniwwftNSeOMzFC1xS2TjOiXZRv6mkRkI7zlaLKcEgA1TBaXEFZPCt
         vDWLkxZiLVuc4xD5rZ0gkGg+75uyqFDRCzc/MozKnDp5wx15JU3tPSCQ9YedigtSs2RN
         PahcBxdqKHmWfxc/iNhzN8IQ3RObSML5rwXGuVz0C4el0KH/eL5H4Z17SQavMXq3Bz7j
         9m9YZikzQq5DcRigsISIpDouX9F0DZ30vKjwbRQ4bhCv4kpVn6rlN4YUaHOhHuw4houO
         aZ4A==
X-Gm-Message-State: AC+VfDzzdDWQtm1k57iqpPSpLVoXqfk/8v9LfvI+kwl2tcnU/XpE4C0i
        +j7SbyFtW98auxAbiJXcUPqN5Q==
X-Google-Smtp-Source: ACHHUZ5Z8L5+gsuV0Vp/V1wMVAvDi3cyVCaZDXHr2VY8t2bgbdMDsnlE8QTZgIjlmziBgBimkE2xDQ==
X-Received: by 2002:a17:902:7605:b0:1b1:a9e7:5d4b with SMTP id k5-20020a170902760500b001b1a9e75d4bmr2874824pll.22.1686076787139;
        Tue, 06 Jun 2023 11:39:47 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id f3-20020a170902ce8300b001aaf2e7b06csm8839952plg.132.2023.06.06.11.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 11:39:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q6baq-0030jJ-Oc;
        Tue, 06 Jun 2023 15:39:44 -0300
Date:   Tue, 6 Jun 2023 15:39:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hugh Dickins <hughd@google.com>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 07/12] s390: add pte_free_defer(), with use of
 mmdrop_async()
Message-ID: <ZH99cLKeALvUCIH8@ziepe.ca>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
 <6dd63b39-e71f-2e8b-7e0-83e02f3bcb39@google.com>
 <175ebec8-761-c3f-2d98-6c3bd87161c8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175ebec8-761-c3f-2d98-6c3bd87161c8@google.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jun 05, 2023 at 10:11:52PM -0700, Hugh Dickins wrote:

> "deposited" pagetable fragments, over in arch/s390/mm/pgtable.c: use
> the first two longs of the page table itself for threading the list.

It is not RCU anymore if it writes to the page table itself before the
grace period, so this change seems to break the RCU behavior of
page_table_free_rcu().. The rcu sync is inside tlb_remove_table()
called after the stores.

Maybe something like an xarray on the mm to hold the frags?

Jason
