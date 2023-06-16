Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA332EB64DA
	for <linux-s390@archiver.kernel.org>; Fri, 16 Jun 2023 12:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345332AbjFPMfw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 16 Jun 2023 08:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345206AbjFPMft (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 16 Jun 2023 08:35:49 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8326130E8
        for <linux-s390@vger.kernel.org>; Fri, 16 Jun 2023 05:35:45 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-75eba89e373so91538185a.0
        for <linux-s390@vger.kernel.org>; Fri, 16 Jun 2023 05:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1686918944; x=1689510944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VaT6gHKjY6WWAZbs8KhagJ4ZMxbyWbOfMvMQZq2Nlzk=;
        b=nqU3OuYd7T9BnZ673DZaqnHYQnoCyRpD2Bu29KYcM4zTKVMUC6LfSqwd7ZMU4PiR9G
         n0Os3QG1GgQOvufyTH+IefleASB0rfM2L/BX13t6ued+qogSXxN+xDmWeucCUrDVauW6
         H+ALTb6rASYK/TMFcmxjHjOM7ZYvOcADMhQup1A3y077DazwADlJfhQD60gF3du8Gr6O
         3ehHK1aXB7VVVjxaXRwbbV51Y0QlSTdP3nRrBegG14bX7uUjH4FzCFEVnTz/qtsoP8wZ
         UlFsFCIUvpbv5knFBShD4U3mhW8Ug42owhXg6kV4FoobO95A62/7MoaUtgftF420iSzM
         xwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686918944; x=1689510944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaT6gHKjY6WWAZbs8KhagJ4ZMxbyWbOfMvMQZq2Nlzk=;
        b=CdDqbCviqKAM32mxru8/ta2Nte42+yTEwVZGDGMnQYNRaAsIMM3qnhwxE43QyBuAv8
         5ORD5BOgXoiBZs/DGnqX0RLXOSGxf1ZkwD0BDRxFcQefJWS6euKovNURTKQ/wkPF4g2e
         JphxUAXxjm9LDeCexvAz8+8DzOll/d2/KBx+J2bk2/pPKDm4+g4sEIsPWLyJeosjl8wu
         Ywz2rBVK+D/8UJgxCeyvK+hzs553STC1nCB03Aek2FjUdQedp76FOX4T7A6Pp2HlBjGx
         cXUFF/bSw9XsbVX0tWm1r/7TpcHSejWv+46YmNVrpTFs3Ww1qylT7f82HKOR8tmj52hz
         s2dQ==
X-Gm-Message-State: AC+VfDzDQxanMUQUVUJyLiZcGf1oUvNE8oz4FnCWmXyxticyPQqhWokh
        WNpMStOdMTXffExwUYqla281fC22e0Nm0sZpkNI=
X-Google-Smtp-Source: ACHHUZ7MAxb9Kzc3xGrJsBybloGdboexOqP8uN4xxULmyci4A2h0IU/JZaUSAulrgFIC9FXBn4jQkA==
X-Received: by 2002:a05:6214:1c8a:b0:62d:ed66:7ad1 with SMTP id ib10-20020a0562141c8a00b0062ded667ad1mr1507185qvb.28.1686918943024;
        Fri, 16 Jun 2023 05:35:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id e30-20020a0cb45e000000b006260a1f1534sm6932195qvf.25.2023.06.16.05.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 05:35:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qA8g1-006BOG-Lu;
        Fri, 16 Jun 2023 09:35:41 -0300
Date:   Fri, 16 Jun 2023 09:35:41 -0300
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
Message-ID: <ZIxXHUcb5LumkxEH@ziepe.ca>
References: <6dd63b39-e71f-2e8b-7e0-83e02f3bcb39@google.com>
 <175ebec8-761-c3f-2d98-6c3bd87161c8@google.com>
 <20230606214037.09c6b280@thinkpad-T15>
 <dbed4c5-1d-f278-d03a-66f5eff5e48e@google.com>
 <20230608174756.27cace18@thinkpad-T15>
 <a948f24b-4fe6-8bc0-221a-65e9ccc8371a@google.com>
 <20230614153042.43a52187@thinkpad-T15>
 <fc5cd62e-d85f-36c3-ba37-db87e8b625d@google.com>
 <ZIsFQalF7rwVKXrD@ziepe.ca>
 <422e8778-444c-d291-988c-26fc041a481@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422e8778-444c-d291-988c-26fc041a481@google.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jun 15, 2023 at 02:09:30PM -0700, Hugh Dickins wrote:
> On Thu, 15 Jun 2023, Jason Gunthorpe wrote:
> > On Wed, Jun 14, 2023 at 02:59:33PM -0700, Hugh Dickins wrote:
> > 
> > > I guess the best thing would be to modify kernel/fork.c to allow the
> > > architecture to override free_mm(), and arch/s390 call_rcu to free mm.
> > > But as a quick and dirty s390-end workaround, how about:
> > 
> > RCU callbacks are not ordered so that doesn't seem like it helps..
> 
> Thanks, that's an interesting and important point, which I need to knock
> into my head better.
> 
> But can you show me where that's handled in the existing mm/mmu_gather.c
> include/asm-generic/tlb.h framework?  I don't see any rcu_barrier()s
> there, yet don't the pmd_huge_pte pointers point into pud page tables
> freed shortly afterwards also by RCU?

I don't know anything about the pmd_huge_pte stuff.. I was expecting
it got cleaned up explicitly before things reached the call_rcu? Where is it
touched from a call_rcu callback?

> > Making the page frag pool global (per-cpu global I guess) would also
> > remove the need to reach back to the freeable mm_struct and reduce the
> > need for struct page memory. This views it as a special kind of
> > kmemcache.
> 
> I haven't thought in that direction at all.  Hmm.  Or did I think of
> it once, but discarded for accounting reasons - IIRC (haven't rechecked)
> page table pages are charged to memcg, and counted for meminfo and other(?)
> purposes: if the fragments are all lumped into a global pool, we
> lose that.

You'd have to search the free list for fragments that match the
current memcg to avoid creating mismatches :\, or rework how memcg
accouting works for page tables - eg move the memcg from the struct
page to the mm_struct so that each frag can be accounted differently.

> > Can arches opt in to RCU freeing page table support and still keep
> > your series sane?
> 
> Yes, or perhaps we mean different things: I thought most architectures
> are already freeing page tables by RCU.  s390 included.
> "git grep MMU_GATHER_RCU_TABLE_FREE" shows plenty of selects.

MMU_GATHER_RCU_TABLE_FREE is a very confusing option. What it really
says is that the architecture doesn't do an IPI so we sometimes use
RCU as a replacement for the IPI, but not always.

Specifically this means it doesn't allow rcu reading of the page
tables. You still have to take the IPI blocking interrupt-disable lock
to read page tables, even if MMU_GATHER_RCU_TABLE_FREE is set.

IMHO I would be alot happier with what you were trying to do here if
it came along with full RCU enabling of page tables so that we could
say that the rcu_read_lock() is sufficient locking to read page tables
*always*.

I didn't really put together how this series works that we could
introduce rcu_read_lock() in only one specific place..

My query was simpler - if we could find enough space to put a rcu_head
in the ptdesc for many architectures, and thus *always* RCU free on
many architectures, could you do what you want but disable it on S390
and POWER which would still have to rely on an RCU head allocation and
a backup IPI?

Jason
