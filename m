From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 09/12] KVM: s390: make kvm_s390_get_io_int() aware of
 GISA
Date: Fri, 26 Jan 2018 14:13:04 +0100
Message-ID: <065a843b-c25e-720d-5873-f6b880fa1d68@de.ibm.com>
References: <20180125132848.175942-1-borntraeger@de.ibm.com>
 <20180125132848.175942-10-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180125132848.175942-10-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 01/25/2018 02:28 PM, Christian Borntraeger wrote:
> From: Michael Mueller <mimu@linux.vnet.ibm.com>
> 
> The function returns a pending I/O interrupt with the highest
> priority defined by its ISC.
> 
> Together with AIV activation, pending adapter interrupts are
> managed by the GISA IPM. Thus kvm_s390_get_io_int() needs to
> inspect the IPM as well when the interrupt with the highest
> priority has to be identified.
> 
> In case classic and adapter interrupts with the same ISC are
> pending, the classic interrupt will be returned first.
> 
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 71 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 65 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 0edf97a..5c48930 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -1471,12 +1471,8 @@ static struct kvm_s390_interrupt_info *get_io_int(struct kvm *kvm,
>  	return NULL;
>  }
> 
> -/*
> - * Dequeue and return an I/O interrupt matching any of the interruption
> - * subclasses as designated by the isc mask in cr6 and the schid (if != 0).
> - */
> -struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
> -						    u64 isc_mask, u32 schid)
> +static struct kvm_s390_interrupt_info *get_top_io_int(struct kvm *kvm,
> +						      u64 isc_mask, u32 schid)
>  {
>  	struct kvm_s390_interrupt_info *inti = NULL;
>  	int isc;
> @@ -1488,6 +1484,69 @@ struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
>  	return inti;
>  }
> 
> +static int get_top_gisa_isc(struct kvm *kvm, u64 isc_mask, u32 schid)
> +{
> +	unsigned long active_mask;
> +	int isc;
> +
> +	if (schid)
> +		goto out;
> +	if (!kvm->arch.gisa)
> +		goto out;
> +
> +	active_mask = (isc_mask & kvm_s390_gisa_get_ipm(kvm->arch.gisa) << 24) << 32;
> +	while (active_mask) {
> +		isc = __flogr(active_mask);

Sebastian Ott noticed that newer binutils will complain about that when
compiling for z990 or older.

I will use the equivalent

-               isc = __flogr(active_mask);
+               isc = __fls(active_mask) ^ (BITS_PER_LONG - 1);
