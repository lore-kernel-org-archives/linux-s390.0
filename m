From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Wed, 01 Aug 2018 22:12:56 +0000
Subject: Re: [PATCH v7 16/22] s390: vfio-ap: implement mediated device open callback
Message-Id: <f1a5bcd7-37bf-6d49-3f20-5781e294ecee@linux.ibm.com>
In-Reply-To: <c54b9ab8-720e-e277-aee1-7d73df07c08a@redhat.com>
References: <c54b9ab8-720e-e277-aee1-7d73df07c08a@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 07/27/2018 11:23 AM, Thomas Huth wrote:
> On 07/26/2018 09:54 PM, Christian Borntraeger wrote:
> [...]
>> +static void kvm_ap_merge_bitmasks(unsigned long *dst, unsigned long *mask1,
>> +				  unsigned long *mask2, unsigned long nbits)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < BITS_TO_LONGS(nbits); i++)
>> +		dst[i] = mask1[i] | mask2[i];
>> +}
> Could you use the standard bitmap_or() function instead of implementing
> your own version?

In a previous iteration of this patch, the bitmap_or() function was used.
It did not perform as expected when nbits > 32, so we rolled out own.

>
>> +static void vfio_ap_mdev_copy_masks(struct ap_matrix_mdev *matrix_mdev,
>> +				    struct kvm_s390_crypto_cb *crycb)
>> +{
>> +	int nbytes;
>> +	unsigned long *apm, *aqm, *adm;
>> +
>> +	switch (matrix_mdev->kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
>> +	case CRYCB_FORMAT2:
>> +		apm = (unsigned long *)crycb->apcb1.apm;
>> +		aqm = (unsigned long *)crycb->apcb1.aqm;
>> +		adm = (unsigned long *)crycb->apcb1.adm;
>> +		break;
>> +	case CRYCB_FORMAT1:
>> +	case CRYCB_FORMAT0:
>> +	default:
>> +		apm = (unsigned long *)crycb->apcb0.apm;
>> +		aqm = (unsigned long *)crycb->apcb0.aqm;
>> +		adm = (unsigned long *)crycb->apcb0.adm;
>> +		break;
>> +	}
>> +
>> +	nbytes = DIV_ROUND_UP(matrix_mdev->matrix.apm_max + 1, BITS_PER_BYTE);
>> +	memcpy(apm, matrix_mdev->matrix.apm, nbytes);
>> +	nbytes = DIV_ROUND_UP(matrix_mdev->matrix.aqm_max + 1, BITS_PER_BYTE);
>> +	memcpy(aqm, matrix_mdev->matrix.aqm, nbytes);
>> +	kvm_ap_merge_bitmasks(adm, aqm, adm, matrix_mdev->matrix.adm_max + 1);
>> +}
>> +
>> +static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>> +				       unsigned long action, void *data)
>> +{
>> +	int ret;
>> +	struct ap_matrix_mdev *matrix_mdev;
>> +	struct kvm_s390_crypto_cb *crycb;
>> +
>> +	if (action == VFIO_GROUP_NOTIFY_SET_KVM) {
>> +		matrix_mdev = container_of(nb, struct ap_matrix_mdev,
>> +					   group_notifier);
>> +		matrix_mdev->kvm = data;
>> +		crycb  = matrix_mdev->kvm->arch.crypto.crycb;
>> +
>> +		ret = kvm_ap_validate_crypto_setup(matrix_mdev->kvm);
>> +		if (ret)
>> +			return ret;
>> +
>> +		/* NOTE: Happens before any vcpu is running (no hotplug). */
>> +		vfio_ap_mdev_copy_masks(matrix_mdev, crycb);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>> +/**
>> + * vfio_ap_mdev_open_once
>> + *
>> + * @matrix_mdev: a mediated matrix device
>> + *
>> + * Return 0 if no other mediated matrix device has been opened for the
>> + * KVM guest assigned to @matrix_mdev; otherwise, returns an error.
>> + */
>> +static int vfio_ap_mdev_open_once(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +	int ret = 0;
>> +	struct ap_matrix_mdev *lstdev;
>> +
>> +	list_for_each_entry(lstdev, &matrix_dev.mdev_list, list) {
>> +		if ((lstdev->kvm == matrix_mdev->kvm) &&
>> +		    (lstdev != matrix_mdev)) {
> Too much parentheses again for my taste ;-)

I think we'll have to agree to disagree here. As I stated in a previous
response, it is my opinion that using parenthesis precludes having to
memorize operator preference rules.

>
>> +			ret = -EPERM;
>> +			break;
>> +		}
>> +	}
>
>   Thomas
>
>
