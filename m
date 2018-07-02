From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCHi v2] mm: do not drop unused pages when userfaultd is
 running
Date: Mon, 2 Jul 2018 14:06:38 -0700
Message-ID: <20180702140638.eb3edfaa611ba9fa018f92eb@linux-foundation.org>
References: <20180702075049.9157-1-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702075049.9157-1-borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-mm@kvack.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon,  2 Jul 2018 09:50:49 +0200 Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> KVM guests on s390 can notify the host of unused pages. This can result
> in pte_unused callbacks to be true for KVM guest memory.
> 
> If a page is unused (checked with pte_unused) we might drop this page
> instead of paging it. This can have side-effects on userfaultd, when the
> page in question was already migrated:
> 
> The next access of that page will trigger a fault and a user fault
> instead of faulting in a new and empty zero page. As QEMU does not
> expect a userfault on an already migrated page this migration will fail.
> 
> The most straightforward solution is to ignore the pte_unused hint if a
> userfault context is active for this VMA.
> 
> ...
>
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -64,6 +64,7 @@
>  #include <linux/backing-dev.h>
>  #include <linux/page_idle.h>
>  #include <linux/memremap.h>
> +#include <linux/userfaultfd_k.h>
>  
>  #include <asm/tlbflush.h>
>  
> @@ -1481,7 +1482,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  				set_pte_at(mm, address, pvmw.pte, pteval);
>  			}
>  
> -		} else if (pte_unused(pteval)) {
> +		} else if (pte_unused(pteval) && !userfaultfd_armed(vma)) {
>  			/*
>  			 * The guest indicated that the page content is of no
>  			 * interest anymore. Simply discard the pte, vmscan

A reader of this code will wonder why we're checking
userfaultfd_armed().  So the writer of this code should add a comment
which explains this to them ;)  Please.
