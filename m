Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58212 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727983AbgBYRWV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 25 Feb 2020 12:22:21 -0500
Date: Tue, 25 Feb 2020 18:21:42 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 18/36] KVM: S390: protvirt: Introduce instruction
 data area bounce buffer
Message-ID: <20200225182142.37fbf6c3.cohuck@redhat.com>
In-Reply-To: <f8d7321e-400e-ed82-471e-166a2d18ede6@de.ibm.com>
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
        <20200224114107.4646-19-borntraeger@de.ibm.com>
        <3db82b2d-ad79-8178-e027-c19889d96558@redhat.com>
        <f8d7321e-400e-ed82-471e-166a2d18ede6@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Tue, 25 Feb 2020 08:50:47 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> This is the guest breaking event address. So a guest (and QEMU) can read it.
> It is kind of overlaid sida and gbea. Something like this:
> 
> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
> index cd81a58349a9..055bf0ec8fbb 100644
> --- a/arch/s390/kvm/pv.c
> +++ b/arch/s390/kvm/pv.c
> @@ -39,6 +39,11 @@ int kvm_s390_pv_destroy_cpu(struct kvm_vcpu *vcpu, u16 *rc, u16 *rrc)
>         vcpu->arch.sie_block->pv_handle_config = 0;
>         memset(&vcpu->arch.pv, 0, sizeof(vcpu->arch.pv));
>         vcpu->arch.sie_block->sdf = 0;
> +       /*
> +        * the sidad field (for sdf == 2) is now the gbea field (for sdf == 0).

s/the sidad/The sidad/

> +        * Use the reset value of gbea to not leak the kernel pointer of the

s/to not leak/to avoid leaking/

> +        * just free sida

s/free sida/freed sida./

> +        */
>         vcpu->arch.sie_block->gbea = 1;
>         kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
>  
