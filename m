From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [RFC 18/19] KVM: s390: New ioctl to configure KVM guest's AP
 matrix
Date: Thu, 2 Nov 2017 14:55:41 -0400
Message-ID: <5955dc6b-d7bd-2899-49d8-1f1118783b5f@linux.vnet.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1507916344-3896-19-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507916344-3896-19-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 10/13/2017 01:39 PM, Tony Krowiak wrote:
> Implements an ioctl to configure the adapters, usage domains
> and control domains to which a KVM guest will be granted
> access. The ioctl is invoked using the VFIO mediated matrix
> device's file descriptor.
>
> Guest access to AP adapters, usage domains and control domains
> is controlled by three bit masks referenced from the
> guest's SIE state description: The AP Mask (APM) controls
> access to the AP adapters; the AP Queue Mask (AQM) controls
> access to the AP usage domains; and the AP Domain Mask (ADM)
> controls access to the AP control domains. Each bit
> in the APM represents an adapter, from left to right,
> starting with adapter 0. Each bit in the AQM represents
> a usage domain, from left to right, starting with domain 0.
> Each bit in the ADM represents a control domain, from left
> to right, starting with domain 0.
>
> The APM, AQM and ADM bit masks will be populated from the
> bit masks stored in the corresponding mediated matrix device's
> sysfs files. The bit masks will also be returned by the ioctl
> call to the caller.
>
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_matrix_ops.c |   68 +++++++++++++++++++++++++++++-
>   include/uapi/linux/vfio.h                |   20 +++++++++
>   2 files changed, 86 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_matrix_ops.c b/drivers/s390/crypto/vfio_ap_matrix_ops.c
> index 74ea8db..d81e3ab 100644
> --- a/drivers/s390/crypto/vfio_ap_matrix_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_matrix_ops.c
> @@ -160,8 +160,69 @@ static int ap_matrix_mdev_get_device_info(unsigned long arg)
>   	return copy_to_user((void __user *)arg, &info, minsz);
>   }
>
> -static ssize_t ap_matrix_mdev_ioctl(struct mdev_device *mdev,
> -				    unsigned int cmd, unsigned long arg)
> +static int ap_matrix_configure(struct mdev_device *mdev)
> +{
> +	int ret;
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +
> +	ret = ap_config_matrix(matrix_mdev->kvm, &matrix_mdev->masks);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int ap_matrix_copy_to_user(struct mdev_device *mdev,
> +				  struct vfio_ap_matrix_config *mcfg,
> +				  unsigned long arg)
> +{
> +	size_t i;
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +
> +
> +	for (i = 0; i < AP_MATRIX_MASK_INDICES; i++) {
> +		if (i < VFIO_AP_MATRIX_MASK_INDICES) {
> +			mcfg->apm[i] = matrix_mdev->masks.apm[i];
> +			mcfg->aqm[i] = matrix_mdev->masks.aqm[i];
> +			mcfg->adm[i] = matrix_mdev->masks.adm[i];
> +		}
> +	}
> +
> +	if (copy_to_user((void __user *)arg, &mcfg, sizeof(mcfg)))
> +		return -EFAULT;
This is in error and needs to be:

if (copy_to_user((void __user *)arg, &mcfg, sizeof(*mcfg)))
	return -EFAULT;

> +
> +	return 0;
> +}
> +
> +static ssize_t ap_matrix_mdev_configure(struct mdev_device *mdev,
> +					unsigned long arg)
> +{
> +	int ret;
> +	unsigned long minsz;
> +	struct vfio_ap_matrix_config mcfg;
> +
> +	minsz = offsetofend(struct vfio_ap_matrix_config, adm);
> +
> +	if (copy_from_user(&mcfg, (void __user *)arg, minsz))
> +		return -EFAULT;
> +
> +	if (mcfg.argsz < minsz) {
> +		pr_err("%s: Argument size %u less than min size %li",
> +		       VFIO_AP_MATRIX_MODULE_NAME, mcfg.argsz, minsz);
> +		return -EINVAL;
> +	}
> +
> +	ret = ap_matrix_configure(mdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ap_matrix_copy_to_user(mdev, &mcfg, arg);
> +
> +	return 0;
> +}
> +
> +static long ap_matrix_mdev_ioctl(struct mdev_device *mdev,
> +				 unsigned int cmd, unsigned long arg)
>   {
>   	int ret;
>
> @@ -169,6 +230,9 @@ static ssize_t ap_matrix_mdev_ioctl(struct mdev_device *mdev,
>   	case VFIO_DEVICE_GET_INFO:
>   		ret = ap_matrix_mdev_get_device_info(arg);
>   		break;
> +	case VFIO_AP_MATRIX_CONFIGURE:
> +		ret = ap_matrix_mdev_configure(mdev, arg);
> +		break;
>   	default:
>   		pr_err("%s: ioctl command %d is not a supported command",
>   		       VFIO_AP_MATRIX_MODULE_NAME, cmd);
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 08f1ab4..2d96c57 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -716,6 +716,26 @@ struct vfio_iommu_spapr_tce_remove {
>   };
>   #define VFIO_IOMMU_SPAPR_TCE_REMOVE	_IO(VFIO_TYPE, VFIO_BASE + 20)
>
> +/**
> + * VFIO_AP_MATRIX_CONFIGURE		_IO(VFIO_TYPE, VFIO_BASE + 21
> + *
> + * Configure the AP matrix for a KVM guest.
> + */
> +#define VFIO_AP_MATRIX_CONFIGURE	_IO(VFIO_TYPE, VFIO_BASE + 21)
> +
> +#define VFIO_AP_MATRIX_MASK_INDICES	4
> +#define VFIO_AP_MATTRIX_MASK_BYTES	(VFIO_AP_MATRIX_MASK_INDICES * \
> +					 sizeof(__u64))
> +#define VFIO_AP_MATRIX_MASK_BITS	(VFIO_AP_MATTRIX_MASK_BYTES * 8)
> +
> +struct vfio_ap_matrix_config {
> +	__u32 argsz;
> +	__u32 flags;
> +	/* out */
> +	__u64 apm[VFIO_AP_MATRIX_MASK_INDICES];
> +	__u64 aqm[VFIO_AP_MATRIX_MASK_INDICES];
> +	__u64 adm[VFIO_AP_MATRIX_MASK_INDICES];
> +};
>   /* ***************************************************************** */
>
>   #endif /* _UAPIVFIO_H */
