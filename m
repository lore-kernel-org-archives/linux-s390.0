From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 5/8] KVM: async_pf: Provide additional direct page notification
Date: Fri, 31 Jan 2014 12:38:35 +0100
Message-ID: <52EB8B3B.1090806@redhat.com>
References: <1391086429-43935-1-git-send-email-borntraeger@de.ibm.com> <1391086429-43935-6-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1391086429-43935-6-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Alexander Graf <agraf@suse.de>, Dominik Dingel <dingel@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Il 30/01/2014 13:53, Christian Borntraeger ha scritto:
> +static inline void kvm_async_page_present_async(struct kvm_vcpu *vcpu,
> +						struct kvm_async_pf *work)
> +{
> +#ifndef CONFIG_KVM_ASYNC_PF_SYNC
> +	kvm_arch_async_page_present(vcpu, work);
> +#endif
> +}
> +

This is not used, should it be used in kvm_check_async_pf_completion?

Paolo
