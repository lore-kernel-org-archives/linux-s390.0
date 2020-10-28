Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 28 Oct 2020 16:03:30 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v11 09/14] s390/vfio-ap: allow assignment of unavailable
 AP queues to mdev device
Message-ID: <20201028160330.55df0068.pasic@linux.ibm.com>
In-Reply-To: <20201022171209.19494-10-akrowiak@linux.ibm.com>
References: <20201022171209.19494-1-akrowiak@linux.ibm.com>
        <20201022171209.19494-10-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Thu, 22 Oct 2020 13:12:04 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

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
>  static bool vfio_ap_mdev_matrixes_equal(struct ap_matrix *matrix1,
>  					struct ap_matrix *matrix2)
>  {
> @@ -840,33 +734,21 @@ static ssize_t assign_adapter_store(struct device *dev,
>  	if (apid > matrix_mdev->matrix.apm_max)
>  		return -ENODEV;
>  
> -	/*
> -	 * Set the bit in the AP mask (APM) corresponding to the AP adapter
> -	 * number (APID). The bits in the mask, from most significant to least
> -	 * significant bit, correspond to APIDs 0-255.
> -	 */
> -	mutex_lock(&matrix_dev->lock);
> -
> -	ret = vfio_ap_mdev_verify_queues_reserved_for_apid(matrix_mdev, apid);
> -	if (ret)
> -		goto done;
> -
>  	memset(apm, 0, sizeof(apm));
>  	set_bit_inv(apid, apm);
>  
> -	ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev, apm,
> -					     matrix_mdev->matrix.aqm);
> -	if (ret)
> -		goto done;
> -
> +	mutex_lock(&matrix_dev->lock);
> +	ret = vfio_ap_mdev_validate_masks(matrix_mdev, apm,
> +					  matrix_mdev->matrix.aqm);

Is this a potential deadlock?

Consider following scenario 
1) apmask_store() takes ap_perms_mutex
2) assign_adapter_store() takes matrix_dev->lock
3) apmask_store() calls vfio_ap_mdev_resource_in_use() which tries
   to take matrix_dev->lock
4) assign_adapter_store() calls ap_apqn_in_matrix_owned_by_def_drv
   which tries to take ap_perms_mutex

BANG!

I think using mutex_trylock(&matrix_dev->lock) and bailing out with busy
if we don't manage to acquire the lock would be a good idea anyway, to
prevent a bunch of mdev management operations piling up on the mutex
and starving in_use().

Regards,
Halil

 
> +	if (ret) {
> +		mutex_unlock(&matrix_dev->lock);
> +		return ret;
> +	}
>  	set_bit_inv(apid, matrix_mdev->matrix.apm);
>  	vfio_ap_mdev_link_queues(matrix_mdev, LINK_APID, apid);
> -	ret = count;
> -
> -done:
>  	mutex_unlock(&matrix_dev->lock);
>  
> -	return ret;
> +	return count;
