From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v7 12/15] KVM: s390: kvm_s390_gisa_clear() now clears
 the IPM only
Date: Thu, 31 Jan 2019 15:39:41 +0100
Message-ID: <20190131153941.4b69e3bb@oc2783563651>
References: <20190131085247.13826-1-mimu@linux.ibm.com>
        <20190131085247.13826-13-mimu@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131085247.13826-13-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 31 Jan 2019 09:52:43 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> Function kvm_s390_gisa_clear() now clears the Interruption
> Pending Mask of the GISA asap. If the GISA is in the alert
> list at this time it stays in the list but is removed by
> process_gib_alert_list().
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index f37dfb01c63c..341664b94491 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -249,6 +249,25 @@ static inline int gisa_set_iam(struct kvm_s390_gisa *gisa, u8 iam)
>  	return 0;
>  }
>  
> +/**
> + * gisa_clear_ipm - clear the GISA interruption pending mask
> + *
> + * @gisa: gisa to operate on
> + *
> + * Clear the IPM atomically with the next alert address and the IAM
> + * of the GISA unconditionally. All three fields are located in the
> + * first long word of the GISA.
> + */
> +static inline void gisa_clear_ipm(struct kvm_s390_gisa *gisa)
> +{
> +	u64 word, _word;
> +
> +	do {
> +		word = READ_ONCE(gisa->u64.word[0]);
> +		_word = word & ~(0xffUL << 24);
> +	} while (cmpxchg(&gisa->u64.word[0], word, _word) != word);
> +}
> +
>  static inline void gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
>  {
>  	set_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
> @@ -2926,8 +2945,7 @@ void kvm_s390_gisa_clear(struct kvm *kvm)
>  
>  	if (!gi->origin)
>  		return;
> -	memset(gi->origin, 0, sizeof(struct kvm_s390_gisa));
> -	gi->origin->next_alert = (u32)(u64)gi->origin;
> +	gisa_clear_ipm(gi->origin);
>  	VM_EVENT(kvm, 3, "gisa 0x%pK cleared", gi->origin);
>  }

I'm a bit confused. Now all kvm_s390_gisa_clear() does to the gisa is
gisa_clear_ipm(). The only usage I see is triggered by
KVM_DEV_FLIC_CLEAR_IRQS. And in that context this seems appropriate.

However gisa can hold other stuff than the ipm, and in that sense
the name kvm_s390_gisa_clear() may be misleading. I ask myself
questions like who would need to reset simm and nimm on system
reset. At the moment we don't use these AFAICT, so I guess it does not
matter.

Thus not a showstopper to me:

Acked-by: Halil Pasic <pasic@linux.ibm.com>


>  
> @@ -2940,7 +2958,8 @@ void kvm_s390_gisa_init(struct kvm *kvm)
>  	gi->origin = &kvm->arch.sie_page2->gisa;
>  	gi->alert.mask = 0;
>  	spin_lock_init(&gi->alert.ref_lock);
> -	kvm_s390_gisa_clear(kvm);
> +	memset(gi->origin, 0, sizeof(struct kvm_s390_gisa));
> +	gi->origin->next_alert = (u32)(u64)gi->origin;
>  	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", gi->origin);
>  }
>  
