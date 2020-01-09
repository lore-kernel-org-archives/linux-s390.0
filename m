Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728280AbgAIOG3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jan 2020 09:06:29 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009E3l8L076430
        for <linux-s390@vger.kernel.org>; Thu, 9 Jan 2020 09:06:28 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xe1snhfun-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 09 Jan 2020 09:06:28 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 9 Jan 2020 14:06:26 -0000
Subject: Re: [PATCH] KVM: s390: check if kernel irqchip is actually enabled
References: <20200109134713.14755-1-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 9 Jan 2020 15:06:22 +0100
MIME-Version: 1.0
In-Reply-To: <20200109134713.14755-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <dd1ea7ee-d848-63ae-8b4d-857185e32b44@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org



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

I think this is semantically wrong. We always have in-kernel irq handling.
It is actually not possible to not use it. So I understand where you are coming
from but this feels kind of wrong. 

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
