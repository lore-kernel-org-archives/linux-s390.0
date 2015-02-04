From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/7] KVM: s390/CPACF: Choose crypto control block format
Date: Wed, 04 Feb 2015 14:00:40 +0100
Message-ID: <54D217F8.5050302@redhat.com>
References: <1423043092-34044-1-git-send-email-borntraeger@de.ibm.com> <1423043092-34044-5-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1423043092-34044-5-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 04/02/2015 10:44, Christian Borntraeger wrote:
> +static void kvm_s390_set_crycb_format(struct kvm *kvm)
> +{
> +	kvm->arch.crypto.crycbd = (__u32)(unsigned long) kvm->arch.crypto.crycb;
> +
> +	if (kvm_s390_apxa_installed())
> +		kvm->arch.crypto.crycbd |= CRYCB_FORMAT2;
> +	else
> +		kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
> +}
> +
>  static int kvm_s390_crypto_init(struct kvm *kvm)
>  {
>  	if (!test_vfacility(76))
> @@ -663,8 +709,7 @@ static int kvm_s390_crypto_init(struct kvm *kvm)
>  	if (!kvm->arch.crypto.crycb)
>  		return -ENOMEM;
>  
> -	kvm->arch.crypto.crycbd = (__u32) (unsigned long) kvm->arch.crypto.crycb |
> -				  CRYCB_FORMAT1;
> +	kvm_s390_set_crycb_format(kvm);

Could this also be part of the "things" that KVM can choose to enable,
even though it's not a facility?

Paolo
