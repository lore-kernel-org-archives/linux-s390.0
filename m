Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29743 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727671AbgBJOr4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 09:47:56 -0500
Date: Mon, 10 Feb 2020 15:47:43 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 32/35] KVM: s390: protvirt: Mask PSW interrupt bits for
 interception 104 and 112
Message-ID: <20200210154743.004f9bdb.cohuck@redhat.com>
In-Reply-To: <305c63ba-b9f1-aa88-7006-709c85006cda@de.ibm.com>
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
        <20200207113958.7320-33-borntraeger@de.ibm.com>
        <20200210142845.2188b008.cohuck@redhat.com>
        <305c63ba-b9f1-aa88-7006-709c85006cda@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Mon, 10 Feb 2020 14:48:06 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index b53cabc15d9d..52a5196fe975 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4089,6 +4089,12 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
>                         memcpy(vcpu->run->s.regs.gprs,
>                                sie_page->pv_grregs,
>                                sizeof(sie_page->pv_grregs));
> +                       /*
> +                        * We're not allowed to inject interrupts on intercepts
> +                        * that leave the guest state in an "in-beetween" state

s/beetween/between/ here as well :)

> +                        * where the next SIE entry will do a continuation.
> +                        * Fence interrupts in our "internal" PSW.
> +                        */
>                         if (vcpu->arch.sie_block->icptcode == ICPT_PV_INSTR ||
>                             vcpu->arch.sie_block->icptcode == ICPT_PV_PREF) {
>                                 vcpu->arch.sie_block->gpsw.mask &= ~PSW_INT_MASK;

With that on top,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
