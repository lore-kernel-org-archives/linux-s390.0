From: David Hildenbrand <david@redhat.com>
Subject: Re: [GIT PULL 4/4] KVM: s390: Support keyless subset guest mode
Date: Fri, 21 Apr 2017 14:15:22 +0200
Message-ID: <00eaf534-b042-a09e-933f-cb051816fea2@redhat.com>
References: <1492769385-237420-1-git-send-email-borntraeger@de.ibm.com>
 <1492769385-237420-5-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1492769385-237420-5-git-send-email-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Farhan Ali <alifm@linux.vnet.ibm.com>, "Corey S . McQuay" <csmcquay@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 025b1f2..4719ecb 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -117,6 +117,8 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  		newflags |= cpuflags & CPUSTAT_SM;
>  	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_IBS))
>  		newflags |= cpuflags & CPUSTAT_IBS;
> +	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_KSS))
> +		newflags |= cpuflags & CPUSTAT_KSS;
>  
>  	atomic_set(&scb_s->cpuflags, newflags);
>  	return 0;
> @@ -289,7 +291,9 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  	 * bits. Therefore we cannot provide interpretation and would later
>  	 * have to provide own emulation handlers.
>  	 */
> -	scb_s->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
> +	if (!(atomic_read(&scb_s->cpuflags) & CPUSTAT_KSS))
> +		scb_s->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
> +
What would actually happen, if ICTL_ISKE | ICTL_SSKE | ICTL_RRBE remain
set? I assume KSS will dominate? Or are there any validity interceptions
defined for this?

-- 

Thanks,

David
