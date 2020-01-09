Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44445 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728435AbgAINuP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jan 2020 08:50:15 -0500
Date: Thu, 9 Jan 2020 14:50:06 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] KVM: s390: check if kernel irqchip is actually enabled
Message-ID: <20200109145006.21f0a065.cohuck@redhat.com>
In-Reply-To: <20200109134713.14755-1-cohuck@redhat.com>
References: <20200109134713.14755-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org

On Thu,  9 Jan 2020 14:47:13 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On s390, we only allow userspace to create an in-kernel irqchip
> if it has first enabled the KVM_CAP_S390_IRQCHIP vm capability.
> Let's assume that a userspace that enabled that capability has
> created an irqchip as well.
> 
> Fixes: 84223598778b ("KVM: s390: irq routing for adapter interrupts.")
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> A more precise check would be to add a field in kvm_arch that tracks
> whether an irqchip has actually been created; not sure if that is
> really needed.
> 
> Found while trying to hunt down QEMU crashes with kvm-irqchip=off;

s/kvm-irqchip/kernel_irqchip/

> this is not sufficient, though. I *think* everything but irqfds
> should work without kvm-irqchip as well, but have not found the problem
> yet.
> 
> ---
>  arch/s390/kvm/irq.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/irq.h b/arch/s390/kvm/irq.h
> index 484608c71dd0..30e13d031379 100644
> --- a/arch/s390/kvm/irq.h
> +++ b/arch/s390/kvm/irq.h
> @@ -13,7 +13,7 @@
>  
>  static inline int irqchip_in_kernel(struct kvm *kvm)
>  {
> -	return 1;
> +	return !!kvm->arch.use_irqchip;
>  }
>  
>  #endif
