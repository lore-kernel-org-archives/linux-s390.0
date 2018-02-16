From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH RFC 3/6] KVM: s390: consider epoch index on hotplugged
 CPUs
Date: Fri, 16 Feb 2018 10:50:32 +0100
Message-ID: <4b5a5ef5-4721-8a2d-1ad2-caba98af9ae8@de.ibm.com>
References: <20180207114647.6220-1-david@redhat.com>
 <20180207114647.6220-4-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180207114647.6220-4-david@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 02/07/2018 12:46 PM, David Hildenbrand wrote:
> We must copy both, the epoch and the epoch_idx.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Thanks applied. Deserves a cc stable I think.

> ---
>  arch/s390/kvm/kvm-s390.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index b514ee427077..d007b737cd4d 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2387,6 +2387,7 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>  	mutex_lock(&vcpu->kvm->lock);
>  	preempt_disable();
>  	vcpu->arch.sie_block->epoch = vcpu->kvm->arch.epoch;
> +	vcpu->arch.sie_block->epdx = vcpu->kvm->arch.epdx;
>  	preempt_enable();
>  	mutex_unlock(&vcpu->kvm->lock);
>  	if (!kvm_is_ucontrol(vcpu->kvm)) {
> 
