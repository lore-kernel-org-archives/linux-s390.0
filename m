Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58248 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731304AbgF3ITQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 30 Jun 2020 04:19:16 -0400
Subject: Re: [PATCH v1 1/2] mm/memblock: expose only miminal interface to
 add/walk physmem
References: <20200630081730.6862-1-david@redhat.com>
 <20200630081730.6862-2-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <db028915-dbad-6989-600a-27d9ea59ba76@redhat.com>
Date: Tue, 30 Jun 2020 10:19:06 +0200
MIME-Version: 1.0
In-Reply-To: <20200630081730.6862-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>

On 30.06.20 10:17, David Hildenbrand wrote:
> "physmem" in the memblock allocator is somewhat weird: it's not actually
> used for allocation, it's simply information collected during boot, which
> describes the unmodified physical memory map at boot time, without any
> standby/hotplugged memory. It's only used on s390x and is currently the
> only reason s390x keeps using CONFIG_ARCH_KEEP_MEMBLOCK.
> 
> Physmem isn't numa aware and current users don't specify any flags. Let's
> hide it from the user, exposing only for_each_physmem(), and simplify. The
> interface for physmem is now really minimalistic:
> - memblock_physmem_add() to add ranges
> - for_each_physmem() / __next_physmem_range() to walk physmem ranges
> 
> Don't place it into an __init section and don't discard it without
> CONFIG_ARCH_KEEP_MEMBLOCK. As we're reusing __next_mem_range(), remove
> the __meminit notifier to avoid section mismatch warnings once
> CONFIG_ARCH_KEEP_MEMBLOCK is no longer used with
> CONFIG_HAVE_MEMBLOCK_PHYS_MAP.
> 
> We can stop setting CONFIG_HAVE_MEMBLOCK_PHYS_MAP for s390x next.

(how I hate to spot typos just after I send stuff :) )

s/CONFIG_HAVE_MEMBLOCK_PHYS_MAP/CONFIG_ARCH_KEEP_MEMBLOCK/


-- 
Thanks,

David / dhildenb
