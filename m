From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v3 2/3] KVM: s390: vsie: Do the CRYCB validation first
Date: Thu, 23 Aug 2018 13:17:47 +0200
Message-ID: <b7c0b0eb-c750-caeb-41b5-d6593791a6ef@de.ibm.com>
References: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
 <1535019956-23539-3-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535019956-23539-3-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, david@redhat.com
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 08/23/2018 12:25 PM, Pierre Morel wrote:
> When entering the SIE the CRYCB validation better
> be done independently of the instruction's
> availability.

Maybe something like

We need to handle the validity checks for the crycb, no matter what the
settings for the keywrappings are. So lets move the keywrapping checks
after we have done the validy checks.

?

> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  arch/s390/kvm/vsie.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 12b9707..38ea5da 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -161,17 +161,18 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  	/* format-1 is supported with message-security-assist extension 3 */
>  	if (!test_kvm_facility(vcpu->kvm, 76))
>  		return 0;
> -	/* we may only allow it if enabled for guest 2 */
> -	ecb3_flags = scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
> -		     (ECB3_AES | ECB3_DEA);
> -	if (!ecb3_flags)
> -		return 0;
> 
>  	if ((crycb_addr & PAGE_MASK) != ((crycb_addr + 128) & PAGE_MASK))
>  		return set_validity_icpt(scb_s, 0x003CU);
>  	else if (!crycb_addr)
>  		return set_validity_icpt(scb_s, 0x0039U);
> 
> +	/* we may only allow it if enabled for guest 2 */
> +	ecb3_flags = scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
> +		     (ECB3_AES | ECB3_DEA);
> +	if (!ecb3_flags)
> +		return 0;
> +
>  	/* copy only the wrapping keys */
>  	if (read_guest_real(vcpu, crycb_addr + 72,
>  			    vsie_page->crycb.dea_wrapping_key_mask, 56))
> 
