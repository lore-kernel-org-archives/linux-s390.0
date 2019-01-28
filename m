From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v6 04/13] KVM: s390: coding style
 kvm_s390_gisa_init/clear()
Date: Mon, 28 Jan 2019 15:43:58 +0100
Message-ID: <20190128154358.0b6be481@oc2783563651>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
        <20190124125939.130763-5-mimu@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124125939.130763-5-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 24 Jan 2019 13:59:30 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> The change helps to reduce line length and
> increases code readability.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

> ---
>  arch/s390/kvm/interrupt.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 2a3eb9f076c3..005dbe7252e7 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2885,20 +2885,20 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
>  
>  void kvm_s390_gisa_clear(struct kvm *kvm)
>  {
> -	if (kvm->arch.gisa) {
> -		memset(kvm->arch.gisa, 0, sizeof(struct kvm_s390_gisa));
> -		kvm->arch.gisa->next_alert = (u32)(u64)kvm->arch.gisa;
> -		VM_EVENT(kvm, 3, "gisa 0x%pK cleared", kvm->arch.gisa);
> -	}
> +	if (!kvm->arch.gisa)
> +		return;
> +	memset(kvm->arch.gisa, 0, sizeof(struct kvm_s390_gisa));
> +	kvm->arch.gisa->next_alert = (u32)(u64)kvm->arch.gisa;
> +	VM_EVENT(kvm, 3, "gisa 0x%pK cleared", kvm->arch.gisa);
>  }
>  
>  void kvm_s390_gisa_init(struct kvm *kvm)
>  {
> -	if (css_general_characteristics.aiv) {
> -		kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
> -		VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
> -		kvm_s390_gisa_clear(kvm);
> -	}
> +	if (!css_general_characteristics.aiv)
> +		return;
> +	kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
> +	kvm_s390_gisa_clear(kvm);
> +	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
>  }
>  
>  void kvm_s390_gisa_destroy(struct kvm *kvm)
