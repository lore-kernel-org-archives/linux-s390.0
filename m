From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v6 01/13] KVM: s390: drop obsolete else path
Date: Mon, 28 Jan 2019 14:57:39 +0100
Message-ID: <20190128145739.4a7f8181@oc2783563651>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
        <20190124125939.130763-2-mimu@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124125939.130763-2-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 24 Jan 2019 13:59:27 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> The explicit else path specified in set_intercept_indicators_io
> is not required as the function returns in case the first branch
> is taken anyway.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

> ---
>  arch/s390/kvm/interrupt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index fcb55b02990e..19d556512452 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -345,7 +345,7 @@ static void set_intercept_indicators_io(struct kvm_vcpu *vcpu)
>  {
>  	if (!(pending_irqs_no_gisa(vcpu) & IRQ_PEND_IO_MASK))
>  		return;
> -	else if (psw_ioint_disabled(vcpu))
> +	if (psw_ioint_disabled(vcpu))
>  		kvm_s390_set_cpuflags(vcpu, CPUSTAT_IO_INT);
>  	else
>  		vcpu->arch.sie_block->lctl |= LCTL_CR6;
