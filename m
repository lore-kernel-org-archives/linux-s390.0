Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BA5C433B4
	for <linux-s390@archiver.kernel.org>; Mon, 12 Apr 2021 13:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8206134F
	for <linux-s390@archiver.kernel.org>; Mon, 12 Apr 2021 13:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241628AbhDLNzm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238999AbhDLNzl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 12 Apr 2021 09:55:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6CDC061574
        for <linux-s390@vger.kernel.org>; Mon, 12 Apr 2021 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qXemFGMBM8JTxs4FqRGQhLgCCxC3ChdlJe3Sw6yZFko=; b=dBmTrPR1UZU2WwxLPnglEiS1aA
        VacjWm7rZB/WrOZKm1WR3TYpwBtKz9KwproemnU0suFxdNlGRhtSGgwQXwSJWIOQC3ZjmpRscZqxR
        60+m6SBPHno7Qbd0rY3wrfEZA0DWvHENdoa/nLq7nof0mhth0L2t6DILro4SLnSzKSQNtUkFTgvCZ
        O7+llY5vcF9BUaXNoYnoRBCgUHHbwJCushv7/Co4wJ626mwV5r+wTsu0eptSwsyf955fsl8mfYVTH
        4SY4JJFMSw3hvTFKjbYN4U9lvLYMxbO3EBZNPRvZG52l0T6csWt6Ad864DaSp5hMWNuQyVwQ5muPG
        ubXW6JLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lVx22-004Q1I-M8; Mon, 12 Apr 2021 13:55:15 +0000
Date:   Mon, 12 Apr 2021 14:55:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-s390@vger.kernel.org
Subject: Re: Inaccessible pages & folios
Message-ID: <20210412135514.GK2531743@casper.infradead.org>
References: <20210409194059.GW2531743@casper.infradead.org>
 <20210412141809.36c349d6@ibm-vm>
 <20210412124341.GJ2531743@casper.infradead.org>
 <20210412153718.06e30c9c@ibm-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412153718.06e30c9c@ibm-vm>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Apr 12, 2021 at 03:37:18PM +0200, Claudio Imbrenda wrote:
> On Mon, 12 Apr 2021 13:43:41 +0100
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> [...]
> 
> > > For the rename case, how would you handle gup.c?  
> > 
> > At first, I'd turn it into
> > arch_make_folio_accessible(page_folio(page));
> 
> that's tricky. what happens if some pages in the folio cannot be made
> accessible?

I was only thinking about the page cache case ...

        access_ret = arch_make_page_accessible(page);
        /*
         * If writeback has been triggered on a page that cannot be made
         * accessible, it is too late to recover here.
         */
        VM_BUG_ON_PAGE(access_ret != 0, page);

... where it seems all pages _can_ be made accessible.

> also, I assume you keep the semantic difference between get_page and
> pin_page? that's also very important for us

I haven't changed anything in gup.c yet.  Just trying to get the page
cache to suck less right now.

> > So what you're saying is that the host might allocate, eg a 1GB folio
> > for a guest, then the guest splits that up into smaller chunks (eg
> > 1MB), and would only want one of those small chunks accessible to the
> > hypervisor?
> 
> qemu will allocate a big chunk of memory, and I/O would happen only on
> small chunks (depending on what the guest does). I don't know how swap
> and pagecache would behave in the folio scenario.
> 
> Also consider that currently we need 4k hardware pages for protected
> guests (so folios would be ok, as long as they are backed by small
> pages)
> 
> How and when are folios created actually?
> 
> is there a way to prevent creation of multi-page folios?

Today there's no way to create multi-page folios because I haven't submitted
the patch to add alloc_folio() and friends:

https://git.infradead.org/users/willy/pagecache.git/commitdiff/4fe26f7a28ffdc850cd016cdaaa74974c59c5f53

We do have a way to allocate compound pages and add them to the page cache,
but that's only in use by tmpfs/shmem.

What will happen is that (for filesystems which support multipage folios),
they'll be allocated by the page cache.  I expect other places will start
to use folios after that (eg anonymous memory), but I don't know where
all those places will be.  I hope not to be involved in that!

The general principle, though, is that the overhead of tracking memory in
page-sized units is too high, and we need to use larger units by default.
There are occasions when we need to do things to memory in smaller units,
and for those, we can choose to either handle sub-folio things, or we
can split a folio apart into smaller folios.

> > > a possible approach maybe would be to keep the _page variant, and
> > > add a _folio wrapper around it  
> > 
> > Yes, we can do that.  It's what I'm currently doing for
> > flush_dcache_folio().
> 
> where would the page flags be stored? as I said, we really depend on
> that bit to be set correctly to prevent potentially disruptive I/O
> errors. It's ok if the bit overindicates protection (non-protected
> pages can be marked as protected), but protected pages must at all
> times have the bit set.
> 
> the reason why this hook exists at all, is to prevent secure pages from
> being accidentally (or maliciously) fed into I/O

You can still use PG_arch_1 on the sub-pages of a folio.  It's one of the
things you'll have to decide, actually.  Does setting PG_arch_1 on
the head page of the folio indicate that the entire page is accessible,
or just that the head page is accessible?  Different page flags have
made different decisions here.

