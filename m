Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53691 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725791AbgAIN5v (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jan 2020 08:57:51 -0500
Subject: Re: [PATCH] KVM: s390: check if kernel irqchip is actually enabled
References: <20200109134713.14755-1-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6020c443-a5b4-8064-87b6-a61e1b0b7c40@redhat.com>
Date: Thu, 9 Jan 2020 14:57:43 +0100
MIME-Version: 1.0
In-Reply-To: <20200109134713.14755-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org

On 09.01.20 14:47, Cornelia Huck wrote:
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
> 

This function is used on s390x/common code only in

virt/kvm/irqchip.c:kvm_send_userspace_msi()

That function is only used with CONFIG_HAVE_KVM_MSI. That is not
selected for s390x.

What does this patch fix?

-- 
Thanks,

David / dhildenb
