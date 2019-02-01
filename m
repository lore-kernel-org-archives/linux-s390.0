From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1] KVM: s390: vsie: fix Do the CRYCB validation first
Date: Fri, 1 Feb 2019 11:50:41 +0100
Message-ID: <20190201115041.04797c4c.cohuck@redhat.com>
References: <1549014725-28216-1-git-send-email-pmorel@linux.ibm.com>
        <1549014725-28216-2-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549014725-28216-2-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, david@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri,  1 Feb 2019 10:52:05 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> The case when the SIE for guest3 is not setup for using
> encryption keys nor Adjunct processor but the guest2
> does use these features was not properly handled.
> 
> This leads SIE entry for guest3 to crash with validity intercept
> because the guest2, not having the use of encryption keys nor
> Adjunct Processor did not initialize the CRYCB designation.
> 
> In the case where none of ECA_APIE, ECB3_AES or ECB3_DEA
> are set in guest3 a format 0 CRYCB is allowed for guest3
> and the CRYCB designation in the SIE for guest3 is not checked
> on SIE entry.
> 
> Let's allow the CRYCD designation to be ignored when the

s/CRYCD/CRYCB/

> SIE for guest3 is not initialized for encryption key usage
> nor AP.
> 
> Fixup: d6f6959 (KVM: s390: vsie: Do the CRYCB validation first)

I think the canonical format is

Fixes: d6f6959ac587 ("KVM: s390: vsie: Do the CRYCB validation first")

> 

CC: stable@vger.kernel.org # 4.20+

> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reported-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  arch/s390/kvm/vsie.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index a153257..a748f76 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -300,6 +300,9 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  	if (!apie_h && !key_msk)
>  		return 0;
>  
> +	if (!(scb_o->eca & ECA_APIE) && !(scb_o->ecb3 & (ECB3_AES | ECB3_DEA)))
> +		return 0;
> +
>  	if (!crycb_addr)
>  		return set_validity_icpt(scb_s, 0x0039U);
>  

Looks sane to me, but I'll let vsie experts comment.
