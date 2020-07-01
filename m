Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731672AbgGAQ2n (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 1 Jul 2020 12:28:43 -0400
Date: Wed, 1 Jul 2020 19:28:31 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] mm/memblock: expose only miminal interface to
 add/walk physmem
Message-ID: <20200701162831.GB2999146@linux.ibm.com>
References: <20200701141830.18749-1-david@redhat.com>
 <20200701141830.18749-2-david@redhat.com>
 <20200701150643.GA2999146@linux.ibm.com>
 <20200701153157.GC5008@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701153157.GC5008@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>

On Wed, Jul 01, 2020 at 05:31:57PM +0200, Heiko Carstens wrote:
> On Wed, Jul 01, 2020 at 06:06:43PM +0300, Mike Rapoport wrote:
> > Hi David,
> > 
> > On Wed, Jul 01, 2020 at 04:18:29PM +0200, David Hildenbrand wrote:
> > > "physmem" in the memblock allocator is somewhat weird: it's not actually
> > > used for allocation, it's simply information collected during boot, which
> > > describes the unmodified physical memory map at boot time, without any
> > > standby/hotplugged memory. It's only used on s390x and is currently the
> > > only reason s390x keeps using CONFIG_ARCH_KEEP_MEMBLOCK.
> > > 
> > > Physmem isn't numa aware and current users don't specify any flags. Let's
> > > hide it from the user, exposing only for_each_physmem(), and simplify. The
> > > interface for physmem is now really minimalistic:
> > > - memblock_physmem_add() to add ranges
> > > - for_each_physmem() / __next_physmem_range() to walk physmem ranges
> > > 
> > > Don't place it into an __init section and don't discard it without
> > > CONFIG_ARCH_KEEP_MEMBLOCK. As we're reusing __next_mem_range(), remove
> > > the __meminit notifier to avoid section mismatch warnings once
> > > CONFIG_ARCH_KEEP_MEMBLOCK is no longer used with
> > > CONFIG_HAVE_MEMBLOCK_PHYS_MAP.
> > > 
> > > While fixing up the documentation, sneak in some related cleanups. We can
> > > stop setting CONFIG_HAVE_MEMBLOCK_PHYS_MAP for s390x next.
> > 
> > As you noted in the previous version it should have been
> > CONFIG_ARCH_KEEP_MEMBLOCK ;-)
> > 
> > > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > > Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > > Cc: Mike Rapoport <rppt@linux.ibm.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > 
> > Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > > ---
> > >  arch/s390/kernel/crash_dump.c |  6 ++--
> > >  include/linux/memblock.h      | 28 ++++++++++++++---
> > >  mm/memblock.c                 | 57 ++++++++++++++++++-----------------
> > >  3 files changed, 55 insertions(+), 36 deletions(-)
> 
> So I guess this should go via the s390 tree, since the second patch of
> this series can go only upstream if both this patch and a patch which
> is currently only on our features are merged before.
> 
> Any objections?

Not from my side.

-- 
Sincerely yours,
Mike.
