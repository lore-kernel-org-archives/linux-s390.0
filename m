Return-Path: <SRS0=kLZb=SR=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH 6/7] s390: vfio-ap: handle dynamic config/deconfig of AP
 adapter
References: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
 <1555016604-2008-7-git-send-email-akrowiak@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 15 Apr 2019 11:54:46 +0200
MIME-Version: 1.0
In-Reply-To: <1555016604-2008-7-git-send-email-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <8e6dbb48-3d8b-431f-4b62-f4d30e6635ce@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com
List-ID: <linux-s390.vger.kernel.org>

On 11/04/2019 23:03, Tony Krowiak wrote:
> Once an APQN is assigned to an mdev device it will remained assigned until
> it is explicitly unassigned from the mdev device. The associated AP queue
> devices, however, can come and go due to failures or deliberate actions by
> a sysadmin. For example, a sysadmin can dynamically remove an AP adapter
> card using the SE or by executing an SCLP command. This patch refactors
> the probe and remove callbacks of the vfio_ap driver to handle dynamic
> changes as follows:
> 
> * Probe callback changes:
> 
>    If the APQN of the queue being probed is assigned to an mdev device, the
>    mdev device is in use by a guest, and the APQN is not set in the guest's
>    CRYCB, the CRYCB will be dynamically updated to give the guest access to
>    the queue.
> 
> * Remove callback changes:
> 
>    If the APQN of the queue being removed is assigned to an mdev device,
>    the mdev
>    device is in use by a guest, and the APQN is set in the guest's CRYCB,
>    the CRYCB will be dynamically updated to remove the guest's access to
>    the adapter card associated with the queue. Keep in mind, the
>    architecture does not provide a way to remove access to a single queue
>    unless only one queue is in the guest's configuration, so it was decided
>    that it makes more sense to unplug the adapter from the guest.
> 
>    The APQN of the queue being removed will remain assigned to the mdev
>    device should the queue be dynamically returned to the configuration.
>    The queue will also be reset prior to returning control to the caller
>    (a.k.a., the AP bus).
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h      |  2 ++
>   arch/s390/kvm/kvm-s390.c              | 37 +++++++++++++++++++
>   drivers/s390/crypto/vfio_ap_drv.c     | 16 +++++++--
>   drivers/s390/crypto/vfio_ap_ops.c     | 67 +++++++++++++++++++++++++++++++++--
>   drivers/s390/crypto/vfio_ap_private.h |  2 ++
>   5 files changed, 120 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index c47e22bba87f..0ce5d9b0df59 100644kvm_s390_crypto_cb
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -895,6 +895,8 @@ void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
>   void kvm_arch_crypto_clear_masks(struct kvm *kvm);
>   void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
>   			       unsigned long *aqm, unsigned long *adm);
> +int kvm_arch_crypto_test_masks(struct kvm *kvm, unsigned long *apm,
> +			       unsigned long *aqm, unsigned long *adm);
>   
>   extern int sie64a(struct kvm_s390_sie_block *, u64 *);
>   extern char sie_exit;
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 4638303ba6a8..5f423cdd29ba 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2217,6 +2217,43 @@ static void kvm_s390_set_crycb_format(struct kvm *kvm)
>   		kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
>   }
>   

This function requires the big matrix lock, may be add a comment.

> +int kvm_arch_crypto_test_masks(struct kvm *kvm, unsigned long *apm,
> +			       unsigned long *aqm, unsigned long *adm)
> +{
> +	int ret;
> +	struct kvm_s390_crypto_cb *crycb = kvm->arch.crypto.crycb;
> +
> +	switch (kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
> +	case CRYCB_FORMAT2: /* APCB1 use 256 bits */
> +		ret = bitmap_equal(apm, (unsigned long *)crycb->apcb1.apm, 256);
> +		VM_EVENT(kvm, 3, "TEST CRYCB: apm %016lx %016lx %016lx %016lx",
> +			 apm[0], apm[1], apm[2], apm[3]);
> +		ret &= bitmap_equal(aqm,
> +				    (unsigned long *)crycb->apcb1.aqm, 256);
> +		VM_EVENT(kvm, 3, "TEST CRYCB: aqm %016lx %016lx %016lx %016lx",
> +			 aqm[0], aqm[1], aqm[2], aqm[3]);
> +		ret &= bitmap_equal(adm,
> +				    (unsigned long *)crycb->apcb1.adm, 256);
> +		VM_EVENT(kvm, 3, "TEST CRYCB: adm %016lx %016lx %016lx %016lx",
> +			 adm[0], adm[1], adm[2], adm[3]);
> +		break;
> +	case CRYCB_FORMAT1:
> +	case CRYCB_FORMAT0: /* Fall through both use APCB0 */
> +		ret = bitmap_equal(apm, (unsigned long *)crycb->apcb1.apm, 64);
> +		ret &= bitmap_equal(aqm, (unsigned long *)crycb->apcb1.aqm, 16);
> +		ret &= bitmap_equal(adm, (unsigned long *)crycb->apcb1.adm, 16);
> +		VM_EVENT(kvm, 3, "TEST CRYCB: apm %016lx aqm %04x adm %04x",
> +			 apm[0], *((unsigned short *)aqm),
> +			 *((unsigned short *)adm));
> +		break;
> +	default:	/* Can not happen */
> +		ret = 0;
> +		break;
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(kvm_arch_crypto_test_masks);

Wouldn't it be interesting to work on the ap_matrix structure instead of 
on the real CRYCB?
You could spare a lot of tests and wouldn't require to change this file.

Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
