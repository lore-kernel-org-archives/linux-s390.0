From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 07/14] KVM: s390: interfaces to configure/deconfigure
 guest's AP matrix
Date: Tue, 3 Apr 2018 13:07:58 +0200
Message-ID: <20180403130758.43851026.cohuck@redhat.com>
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1521051954-25715-8-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521051954-25715-8-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 14 Mar 2018 14:25:47 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> Provides interfaces to assign AP adapters, usage domains
> and control domains to a KVM guest.
> 
> A KVM guest is started by executing the Start Interpretive Execution (SIE)
> instruction. The SIE state description is a control block that contains the
> state information for a KVM guest and is supplied as input to the SIE
> instruction. The SIE state description has a satellite structure called the
> Crypto Control Block (CRYCB). The CRYCB contains three bitmask fields
> identifying the adapters, queues (domains) and control domains assigned to
> the KVM guest:
> 
> * The AP Adapter Mask (APM) field identifies the AP adapters assigned to
>   the KVM guest
> 
> * The AP Queue Mask (AQM) field identifies the AP queues assigned to
>   the KVM guest. Each AP queue is connected to a usage domain within
>   an AP adapter.
> 
> * The AP Domain Mask (ADM) field identifies the control domains
>   assigned to the KVM guest.
> 
> Each adapter, queue (usage domain) and control domain are identified by
> a number from 0 to 255. The bits in each mask, from most significant to
> least significant bit, correspond to the numbers 0-255. When a bit is
> set, the corresponding adapter, queue (usage domain) or control domain
> is assigned to the KVM guest.
> 
> This patch will set the bits in the APM, AQM and ADM fields of the
> CRYCB referenced by the KVM guest's SIE state description. The process
> used is:
> 
> 1. Verify that the bits to be set do not exceed the maximum bit
>    number for the given mask.
> 
> 2. Verify that the APQNs that can be derived from the intersection
>    of the bits set in the APM and AQM fields of the KVM guest's CRYCB
>    are not assigned to any other KVM guest running on the same linux
>    host.
> 
> 3. Set the APM, AQM and ADM in the CRYCB according to the matrix
>    configured for the mediated matrix device via its sysfs
>    adapter, domain and control domain attribute files respectively.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  arch/s390/include/asm/kvm-ap.h        |   36 +++++
>  arch/s390/kvm/kvm-ap.c                |  268 +++++++++++++++++++++++++++++++++
>  drivers/s390/crypto/vfio_ap_ops.c     |   19 +++
>  drivers/s390/crypto/vfio_ap_private.h |    4 +
>  4 files changed, 327 insertions(+), 0 deletions(-)
> 

> diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
> index a2c6ad2..eb365e2 100644
> --- a/arch/s390/kvm/kvm-ap.c
> +++ b/arch/s390/kvm/kvm-ap.c
> @@ -8,9 +8,129 @@
>  
>  #include <asm/kvm-ap.h>
>  #include <asm/ap.h>
> +#include <linux/bitops.h>
>  
>  #include "kvm-s390.h"
>  
> +static inline void kvm_ap_clear_crycb_masks(struct kvm *kvm)
> +{
> +	int crycb_fmt = kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK;
> +
> +	if (crycb_fmt == CRYCB_FORMAT2)
> +		memset(&kvm->arch.crypto.crycb->apcb1, 0,
> +		       sizeof(kvm->arch.crypto.crycb->apcb1));
> +	else
> +		memset(&kvm->arch.crypto.crycb->apcb0, 0,
> +		       sizeof(kvm->arch.crypto.crycb->apcb0));
> +}

Should that rather be a switch/case? If there's a CRYCB_FORMAT3 in the
future, I'd think that it's more likely that it uses apcb1 and not
apcb0. Can't comment further without the architecture, obviously.

(...)

> +static void kvm_ap_set_crycb_masks(struct kvm *kvm,
> +				   struct kvm_ap_matrix *matrix)
> +{
> +	unsigned long *apm = kvm_ap_get_crycb_apm(kvm);
> +	unsigned long *aqm = kvm_ap_get_crycb_aqm(kvm);
> +	unsigned long *adm = kvm_ap_get_crycb_adm(kvm);
> +
> +	kvm_ap_clear_crycb_masks(kvm);
> +	memcpy(apm, matrix->apm, KVM_AP_MASK_BYTES(matrix->apm_max));
> +	memcpy(aqm, matrix->aqm, KVM_AP_MASK_BYTES(matrix->aqm_max));
> +
> +	/*
> +	 * Merge the AQM and ADM since the ADM is a superset of the
> +	 * AQM by architectural convention.

Is this 'architectural convention' in the sense of 'there's a statement
in the architecture that it always is like that', or in the sense of
'all real-life systems are like that'?

[From my sketchy memory, this convention makes sense but is not
enshrined; but I might misremember.]

> +	 */
> +	bitmap_or(adm, adm, aqm, matrix->adm_max);
> +}
