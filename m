Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24729 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730175AbgBYKci (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Feb 2020 05:32:38 -0500
Date: Tue, 25 Feb 2020 11:32:25 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 05/36] s390/mm: provide memory management functions
 for protected KVM guests
Message-ID: <20200225113225.2721d469.cohuck@redhat.com>
In-Reply-To: <20200224114107.4646-6-borntraeger@de.ibm.com>
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
        <20200224114107.4646-6-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org

On Mon, 24 Feb 2020 06:40:36 -0500
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
> 
> This provides the basic ultravisor calls and page table handling to cope
> with secure guests:
> - provide arch_make_page_accessible
> - make pages accessible after unmapping of secure guests
> - provide the ultravisor commands convert to/from secure
> - provide the ultravisor commands pin/unpin shared
> - provide callbacks to make pages secure (inacccessible)
>  - we check for the expected pin count to only make pages secure if the
>    host is not accessing them
>  - we fence hugetlbfs for secure pages
> - add missing radix-tree include into gmap.h
> 
> The basic idea is that a page can have 3 states: secure, normal or
> shared. The hypervisor can call into a firmware function called
> ultravisor that allows to change the state of a page: convert from/to
> secure. The convert from secure will encrypt the page and make it
> available to the host and host I/O. The convert to secure will remove
> the host capability to access this page.
> The design is that on convert to secure we will wait until writeback and
> page refs are indicating no host usage. At the same time the convert
> from secure (export to host) will be called in common code when the
> refcount or the writeback bit is already set. This avoids races between
> convert from and to secure.
> 
> Then there is also the concept of shared pages. Those are kind of secure
> where the host can still access those pages. We need to be notified when
> the guest "unshares" such a page, basically doing a convert to secure by
> then. There is a call "pin shared page" that we use instead of convert
> from secure when possible.
> 
> We do use PG_arch_1 as an optimization to minimize the convert from
> secure/pin shared.
> 
> Several comments have been added in the code to explain the logic in
> the relevant places.
> 
> Co-developed-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
> Signed-off-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/gmap.h        |   4 +
>  arch/s390/include/asm/mmu.h         |   2 +
>  arch/s390/include/asm/mmu_context.h |   1 +
>  arch/s390/include/asm/page.h        |   5 +
>  arch/s390/include/asm/pgtable.h     |  35 ++++-
>  arch/s390/include/asm/uv.h          |  31 ++++
>  arch/s390/kernel/uv.c               | 227 ++++++++++++++++++++++++++++
>  7 files changed, 300 insertions(+), 5 deletions(-)

My mm-fu is not very strong; but this looks sane to me.

Acked-by: Cornelia Huck <cohuck@redhat.com>
