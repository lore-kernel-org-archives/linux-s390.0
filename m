From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] KVM: s390: vsie: BUG correction by shadow_crycb
Date: Tue, 21 Aug 2018 16:35:02 +0200
Message-ID: <a7054733-ebd7-477b-0f42-2857db7cb0d3@redhat.com>
References: <1534861178-30372-1-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534861178-30372-1-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 21.08.2018 16:19, Pierre Morel wrote:
> Copy the key mask to the right offset inside the shadow CRYCB

"KVM: s390: vsie: copy wrapping keys to right place"

Indeed, we're writing it into the apcb0 mask (which is ignored).
Luckily, the xor-ing with the g2 keys seems to work.

Reviewed-by: David Hildenbrand <david@redhat.com>

> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  arch/s390/kvm/vsie.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 63844b9..a2b28cd 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -173,7 +173,8 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  		return set_validity_icpt(scb_s, 0x0039U);
>  
>  	/* copy only the wrapping keys */
> -	if (read_guest_real(vcpu, crycb_addr + 72, &vsie_page->crycb, 56))
> +	if (read_guest_real(vcpu, crycb_addr + 72,
> +			    vsie_page->crycb.dea_wrapping_key_mask, 56))
>  		return set_validity_icpt(scb_s, 0x0035U);
>  
>  	scb_s->ecb3 |= ecb3_flags;
> 


-- 

Thanks,

David / dhildenb
