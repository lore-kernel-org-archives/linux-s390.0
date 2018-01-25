From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 10/12] KVM: s390: activate GISA for emulated interrupts
Date: Thu, 25 Jan 2018 18:38:35 +0100
Message-ID: <cb0e8b29-e197-ebe7-afe5-b8a738df6b48@redhat.com>
References: <20180125170608.38276-1-borntraeger@de.ibm.com>
 <20180125170608.38276-5-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180125170608.38276-5-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 25.01.2018 18:06, Christian Borntraeger wrote:
> From: Michael Mueller <mimu@linux.vnet.ibm.com>
> 
> If the AIV facility is available, a GISA will be used to manage emulated
> adapter interrupts.
> 
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 1a561ad..ec4b7bf 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2840,7 +2840,13 @@ void kvm_s390_gisa_clear(struct kvm *kvm)
>  
>  void kvm_s390_gisa_init(struct kvm *kvm)
>  {
> -	/* not implemented yet */
> +	if (!css_general_characteristics.aiv)
> +		kvm->arch.gisa = NULL;
> +	else {

Hmm, isn't it NULL as default?

if (css_general_characteristics.aiv) {

...

Anyhow,

Reviewed-by: David Hildenbrand <david@redhat.com>

> +		kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
> +		VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
> +		kvm_s390_gisa_clear(kvm);
> +	}
>  }
>  
>  void kvm_s390_gisa_destroy(struct kvm *kvm)
> 


-- 

Thanks,

David / dhildenb
