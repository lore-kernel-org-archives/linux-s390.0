Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332C3C7EE32
	for <linux-s390@archiver.kernel.org>; Thu, 25 May 2023 20:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239398AbjEYU5M (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 25 May 2023 16:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjEYU5L (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 25 May 2023 16:57:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C513194;
        Thu, 25 May 2023 13:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=w/nv11jmZL//tzZgnsZQ422wtTnnU+GBTr8mcjZt+5o=; b=jz222m+qmkx46CtsL2SK6imku3
        qq2pJIrpZYwwtoNlBcZF7Fk0xlPqceK3lGx9yfcEP5je3dxHl9hetkE+18QuDijP55CEPQoODBYNI
        uvYKUPiKzBlONmhR187tH+srkvPeqkL343XpLTCXJPsX8gyRZRXys5FShMS4Kw48PvGIyNIrdiJob
        qzWNUEmQ7TjGXaPWTNoBqzaR0fCIqDhz5vX5aceLEg5RLyYCA0NTJNp94Q35H+/kQzQkdBPbuLfU0
        BUQp3kv2YpGE9fMQX8b3xVpJANGw8phzZpM8mq6dy60BHa+pYvxVMkKbTWE80Y8Sdq1m5IiayRsFG
        t/mQy7HA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q2I19-00DAXr-9n; Thu, 25 May 2023 20:57:03 +0000
Date:   Thu, 25 May 2023 21:57:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vishal Moola <vishal.moola@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 01/34] mm: Add PAGE_TYPE_OP folio functions
Message-ID: <ZG/Ln0Nf/Zx//EQk@casper.infradead.org>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-2-vishal.moola@gmail.com>
 <20230525085555.GV4967@kernel.org>
 <CAOzc2pxx489C26NnS9NHkUQY9PYiagzt-nYK6LnkJ1N3NYQWzg@mail.gmail.com>
 <20230525202011.GZ4967@kernel.org>
 <CAOzc2pzGPBYL3S=noc1AAEtep04GexRmn2f_T3BPgVFZKaqXTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOzc2pzGPBYL3S=noc1AAEtep04GexRmn2f_T3BPgVFZKaqXTg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, May 25, 2023 at 01:38:54PM -0700, Vishal Moola wrote:
> On Thu, May 25, 2023 at 1:20 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Thu, May 25, 2023 at 10:00:23AM -0700, Vishal Moola wrote:
> > > On Thu, May 25, 2023 at 1:56 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Mon, May 01, 2023 at 12:27:56PM -0700, Vishal Moola (Oracle) wrote:
> > > > > No folio equivalents for page type operations have been defined, so
> > > > > define them for later folio conversions.
> > > >
> > > > Can you please elaborate why would we need folios for page table descriptors?
> > >
> > > Thanks for the review!
> > >
> > > These macros are for callers that care about the page type, i.e. Table and
> > > Buddy. Aside from accounting for those cases, the page tables don't use folios.
> > > These are more for the cleanliness of those callers.
> >
> > But why using folio APIs for PageType will be cleaner than using page APIs?
> > Do you have an example?
> 
> Ah, for example in mm/memory-failure.c there are a couple uses of PageTable.
> Like the line :
> if (folio_test_slab(folio) || PageTable(&folio->page) ||
> folio_test_reserved(folio))
> where that PageTable(&folio->page) can now be written as folio_test_table(folio)
> instead.
> 
> Also there are numerous uses of PageBuddy in mm/compaction.c that will
> likely need to be converted to folios as well.

... and you can currently call PageTable() on the second/third/... page
of an allocation and it will return false, regardless of what the
first page is typed as.  For most architectures, this doesn't matter,
but /proc/kpageflags will underreport the amount of memory allocated
as page tables on architectures which use multi-page allocations for
their page tables as there's currently absolutely nothing to indicate
the size of the allocation.

To fix this, we need to use __GFP_COMP.
