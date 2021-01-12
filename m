Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 12 Jan 2021 19:44:00 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v13 14/15] s390/vfio-ap: handle AP bus scan completed
 notification
Message-ID: <20210112194400.095707c1.pasic@linux.ibm.com>
In-Reply-To: <20201223011606.5265-15-akrowiak@linux.ibm.com>
References: <20201223011606.5265-1-akrowiak@linux.ibm.com>
        <20201223011606.5265-15-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Tue, 22 Dec 2020 20:16:05 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> Implements the driver callback invoked by the AP bus when the AP bus
> scan has completed. Since this callback is invoked after binding the newly
> added devices to their respective device drivers, the vfio_ap driver will
> attempt to hot plug the adapters, domains and control domains into each
> guest using the matrix mdev to which they are assigned. Keep in mind that
> an adapter or domain can be plugged in only if:
> * Each APQN derived from the newly added APID of the adapter and the APQIs
>   already assigned to the guest's APCB references an AP queue device bound
>   to the vfio_ap driver
> * Each APQN derived from the newly added APQI of the domain and the APIDs
>   already assigned to the guest's APCB references an AP queue device bound
>   to the vfio_ap driver

As stated in my comment to your previous patch, I don't see the promised
mechanism for delaying hotplug (from probe). Without that we can't
consolidate, and the handling of on_scan_complete() is useless, because
the hotplugs are already done.

Regards,
Halil

> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c     |  1 +
>  drivers/s390/crypto/vfio_ap_ops.c     | 21 +++++++++++++++++++++
>  drivers/s390/crypto/vfio_ap_private.h |  2 ++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 2029d8392416..075495fc44c0 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -149,6 +149,7 @@ static int __init vfio_ap_init(void)
>  	vfio_ap_drv.remove = vfio_ap_mdev_remove_queue;
>  	vfio_ap_drv.in_use = vfio_ap_mdev_resource_in_use;
>  	vfio_ap_drv.on_config_changed = vfio_ap_on_cfg_changed;
> +	vfio_ap_drv.on_scan_complete = vfio_ap_on_scan_complete;
>  	vfio_ap_drv.ids = ap_queue_ids;
>  
>  	ret = ap_driver_register(&vfio_ap_drv, THIS_MODULE, VFIO_AP_DRV_NAME);
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 8bbbd1dc7546..b8ed01297812 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -1592,3 +1592,24 @@ void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
>  	vfio_ap_mdev_on_cfg_add();
>  	mutex_unlock(&matrix_dev->lock);
>  }
> +
> +void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
> +			      struct ap_config_info *old_config_info)
> +{
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	mutex_lock(&matrix_dev->lock);
> +	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
> +		if (bitmap_intersects(matrix_mdev->matrix.apm,
> +				      matrix_dev->ap_add, AP_DEVICES) ||
> +		    bitmap_intersects(matrix_mdev->matrix.aqm,
> +				      matrix_dev->aq_add, AP_DOMAINS) ||
> +		    bitmap_intersects(matrix_mdev->matrix.adm,
> +				      matrix_dev->ad_add, AP_DOMAINS))
> +			vfio_ap_mdev_refresh_apcb(matrix_mdev);
> +	}
> +
> +	bitmap_clear(matrix_dev->ap_add, 0, AP_DEVICES);
> +	bitmap_clear(matrix_dev->aq_add, 0, AP_DOMAINS);
> +	mutex_unlock(&matrix_dev->lock);
> +}
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index b99b68968447..7f0f7c92e686 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -117,5 +117,7 @@ int vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm);
>  
>  void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
>  			    struct ap_config_info *old_config_info);
> +void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
> +			      struct ap_config_info *old_config_info);
>  
>  #endif /* _VFIO_AP_PRIVATE_H_ */
