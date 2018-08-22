From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 3/5] KVM: s390: vsie: Allow support for a host without
 AP
Date: Wed, 22 Aug 2018 19:06:09 +0200
Message-ID: <beb38451-8ec9-59c7-2e51-f9a065b769bf@redhat.com>
References: <1534956717-14087-1-git-send-email-pmorel@linux.ibm.com>
 <1534956717-14087-4-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534956717-14087-4-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 22.08.2018 18:51, Pierre Morel wrote:
> Currently the CRYCB format used in the host for the
> shadowed CRYCB is FORMAT2 while no check is done if
> AP instructions are supported in the host.
> 
> We better use the format the host calculated for the
> guest 1 as the host already tested it against its
> facility set.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  arch/s390/kvm/vsie.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 56a9d47..0b12916 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -154,6 +154,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  	const u32 crycb_addr = crycbd_o & 0x7ffffff8U;
>  	unsigned long *b1, *b2;
>  	u8 ecb3_flags;
> +	unsigned long g1_fmt;
>  
>  	scb_s->crycbd = 0;
>  	if (!(crycbd_o == CRYCB_FORMAT1))
> @@ -180,8 +181,8 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  		return set_validity_icpt(scb_s, 0x0035U);
>  
>  	scb_s->ecb3 |= ecb3_flags;
> -	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT1 |
> -			CRYCB_FORMAT2;
> +	g1_fmt = vcpu->arch.sie_block->crycbd & 0x03;
> +	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | g1_fmt;
>  
>  	/* xor both blocks in one run */
>  	b1 = (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;
> 

This is wrong. I remember that with APXA, if FORMAT2 is available, we
should always use FORMAT2. That's why we explicitly convert it here.

-- 

Thanks,

David / dhildenb
