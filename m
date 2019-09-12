Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730434AbfILJOO (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Sep 2019 05:14:14 -0400
Subject: Re: [PATCH] KVM: s390: Do not leak kernel stack data in the
 KVM_S390_INTERRUPT ioctl
References: <20190912090050.20295-1-thuth@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6905df78-95f0-3d6d-aaae-910cd2d7a232@redhat.com>
Date: Thu, 12 Sep 2019 11:14:11 +0200
MIME-Version: 1.0
In-Reply-To: <20190912090050.20295-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 12.09.19 11:00, Thomas Huth wrote:
> When the userspace program runs the KVM_S390_INTERRUPT ioctl to inject
> an interrupt, we convert them from the legacy struct kvm_s390_interrupt
> to the new struct kvm_s390_irq via the s390int_to_s390irq() function.
> However, this function does not take care of all types of interrupts
> that we can inject into the guest later (see do_inject_vcpu()). Since we
> do not clear out the s390irq values before calling s390int_to_s390irq(),
> there is a chance that we copy unwanted data from the kernel stack
> into the guest memory later if the interrupt data has not been properly
> initialized by s390int_to_s390irq().
> 
> Specifically, the problem exists with the KVM_S390_INT_PFAULT_INIT
> interrupt: s390int_to_s390irq() does not handle it, but the function
> __deliver_pfault_init() will later copy the uninitialized stack data
> from the ext.ext_params2 into the guest memory.
> 
> Fix it by handling that interrupt type in s390int_to_s390irq(), too.
> And while we're at it, make sure that s390int_to_s390irq() now
> directly returns -EINVAL for unknown interrupt types, so that we
> do not run into this problem again in case we add more interrupt
> types to do_inject_vcpu() sometime in the future.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/s390/kvm/interrupt.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 3e7efdd9228a..165dea4c7f19 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -1960,6 +1960,16 @@ int s390int_to_s390irq(struct kvm_s390_interrupt *s390int,
>  	case KVM_S390_MCHK:
>  		irq->u.mchk.mcic = s390int->parm64;
>  		break;
> +	case KVM_S390_INT_PFAULT_INIT:
> +		irq->u.ext.ext_params = s390int->parm;
> +		irq->u.ext.ext_params2 = s390int->parm64;
> +		break;
> +	case KVM_S390_RESTART:
> +	case KVM_S390_INT_CLOCK_COMP:
> +	case KVM_S390_INT_CPU_TIMER:
> +		break;
> +	default:
> +		return -EINVAL;
>  	}
>  	return 0;
>  }
> 

Wouldn't a safe fix be to initialize the struct to zero in the caller?

-- 

Thanks,

David / dhildenb
