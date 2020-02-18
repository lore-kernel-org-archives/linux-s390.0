Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34243 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726193AbgBRInE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 18 Feb 2020 03:43:04 -0500
Subject: Re: [PATCH v2 26/42] KVM: s390: protvirt: Do only reset registers
 that are accessible
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-27-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9b66eb07-9755-4afe-6837-6197acd5fa09@redhat.com>
Date: Tue, 18 Feb 2020 09:42:53 +0100
MIME-Version: 1.0
In-Reply-To: <20200214222658.12946-27-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 14.02.20 23:26, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
> 
> For protected VMs the hypervisor can not access guest breaking event
> address, program parameter, bpbc and todpr. Do not reset those fields
> as the control block does not provide access to these fields.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index d20a7fa9d480..5b551cc73540 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3442,14 +3442,16 @@ static void kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
>  	kvm_s390_set_prefix(vcpu, 0);
>  	kvm_s390_set_cpu_timer(vcpu, 0);
>  	vcpu->arch.sie_block->ckc = 0;
> -	vcpu->arch.sie_block->todpr = 0;
>  	memset(vcpu->arch.sie_block->gcr, 0, sizeof(vcpu->arch.sie_block->gcr));
>  	vcpu->arch.sie_block->gcr[0] = CR0_INITIAL_MASK;
>  	vcpu->arch.sie_block->gcr[14] = CR14_INITIAL_MASK;
>  	vcpu->run->s.regs.fpc = 0;
> -	vcpu->arch.sie_block->gbea = 1;
> -	vcpu->arch.sie_block->pp = 0;
> -	vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
> +	if (!kvm_s390_pv_handle_cpu(vcpu)) {

Shouldn't we instead check if the VM is in PV mode? (with changed
lifecycle handling). Easier to understand.

(side not: the name kvm_s390_pv_handle_cpu() is very confusing. I'd
suggest kvm_s390_pv_cpu_get_handle(). Will reply to the other patch)

> +		vcpu->arch.sie_block->gbea = 1;
> +		vcpu->arch.sie_block->pp = 0;
> +		vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
> +		vcpu->arch.sie_block->todpr = 0;
> +	}
>  }
>  
>  static void kvm_arch_vcpu_ioctl_clear_reset(struct kvm_vcpu *vcpu)
> 


-- 
Thanks,

David / dhildenb
