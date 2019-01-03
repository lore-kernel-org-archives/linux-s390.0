From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v5 12/15] KVM: s390: do not restore IAM immediately before
 SIE entry
Date: Thu, 3 Jan 2019 16:00:36 +0100
Message-ID: <5b427ccb-b0b4-f411-a9fc-6b8f8a60b734@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-13-mimu@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219191756.57973-13-mimu@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, kvm390-list@tuxmaker.boeblingen.de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 19/12/2018 20:17, Michael Mueller wrote:
> The IAM shall no be restored when deliverable interruptions are
> delivered to vcpus by means of the PSW swap mechanism. That would
> trigger the GIB alert millicode although we know that SIE will be
> able to handle the pending interruption on entry.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>   arch/s390/kvm/interrupt.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 8307717e3caf..48a93f5e5333 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -328,11 +328,11 @@ static unsigned long disable_iscs(struct kvm_vcpu *vcpu,
>   	return active_mask;
>   }
>   
> -static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu)
> +static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu, u16 irq_flags)
>   {
>   	unsigned long active_mask;
>   
> -	active_mask = pending_irqs(vcpu, IRQ_MASK_ALL);
> +	active_mask = pending_irqs(vcpu, irq_flags);
>   	if (!active_mask)
>   		return 0;
>   
> @@ -1090,7 +1090,7 @@ int kvm_s390_ext_call_pending(struct kvm_vcpu *vcpu)
>   
>   int kvm_s390_vcpu_has_irq(struct kvm_vcpu *vcpu, int exclude_stop)
>   {
> -	if (deliverable_irqs(vcpu))
> +	if (deliverable_irqs(vcpu, IRQ_MASK_ALL | IRQ_FLAG_IAM))

Why do we need to restore IAM here?



-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
