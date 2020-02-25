Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30615 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727035AbgBYLLS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Feb 2020 06:11:18 -0500
Date: Tue, 25 Feb 2020 12:11:05 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 12/36] KVM: s390: protvirt: Handle SE notification
 interceptions
Message-ID: <20200225121105.0274cbb0.cohuck@redhat.com>
In-Reply-To: <20200224114107.4646-13-borntraeger@de.ibm.com>
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
        <20200224114107.4646-13-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Mon, 24 Feb 2020 06:40:43 -0500
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Janosch Frank <frankja@linux.ibm.com>
> 
> Since there is no interception for load control and load psw
> instruction in the protected mode, we need a new way to get notified
> whenever we can inject an IRQ right after the guest has just enabled
> the possibility for receiving them.
> 
> The new interception codes solve that problem by providing a
> notification for changes to IRQ enablement relevant bits in CRs 0, 6
> and 14, as well a the machine check mask bit in the PSW.
> 
> No special handling is needed for these interception codes, the KVM
> pre-run code will consult all necessary CRs and PSW bits and inject
> IRQs the guest is enabled for.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  2 ++
>  arch/s390/kvm/intercept.c        | 11 ++++++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
