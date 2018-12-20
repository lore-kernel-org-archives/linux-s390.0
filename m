From: Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH v5 10/15] KVM: s390: add functions to (un)register GISC
 with GISA
Date: Thu, 20 Dec 2018 15:32:00 +0100
Message-ID: <23513047-9ef8-c0a3-1b7f-d87e02da4c90@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-11-mimu@linux.ibm.com>
Reply-To: mimu@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219191756.57973-11-mimu@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 19.12.18 20:17, Michael Mueller wrote:
> Add the IAM (Interruption Alert Mask) to the architecture specific
> kvm struct. This mask in the GISA is used to define for which ISC
> a GIB alert can be issued.
> 
> The functions kvm_s390_gisc_register() and kvm_s390_gisc_unregister()
> are used to (un)register a GISC (guest ISC) with a virtual machine and
> its GISA.
> 
> Upon successful completion, kvm_s390_gisc_register() returns the
> ISC to be used for GIB alert interruptions. A negative return code
> indicates an error during registration.
> 
> Theses functions will be used by other adapter types like AP and PCI to
> request pass-through interruption support.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h |  9 ++++++
>   arch/s390/kvm/interrupt.c        | 66 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 75 insertions(+)
> 

...

> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -229,6 +229,25 @@ static inline u8 int_word_to_isc(u32 int_word)
>    */
>   #define IPM_BIT_OFFSET (offsetof(struct kvm_s390_gisa, ipm) * BITS_PER_BYTE)
>   
> +static inline int set_iam(struct kvm_s390_gisa *gisa, u8 iam)

I will rename this one here as well to gisa_set_iam()

> +{
> +	u64 word0, _word0;
> +
> +	do {
> +		word0 = READ_ONCE(gisa->u64.word[0]);
> +		/* If the GISA is in the alert list, do nothing. */
> +		if ((u64)gisa != word0 >> 32)
> +			return -EBUSY;
> +		/*
> +		 * Try to set the IAM or loop, if the IPM has changed
> +		 * or the GISA has been inserted into the alert list.
> +		 */
> +		_word0 = (word0 & ~0xffUL) | iam;
> +	} while (cmpxchg(&gisa->u64.word[0], word0, _word0) != _word0);
> +
> +	return 0;
> +}
> +
