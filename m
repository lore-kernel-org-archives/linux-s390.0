Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] KVM: s390: Remove unused parameter from
 __inject_sigp_restart()
References: <20190912070250.15131-1-thuth@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2718e8a0-9ca3-4c09-b68b-6e501eb2840f@redhat.com>
Date: Thu, 12 Sep 2019 10:10:57 +0200
MIME-Version: 1.0
In-Reply-To: <20190912070250.15131-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 12.09.19 09:02, Thomas Huth wrote:
> It's not required, so drop it to make it clear that this interrupt
> does not have any extra parameters.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/s390/kvm/interrupt.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index b5fd6e85657c..3e7efdd9228a 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -1477,8 +1477,7 @@ static int __inject_sigp_stop(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
>  	return 0;
>  }
>  
> -static int __inject_sigp_restart(struct kvm_vcpu *vcpu,
> -				 struct kvm_s390_irq *irq)
> +static int __inject_sigp_restart(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
>  
> @@ -1997,7 +1996,7 @@ static int do_inject_vcpu(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
>  		rc = __inject_sigp_stop(vcpu, irq);
>  		break;
>  	case KVM_S390_RESTART:
> -		rc = __inject_sigp_restart(vcpu, irq);
> +		rc = __inject_sigp_restart(vcpu);
>  		break;
>  	case KVM_S390_INT_CLOCK_COMP:
>  		rc = __inject_ckc(vcpu);
> 

Yeah, why not

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
