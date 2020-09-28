Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726387AbgI1BjB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sun, 27 Sep 2020 21:39:01 -0400
Date: Mon, 28 Sep 2020 03:38:17 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v10 13/16] s390/vfio-ap: handle host AP config change
 notification
Message-ID: <20200928033817.20b95549.pasic@linux.ibm.com>
In-Reply-To: <20200821195616.13554-14-akrowiak@linux.ibm.com>
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
        <20200821195616.13554-14-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, kernel test robot <lkp@intel.com>

On Fri, 21 Aug 2020 15:56:13 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> Implements the driver callback invoked by the AP bus when the host
> AP configuration has changed. Since this callback is invoked prior to
> unbinding a device from its device driver, the vfio_ap driver will
> respond by unplugging the AP adapters, domains and control domains
> removed from the host's AP configuration from the guests using them.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reported-by: kernel test robot <lkp@intel.com>

Looks reasonable, but shouldn't vfio_ap_mdev_remove_queue() already
have code that kicks the queue from the shadow at this stage?

I mean if the removal is for a reason different that host config change,
we wont update the guest_matrix or?

> ---
>  drivers/s390/crypto/vfio_ap_drv.c     |   5 +-
>  drivers/s390/crypto/vfio_ap_ops.c     | 147 ++++++++++++++++++++++++--
>  drivers/s390/crypto/vfio_ap_private.h |   7 +-
>  3 files changed, 146 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index aae5b3d8e3fa..ea0a7603e886 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -115,9 +115,11 @@ static int vfio_ap_matrix_dev_create(void)
>  
>  	/* Fill in config info via PQAP(QCI), if available */
>  	if (test_facility(12)) {
> -		ret = ap_qci(&matrix_dev->info);
> +		ret = ap_qci(&matrix_dev->config_info);
>  		if (ret)
>  			goto matrix_alloc_err;
> +		memcpy(&matrix_dev->config_info_prev, &matrix_dev->config_info,
> +		       sizeof(struct ap_config_info));
>  	}
>  
>  	mutex_init(&matrix_dev->lock);
> @@ -177,6 +179,7 @@ static int __init vfio_ap_init(void)
>  	vfio_ap_drv.remove = vfio_ap_queue_dev_remove;
>  	vfio_ap_drv.in_use = vfio_ap_mdev_resource_in_use;
>  	vfio_ap_drv.ids = ap_queue_ids;
> +	vfio_ap_drv.on_config_changed = vfio_ap_on_cfg_changed;
>  
>  	ret = ap_driver_register(&vfio_ap_drv, THIS_MODULE, VFIO_AP_DRV_NAME);
>  	if (ret) {
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 2b01a8eb6ee7..e002d556abab 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -347,7 +347,9 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>  	}
>  
>  	matrix_mdev->mdev = mdev;
> -	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
> +	vfio_ap_matrix_init(&matrix_dev->config_info, &matrix_mdev->matrix);
> +	vfio_ap_matrix_init(&matrix_dev->config_info,
> +			    &matrix_mdev->shadow_apcb);
>  	hash_init(matrix_mdev->qtable);
>  	mdev_set_drvdata(mdev, matrix_mdev);
>  	matrix_mdev->pqap_hook.hook = handle_pqap;
> @@ -526,8 +528,8 @@ static int vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev,
>  		 * If the APID is not assigned to the host AP configuration,
>  		 * we can not assign it to the guest's AP configuration
>  		 */
> -		if (!test_bit_inv(apid,
> -				  (unsigned long *)matrix_dev->info.apm)) {
> +		if (!test_bit_inv(apid, (unsigned long *)
> +				  matrix_dev->config_info.apm)) {
>  			clear_bit_inv(apid, shadow_apcb->apm);
>  			continue;
>  		}
> @@ -540,7 +542,7 @@ static int vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev,
>  			 * guest's AP configuration
>  			 */
>  			if (!test_bit_inv(apqi, (unsigned long *)
> -					  matrix_dev->info.aqm)) {
> +					  matrix_dev->config_info.aqm)) {
>  				clear_bit_inv(apqi, shadow_apcb->aqm);
>  				continue;
>  			}
> @@ -594,7 +596,7 @@ static bool vfio_ap_mdev_config_shadow_apcb(struct ap_matrix_mdev *matrix_mdev)
>  	int napm, naqm;
>  	struct ap_matrix shadow_apcb;
>  
> -	vfio_ap_matrix_init(&matrix_dev->info, &shadow_apcb);
> +	vfio_ap_matrix_init(&matrix_dev->config_info, &shadow_apcb);
>  	napm = bitmap_weight(matrix_mdev->matrix.apm, AP_DEVICES);
>  	naqm = bitmap_weight(matrix_mdev->matrix.aqm, AP_DOMAINS);
>  
> @@ -741,7 +743,7 @@ static bool vfio_ap_mdev_assign_apqis_4_apid(struct ap_matrix_mdev *matrix_mdev,
>  
>  	for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS) {
>  		if (!test_bit_inv(apqi,
> -				  (unsigned long *) matrix_dev->info.aqm))
> +				  (unsigned long *)matrix_dev->config_info.aqm))
>  			clear_bit_inv(apqi, aqm);
>  
>  		apqn = AP_MKQID(apid, apqi);
> @@ -764,7 +766,7 @@ static bool vfio_ap_mdev_assign_guest_apid(struct ap_matrix_mdev *matrix_mdev,
>  	unsigned long apqi, apqn;
>  
>  	if (!vfio_ap_mdev_has_crycb(matrix_mdev) ||
> -	    !test_bit_inv(apid, (unsigned long *)matrix_dev->info.apm))
> +	    !test_bit_inv(apid, (unsigned long *)matrix_dev->config_info.apm))
>  		return false;
>  
>  	if (bitmap_empty(matrix_mdev->shadow_apcb.aqm, AP_DOMAINS))
> @@ -931,8 +933,8 @@ static bool vfio_ap_mdev_assign_apids_4_apqi(struct ap_matrix_mdev *matrix_mdev,
>  	bitmap_copy(apm, matrix_mdev->matrix.apm, AP_DEVICES);
>  
>  	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
> -		if (!test_bit_inv(apid,
> -				  (unsigned long *) matrix_dev->info.apm))
> +		if (!test_bit_inv(apid, (unsigned long *)
> +				  matrix_dev->config_info.apm))
>  			clear_bit_inv(apqi, apm);
>  
>  		apqn = AP_MKQID(apid, apqi);
> @@ -955,7 +957,7 @@ static bool vfio_ap_mdev_assign_guest_apqi(struct ap_matrix_mdev *matrix_mdev,
>  	unsigned long apid, apqn;
>  
>  	if (!vfio_ap_mdev_has_crycb(matrix_mdev) ||
> -	    !test_bit_inv(apqi, (unsigned long *)matrix_dev->info.aqm))
> +	    !test_bit_inv(apqi, (unsigned long *)matrix_dev->config_info.aqm))
>  		return false;
>  
>  	if (bitmap_empty(matrix_mdev->shadow_apcb.apm, AP_DEVICES))
> @@ -1702,7 +1704,7 @@ int vfio_ap_mdev_probe_queue(struct ap_queue *queue)
>  void vfio_ap_mdev_remove_queue(struct ap_queue *queue)
>  {
>  	struct vfio_ap_queue *q;
> -	int apid, apqi;
> +	unsigned long apid, apqi;
>  

Unrelated?

>  	mutex_lock(&matrix_dev->lock);
>  	q = dev_get_drvdata(&queue->ap_dev.device);
> @@ -1727,3 +1729,126 @@ bool vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm)
>  
>  	return in_use;
>  }
> +
> +/**
> + * vfio_ap_mdev_unassign_apids
> + *
> + * @matrix_mdev: The matrix mediated device
> + *
> + * @aqm: A bitmap with 256 bits. Each bit in the map represents an APID from 0
> + *	 to 255 (with the leftmost bit corresponding to APID 0).
> + *
> + * Unassigns each APID specified in @aqm that is assigned to the shadow CRYCB
> + * of @matrix_mdev. Returns true if at least one APID is unassigned; otherwise,
> + * returns false.
> + */
> +static bool vfio_ap_mdev_unassign_apids(struct ap_matrix_mdev *matrix_mdev,
> +					unsigned long *apm_unassign)
> +{
> +	unsigned long apid;
> +	bool unassigned = false;
> +
> +	/*
> +	 * If the matrix mdev is not in use by a KVM guest, return indicating
> +	 * that no APIDs have been unassigned.
> +	 */
> +	if (!vfio_ap_mdev_has_crycb(matrix_mdev))
> +		return false;
> +
> +	for_each_set_bit_inv(apid, apm_unassign, AP_DEVICES) {
> +		unassigned |= vfio_ap_mdev_unassign_guest_apid(matrix_mdev,
> +							       apid);
> +	}

I guess, we could accomplish the unassign with operations operating on
full bitmaps (without looping over bits), but I have no strong opinion
here.

> +
> +	return unassigned;
> +}
> +
> +/**
> + * vfio_ap_mdev_unassign_apqis
> + *
> + * @matrix_mdev: The matrix mediated device
> + *
> + * @aqm: A bitmap with 256 bits. Each bit in the map represents an APQI from 0
> + *	 to 255 (with the leftmost bit corresponding to APQI 0).
> + *
> + * Unassigns each APQI specified in @aqm that is assigned to the shadow CRYCB
> + * of @matrix_mdev. Returns true if at least one APQI is unassigned; otherwise,
> + * returns false.
> + */
> +static bool vfio_ap_mdev_unassign_apqis(struct ap_matrix_mdev *matrix_mdev,
> +					unsigned long *aqm_unassign)
> +{
> +	unsigned long apqi;
> +	bool unassigned = false;
> +
> +	/*
> +	 * If the matrix mdev is not in use by a KVM guest, return indicating
> +	 * that no APQIs have been unassigned.
> +	 */
> +	if (!vfio_ap_mdev_has_crycb(matrix_mdev))
> +		return false;
> +
> +	for_each_set_bit_inv(apqi, aqm_unassign, AP_DOMAINS) {
> +		unassigned |= vfio_ap_mdev_unassign_guest_apqi(matrix_mdev,
> +							       apqi);
> +	}
> +
> +	return unassigned;
> +}
> +
> +void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
> +			    struct ap_config_info *old_config_info)
> +{
> +	bool unassigned;
> +	int ap_remove, aq_remove;
> +	struct ap_matrix_mdev *matrix_mdev;
> +	DECLARE_BITMAP(apm_unassign, AP_DEVICES);
> +	DECLARE_BITMAP(aqm_unassign, AP_DOMAINS);
> +
> +	unsigned long *cur_apm, *cur_aqm, *prev_apm, *prev_aqm;
> +
> +	if (matrix_dev->flags & AP_MATRIX_CFG_CHG) {
> +		WARN_ONCE(1, "AP host configuration change already reported");
> +		return;
> +	}
> +
> +	memcpy(&matrix_dev->config_info, new_config_info,
> +	       sizeof(struct ap_config_info));
> +	memcpy(&matrix_dev->config_info_prev, old_config_info,
> +	       sizeof(struct ap_config_info));
> +
> +	cur_apm = (unsigned long *)matrix_dev->config_info.apm;
> +	cur_aqm = (unsigned long *)matrix_dev->config_info.aqm;
> +	prev_apm = (unsigned long *)matrix_dev->config_info_prev.apm;
> +	prev_aqm = (unsigned long *)matrix_dev->config_info_prev.aqm;
> +
> +	ap_remove = bitmap_andnot(apm_unassign, prev_apm, cur_apm, AP_DEVICES);
> +	aq_remove = bitmap_andnot(aqm_unassign, prev_aqm, cur_aqm, AP_DOMAINS);
> +
> +	mutex_lock(&matrix_dev->lock);
> +	matrix_dev->flags |= AP_MATRIX_CFG_CHG;
> +
> +	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
> +		if (!vfio_ap_mdev_has_crycb(matrix_mdev))
> +			continue;
> +
> +		unassigned = false;
> +
> +		if (ap_remove)
> +			if (bitmap_intersects(matrix_mdev->shadow_apcb.apm,
> +					      apm_unassign, AP_DEVICES))
> +				if (vfio_ap_mdev_unassign_apids(matrix_mdev,
> +								apm_unassign))

This can be done with a single "if".

if (A)
	if (B)
		if (C)
			D;

should be equivalent with
if (A && B && C)
	D;
and your wouldn't end up that deep indentation. It is a style thing,
so unless regulated by the official coding style, it is up to you :)


> +					unassigned = true;
> +		if (aq_remove)
> +			if (bitmap_intersects(matrix_mdev->shadow_apcb.aqm,
> +					      aqm_unassign, AP_DOMAINS))
> +				if (vfio_ap_mdev_unassign_apqis(matrix_mdev,
> +								aqm_unassign))
> +					unassigned = true;
> +
> +		if (unassigned)
> +			vfio_ap_mdev_commit_shadow_apcb(matrix_mdev);
> +	}
> +	mutex_unlock(&matrix_dev->lock);
> +}
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 055bce6d45db..fc8629e28ad3 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -40,10 +40,13 @@
>  struct ap_matrix_dev {
>  	struct device device;
>  	atomic_t available_instances;
> -	struct ap_config_info info;
> +	struct ap_config_info config_info;
> +	struct ap_config_info config_info_prev;
>  	struct list_head mdev_list;
>  	struct mutex lock;
>  	struct ap_driver  *vfio_ap_drv;
> +	#define AP_MATRIX_CFG_CHG (1UL << 0)
> +	unsigned long flags;
>  };
>  
>  extern struct ap_matrix_dev *matrix_dev;
> @@ -108,5 +111,7 @@ int vfio_ap_mdev_probe_queue(struct ap_queue *queue);
>  void vfio_ap_mdev_remove_queue(struct ap_queue *queue);
>  
>  bool vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm);
> +void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
> +			    struct ap_config_info *old_config_info);
>  
>  #endif /* _VFIO_AP_PRIVATE_H_ */
