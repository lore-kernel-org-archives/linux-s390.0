Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38963 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726540AbgGGMI7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Jul 2020 08:08:59 -0400
Date: Tue, 7 Jul 2020 14:08:49 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v1 0/9] s390: implement and optimize vmemmap_free()
Message-ID: <20200707120849.GB12303@osiris>
References: <20200703133917.39045-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703133917.39045-1-david@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, Christian Borntraeger <borntraeger@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On Fri, Jul 03, 2020 at 03:39:08PM +0200, David Hildenbrand wrote:
> This series is based on the latest s390/features branch [1]. It implements
> vmemmap_free(), consolidating it with vmem_add_range(), and optimizes it by
> - Freeing empty page tables (now also done for idendity mapping).
> - Handling cases where the vmemmap of a section does not fill huge pages
>   completely.
> 
> vmemmap_free() is currently never used, unless adiing standby memory fails
> (unlikely). This is relevant for virtio-mem, which adds/removes memory
> in memory block/section granularity (always removes memory in the same
> granularity it added it).
> 
> I gave this a proper test with my virtio-mem prototype (which I will share
> once the basic QEMU implementation is upstream), both with 56 byte memmap
> per page and 64 byte memmap per page, with and without huge page support.
> In both cases, removing memory (routed through arch_remove_memory()) will
> result in
> - all populated vmemmap pages to get removed/freed
> - all applicable page tables for the vmemmap getting removed/freed
> - all applicable page tables for the idendity mapping getting removed/freed
> Unfortunately, I don't have access to bigger and z/VM (esp. dcss)
> environments.
> 
> This is the basis for real memory hotunplug support for s390x and should
> complete my journey to s390x vmem/vmemmap code for now :)
> 
> What needs double-checking is tlb flushing. AFAIKS, as there are no valid
> accesses, doing a single range flush at the end is sufficient, both when
> removing vmemmap pages and the idendity mapping.
> 
> Along, some minor cleanups.

Hmm.. I really would like to see if there would be only a single page
table walker left in vmem.c, which handles both adding and removing
things.
Now we end up with two different page table walk implementations
within the same file. However not sure if it is worth the effort to
unify them though.
