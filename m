From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v9 14/22] KVM: s390: interfaces to clear CRYCB masks
Date: Wed, 15 Aug 2018 15:10:39 +0200
Message-ID: <20180815151039.63d83d5d.cohuck@redhat.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-15-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534196899-16987-15-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 13 Aug 2018 17:48:11 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Introduces two new KVM interface to clear the APM, AQM and ADM masks in
> the guest's CRYCB.  The VCPUs are taken out of SIE to ensure the VCPUs do
> not get out of sync.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |    3 +++
>  arch/s390/kvm/kvm-s390.c         |   15 +++++++++++++++
>  2 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 4a739d4..07e58d8 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -258,6 +258,7 @@ struct kvm_s390_sie_block {
>  	__u64	tecmc;			/* 0x00e8 */
>  	__u8	reservedf0[12];		/* 0x00f0 */
>  #define CRYCB_FORMAT_MASK 0x00000003
> +#define CRYCB_FORMAT0 0x00000000

This should probably go into a different patch (define is not used
here)?

>  #define CRYCB_FORMAT1 0x00000001
>  #define CRYCB_FORMAT2 0x00000003
>  	__u32	crycbd;			/* 0x00fc */
> @@ -861,6 +862,8 @@ void kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
>  void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
>  				 struct kvm_async_pf *work);
>  
> +void kvm_arch_crypto_clear_masks(struct kvm *kvm);
> +
>  extern int sie64a(struct kvm_s390_sie_block *, u64 *);
>  extern char sie_exit;
>  
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index f7de123..8d8a65a 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -1919,6 +1919,21 @@ static void kvm_s390_set_crycb_format(struct kvm *kvm)
>  		kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
>  }
>  
> +void kvm_arch_crypto_clear_masks(struct kvm *kvm)
> +{
> +	mutex_lock(&kvm->lock);
> +	kvm_s390_vcpu_block_all(kvm);
> +
> +	memset(&kvm->arch.crypto.crycb->apcb0, 0,
> +	       sizeof(kvm->arch.crypto.crycb->apcb0));
> +	memset(&kvm->arch.crypto.crycb->apcb1, 0,
> +	       sizeof(kvm->arch.crypto.crycb->apcb1));
> +
> +	kvm_s390_vcpu_unblock_all(kvm);
> +	mutex_unlock(&kvm->lock);
> +}
> +EXPORT_SYMBOL(kvm_arch_crypto_clear_masks);

A quick grep shows that kvm-related exports tend to be
EXPORT_SYMBOL_GPL. Should that also be done here?

> +
>  static u64 kvm_s390_get_initial_cpuid(void)
>  {
>  	struct cpuid cpuid;
