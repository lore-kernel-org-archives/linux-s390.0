Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726380AbgI1CMB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sun, 27 Sep 2020 22:12:01 -0400
Date: Mon, 28 Sep 2020 04:11:00 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v10 14/16] s390/vfio-ap: handle AP bus scan completed
 notification
Message-ID: <20200928041100.14626565.pasic@linux.ibm.com>
In-Reply-To: <20200821195616.13554-15-akrowiak@linux.ibm.com>
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
        <20200821195616.13554-15-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Fri, 21 Aug 2020 15:56:14 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> Implements the driver callback invoked by the AP bus when the AP bus
> scan has completed. Since this callback is invoked after binding the newly
> added devices to their respective device drivers, the vfio_ap driver will
> attempt to plug the adapters, domains and control domains into each guest
> using a matrix mdev to which they are assigned. Keep in mind that an
> adapter or domain can be plugged in only if each APQN with the APID of the
> adapter or the APQI of the domain references a queue device bound to the
> vfio_ap device driver. Consequently, not all newly added adapters and
> domains will necessarily get hot plugged.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c     |   1 +
>  drivers/s390/crypto/vfio_ap_ops.c     | 110 +++++++++++++++++++++++++-
>  drivers/s390/crypto/vfio_ap_private.h |   2 +
>  3 files changed, 110 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index ea0a7603e886..21bfae928be5 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -180,6 +180,7 @@ static int __init vfio_ap_init(void)
>  	vfio_ap_drv.in_use = vfio_ap_mdev_resource_in_use;
>  	vfio_ap_drv.ids = ap_queue_ids;
>  	vfio_ap_drv.on_config_changed = vfio_ap_on_cfg_changed;
> +	vfio_ap_drv.on_scan_complete = vfio_ap_on_scan_complete;
>  
>  	ret = ap_driver_register(&vfio_ap_drv, THIS_MODULE, VFIO_AP_DRV_NAME);
>  	if (ret) {
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index e002d556abab..e6480f31a42b 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -616,14 +616,13 @@ static bool vfio_ap_mdev_config_shadow_apcb(struct ap_matrix_mdev *matrix_mdev)
>  		 * CRYCB after filtering, then try filtering the APQIs.
>  		 */
>  		if (napm == 0) {
> -			naqm = vfio_ap_mdev_filter_matrix(matrix_mdev,
> -							  &shadow_apcb, false);
> -
>  			/*
>  			 * If there are no APQNs that can be assigned to the
>  			 * matrix mdev after filtering the APQIs, then no APQNs
>  			 * shall be assigned to the guest's CRYCB.
>  			 */
> +			naqm = vfio_ap_mdev_filter_matrix(matrix_mdev,
> +							  &shadow_apcb, false);

Here you just moved the thing around the comment, or?

>  			if (naqm == 0) {
>  				bitmap_clear(shadow_apcb.apm, 0, AP_DEVICES);
>  				bitmap_clear(shadow_apcb.aqm, 0, AP_DOMAINS);
> @@ -1758,6 +1757,16 @@ static bool vfio_ap_mdev_unassign_apids(struct ap_matrix_mdev *matrix_mdev,
>  	for_each_set_bit_inv(apid, apm_unassign, AP_DEVICES) {
>  		unassigned |= vfio_ap_mdev_unassign_guest_apid(matrix_mdev,
>  							       apid);
> +		/*
> +		 * If the APID is not assigned to the matrix mdev's shadow
> +		 * CRYCB, continue with the next APID.
> +		 */
> +		if (!test_bit_inv(apid, matrix_mdev->shadow_apcb.apm))
> +			continue;
> +
> +		/* Unassign the APID from the matrix mdev's shadow CRYCB */
> +		clear_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
> +		unassigned = true;

I don't understand this at all. This patch is supposed to be about
assign and not unassign, or?

>  	}
>  
>  	return unassigned;
> @@ -1791,6 +1800,17 @@ static bool vfio_ap_mdev_unassign_apqis(struct ap_matrix_mdev *matrix_mdev,
>  	for_each_set_bit_inv(apqi, aqm_unassign, AP_DOMAINS) {
>  		unassigned |= vfio_ap_mdev_unassign_guest_apqi(matrix_mdev,
>  							       apqi);
> +
> +		/*
> +		 * If the APQI is not assigned to the matrix mdev's shadow
> +		 * CRYCB, continue with the next APQI
> +		 */
> +		if (!test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm))
> +			continue;
> +
> +		/* Unassign the APQI from the matrix mdev's shadow CRYCB */
> +		clear_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm);
> +		unassigned = true;
>  	}
>  
>  	return unassigned;
> @@ -1852,3 +1872,87 @@ void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
>  	}
>  	mutex_unlock(&matrix_dev->lock);
>  }
> +
> +bool vfio_ap_mdev_assign_apids(struct ap_matrix_mdev *matrix_mdev,
> +			       unsigned long *apm_assign)
> +{
> +	unsigned long apid;
> +	bool assigned = false;
> +
> +	for_each_set_bit_inv(apid, apm_assign, AP_DEVICES)
> +		if (test_bit_inv(apid, matrix_mdev->matrix.apm))
> +			if (vfio_ap_mdev_assign_guest_apid(matrix_mdev, apid))
> +				assigned = true;
> +
> +	return assigned;
> +}
> +
> +bool vfio_ap_mdev_assign_apqis(struct ap_matrix_mdev *matrix_mdev,
> +			       unsigned long *aqm_assign)
> +{
> +	unsigned long apqi;
> +	bool assigned = false;
> +
> +	for_each_set_bit_inv(apqi, aqm_assign, AP_DOMAINS)
> +		if (test_bit_inv(apqi, matrix_mdev->matrix.aqm))
> +			if (vfio_ap_mdev_assign_guest_apqi(matrix_mdev, apqi))
> +				assigned = true;
> +
> +	return assigned;
> +}
> +
> +void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
> +			      struct ap_config_info *old_config_info)
> +{
> +	struct ap_matrix_mdev *matrix_mdev;
> +	DECLARE_BITMAP(apm_assign, AP_DEVICES);
> +	DECLARE_BITMAP(aqm_assign, AP_DOMAINS);
> +	int ap_add, aq_add;
> +	bool assign;
> +	unsigned long *cur_apm, *cur_aqm, *prev_apm, *prev_aqm;
> +
> +	/*
> +	 * If we are not in the middle of a host configuration change scan it is
> +	 * likely that the vfio_ap driver was loaded mid-scan, so let's handle
> +	 * this scenario by calling the vfio_ap_on_cfg_changed function which
> +	 * gets called at the start of an AP bus scan when the host AP
> +	 * configuration has changed.
> +	 */
> +	if (!(matrix_dev->flags & AP_MATRIX_CFG_CHG))
> +		vfio_ap_on_cfg_changed(new_config_info, old_config_info);

Or we could just let the not-optimized variant handle it. Patch 15 has
to take care of single queues anyway, and 13 and 14 are about avoiding
having a bunch of updates to the CRYCB in short succession. But if we
just loaded the module in a middle of a config changing scan, then I
guess having a bunch of populated mdevs attached to guests is not very
likely.

> +
> +	cur_apm = (unsigned long *)matrix_dev->config_info.apm;
> +	cur_aqm = (unsigned long *)matrix_dev->config_info.aqm;
> +
> +	prev_apm = (unsigned long *)matrix_dev->config_info_prev.apm;
> +	prev_aqm = (unsigned long *)matrix_dev->config_info_prev.aqm;
> +
> +	ap_add = bitmap_andnot(apm_assign, cur_apm, prev_apm, AP_DEVICES);
> +	aq_add = bitmap_andnot(aqm_assign, cur_aqm, prev_aqm, AP_DOMAINS);
> +
> +	mutex_lock(&matrix_dev->lock);
> +	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
> +		if (!vfio_ap_mdev_has_crycb(matrix_mdev))
> +			continue;
> +
> +		assign = false;
> +
> +		if (ap_add)
> +			if (bitmap_intersects(matrix_mdev->matrix.apm,
> +					      apm_assign, AP_DEVICES))
> +				assign |= vfio_ap_mdev_assign_apids(matrix_mdev,
> +								    apm_assign);
> +
> +		if (aq_add)
> +			if (bitmap_intersects(matrix_mdev->matrix.aqm,
> +					      aqm_assign, AP_DOMAINS))
> +				assign |= vfio_ap_mdev_assign_apqis(matrix_mdev,
> +								    aqm_assign);
> +
> +		if (assign)
> +			vfio_ap_mdev_commit_shadow_apcb(matrix_mdev);
> +	}
> +
> +	matrix_dev->flags &= ~AP_MATRIX_CFG_CHG;
> +	mutex_unlock(&matrix_dev->lock);
> +}


There may be a simpler and more concise way to accomplish this logic,
but at this point I don't want to think about that. We can do
refactoring any time we want. I'm more worried about the points I
addressed in reference to the previous patches.

Regards,
Halil

> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index fc8629e28ad3..da1754fd4f66 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -113,5 +113,7 @@ void vfio_ap_mdev_remove_queue(struct ap_queue *queue);
>  bool vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm);
>  void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
>  			    struct ap_config_info *old_config_info);
> +void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
> +			      struct ap_config_info *old_config_info);
>  
>  #endif /* _VFIO_AP_PRIVATE_H_ */
