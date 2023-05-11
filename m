Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719C8C77B7C
	for <linux-s390@archiver.kernel.org>; Thu, 11 May 2023 03:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbjEKDQx (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 May 2023 23:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbjEKDQo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 May 2023 23:16:44 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828A926A2
        for <linux-s390@vger.kernel.org>; Wed, 10 May 2023 20:16:40 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-559f1819c5dso121473077b3.0
        for <linux-s390@vger.kernel.org>; Wed, 10 May 2023 20:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683774999; x=1686366999;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hRBzifhysJxaavDAsJ+Sa+/VyNhQzLXJPjsoUGcNRd4=;
        b=JDYjlZO6u5Rd6QYeBUTXCp/kgqPCJk7kIYj5131tW+Oftjr3CeY+3TrtF265PwQLsY
         CzyhzuHdTlVexa4Irr81wJWJONYV4WJYb+Qmn3xCOOTrZII3mN3FIl3WlUa9ZzRwMyft
         TbG+lOOAm/FlIwiaNhNLr42JUk/Xp0bH2c5++eORJ8zXY8TzfBVIgW201ldf27i4oXvO
         WYco0w5tL3fNC1aMrOMXgic+X453i3JN5jojWOgIXdVajjoFoae+wDli+04h87K4PSDU
         PrZHQkqAQy9rNdfpBcTkPkLhTcEgcEAEnkRKNVLkHXWaXGdspdGha99g/0X8mBFfM1nS
         C7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683774999; x=1686366999;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hRBzifhysJxaavDAsJ+Sa+/VyNhQzLXJPjsoUGcNRd4=;
        b=ZN+88JBv6LKRL9h2YkvqlW2lbaCCEbAMmezxsZCk+N14IjVZ2O0sGloamPAddiO61V
         E5BbdY0HaHdupDWyJY3Y3WNyzNZpjuHT2zvBXKM9jRTVvOk+F8x84Nn7LK7yhFv1S7o1
         AW6JOFP++8WFFtnRhtq7G98SuWKJ2Fovf2F+5GbuutjpLoSoghcY9tZcYLG80E5txn4R
         UskI8LxCzA+QzOneMFIRSm4SG60P0oUGU9yyhWkEK8hYU85ZMJeLw5OR2YW/S/QAqnVS
         tC8xGCdADrxn0JdBY/KzSnJSxknzAtfSRboWfWuNkg/Fzzqlp7fFsrLCBW/2a9lc2biF
         EyHw==
X-Gm-Message-State: AC+VfDyD4TkzxetbMHBS6Jlp7E8LJws+s5MVsoy3yoEZNvBRWIXLtx4n
        /K6rph+J6wiBA7ogyWeE9O96ow==
X-Google-Smtp-Source: ACHHUZ7/wlg4bppDf9uBVNG9J9Qk7aL+NA0hCKaxoiuDXlSicnUNf7o6tqD4YBoUi/tdOZkorZkwaA==
X-Received: by 2002:a25:4087:0:b0:b9e:5006:42af with SMTP id n129-20020a254087000000b00b9e500642afmr19049386yba.58.1683774998976;
        Wed, 10 May 2023 20:16:38 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j128-20020a255586000000b00b923b2935d9sm4144529ybb.20.2023.05.10.20.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 20:16:38 -0700 (PDT)
Date:   Wed, 10 May 2023 20:16:34 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 21/23] x86: Allow get_locked_pte() to fail
In-Reply-To: <20230510081848.GD83892@hirez.programming.kicks-ass.net>
Message-ID: <e5554cd1-417a-aa6a-5e5e-f4f5f773dda@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com> <eba2b72f-2180-498b-c8bd-ce8f717fc78a@google.com> <20230510081848.GD83892@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 10 May 2023, Peter Zijlstra wrote:

> On Tue, May 09, 2023 at 10:08:37PM -0700, Hugh Dickins wrote:
> > In rare transient cases, not yet made possible, pte_offset_map() and
> > pte_offset_map_lock() may not find a page table: handle appropriately.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >  arch/x86/kernel/ldt.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
> > index 525876e7b9f4..eb844549cd83 100644
> > --- a/arch/x86/kernel/ldt.c
> > +++ b/arch/x86/kernel/ldt.c
> > @@ -367,8 +367,10 @@ static void unmap_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt)
> >  
> >  		va = (unsigned long)ldt_slot_va(ldt->slot) + offset;
> >  		ptep = get_locked_pte(mm, va, &ptl);
> > -		pte_clear(mm, va, ptep);
> > -		pte_unmap_unlock(ptep, ptl);
> > +		if (ptep) {
> > +			pte_clear(mm, va, ptep);
> > +			pte_unmap_unlock(ptep, ptl);
> > +		}
> >  	}
> 
> Ow geez, now I have to go remember how the whole PTI/LDT crud worked :/

I apologize for sending you back there!

> 
> At first glance this seems wrong; we can't just not unmap the LDT if we
> can't find it in a hurry. Also, IIRC this isn't in fact a regular user
> mapping, so it should not be subject to THP induced seizures.
> 
> ... memory bubbles back ... for PTI kernels we need to map this in the
> user and kernel page-tables because obviously userspace needs to be able
> to have access to the LDT. But it is not directly acessible by
> userspace. It lives in the cpu_entry_area as a virtual map of the real
> kernel allocation, and this virtual address is used for LLDT.
> Modification is done through sys_modify_ldt().

And there must be a user-style page table backing that cpu_entry_area,
because the use of get_locked_pte() and pte_unmap_unlock() implies
that there's a user page table (struct page containing spinlock if
config says so) rather than just a kernel page table mapping it.

> 
> I think I would feel much better if this were something like:
> 
> 	if (!WARN_ON_ONCE(!ptep))
> 
> This really shouldn't fail and if it does, simply skipping it isn't the
> right thing either.

Sure, I'll gladly make that change when I respin - not immediately, let's
get more feedback on this arch series first, but maybe in a week's time.

Thanks for looking so quickly, Peter: I didn't Cc you on this particular
series, but shall certainly be doing so on the ones that follow, because
a few of those patches go into interesting pmdp_get_lockless() territory.

Hugh
