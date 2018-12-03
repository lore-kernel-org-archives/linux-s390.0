From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 3/3] vfio: ap: AP Queue Interrupt Control VFIO ioctl
 calls
Date: Mon, 3 Dec 2018 11:04:22 +0100
Message-ID: <20181203110422.4d069a8c.cohuck@redhat.com>
References: <1542906675-7949-1-git-send-email-pmorel@linux.ibm.com>
        <1542906675-7949-4-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542906675-7949-4-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 22 Nov 2018 18:11:15 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> This is the implementation of the VFIO ioctl calls to handle
> the AQIC interception and use GISA to handle interrupts.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 110 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 109 insertions(+), 1 deletion(-)
> 

> +static int vfio_ap_ioctl_setirq(struct mdev_device *mdev, unsigned long arg)
> +{
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	struct vfio_ap_aqic parm;
> +	struct ap_qirq_ctrl aqic_gisa = {};
> +	struct kvm *kvm = matrix_mdev->kvm;
> +	struct kvm_s390_gisa *gisa = kvm->arch.gisa;
> +	struct ap_queue_status ap_status;
> +	unsigned long nib;
> +
> +	if (copy_from_user(&parm, (void __user *)arg, sizeof(parm)))
> +		return -EFAULT;
> +
> +	if (parm.isc > MAX_ISC)
> +		return -EINVAL;
> +
> +	if (kvm->vcpus[0]->arch.sie_block->gd & 0x01)
> +		aqic_gisa.gf = 1;
> +
> +	nib = vfio_ap_get_nib(kvm, &parm);
> +	if (!nib)
> +		return -ENODEV;
> +
> +	aqic_gisa.gisc = parm.isc;
> +	aqic_gisa.isc = kvm_s390_gisc_register(kvm, parm.isc);

Oh, and as I just looked at the callers of these functions: You'll want
to check the return code here, even though the function should not fail
with the checking you did beforehand.

[I assume you'll have similar code even when using a different
interface.]

> +	aqic_gisa.ir = 1;
> +	aqic_gisa.gisa = gisa->next_alert >> 4;
> +
> +	ap_status = ap_aqic(parm.apqn, aqic_gisa, (void *)nib);
> +	parm.status = *(uint32_t *)(&ap_status);
> +
> +	if (copy_to_user((void __user *)arg, &parm, sizeof(parm))) {
> +		kvm_s390_gisc_unregister(kvm, parm.isc);
> +		return -EFAULT;
> +	}
> +
> +	if (ap_status.response_code) {
> +		kvm_s390_gisc_unregister(kvm, parm.isc);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int vfio_ap_ioctl_clrirq(struct mdev_device *mdev, unsigned long arg)
> +{
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	struct vfio_ap_aqic parm;
> +	struct ap_qirq_ctrl aqic_gisa = {};
> +	struct ap_queue_status ap_status;
> +	struct kvm *kvm = matrix_mdev->kvm;
> +
> +	if (copy_from_user(&parm, (void __user *)arg, sizeof(parm)))
> +		return -EFAULT;
> +
> +	if (kvm->vcpus[0]->arch.sie_block->gd & 0x01)
> +		aqic_gisa.gf = 1;
> +	aqic_gisa.ir = 0;
> +
> +	ap_status = ap_aqic(parm.apqn, aqic_gisa, NULL);
> +	parm.status = *(uint32_t *)(&ap_status);
> +
> +	kvm_s390_gisc_unregister(kvm, parm.isc);

Here, you don't seem to verify the sanity of parm.isc beforehand...
luckily the function can deal with that :)

> +
> +	if (copy_to_user((void __user *)arg, &parm, sizeof(parm)))
> +		return -EFAULT;
> +
> +	return (ap_status.response_code) ? -EIO : 0;
> +}
> +
