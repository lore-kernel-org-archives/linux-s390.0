From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Date: Thu, 02 Aug 2018 11:38:19 +0000
Subject: Re: [PATCH] KVM: s390: Make huge pages unavailable in ucontrol vms
Message-Id: <20180802133819.55db0006@p-imbrenda.boeblingen.de.ibm.com>
In-Reply-To: <c5536333-1e09-cabc-a282-df95f48ed068@linux.ibm.com>
References: <c5536333-1e09-cabc-a282-df95f48ed068@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed,  1 Aug 2018 12:25:08 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> We currently do not notify all gmaps when using gmap_pmdp_xchg(), due
> to locking constraints. This makes ucontrol vms, which is the only vm
> type that creates multiple gmaps, incompatible with huge pages.
> 
> ucontrol vms are rather exotic and creating a new locking concept is
> no easy task. Hence we return EINVAL when trying to active
> KVM_CAP_S390_HPAGE_1M and report it as being not available when
> checking for it.

makes sense
 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index f9d90337e64a..549f38d1baa1 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -481,7 +481,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm,
> long ext) break;
>  	case KVM_CAP_S390_HPAGE_1M:
>  		r = 0;
> -		if (hpage)
> +		if (hpage && !kvm_is_ucontrol(kvm))
>  			r = 1;
>  		break;
>  	case KVM_CAP_S390_MEM_OP:
> @@ -691,7 +691,7 @@ static int kvm_vm_ioctl_enable_cap(struct kvm
> *kvm, struct kvm_enable_cap *cap) mutex_lock(&kvm->lock);
>  		if (kvm->created_vcpus)
>  			r = -EBUSY;
> -		else if (!hpage || kvm->arch.use_cmma)
> +		else if (!hpage || kvm->arch.use_cmma ||
> kvm_is_ucontrol(kvm)) r = -EINVAL;
>  		else {
>  			r = 0;

the patch is rather straightforward

Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
