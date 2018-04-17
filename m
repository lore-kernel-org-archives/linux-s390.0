From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 02/15] KVM: s390: reset crypto attributes for all
 vcpus
Date: Tue, 17 Apr 2018 13:34:03 +0200
Message-ID: <20180417133403.6fd7627a.cohuck@redhat.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1523827345-11600-3-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523827345-11600-3-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Sun, 15 Apr 2018 17:22:12 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> Introduces a new function to reset the crypto attributes for all
> vcpus whether they are running or not. Each vcpu in KVM will
> be removed from SIE prior to resetting the crypto attributes in its
> SIE state description. After all vcpus have had their crypto attributes
> reset the vcpus will be restored to SIE.
> 
> This function will be used in a later patch to set the ECA.28
> bit in the SIE state description to enable interpretive execution of
> AP instructions. It will also be incorporated into the
> kvm_s390_vm_set_crypto(kvm) function to fix an issue whereby the crypto
> key wrapping attributes could potentially get out of synch for running
> vcpus.

So, this description leads me to think it would make sense to queue
this patch (fixing the key wrapping) independently of this series,
wouldn't it?

> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c |   19 +++++++++++++------
>  arch/s390/kvm/kvm-s390.h |   14 ++++++++++++++
>  2 files changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 64c9862..d0c3518 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -791,11 +791,21 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
>  
>  static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu);
>  
> -static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
> +void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)

_reset_all() or _set_all()? Don't really care much, tbh.

>  {
> -	struct kvm_vcpu *vcpu;
>  	int i;
> +	struct kvm_vcpu *vcpu;

I'd avoid swapping the order of the declarations.

> +
> +	kvm_s390_vcpu_block_all(kvm);
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm)
> +		kvm_s390_vcpu_crypto_setup(vcpu);
>  
> +	kvm_s390_vcpu_unblock_all(kvm);
> +}
> +
> +static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
> +{
>  	if (!test_kvm_facility(kvm, 76))
>  		return -EINVAL;
>  
> @@ -832,10 +842,7 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
>  		return -ENXIO;
>  	}
>  
> -	kvm_for_each_vcpu(i, vcpu, kvm) {
> -		kvm_s390_vcpu_crypto_setup(vcpu);
> -		exit_sie(vcpu);
> -	}
> +	kvm_s390_vcpu_crypto_reset_all(kvm);
>  	mutex_unlock(&kvm->lock);
>  	return 0;
>  }
> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> index 1b5621f..76324b7 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/kvm-s390.h
> @@ -410,4 +410,18 @@ static inline int kvm_s390_use_sca_entries(void)
>  }
>  void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
>  				     struct mcck_volatile_info *mcck_info);
> +
> +/**
> + * kvm_s390_vcpu_crypto_reset_all
> + *
> + * Reset the crypto attributes for each vcpu. This can be done while the vcpus
> + * are running as each vcpu will be removed from SIE before resetting the crypto
> + * attributes and restored to SIE afterward.
> + *
> + * Note: The kvm->lock mutex must be locked prior to calling this function and
> + *	 unlocked after it returns.

"Must be called with kvm->lock held"?

> + *
> + * @kvm: the KVM guest
> + */
> +void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm);
>  #endif

Other than the nits above, looks good to me.
