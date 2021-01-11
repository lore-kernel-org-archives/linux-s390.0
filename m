Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390886AbhAKUl2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 Jan 2021 15:41:28 -0500
Date: Mon, 11 Jan 2021 21:40:37 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v13 06/15] s390/vfio-ap: allow assignment of unavailable
 AP queues to mdev device
Message-ID: <20210111214037.477f0f03.pasic@linux.ibm.com>
In-Reply-To: <20201223011606.5265-7-akrowiak@linux.ibm.com>
References: <20201223011606.5265-1-akrowiak@linux.ibm.com>
        <20201223011606.5265-7-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Tue, 22 Dec 2020 20:15:57 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> The current implementation does not allow assignment of an AP adapter or
> domain to an mdev device if each APQN resulting from the assignment
> does not reference an AP queue device that is bound to the vfio_ap device
> driver. This patch allows assignment of AP resources to the matrix mdev as
> long as the APQNs resulting from the assignment:
>    1. Are not reserved by the AP BUS for use by the zcrypt device drivers.
>    2. Are not assigned to another matrix mdev.
> 
> The rationale behind this is twofold:
>    1. The AP architecture does not preclude assignment of APQNs to an AP
>       configuration that are not available to the system.
>    2. APQNs that do not reference a queue device bound to the vfio_ap
>       device driver will not be assigned to the guest's CRYCB, so the
>       guest will not get access to queues not bound to the vfio_ap driver.

You didn't tell us about the changed error code.

Also notice that this point we don't have neither filtering nor in-use.
This used to be patch 11, and most of that stuff used to be in place. But
I'm going to trust you, if you say its fine to enable it this early.

> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 241 ++++++++----------------------
>  1 file changed, 62 insertions(+), 179 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index cdcc6378b4a5..2d58b39977be 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -379,134 +379,37 @@ static struct attribute_group *vfio_ap_mdev_type_groups[] = {
>  	NULL,
>  };
>  
> -struct vfio_ap_queue_reserved {
> -	unsigned long *apid;
> -	unsigned long *apqi;
> -	bool reserved;
> -};
> +#define MDEV_SHARING_ERR "Userspace may not re-assign queue %02lx.%04lx " \
> +			 "already assigned to %s"
>  
> -/**
> - * vfio_ap_has_queue
> - *
> - * @dev: an AP queue device
> - * @data: a struct vfio_ap_queue_reserved reference
> - *
> - * Flags whether the AP queue device (@dev) has a queue ID containing the APQN,
> - * apid or apqi specified in @data:
> - *
> - * - If @data contains both an apid and apqi value, then @data will be flagged
> - *   as reserved if the APID and APQI fields for the AP queue device matches
> - *
> - * - If @data contains only an apid value, @data will be flagged as
> - *   reserved if the APID field in the AP queue device matches
> - *
> - * - If @data contains only an apqi value, @data will be flagged as
> - *   reserved if the APQI field in the AP queue device matches
> - *
> - * Returns 0 to indicate the input to function succeeded. Returns -EINVAL if
> - * @data does not contain either an apid or apqi.
> - */
> -static int vfio_ap_has_queue(struct device *dev, void *data)
> +static void vfio_ap_mdev_log_sharing_err(const char *mdev_name,
> +					 unsigned long *apm,
> +					 unsigned long *aqm)
[..]
> -	return 0;
> +	for_each_set_bit_inv(apid, apm, AP_DEVICES)
> +		for_each_set_bit_inv(apqi, aqm, AP_DOMAINS)
> +			pr_warn(MDEV_SHARING_ERR, apid, apqi, mdev_name);

I would prefer dev_warn() here. We know which device is about to get
more queues, and this device can provide a clue regarding the initiator.

Also I believe a warning is too heavy handed here. Warnings should not
be ignored. This is a condition that can emerge during normal operation,
AFAIU. Or am I worng?

>  }
>  
>  /**
>   * vfio_ap_mdev_verify_no_sharing
>   *
> - * Verifies that the APQNs derived from the cross product of the AP adapter IDs
> - * and AP queue indexes comprising the AP matrix are not configured for another
> - * mediated device. AP queue sharing is not allowed.
> + * Verifies that each APQN derived from the Cartesian product of the AP adapter
> + * IDs and AP queue indexes comprising the AP matrix are not configured for
> + * another mediated device. AP queue sharing is not allowed.
>   *
> - * @matrix_mdev: the mediated matrix device
> + * @matrix_mdev: the mediated matrix device to which the APQNs being verified
> + *		 are assigned.
> + * @mdev_apm: mask indicating the APIDs of the APQNs to be verified
> + * @mdev_aqm: mask indicating the APQIs of the APQNs to be verified
>   *
> - * Returns 0 if the APQNs are not shared, otherwise; returns -EADDRINUSE.
> + * Returns 0 if the APQNs are not shared, otherwise; returns -EBUSY.
>   */
> -static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
> +static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev,
> +					  unsigned long *mdev_apm,
> +					  unsigned long *mdev_aqm)
>  {
>  	struct ap_matrix_mdev *lstdev;
>  	DECLARE_BITMAP(apm, AP_DEVICES);
> @@ -523,20 +426,31 @@ static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
>  		 * We work on full longs, as we can only exclude the leftover
>  		 * bits in non-inverse order. The leftover is all zeros.
>  		 */
> -		if (!bitmap_and(apm, matrix_mdev->matrix.apm,
> -				lstdev->matrix.apm, AP_DEVICES))
> +		if (!bitmap_and(apm, mdev_apm, lstdev->matrix.apm, AP_DEVICES))
>  			continue;
>  
> -		if (!bitmap_and(aqm, matrix_mdev->matrix.aqm,
> -				lstdev->matrix.aqm, AP_DOMAINS))
> +		if (!bitmap_and(aqm, mdev_aqm, lstdev->matrix.aqm, AP_DOMAINS))
>  			continue;
>  
> -		return -EADDRINUSE;
> +		vfio_ap_mdev_log_sharing_err(dev_name(mdev_dev(lstdev->mdev)),
> +					     apm, aqm);
> +
> +		return -EBUSY;

Why do we change -EADDRINUSE to -EBUSY? This gets bubbled up to
userspace, or? So a tool that checks for the other mdev has it
condition by checking for -EADDRINUSE, would be confused...

>  	}
>  
>  	return 0;
>  }
>  
> +static int vfio_ap_mdev_validate_masks(struct ap_matrix_mdev *matrix_mdev,
> +				       unsigned long *mdev_apm,
> +				       unsigned long *mdev_aqm)
> +{
> +	if (ap_apqn_in_matrix_owned_by_def_drv(mdev_apm, mdev_aqm))
> +		return -EADDRNOTAVAIL;
> +
> +	return vfio_ap_mdev_verify_no_sharing(matrix_mdev, mdev_apm, mdev_aqm);
> +}
> +
>  static void vfio_ap_mdev_link_queue(struct ap_matrix_mdev *matrix_mdev,
>  				    struct vfio_ap_queue *q)
>  {
> @@ -608,10 +522,10 @@ static void vfio_ap_mdev_link_adapter(struct ap_matrix_mdev *matrix_mdev,
>   *	   driver; or, if no APQIs have yet been assigned, the APID is not
>   *	   contained in an APQN bound to the vfio_ap device driver.
>   *
> - *	4. -EADDRINUSE
> + *	4. -EBUSY
>   *	   An APQN derived from the cross product of the APID being assigned
>   *	   and the APQIs previously assigned is being used by another mediated
> - *	   matrix device
> + *	   matrix device or the mdev lock could not be acquired.

This is premature. We don't use try_lock yet.

[..]

>  static void vfio_ap_mdev_link_domain(struct ap_matrix_mdev *matrix_mdev,
>  				     unsigned long apqi)
>  {
> @@ -774,10 +660,10 @@ static void vfio_ap_mdev_link_domain(struct ap_matrix_mdev *matrix_mdev,
>   *	   driver; or, if no APIDs have yet been assigned, the APQI is not
>   *	   contained in an APQN bound to the vfio_ap device driver.
>   *
> - *	4. -EADDRINUSE
> + *	4. -BUSY
>   *	   An APQN derived from the cross product of the APQI being assigned
>   *	   and the APIDs previously assigned is being used by another mediated
> - *	   matrix device
> + *	   matrix device or the mdev lock could not be acquired.

Same here as above.

Otherwise looks good.

[..]
