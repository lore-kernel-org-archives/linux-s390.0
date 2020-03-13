Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44715 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726591AbgCMMso (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 13 Mar 2020 08:48:44 -0400
Subject: Re: [PATCH] KVM: s390: pending interrupts are unlikely
References: <20200313124030.99834-1-mimu@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b31aef6d-7cf7-c870-5250-02cfd4e29542@redhat.com>
Date: Fri, 13 Mar 2020 13:48:37 +0100
MIME-Version: 1.0
In-Reply-To: <20200313124030.99834-1-mimu@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com

On 13.03.20 13:40, Michael Mueller wrote:
> A statistical analysis shows that in most cases when deliverable_irqs()
> is called, no interrupts are pending. (see: early exit ratio)
> 
> The data was sampled during an iperf3 run over virtio_net
> between one guest and the host.
> 
> deliverable_irqs()
>         called = 3145123
>            by kvm_s390_vcpu_has_irq() = 3005581 (95.56%)
>               by kvm_arch_vcpu_runnable() = 3005578 (95.56%)
>                  by kvm_s390_handle_wait() = 1219331 (38.76%)
>                  by kvm_vcpu_check_block() = 2943565 (93.59%)
>                     by kvm_cpu_block(1) = 2826431 (89.86%)
>                     by kvm_cpu_block(2) = 117136 (3.72%)
>                  by kvm_arch_dy_runnable() = 0 (0%)
>               by kvm_arch_setup_async_pf() = 0 (0%)
>               by handle_stop() = 0 (0%)
>            by kvm_s390_deliver_pending_interrupt() = 139542 (4.43%)
>               irqs_delivered = (0:15917 1:61810 2:1 3:0 4:0 x:0)
>               irqs_pending = (0:15917 1:61722 2:86 3:1 4:0 x:0)
>     early exit = 3021787 (96.07%)
>   pending irqs = 123237 (3.91%)
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 028167d6eacd..c34d62b4209e 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -369,7 +369,7 @@ static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu)
>  	unsigned long active_mask;
>  
>  	active_mask = pending_irqs(vcpu);
> -	if (!active_mask)
> +	if (likely(!active_mask))
>  		return 0;
>  
>  	if (psw_extint_disabled(vcpu))
> 

Is this change even observable in practice? Usually, we do have some
performance numbers backing such micro optimizations. But I guess it
will be fairly hard to get some meaning full numbers backing this ...

-- 
Thanks,

David / dhildenb
