From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH 19/22] s390/mm: Split huge pages if granular
 protection is needed
Date: Thu, 7 Dec 2017 17:32:52 +0100
Message-ID: <e3030116-81cf-b419-97ab-8bd863317222@redhat.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1510007400-42493-20-git-send-email-frankja@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1510007400-42493-20-git-send-email-frankja@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 06.11.2017 23:29, Janosch Frank wrote:
> A guest can put DAT tables for a lower level guest in the same huge
> segment as one of its prefixes. This would make it necessary for the
> segment to be unprotected (because of the prefix) and protected
> (because of the shadowing) at the same time. This is not possible in
> this universe.
> 
> Hence we split the affected huge segment, so we can protect on a
> per-page basis. Such gmap segments are special and get a new software
> bit, that helps us handling this edge case.

I am thinking about another condition and am not sure yet if it is
really a problem and already handled by this patch (if so, feel free to
add it to the description :) ): G2 -> G3 page table and a contained G2
-> G3 page lying on same G1 huge page

G1 runs G2 with huge pages.
G2 runs G3 without huge pages,
G1 creates shadow page tables for G3.

G2 has no idea of huge pages, so it could happen that a
page table from G2 -> G3 falls into the same G1 huge page as a G2->G3
backing page.

Now, if we're unlucky, it can happen that this page table references
that G3 page, lying on the same G1 huge page.

G1 will create a shadow page table, protecting access to this huge page
(do maintain the shadow properly).

What will happen when G3 tries to write to this page:

1. Shadow page table in G1 is built, huge page is protected in g2 gmap.
2. Part of that huge page is to be used in the shadow page table with
write access. This huge page is protected but we need write access, we
need to fixup.
3. Fixing up will invalidate the shadow page table.

IOW, G3 will never make progress.


-- 

Thanks,

David / dhildenb
