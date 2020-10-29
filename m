Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32531 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728563AbgJ2IQJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 29 Oct 2020 04:16:09 -0400
Subject: Re: [PATCH 0/4] arch, mm: improve robustness of direct map
 manipulation
References: <20201025101555.3057-1-rppt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <30075bb8-caed-c4de-c09e-e0f6fb964a8d@redhat.com>
Date: Thu, 29 Oct 2020 09:15:47 +0100
MIME-Version: 1.0
In-Reply-To: <20201025101555.3057-1-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Lameter <cl@linux.com>, "David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, David Rientjes <rientjes@google.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Len Brown <len.brown@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Pavel Machek <pavel@ucw.cz>, Pekka Enberg <penberg@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, x86@kernel.org

On 25.10.20 11:15, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> During recent discussion about KVM protected memory, David raised a concern
> about usage of __kernel_map_pages() outside of DEBUG_PAGEALLOC scope [1].
> 
> Indeed, for architectures that define CONFIG_ARCH_HAS_SET_DIRECT_MAP it is
> possible that __kernel_map_pages() would fail, but since this function is
> void, the failure will go unnoticed.
> 
> Moreover, there's lack of consistency of __kernel_map_pages() semantics
> across architectures as some guard this function with
> #ifdef DEBUG_PAGEALLOC, some refuse to update the direct map if page
> allocation debugging is disabled at run time and some allow modifying the
> direct map regardless of DEBUG_PAGEALLOC settings.
> 
> This set straightens this out by restoring dependency of
> __kernel_map_pages() on DEBUG_PAGEALLOC and updating the call sites
> accordingly.
> 

So, I was primarily wondering if we really have to touch direct mappings 
in hibernation code, or if we can avoid doing that. I was wondering if 
we cannot simply do something like kmap() when trying to access a 
!mapped page. Similar to reading old-os memory after kexec when in 
kdump. Just a thought.

-- 
Thanks,

David / dhildenb
