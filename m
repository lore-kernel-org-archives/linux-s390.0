Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43577 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726993AbgKJKCk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Nov 2020 05:02:40 -0500
Subject: Re: [PATCH v7 4/4] arch, mm: make kernel_page_present() always
 available
References: <20201109192128.960-1-rppt@kernel.org>
 <20201109192128.960-5-rppt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <01b18dfb-2650-f70a-8e0a-a062d96e1849@redhat.com>
Date: Tue, 10 Nov 2020 11:02:18 +0100
MIME-Version: 1.0
In-Reply-To: <20201109192128.960-5-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Lameter <cl@linux.com>, "David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, David Rientjes <rientjes@google.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Len Brown <len.brown@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Pavel Machek <pavel@ucw.cz>, Pekka Enberg <penberg@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, x86@kernel.org

On 09.11.20 20:21, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> For architectures that enable ARCH_HAS_SET_MEMORY having the ability to
> verify that a page is mapped in the kernel direct map can be useful
> regardless of hibernation.
> 
> Add RISC-V implementation of kernel_page_present(), update its forward
> declarations and stubs to be a part of set_memory API and remove ugly
> ifdefery in inlcude/linux/mm.h around current declarations of
> kernel_page_present().
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
