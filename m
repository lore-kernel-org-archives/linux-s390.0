Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04456C433ED
	for <linux-s390@archiver.kernel.org>; Mon, 12 Apr 2021 12:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB7936109F
	for <linux-s390@archiver.kernel.org>; Mon, 12 Apr 2021 12:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241245AbhDLMoY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 12 Apr 2021 08:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241236AbhDLMoY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 12 Apr 2021 08:44:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A081AC061574
        for <linux-s390@vger.kernel.org>; Mon, 12 Apr 2021 05:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=MX4O8F2djzZxJzEjMfbyx+I8Xmr6JSkcmoV9j3dbeu0=; b=uMfRa4qk99jhDYrahrIP73CWJ8
        tQU4CusT6qrGUIX8nqUtAyc0NGTjVDeREowrlkdjzq/4p9bOEHtBvC3prSqaKnS1KQMrdfE4BBh2g
        TT5D3tt6icHr6PmMZBrzmcWEYoFWKxWocSH/tMvncjY21Ojb4BI7qi6XOOmnM4DgQLyczibTkBgy/
        ejaT4/IVQceaAVM6Sq7AFt6BPxziFr0GnEXFqZ7dKXQpcwqQMb3HqaDP0CGb9PE/41YWH7IsrWeyK
        iK7b+69YzyM2VCX2C/eX8H14OLaQvhcyRCSrjfkJIbhNSXyqSKEbHsqvWFwF/omTD/d+qL8X+M8Jk
        XmjYW4hg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lVvun-004L1k-Bg; Mon, 12 Apr 2021 12:43:42 +0000
Date:   Mon, 12 Apr 2021 13:43:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-s390@vger.kernel.org
Subject: Re: Inaccessible pages & folios
Message-ID: <20210412124341.GJ2531743@casper.infradead.org>
References: <20210409194059.GW2531743@casper.infradead.org>
 <20210412141809.36c349d6@ibm-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210412141809.36c349d6@ibm-vm>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Apr 12, 2021 at 02:18:09PM +0200, Claudio Imbrenda wrote:
> On Fri, 9 Apr 2021 20:40:59 +0100
> Matthew Wilcox <willy@infradead.org> wrote:
> > I'm going to change __test_set_page_writeback() to take a folio [3]
> > and now I'm wondering what interface you'd like to use.  My
> > preference would be to rename arch_make_page_accessible() to
> > arch_make_folio_accessible() and pass a folio, at which time you
> > would make the entire folio (however many pages might be in it)
> > accessible.  If you would rather, we can leave the interface as
> > arch_make_page_accessible(), in which case we'll just call it N times
> > in __test_set_page_writeback() (and I won't need to touch gup.c).
> 
> For the rename case, how would you handle gup.c?

At first, I'd turn it into arch_make_folio_accessible(page_folio(page));

Eventually, gup.c needs to become folio-aware.  I haven't spent too much
time thinking about it, but code written like this:

                page = pte_page(pte);
                head = try_grab_compound_head(page, 1, flags);
                if (!head)
                        goto pte_unmap;
                if (unlikely(pte_val(pte) != pte_val(*ptep))) {
                        put_compound_head(head, 1, flags);
                        goto pte_unmap;
                }
                VM_BUG_ON_PAGE(compound_head(page) != head, page);

is just crying out for use of folios.  Also, some of the gup callers
would much prefer to work in terms of folios than individual struct pages
(imagine an RDMA adapter that wants to pin several gigabytes of memory
that's allocated using hugetlbfs for example).

> Consider that arch_make_page_accessible deals (typically) with KVM
> guest pages. Once you bundle up the pages in folios, you can have
> different pages in the same folio with different properties.

So what you're saying is that the host might allocate, eg a 1GB folio
for a guest, then the guest splits that up into smaller chunks (eg 1MB),
and would only want one of those small chunks accessible to the hypervisor?

> In case of failure, you could end up with a folio with some pages
> processed and some not processed. Would you stop at the first error?
> What would the state of the folio be? On s390x we use the PG_arch_1 bit
> to mark secure pages, how would that work with folios?
> 
> and how are fault handlers affected by this folio conversion? would
> they still work on pages, or would that also work on folios? on s390x
> we use the arch_make_page_accessible function in some fault handlers.

Folios can be mapped into userspace at an unaligned offset.  So we still
have to work in pages, at least for now.  We might have some optimised
path for aligned folios later.

> a possible approach maybe would be to keep the _page variant, and add a
> _folio wrapper around it

Yes, we can do that.  It's what I'm currently doing for
flush_dcache_folio().

> for s390x the PG_arch_1 is very important to prevent protected pages
> from being fed to I/O, as in that case Very Bad Things™ would happen.
> 
> sorry for the wall of questions, but I actually like your folio
> approach and I want to understand it better, so we can find a way to
> make everything work well together

Great!

> > PS: The prototype is in gfp.h.  That's not really appropriate; gfp.h
> > is about allocating memory, and this call really has nothing to do
> > with memory allocation.  I think mm.h is a better place for it, if
> > you can't find a better header file than that.
> 
> I had put it there because arch_alloc_page and arch_free_page are also
> there, and the behaviour, from a kernel point of view, is similar
> (unaccessible/unallocated pages will trigger a fault). 
> 
> I actually do not have a preference regarding where the prototype
> lives, as long as everything works. If you think mm.h is more
> appropriate, go for it :)

Heh, I see how you got there from the implementors point of view ;-)
I'll move it ...
