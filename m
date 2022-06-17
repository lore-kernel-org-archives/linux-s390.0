Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07ABCCA481
	for <linux-s390@archiver.kernel.org>; Fri, 17 Jun 2022 08:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380958AbiFQI0b (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 17 Jun 2022 04:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380971AbiFQI03 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 17 Jun 2022 04:26:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8404D68983
        for <linux-s390@vger.kernel.org>; Fri, 17 Jun 2022 01:26:28 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so3561683pjz.1
        for <linux-s390@vger.kernel.org>; Fri, 17 Jun 2022 01:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yr0ixUanPwolWpl8lCaQhXzB90rLEzIJZVwDXXKPA0U=;
        b=T0JCgWDTB1C2DISDgdZ4UDVFOWnRp2zy2MnmauLXScjZ1nAwZFhugPqk7LJHr/ZqYR
         gS7AQ2LY7MCi12zojIG7f8Ph+i4IbqU+gY2wftHcxhfe5I/JxipjHT9G+VpC1zh5K6vU
         duBUQkQeO+lYH2S0APPy5npNumr73wIpqlOnbbnKsqaOmmaPmmMnefSyRGqfn72oeVHY
         4XT/louGb1lBLYbfoesSgG/+I51syqllEu+lF2uvmS6543R3TVlllAbeuSojS2oaZNiz
         0vsqAzWz7egUsoU66blaHOD0ko2YmWG/bFdUR0JWK3PFEfpAyeZtKbMvGonQ25pbr7g8
         /rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yr0ixUanPwolWpl8lCaQhXzB90rLEzIJZVwDXXKPA0U=;
        b=b02KwOSd3MynSwVPnm6Y1uIOK6kOQFX8V7+rJwORBAOR+U9AljxN7voS29JJ+LIHX+
         jPxESEDbD+9rwt2F5Aw337x8Qnp8ehdMbE7KfRaAotz9ZLhcbVBQsJoJDYTyvxv7CzB1
         h0Ia5K+pe6uFDcFegASQ/2PGvF6HdSZ3O1cJ4bDK8EcobfSsfrMnRiMzqjQK1pfixzx+
         5XazUORu06nwYXnES/xl/XGqxd5EAfOqNr1K2ojulVKoTBzYkT4eJK+FZNvKsycg/+DK
         Bpcb0UxQjoQPfZxoxwsf8/07B1My98UY4+F9bE8DEVGOii7Fo/WiwEjbRgCrB2+fYbn6
         fMPQ==
X-Gm-Message-State: AJIora/jY35lJU60NYDY/qIKDuajS/Upoo3kRNAZq2K8D9kPExtj7DPe
        z3rJZbMHCjtMRW8XTeFKrBkqYw==
X-Google-Smtp-Source: AGRyM1t5yEL1BPz7y9ug30F37C0ubzhxM59TWM8YWNbgEGd6O1gO2tufJo02mvgvoeRwcOdvYuG/tA==
X-Received: by 2002:a17:903:22cb:b0:167:992f:60c3 with SMTP id y11-20020a17090322cb00b00167992f60c3mr8629830plg.59.1655454387624;
        Fri, 17 Jun 2022 01:26:27 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902cf0c00b001677fa34a07sm2974542plg.43.2022.06.17.01.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 01:26:27 -0700 (PDT)
Date:   Fri, 17 Jun 2022 16:26:23 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        catalin.marinas@arm.com, will@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/4] arm64/hugetlb: Implement arm64 specific
 hugetlb_mask_last_page
Message-ID: <Yqw6r0/r34sZdrsk@FVFYT0MHHV2J.usts.net>
References: <20220616210518.125287-1-mike.kravetz@oracle.com>
 <20220616210518.125287-3-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616210518.125287-3-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jun 16, 2022 at 02:05:16PM -0700, Mike Kravetz wrote:
> From: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> The HugeTLB address ranges are linearly scanned during fork, unmap and
> remap operations, and the linear scan can skip to the end of range mapped
> by the page table page if hitting a non-present entry, which can help
> to speed linear scanning of the HugeTLB address ranges.
> 
> So hugetlb_mask_last_page() is introduced to help to update the address in
> the loop of HugeTLB linear scanning with getting the last huge page mapped
> by the associated page table page[1], when a non-present entry is encountered.
> 
> Considering ARM64 specific cont-pte/pmd size HugeTLB, this patch implemented
> an ARM64 specific hugetlb_mask_last_page() to help this case.
> 
> [1] https://lore.kernel.org/linux-mm/20220527225849.284839-1-mike.kravetz@oracle.com/
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
