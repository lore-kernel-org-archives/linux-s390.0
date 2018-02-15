From: Farhan Ali <alifm@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] KVM: s390: Add storage key facility interpretation
 control
Date: Thu, 15 Feb 2018 15:27:54 -0500
Message-ID: <4e2896a6-3e38-fa0c-a9f2-9aa8faa184ee@linux.vnet.ibm.com>
References: <28551222-18a6-4566-0b7a-acc366c860c3@redhat.com>
 <1518709402-91101-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518709402-91101-3-git-send-email-frankja@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1518709402-91101-3-git-send-email-frankja@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Reviewed-by: Farhan Ali <alifm@linux.vnet.ibm.com>

On 02/15/2018 10:43 AM, Janosch Frank wrote:
> Up to now we always expected to have the storage key facility
> available for our (non-VSIE) KVM guests. For huge page support, we
> need to be able to disable it, so let's introduce that now.
> 
> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h |  1 +
>   arch/s390/kvm/kvm-s390.c         |  1 +
>   arch/s390/kvm/priv.c             | 22 +++++++++++++---------
>   3 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index b768754..ccbbd12 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -793,6 +793,7 @@ struct kvm_arch{
>   	int use_irqchip;
>   	int has_cmma;
>   	int has_pfmfi;
> +	int has_skf;
>   	int user_cpu_state_ctrl;
>   	int user_sigp;
>   	int user_stsi;
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 781aaf0..ddf3599 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2010,6 +2010,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>   	kvm->arch.css_support = 0;
>   	kvm->arch.use_irqchip = 0;
>   	kvm->arch.has_pfmfi = sclp.has_pfmfi;
> +	kvm->arch.has_skf = sclp.has_skey;
>   	kvm->arch.epoch = 0;
> 
>   	spin_lock_init(&kvm->arch.start_stop_lock);
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index 908b579..c74ad22 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -208,19 +208,23 @@ int kvm_s390_skey_check_enable(struct kvm_vcpu *vcpu)
>   	struct kvm_s390_sie_block *sie_block = vcpu->arch.sie_block;
> 
>   	trace_kvm_s390_skey_related_inst(vcpu);
> -	if (!(sie_block->ictl & (ICTL_ISKE | ICTL_SSKE | ICTL_RRBE)) &&
> +	/* Already enabled? */
> +	if (vcpu->kvm->arch.has_skf &&
> +	    !(sie_block->ictl & (ICTL_ISKE | ICTL_SSKE | ICTL_RRBE)) &&
>   	    !kvm_s390_test_cpuflags(vcpu, CPUSTAT_KSS))
>   		return rc;
> 
>   	rc = s390_enable_skey();
>   	VCPU_EVENT(vcpu, 3, "enabling storage keys for guest: %d", rc);
> -	if (!rc) {
> -		if (kvm_s390_test_cpuflags(vcpu, CPUSTAT_KSS))
> -			kvm_s390_clear_cpuflags(vcpu, CPUSTAT_KSS);
> -		else
> -			sie_block->ictl &= ~(ICTL_ISKE | ICTL_SSKE |
> -					     ICTL_RRBE);
> -	}
> +	if (rc)
> +		return rc;
> +
> +	if (kvm_s390_test_cpuflags(vcpu, CPUSTAT_KSS))
> +		kvm_s390_clear_cpuflags(vcpu, CPUSTAT_KSS);
> +	if (!vcpu->kvm->arch.has_skf)
> +		sie_block->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
> +	else
> +		sie_block->ictl &= ~(ICTL_ISKE | ICTL_SSKE | ICTL_RRBE);
>   	return rc;
>   }
> 
> @@ -231,7 +235,7 @@ static int try_handle_skey(struct kvm_vcpu *vcpu)
>   	rc = kvm_s390_skey_check_enable(vcpu);
>   	if (rc)
>   		return rc;
> -	if (sclp.has_skey) {
> +	if (vcpu->kvm->arch.has_skf) {
>   		/* with storage-key facility, SIE interprets it for us */
>   		kvm_s390_retry_instr(vcpu);
>   		VCPU_EVENT(vcpu, 4, "%s", "retrying storage key operation");
> 
