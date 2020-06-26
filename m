Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726252AbgFZQcX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 26 Jun 2020 12:32:23 -0400
Date: Fri, 26 Jun 2020 18:32:15 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH RFC 2/2] s390/mm: don't set ARCH_KEEP_MEMBLOCK
Message-ID: <20200626163215.GA4268@osiris>
References: <20200417150151.17239-1-david@redhat.com>
 <20200417150151.17239-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417150151.17239-3-david@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>

On Fri, Apr 17, 2020 at 05:01:51PM +0200, David Hildenbrand wrote:
> Commit 50be63450728 ("s390/mm: Convert bootmem to memblock") mentions
> 	"The original bootmem allocator is getting replaced by memblock. To
> 	cover the needs of the s390 kdump implementation the physical
> 	memory list is used."
> 
> zcore was converted to use resources instead of memblocks.
> memblock_discard() will *not* mess with "physmem", only with "memory" and
> "reserved" memblocks. So, that data will stay after early boot, to be
> used in arch/s390/kernel/crash_dump.c to create the ELF header from
> inside the 2nd (a.k.a. dumping) kernel.
> 
> We no longer need ARCH_KEEP_MEMBLOCK.
> 
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Philipp Rudo <prudo@linux.ibm.com>
> Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks!
