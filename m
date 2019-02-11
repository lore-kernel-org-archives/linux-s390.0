From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2] s390: vsie: Use effective CRYCBD.31 to check CRYCBD
 validity
Date: Mon, 11 Feb 2019 10:47:17 +0100
Message-ID: <20190211104717.21299b01.cohuck@redhat.com>
References: <1549876849-32680-1-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549876849-32680-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, david@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, 11 Feb 2019 10:20:49 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> When facility.76 MSAX3 is present for the guest we must issue a validity
> interception if the CRYCBD is not valid.
> 
> The bit CRYCBD.31 is an effective field and tested at each guest
> level and has for effect to mask the facility.76
> 
> It follows that if CRYCBD.31 is clear and AP is not in use  we do not
> have to test the CRYCBD validatity even facility.76 is present in the

s/even/even if/

> host.
> 
> Fixes: 6ee74098201b ("KVM: s390: vsie: allow CRYCB FORMAT-0")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reported-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kvm/vsie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index a153257..d62fa14 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -297,7 +297,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  	scb_s->crycbd = 0;
>  
>  	apie_h = vcpu->arch.sie_block->eca & ECA_APIE;
> -	if (!apie_h && !key_msk)
> +	if (!apie_h && (!key_msk || fmt_o == CRYCB_FORMAT0))
>  		return 0;
>  
>  	if (!crycb_addr)

Acked-by: Cornelia Huck <cohuck@redhat.com>
