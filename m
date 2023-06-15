Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCD0EB64D9
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jun 2023 12:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbjFOMeS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Jun 2023 08:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjFOMeR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 15 Jun 2023 08:34:17 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ECA95
        for <linux-s390@vger.kernel.org>; Thu, 15 Jun 2023 05:34:16 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666a228d244so333954b3a.1
        for <linux-s390@vger.kernel.org>; Thu, 15 Jun 2023 05:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1686832456; x=1689424456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ojZ1+ZW9CrIjcSsPUTw6fn+atFqmZfsOZvSUBuZFNfY=;
        b=R37PGl+oHHfKNACyM1MypigLqzQIHY6Ls/YojmwnAs38cWVAP2Fprzl6cb5JurHpbr
         Cz3iaJE7JoN834H8o6iioKaJjcwq1ag++LcMcVrMHMzOixCkMAOvv6X7UgWoN8dAI9rb
         Jk92tNwwYhi6LyuZbbli8xdV9R/oaXiaz9VrnYGbJs6LBQ+nwbxIcT/Ej7fjeDFger+y
         brN2+djtc6ucbeQXqWyp1xY/MFggFjR4JGwDiWFdqSSuAmS1TlkfATo5PETPhewJo28e
         d8vCApoY2j0Wd2J820FkLfuQFa2mmVJnSpokwsKC+YCZEoUFKiwsvuSYYu2fxRw3cVbe
         2Gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686832456; x=1689424456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojZ1+ZW9CrIjcSsPUTw6fn+atFqmZfsOZvSUBuZFNfY=;
        b=PYM1VIENX9+C9uV/bSkVF+o5tf5H4i9sIgNz1JozabDy6mxNoGVdDR/fYPhduOLHxD
         7YYWqR2ZQ1/JMQN+7IB7EqRIjxKsjG2Pdrh45xymgUDHzp28YKKTcrnUKUIlJHhghQd1
         Tb24HVIh34SvxLcxMytlykChBonerppbRmf4ZVdhw8Om6U2KHv/bqoF+4pMDr3vak1x1
         ugT+Zlle39RQkVineh4s2hwKItdJYve+sDOYahDJZwC3lU4VuWMwFnKc2iEHQKSADSNa
         QCn6zfqweWiEj2/5O3G1rTZ461McLHi86s1KK5iur7/Uj0qBXg5f+Ic67LvP8JYr0tU4
         7zQw==
X-Gm-Message-State: AC+VfDy/lYha/0iPp/6kXqPaVrDVYbJDqVgrXfY4x/GS/LzH+8mgrMEU
        DJmM/oYvFIoLobTFex3jEwApNQ==
X-Google-Smtp-Source: ACHHUZ5ps+8UJfB8wzyHwFkU4dmNODVaU5/J3EFPY3L9juO7wAHMCn2h51PBolTV5fBO9uvTJqcdxw==
X-Received: by 2002:a05:6a20:8f1d:b0:11a:3f7:7edb with SMTP id b29-20020a056a208f1d00b0011a03f77edbmr4618030pzk.12.1686832455810;
        Thu, 15 Jun 2023 05:34:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id bi2-20020a170902bf0200b001ac7f583f72sm13931715plb.209.2023.06.15.05.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 05:34:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q9mAz-005UZz-Iq;
        Thu, 15 Jun 2023 09:34:09 -0300
Date:   Thu, 15 Jun 2023 09:34:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hugh Dickins <hughd@google.com>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 07/12] s390: add pte_free_defer(), with use of
 mmdrop_async()
Message-ID: <ZIsFQalF7rwVKXrD@ziepe.ca>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
 <6dd63b39-e71f-2e8b-7e0-83e02f3bcb39@google.com>
 <175ebec8-761-c3f-2d98-6c3bd87161c8@google.com>
 <20230606214037.09c6b280@thinkpad-T15>
 <dbed4c5-1d-f278-d03a-66f5eff5e48e@google.com>
 <20230608174756.27cace18@thinkpad-T15>
 <a948f24b-4fe6-8bc0-221a-65e9ccc8371a@google.com>
 <20230614153042.43a52187@thinkpad-T15>
 <fc5cd62e-d85f-36c3-ba37-db87e8b625d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc5cd62e-d85f-36c3-ba37-db87e8b625d@google.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 14, 2023 at 02:59:33PM -0700, Hugh Dickins wrote:

> I guess the best thing would be to modify kernel/fork.c to allow the
> architecture to override free_mm(), and arch/s390 call_rcu to free mm.
> But as a quick and dirty s390-end workaround, how about:

RCU callbacks are not ordered so that doesn't seem like it helps..

synchronize_rcu would do the job since it is ordered, but I think the
performance cost is too great to just call it from mmdrop

rcu_barrier() followed by call_rcu on the mm struct might work, but I
don't know the cost

A per-cpu refcount scheme might also do the job reasonably

Making the page frag pool global (per-cpu global I guess) would also
remove the need to reach back to the freeable mm_struct and reduce the
need for struct page memory. This views it as a special kind of
kmemcache.

Another approach is to not use a rcu_head in the ptdesc at all.

With a global kmemcache-like-thing we could probably also organize
something where you don't use a rcu_head in the ptdesc, but instead
just a naked 'next' pointer. This would give enough space to have two
next pointers and the next pointers can be re-used for the normal free
list as well.

In this flow you'd thread the free'd frags onto a waterfall of global
per-cpu lists:
 - RCU free the next cycle
 - RCU free this cycle
 - Actually free

Where a single rcu_head and single call_rcu frees the entire 2nd list
to the 3rd list and then schedules the 1st list to be RCU'd next. This
eliminates the need to store a function pointer in the ptdesc at
all.

It requires some global per-cpu lock on the free/alloc paths however,
but this is basically what every other arch does as it frees the page
back to the page allocator.

I suspect that two next pointers would also eliminate pt_frag_refcount
entirely as we can encode that information in the low bits of the next
pointers.

> (Funnily enough, there's no problem when the stored mm gets re-used for
> a different mm, once past its spin_lock_init(&mm->context.lock);
> because

We do that have really weird "type safe by rcu" thing in the
allocators, but I don't quite know how it works.

> Powerpc is like that.  I have no idea how much gets wasted that way.
> I was keen not to degrade what s390 does: which is definitely superior,
> but possibly not worth the effort.

Yeah, it would be good to understand if this is really sufficiently
beneficial..

> I'll look into it, once I understand c2c224932fd0.  But may have to write
> to Vishal first, or get the v2 of my series out: if only I could work out
> a safe and easy way of unbreaking s390...

Can arches opt in to RCU freeing page table support and still keep
your series sane?

Honestly, I feel like trying to RCU enable page tables should be its
own series. It is a sufficiently tricky subject on its own right.

Jason
