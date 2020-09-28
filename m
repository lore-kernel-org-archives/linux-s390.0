Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 28 Sep 2020 04:45:40 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v10 15/16] s390/vfio-ap: handle probe/remove not due to
 host AP config changes
Message-ID: <20200928044540.6e53760d.pasic@linux.ibm.com>
In-Reply-To: <20200821195616.13554-16-akrowiak@linux.ibm.com>
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
        <20200821195616.13554-16-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Fri, 21 Aug 2020 15:56:15 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> AP queue devices are probed or removed for reasons other than changes
> to the host AP configuration. For example:
> 
> * The state of an AP adapter can be dynamically changed from standby to
>   online via the SE or by execution of the SCLP Configure AP command. When
>   the state changes, each queue device associated with the card device
>   representing the adapter will get created and probed.
> 
> * The state of an AP adapter can be dynamically changed from online to
>   standby via the SE or by execution of the SCLP Deconfigure AP command.
>   When the state changes, each queue device associated with the card device
>   representing the adapter will get removed.
> 
> * Each queue device associated with a card device will get removed
>   when the type of the AP adapter represented by the card device
>   dynamically changes.
> 
> * Each queue device associated with a card device will get removed
>   when the status of the queue represented by the queue device changes
>   from operating to check stop.
> 
> * AP queue devices can be manually bound to or unbound from the vfio_ap
>   device driver by a root user via the sysfs bind/unbind attributes of the
>   driver.
> 
> In response to a queue device probe or remove that is not the result of a
> change to the host's AP configuration, if a KVM guest is using the matrix
> mdev to which the APQN of the queue device is assigned, the vfio_ap device
> driver must respond accordingly. In an ideal world, the queue device being
> probed would be hot plugged into the guest. Likewise, the queue
> corresponding to the queue device being removed would
> be hot unplugged from the guest. Unfortunately, the AP architecture
> precludes plugging or unplugging individual queues, so let's handle
> the probe or remove of an AP queue device as follows:
> 
> Handling Probe
> --------------
> There are two requirements that must be met in order to give a
> guest access to the queue corresponding to the queue device being probed:
> 
> * Each APQN derived from the APID of the queue device and the APQIs of the
>   domains already assigned to the guest's AP configuration must reference
>   a queue device bound to the vfio_ap device driver.
> 
> * Each APQN derived from the APQI of the queue device and the APIDs of the
>   adapters assigned to the guest's AP configuration must reference a queue
>   device bound to the vfio_ap device driver.
> 
> If the above conditions are met, the APQN will be assigned to the guest's
> AP configuration and the guest will be given access to the queue.
> 
> Handling Remove
> ---------------
> Since the AP architecture precludes us from taking access to an individual
> queue from a guest, we are left with the choice of taking access away from
> either the adapter or the domain to which the queue is connected. Access to
> the adapter will be taken away because it is likely that most of the time,
> the remove callback will be invoked because the adapter state has
> transitioned from online to standby. In such a case, no queue connected
> to the adapter will be available to access.
> 

I think I would like to have the 'react to binds and unbinds'
functionality added as a single patch to avoid introducing commits that
realize that don't act like designed. You could, for example implement
the config change callbacks in separate patches (like you did) to ease
review, but delay their registration with the AP bus.

I would also prefer 'react to binds and unbinds' implemented before
'allow changes to a running guests config'. Actually the 'react to binds
and unbinds' should be introduced together with filtering, because if
we filtered because of the bind situation, we want to revisit the
filtering when the bind situation changes. At least in my opinion.


> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 84 +++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index e6480f31a42b..b6a1e280991d 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -1682,6 +1682,61 @@ static void vfio_ap_queue_link_mdev(struct vfio_ap_queue *q)
>  	}
>  }
>  
> +static bool vfio_ap_mdev_assign_shadow_apid(struct ap_matrix_mdev *matrix_mdev,
> +					    unsigned long apid)
> +{
> +	unsigned long apqi;
> +
> +	for_each_set_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm,
> +			     matrix_mdev->shadow_apcb.aqm_max + 1) {
> +		if (!vfio_ap_get_queue(AP_MKQID(apid, apqi)))
> +			return false;
> +	}
> +
> +	set_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
> +
> +	return true;
> +}
> +
> +static bool vfio_ap_mdev_assign_shadow_apqi(struct ap_matrix_mdev *matrix_mdev,
> +					    unsigned long apqi)
> +{
> +	unsigned long apid;
> +
> +	for_each_set_bit_inv(apid, matrix_mdev->shadow_apcb.apm,
> +			     matrix_mdev->shadow_apcb.apm_max + 1) {
> +		if (!vfio_ap_get_queue(AP_MKQID(apid, apqi)))
> +			return false;
> +	}
> +
> +	set_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm);
> +
> +	return true;
> +}
> +
> +static void vfio_ap_mdev_hot_plug_queue(struct vfio_ap_queue *q)
> +{
> +	bool commit = false;
> +	unsigned long apid = AP_QID_CARD(q->apqn);
> +	unsigned long apqi = AP_QID_QUEUE(q->apqn);
> +
> +	if ((q->matrix_mdev == NULL) || !vfio_ap_mdev_has_crycb(q->matrix_mdev))
> +		return;
> +
> +	if (!test_bit_inv(apid, q->matrix_mdev->matrix.apm) ||
> +	    !test_bit_inv(apqi, q->matrix_mdev->matrix.aqm))
> +		return;
> +
> +	if (!test_bit_inv(apid, q->matrix_mdev->shadow_apcb.apm))
> +		commit |= vfio_ap_mdev_assign_shadow_apid(q->matrix_mdev, apid);
> +
> +	if (!test_bit_inv(apqi, q->matrix_mdev->shadow_apcb.aqm))
> +		commit |= vfio_ap_mdev_assign_shadow_apqi(q->matrix_mdev, apqi);
> +
> +	if (commit)
> +		vfio_ap_mdev_commit_shadow_apcb(q->matrix_mdev);
> +}
> +
>  int vfio_ap_mdev_probe_queue(struct ap_queue *queue)
>  {
>  	struct vfio_ap_queue *q;
> @@ -1695,11 +1750,35 @@ int vfio_ap_mdev_probe_queue(struct ap_queue *queue)
>  	q->apqn = queue->qid;
>  	q->saved_isc = VFIO_AP_ISC_INVALID;
>  	vfio_ap_queue_link_mdev(q);
> +	/* Make sure we're not in the middle of an AP configuration change. */
> +	if (!(matrix_dev->flags & AP_MATRIX_CFG_CHG))
> +		vfio_ap_mdev_hot_plug_queue(q);
>  	mutex_unlock(&matrix_dev->lock);
>  
>  	return 0;
>  }
>  
> +void vfio_ap_mdev_hot_unplug_queue(struct vfio_ap_queue *q)
> +{
> +	unsigned long apid = AP_QID_CARD(q->apqn);
> +	unsigned long apqi = AP_QID_QUEUE(q->apqn);
> +
> +	if ((q->matrix_mdev == NULL) || !vfio_ap_mdev_has_crycb(q->matrix_mdev))
> +		return;
> +
> +	/*
> +	 * If the APQN is assigned to the guest, then let's
> +	 * go ahead and unplug the adapter since the
> +	 * architecture does not provide a means to unplug
> +	 * an individual queue.
> +	 */
> +	if (test_bit_inv(apid, q->matrix_mdev->shadow_apcb.apm) &&
> +	    test_bit_inv(apqi, q->matrix_mdev->shadow_apcb.aqm)) {
> +		if (vfio_ap_mdev_unassign_guest_apid(q->matrix_mdev, apid))
> +			vfio_ap_mdev_commit_shadow_apcb(q->matrix_mdev);
> +	}
> +}
> +
>  void vfio_ap_mdev_remove_queue(struct ap_queue *queue)
>  {
>  	struct vfio_ap_queue *q;
> @@ -1707,6 +1786,11 @@ void vfio_ap_mdev_remove_queue(struct ap_queue *queue)
>  
>  	mutex_lock(&matrix_dev->lock);
>  	q = dev_get_drvdata(&queue->ap_dev.device);
> +
> +	/* Make sure we're not in the middle of an AP configuration change. */
> +	if (!(matrix_dev->flags & AP_MATRIX_CFG_CHG))
> +		vfio_ap_mdev_hot_unplug_queue(q);
> +

Can a queue get unplugged for a different reason than a configuration
change, while we are in a middle of a configuration change?

If it can then I don't think we would react accordingly -- it would
slip through the cracks.

Actually I would use the link between the mdev and the queue to shortcut
remove_queue(). That is on_cfg_changed should severe the by setting the
matrix_mdev pointer to NULL after the queue got cleaned up. If the
matrix_mdev pointer is still valid remove_queue should do the full
program.

Please also consider a similar scenario in probe (e.g. queue comes back
form manual unbind while AP_MATRIX_CFG_CHG. It is less critical that
remove though.

Regards,
Halil

>  	dev_set_drvdata(&queue->ap_dev.device, NULL);
>  	apid = AP_QID_CARD(q->apqn);
>  	apqi = AP_QID_QUEUE(q->apqn);
