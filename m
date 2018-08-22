From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 4/5] KVM: s390: vsie: Always test the crycbd for NULL
Date: Wed, 22 Aug 2018 19:07:41 +0200
Message-ID: <c4894cbd-4e4f-74a1-6fe0-6f3c264f297e@redhat.com>
References: <1534956717-14087-1-git-send-email-pmorel@linux.ibm.com>
 <1534956717-14087-5-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534956717-14087-5-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 22.08.2018 18:51, Pierre Morel wrote:
> BUG: the crycbd must be tested for null even if
> not crossing a page boundary (which will never
> occur in this case anyway).

I don't see the BUG. Can you elaborate? (maybe it is too late for me)

Either we return or we check for !crycb_addr

> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  arch/s390/kvm/vsie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 0b12916..7ee4329 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -172,7 +172,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  
>  	if ((crycb_addr & PAGE_MASK) != ((crycb_addr + 128) & PAGE_MASK))
>  		return set_validity_icpt(scb_s, 0x003CU);
> -	else if (!crycb_addr)
> +	if (!crycb_addr)
>  		return set_validity_icpt(scb_s, 0x0039U);
>  
>  	/* copy only the wrapping keys */
> 


-- 

Thanks,

David / dhildenb
