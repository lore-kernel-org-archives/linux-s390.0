Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46766 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728179AbgBULrx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 21 Feb 2020 06:47:53 -0500
Subject: Re: [PATCH v3 09/37] KVM: s390: protvirt: Add initial vm and cpu
 lifecycle handling
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
 <20200220104020.5343-10-borntraeger@de.ibm.com>
 <1f0c2c5a-5964-dc34-73af-7b1776391276@redhat.com>
 <b9aa96ce-9701-cefb-68d8-76d1cba4d5c7@de.ibm.com>
 <abcad458-ff2d-2ec0-6a3c-f4491336d743@redhat.com>
 <947e04fa-d5d3-f352-3b58-766dd463bfd9@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <712d6bb8-81d8-31d1-662b-7de270d204b5@redhat.com>
Date: Fri, 21 Feb 2020 12:47:42 +0100
MIME-Version: 1.0
In-Reply-To: <947e04fa-d5d3-f352-3b58-766dd463bfd9@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

See my other mail, maybe we can merge alloc+create and handle most of
that conditional freeing in there.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 738f7fefcaec..cad04e26dccf 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2173,6 +2173,11 @@ static void kvm_s390_cpus_from_pv(struct kvm *kvm, u16 *rc, u16 *rrc)
>         struct kvm_vcpu *vcpu;
>         int i;
>  
> +       /*
> +        * we ignore failures and try to destroy as many CPUs as possible.
> +        * At the same time we must not free the assigned ressources when
> +        * this fails, as the ultravisor has still access to that memory.
> +        */

Makes sense.

>         kvm_for_each_vcpu(i, vcpu, kvm) {
>                 mutex_lock(&vcpu->mutex);
>                 kvm_s390_pv_destroy_cpu(vcpu, rc, rrc);
> @@ -2221,6 +2226,7 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
>                         kvm_s390_pv_dealloc_vm(kvm);
>                         break;
>                 }
> +               /* we never switch back to bsca from esca */
>                 r = kvm_s390_pv_create_vm(kvm, &cmd->rc, &cmd->rrc);

Helpful.

-- 
Thanks,

David / dhildenb
