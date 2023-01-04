Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758BDC4332F
	for <linux-s390@archiver.kernel.org>; Wed,  4 Jan 2023 16:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjADQuR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 4 Jan 2023 11:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbjADQsL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Jan 2023 11:48:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA783D9D3
        for <linux-s390@vger.kernel.org>; Wed,  4 Jan 2023 08:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672850693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6EzsGSC3holClBSPQw8EocT+rCm9w6LTUpG8IqXLKaM=;
        b=KmfhUiP1Z4CC5XYWE1y6bb4X3paTR4BHLNiHsyvkK1hSy9BNhGkpmIauh4f2QAVKtFrtS6
        Bsse17u+qgjcH6bQQEQ8giUdoCi6b/cvkKsoyb74VQWJ4rqr/zwJu6eHjoHaFMu3Xxp2gJ
        CtAJd4AYtX+NswBVrw5S6W57LY8xFss=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-248-2FsB-fxMPUygM8BFf7ktxg-1; Wed, 04 Jan 2023 11:44:52 -0500
X-MC-Unique: 2FsB-fxMPUygM8BFf7ktxg-1
Received: by mail-qk1-f200.google.com with SMTP id az39-20020a05620a172700b006ff85c3b19eso23427148qkb.18
        for <linux-s390@vger.kernel.org>; Wed, 04 Jan 2023 08:44:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EzsGSC3holClBSPQw8EocT+rCm9w6LTUpG8IqXLKaM=;
        b=RXi9iEaFWE+HGFW5qq2ZQFg+WJJCInE+yQorhcImVsJBuTLY4P6j1Lst3L+bzlvzvo
         PhrqE1TB3u1xJXsvRqWjfLa4wKUQ7uyPRd9Kix60r7EAjdGeD0Wb2ir9OG3izup90A5+
         0iY+aXbcnpOnD6fFGnA5revJxZWnsAGmWqUqwhElFCwSSFfw+L19B0NC2izcYCdh9H4U
         0d0dFhWOKch3z6Mow7vGV/2z9cG56Tgy6sqF4Pu7hHhfmLXFIDQbwHmJCZPCMkZE9VAn
         Nq8wo0xNk0JR3va8DrDJvA4CgvIa2Msu1doz10KD+QxCN1shI5didXsvogFzAZMiR+Mg
         s7cQ==
X-Gm-Message-State: AFqh2koLKhuxs6BT9B8PJooRzQ4XROEqORLOhoJvI6zuNpYEwkx1nrfp
        FMq6JLqz/gMM4HQR8dSQjP29jKwZi1BbXmUOcQWxZXE2z55W0Jip9p1vFBsDj2IcM88P1WBA5cU
        PAO/EQqg5caoJV1jgV6+PIQ==
X-Received: by 2002:a05:622a:124b:b0:3ab:7bb3:4707 with SMTP id z11-20020a05622a124b00b003ab7bb34707mr50094159qtx.64.1672850692361;
        Wed, 04 Jan 2023 08:44:52 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtC6/5x1TZXjNxaTZni/mgmGgEGvHrxdB4Ldf1ggEJ59TT3GmI7MMZ8cyzI4+MP/hbyTOvkqA==
X-Received: by 2002:a05:622a:124b:b0:3ab:7bb3:4707 with SMTP id z11-20020a05622a124b00b003ab7bb34707mr50094133qtx.64.1672850692030;
        Wed, 04 Jan 2023 08:44:52 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-39-70-52-228-144.dsl.bell.ca. [70.52.228.144])
        by smtp.gmail.com with ESMTPSA id u22-20020a05620a455600b006fb112f512csm24300165qkp.74.2023.01.04.08.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 08:44:51 -0800 (PST)
Date:   Wed, 4 Jan 2023 11:44:49 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Christian Brauner <brauner@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: remove zap_page_range and create zap_vma_pages
Message-ID: <Y7WtAXpZM3Mxi95N@x1n>
References: <20230104002732.232573-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230104002732.232573-1-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jan 03, 2023 at 04:27:32PM -0800, Mike Kravetz wrote:
> zap_page_range was originally designed to unmap pages within an address
> range that could span multiple vmas.  While working on [1], it was
> discovered that all callers of zap_page_range pass a range entirely within
> a single vma.  In addition, the mmu notification call within zap_page
> range does not correctly handle ranges that span multiple vmas.  When
> crossing a vma boundary, a new mmu_notifier_range_init/end call pair
> with the new vma should be made.
> 
> Instead of fixing zap_page_range, do the following:
> - Create a new routine zap_vma_pages() that will remove all pages within
>   the passed vma.  Most users of zap_page_range pass the entire vma and
>   can use this new routine.
> - For callers of zap_page_range not passing the entire vma, instead call
>   zap_page_range_single().
> - Remove zap_page_range.
> 
> [1] https://lore.kernel.org/linux-mm/20221114235507.294320-2-mike.kravetz@oracle.com/
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

