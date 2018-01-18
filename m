From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 01/12] KVM: s390: reverse bit ordering of irqs in
 pending mask
Date: Thu, 18 Jan 2018 17:50:04 +0100
Message-ID: <20180118175004.415614fb.cohuck@redhat.com>
References: <20180116200217.211897-1-borntraeger@de.ibm.com>
        <20180116200217.211897-2-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180116200217.211897-2-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 16 Jan 2018 21:02:06 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Michael Mueller <mimu@linux.vnet.ibm.com>
> 
> This patch prepares a simplification of bit operations between the irq
> pending mask for emulated interrupts and the Interruption Pending Mask
> (IPM) which is part of the Guest Interruption State Area (GISA), a feature
> that allows interrupt delivery to guests by means of the SIE instruction.
> 
> Without that change, a bit-wise *or* operation on parts of these two masks
> would either require a look-up table of size 256 bytes to map the IPM
> to the emulated irq pending mask bit orientation (all bits mirrored at half
> byte) or a sequence of up to 8 condidional branches to perform tests of
> single bit positions. Both options are to reject either by performance or

s/to reject/to be rejected/

> space utilization reasons.
> 
> Beyond that this change will be transparent.
> 
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h | 54 ++++++++++++++++++++--------------------
>  arch/s390/kvm/interrupt.c        | 10 ++++----
>  2 files changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index e16a9f2a44ad..9981721f258f 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -409,35 +409,35 @@ struct kvm_vcpu_stat {
>  #define PGM_PER				0x80
>  #define PGM_CRYPTO_OPERATION		0x119
>  
> -/* irq types in order of priority */
> +/* irq types in ascend order of priorities */

"ascending order of priority"?

Otherwise (and with the "reversed order" change),

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
