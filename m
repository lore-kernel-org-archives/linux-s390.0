Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46713 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730130AbgBYKSp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 25 Feb 2020 05:18:45 -0500
Date: Tue, 25 Feb 2020 11:18:31 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 02/36] KVM: s390/interrupt: do not pin adapter
 interrupt pages
Message-ID: <20200225111831.436c6e0a.cohuck@redhat.com>
In-Reply-To: <20200224114107.4646-3-borntraeger@de.ibm.com>
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
        <20200224114107.4646-3-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On Mon, 24 Feb 2020 06:40:33 -0500
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
> 
> The adapter interrupt page containing the indicator bits is currently
> pinned. That means that a guest with many devices can pin a lot of
> memory pages in the host. This also complicates the reference tracking
> which is needed for memory management handling of protected virtual
> machines. It might also have some strange side effects for madvise
> MADV_DONTNEED and other things.
> 
> We can simply try to get the userspace page set the bits and free the
> page. By storing the userspace address in the irq routing entry instead
> of the guest address we can actually avoid many lookups and list walks
> so that this variant is very likely not slower.
> 
> If userspace messes around with the memory slots the worst thing that
> can happen is that we write to some other memory within that process.
> As we get the the page with FOLL_WRITE this can also not be used to
> write to shared read-only pages.
> 
> Signed-off-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> [borntraeger@de.ibm.com: patch simplification]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  Documentation/virt/kvm/devices/s390_flic.rst |  11 +-
>  arch/s390/include/asm/kvm_host.h             |   3 -
>  arch/s390/kvm/interrupt.c                    | 170 ++++++-------------
>  3 files changed, 51 insertions(+), 133 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
