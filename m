From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 3/4] KVM: s390: Fix possible memory leak in SIGP functions
Date: Tue, 25 Mar 2014 15:02:42 +0100
Message-ID: <53318C82.80600@redhat.com>
References: <1395754523-43697-1-git-send-email-borntraeger@de.ibm.com> <1395754523-43697-4-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1395754523-43697-4-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Il 25/03/2014 14:35, Christian Borntraeger ha scritto:
> From: Thomas Huth <thuth@linux.vnet.ibm.com>
>
> When kvm_get_vcpu() returned NULL for the destination CPU in
> __sigp_emergency() or __sigp_external_call(), the memory for the
> "inti" structure was not released anymore. This patch fixes this
> issue by moving the check for !dst_vcpu before the kzalloc() call.
>
> Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Should patch 2 and this one have a Cc: stable?

Paolo

> ---
>  arch/s390/kvm/sigp.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
> index 3fe44c4..26caeb5 100644
> --- a/arch/s390/kvm/sigp.c
> +++ b/arch/s390/kvm/sigp.c
> @@ -58,7 +58,9 @@ static int __sigp_emergency(struct kvm_vcpu *vcpu, u16 cpu_addr)
>  	struct kvm_s390_interrupt_info *inti;
>  	struct kvm_vcpu *dst_vcpu = NULL;
>
> -	if (cpu_addr >= KVM_MAX_VCPUS)
> +	if (cpu_addr < KVM_MAX_VCPUS)
> +		dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
> +	if (!dst_vcpu)
>  		return SIGP_CC_NOT_OPERATIONAL;
>
>  	inti = kzalloc(sizeof(*inti), GFP_KERNEL);
> @@ -68,9 +70,6 @@ static int __sigp_emergency(struct kvm_vcpu *vcpu, u16 cpu_addr)
>  	inti->type = KVM_S390_INT_EMERGENCY;
>  	inti->emerg.code = vcpu->vcpu_id;
>
> -	dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
> -	if (!dst_vcpu)
> -		return SIGP_CC_NOT_OPERATIONAL;
>  	li = &dst_vcpu->arch.local_int;
>  	spin_lock_bh(&li->lock);
>  	list_add_tail(&inti->list, &li->list);
> @@ -121,7 +120,9 @@ static int __sigp_external_call(struct kvm_vcpu *vcpu, u16 cpu_addr)
>  	struct kvm_s390_interrupt_info *inti;
>  	struct kvm_vcpu *dst_vcpu = NULL;
>
> -	if (cpu_addr >= KVM_MAX_VCPUS)
> +	if (cpu_addr < KVM_MAX_VCPUS)
> +		dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
> +	if (!dst_vcpu)
>  		return SIGP_CC_NOT_OPERATIONAL;
>
>  	inti = kzalloc(sizeof(*inti), GFP_KERNEL);
> @@ -131,9 +132,6 @@ static int __sigp_external_call(struct kvm_vcpu *vcpu, u16 cpu_addr)
>  	inti->type = KVM_S390_INT_EXTERNAL_CALL;
>  	inti->extcall.code = vcpu->vcpu_id;
>
> -	dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
> -	if (!dst_vcpu)
> -		return SIGP_CC_NOT_OPERATIONAL;
>  	li = &dst_vcpu->arch.local_int;
>  	spin_lock_bh(&li->lock);
>  	list_add_tail(&inti->list, &li->list);
>
