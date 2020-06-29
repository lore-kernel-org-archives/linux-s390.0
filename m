Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726158AbgF2Swk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:40 -0400
Date: Mon, 29 Jun 2020 14:44:32 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH RFC 2/2] s390/mm: don't set ARCH_KEEP_MEMBLOCK
Message-ID: <20200629124432.GE4468@osiris>
References: <20200417150151.17239-1-david@redhat.com>
 <20200417150151.17239-3-david@redhat.com>
 <20200626163215.GA4268@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626163215.GA4268@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>

On Fri, Jun 26, 2020 at 06:32:15PM +0200, Heiko Carstens wrote:
> On Fri, Apr 17, 2020 at 05:01:51PM +0200, David Hildenbrand wrote:
> > Commit 50be63450728 ("s390/mm: Convert bootmem to memblock") mentions
> > 	"The original bootmem allocator is getting replaced by memblock. To
> > 	cover the needs of the s390 kdump implementation the physical
> > 	memory list is used."
> > 
> > zcore was converted to use resources instead of memblocks.
> > memblock_discard() will *not* mess with "physmem", only with "memory" and
> > "reserved" memblocks. So, that data will stay after early boot, to be
> > used in arch/s390/kernel/crash_dump.c to create the ELF header from
> > inside the 2nd (a.k.a. dumping) kernel.
> > 
> > We no longer need ARCH_KEEP_MEMBLOCK.
> > 
> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > Cc: Philipp Rudo <prudo@linux.ibm.com>
> > Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  arch/s390/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> 
> Applied, thanks!

Hmm, this triggers:

WARNING: modpost: vmlinux.o(.text+0x1e7c2): Section mismatch in reference from the function elfcorehdr_alloc() to the variable .meminit.data:memblock
The function elfcorehdr_alloc() references
the variable __meminitdata memblock.
This is often because elfcorehdr_alloc lacks a __meminitdata 
annotation or the annotation of memblock is wrong.

WARNING: modpost: vmlinux.o(.text+0x1e800): Section mismatch in reference from the function elfcorehdr_alloc() to the function .meminit.text:__next_mem_range()
The function elfcorehdr_alloc() references
the function __meminit __next_mem_range().
This is often because elfcorehdr_alloc lacks a __meminit 
annotation or the annotation of __next_mem_range is wrong.

WARNING: modpost: vmlinux.o(.text+0x1e844): Section mismatch in reference from the function elfcorehdr_alloc() to the function .meminit.text:__next_mem_range()
The function elfcorehdr_alloc() references
the function __meminit __next_mem_range().
This is often because elfcorehdr_alloc lacks a __meminit 
annotation or the annotation of __next_mem_range is wrong.

So, reverted again ;)
