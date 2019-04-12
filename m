Return-Path: <SRS0=UIqJ=SO=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH 6/7] s390: vfio-ap: handle dynamic config/deconfig of AP
 adapter
References: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
 <1555016604-2008-7-git-send-email-akrowiak@linux.ibm.com>
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Fri, 12 Apr 2019 09:09:04 +0200
MIME-Version: 1.0
In-Reply-To: <1555016604-2008-7-git-send-email-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <735b94b2-9c03-2757-a2d7-043d46958d70@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com
List-ID: <linux-s390.vger.kernel.org>

On 11.04.19 23:03, Tony Krowiak wrote:
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
>   If the APQN of the queue being probed is assigned to an mdev device, the
>   mdev device is in use by a guest, and the APQN is not set in the guest's
>   CRYCB, the CRYCB will be dynamically updated to give the guest access to
>   the queue.
>
> * Remove callback changes:
>
>   If the APQN of the queue being removed is assigned to an mdev device,
>   the mdev
>   device is in use by a guest, and the APQN is set in the guest's CRYCB,
>   the CRYCB will be dynamically updated to remove the guest's access to
>   the adapter card associated with the queue. Keep in mind, the
>   architecture does not provide a way to remove access to a single queue
>   unless only one queue is in the guest's configuration, so it was decided
>   that it makes more sense to unplug the adapter from the guest.
>
>   The APQN of the queue being removed will remain assigned to the mdev
>   device should the queue be dynamically returned to the configuration.
>   The queue will also be reset prior to returning control to the caller
>   (a.k.a., the AP bus).
Didn't we agree that the reset is done by the AP bus anyway. This was
why I did the rework around the remove callback in the AP bus code.
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h      |  2 ++
>  arch/s390/kvm/kvm-s390.c              | 37 +++++++++++++++++++
>  drivers/s390/crypto/vfio_ap_drv.c     | 16 +++++++--
>  drivers/s390/crypto/vfio_ap_ops.c     | 67 +++++++++++++++++++++++++++++++++--
>  drivers/s390/crypto/vfio_ap_private.h |  2 ++
>  5 files changed, 120 insertions(+), 4 deletions(-)
>
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index c47e22bba87f..0ce5d9b0df59 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -895,6 +895,8 @@ void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
>  void kvm_arch_crypto_clear_masks(struct kvm *kvm);
>  void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
>  			       unsigned long *aqm, unsigned long *adm);
> +int kvm_arch_crypto_test_masks(struct kvm *kvm, unsigned long *apm,
> +			       unsigned long *aqm, unsigned long *adm);
>  
>  extern int sie64a(struct kvm_s390_sie_block *, u64 *);
>  extern char sie_exit;
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 4638303ba6a8..5f423cdd29ba 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2217,6 +2217,43 @@ static void kvm_s390_set_crycb_format(struct kvm *kvm)
>  		kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
>  }
>  
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
> +
>  void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
>  			       unsigned long *aqm, unsigned long *adm)
>  {
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index f340a28c1d65..2a79d27d9730 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -42,12 +42,24 @@ MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>  
>  static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
>  {
> -	return 0;
> +	struct ap_queue *apq = to_ap_queue(&apdev->device);
> +	unsigned long apid = AP_QID_CARD(apq->qid);
> +	unsigned long apqi = AP_QID_QUEUE(apq->qid);
> +
> +	mutex_lock(&matrix_dev->lock);
> +	vfio_ap_mdev_probe_queue(apid, apqi);
> +	mutex_unlock(&matrix_dev->lock);
>  }
>  
>  static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
>  {
> -	/* Nothing to do yet */
> +	struct ap_queue *apq = to_ap_queue(&apdev->device);
> +	unsigned long apid = AP_QID_CARD(apq->qid);
> +	unsigned long apqi = AP_QID_QUEUE(apq->qid);
> +
> +	mutex_lock(&matrix_dev->lock);
> +	vfio_ap_mdev_remove_queue(apid, apqi);
> +	mutex_unlock(&matrix_dev->lock);
>  }
>  
>  static void vfio_ap_matrix_dev_release(struct device *dev)
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index ade2c150fe6b..8a70707bf870 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -683,8 +683,8 @@ static void vfio_ap_mdev_wait_for_qempty(unsigned long apid, unsigned long apqi)
>  			msleep(20);
>  			break;
>  		default:
> -			pr_warn("%s: tapq err %02x: 0x%04x may not be empty\n",
> -				__func__, status.response_code, q->apqn);
> +			pr_warn("%s: tapq err %02x: %02lx%04lx may not be empty\n",
> +				__func__, status.response_code, apid, apqi);
>  			return;
>  		}
>  	} while (--retry);
> @@ -840,3 +840,66 @@ void vfio_ap_mdev_unregister(void)
>  {
>  	mdev_unregister_device(&matrix_dev->device);
>  }
> +
> +static struct ap_matrix_mdev *vfio_ap_mdev_find_matrix_mdev(unsigned long apid,
> +							    unsigned long apqi)
> +{
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
> +		if (test_bit_inv(apid, matrix_mdev->matrix.apm) &&
> +		    test_bit_inv(apqi, matrix_mdev->matrix.aqm))
> +			return matrix_mdev;
> +	}
> +
> +	return NULL;
> +}
> +
> +void vfio_ap_mdev_remove_queue(unsigned long apid, unsigned long apqi)
> +{
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	matrix_mdev = vfio_ap_mdev_find_matrix_mdev(apid, apqi);
> +
> +	/*
> +	 * If the queue is assigned to the mdev device and the mdev device
> +	 * is in use by a guest
> +	 */
> +	if (matrix_mdev && matrix_mdev->kvm) {
> +		/*
> +		 * If the queue is plugged into the guest, unplug the adapter
> +		 * but keep the adapter assigned to the mdev device
> +		 */
> +		if (!kvm_arch_crypto_test_masks(matrix_mdev->kvm,
> +						matrix_mdev->matrix.apm,
> +						matrix_mdev->matrix.aqm,
> +						matrix_mdev->matrix.adm)) {
> +			clear_bit_inv(apid, matrix_mdev->matrix.apm);
> +			vfio_ap_mdev_update_crycb(matrix_mdev);
> +			set_bit_inv(apid, matrix_mdev->matrix.apm);
> +		}
> +	}
> +
> +	vfio_ap_mdev_reset_queue(apid, apqi);
> +}
> +
> +void vfio_ap_mdev_probe_queue(unsigned long apid, unsigned long apqi)
> +{
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	matrix_mdev = vfio_ap_mdev_find_matrix_mdev(apid, apqi);
> +
> +	/*
> +	 * If the queue is assigned to the mdev device and the mdev device
> +	 * is in use by a guest
> +	 */
> +	if (matrix_mdev && matrix_mdev->kvm) {
> +		/* If the queue is not plugged into the guest, plug it in */
> +		if (!kvm_arch_crypto_test_masks(matrix_mdev->kvm,
> +						matrix_mdev->matrix.apm,
> +						matrix_mdev->matrix.aqm,
> +						matrix_mdev->matrix.adm)) {
> +			vfio_ap_mdev_update_crycb(matrix_mdev);
> +		}
> +	}
> +}
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 76b7f98e47e9..acdd5bfabaaf 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -85,5 +85,7 @@ struct ap_matrix_mdev {
>  
>  extern int vfio_ap_mdev_register(void);
>  extern void vfio_ap_mdev_unregister(void);
> +void vfio_ap_mdev_remove_queue(unsigned long apid, unsigned long apqi);
> +void vfio_ap_mdev_probe_queue(unsigned long apid, unsigned long apqi);
>  
>  #endif /* _VFIO_AP_PRIVATE_H_ */
