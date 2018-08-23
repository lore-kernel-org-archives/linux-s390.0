From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v3 1/3] KVM: s390: vsie: copy wrapping keys to right place
Date: Thu, 23 Aug 2018 15:12:12 +0200
Message-ID: <52c01a4c-48d4-30c7-a780-a33bcdd8accc@de.ibm.com>
References: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
 <1535019956-23539-2-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535019956-23539-2-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, david@redhat.com
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 08/23/2018 12:25 PM, Pierre Morel wrote:
> Copy the key mask to the right offset inside the shadow CRYCB
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/kvm/vsie.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 9175518..12b9707 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -173,7 +173,8 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  		return set_validity_icpt(scb_s, 0x0039U);
>  
>  	/* copy only the wrapping keys */
> -	if (read_guest_real(vcpu, crycb_addr + 72, &vsie_page->crycb, 56))
> +	if (read_guest_real(vcpu, crycb_addr + 72,
> +			    vsie_page->crycb.dea_wrapping_key_mask, 56))

When we fix that code.., dont  we have to XOR the guest3 wrapping keys with
the guest2 ones? 


>  		return set_validity_icpt(scb_s, 0x0035U);
>  
>  	scb_s->ecb3 |= ecb3_flags;
> 
