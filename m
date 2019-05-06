Return-Path: <SRS0=l9rD=TG=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2 4/7] s390: vfio-ap: allow assignment of unavailable AP
 resources to mdev device
References: <1556918073-13171-1-git-send-email-akrowiak@linux.ibm.com>
 <1556918073-13171-5-git-send-email-akrowiak@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 6 May 2019 09:05:07 +0200
MIME-Version: 1.0
In-Reply-To: <1556918073-13171-5-git-send-email-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <2ba0aa01-e043-0013-4e2e-ea17bf9eea05@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com
List-ID: <linux-s390.vger.kernel.org>

On 03/05/2019 23:14, Tony Krowiak wrote:
> The AP architecture does not preclude assignment of AP resources that are
> not yet in the AP configuration (i.e., not available or not online).
> Let's go ahead and implement this facet of the AP architecture for linux
> guests.
> 
> The current implementation does not allow assignment of AP resources to
> an mdev device if the AP queue devices identified by the assignment are
> not bound to the vfio_ap device driver. This patch allows assignment of AP
> resources to the mdev device even if the AP queue devices are not bound to
> the vfio_ap device driver, as long as the AP queue devices are not
> reserved by the AP BUS for use by the zcrypt device drivers.

or another mediated device.


> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c | 231 ++++++++------------------------------
>   1 file changed, 44 insertions(+), 187 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 1021466cb661..ea24caf17a16 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -113,122 +113,6 @@ static struct attribute_group *vfio_ap_mdev_type_groups[] = {
>   	NULL,
>   };
>   
> -struct vfio_ap_queue_reserved {
> -	unsigned long *apid;
> -	unsigned long *apqi;
> -	bool reserved;
> -};
> -
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
> -{
> -	struct vfio_ap_queue_reserved *qres = data;
> -	struct ap_queue *ap_queue = to_ap_queue(dev);
> -	ap_qid_t qid;
> -	unsigned long id;
> -
> -	if (qres->apid && qres->apqi) {
> -		qid = AP_MKQID(*qres->apid, *qres->apqi);
> -		if (qid == ap_queue->qid)
> -			qres->reserved = true;
> -	} else if (qres->apid && !qres->apqi) {
> -		id = AP_QID_CARD(ap_queue->qid);
> -		if (id == *qres->apid)
> -			qres->reserved = true;
> -	} else if (!qres->apid && qres->apqi) {
> -		id = AP_QID_QUEUE(ap_queue->qid);
> -		if (id == *qres->apqi)
> -			qres->reserved = true;
> -	} else {
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -/**
> - * vfio_ap_verify_queue_reserved
> - *
> - * @matrix_dev: a mediated matrix device
> - * @apid: an AP adapter ID
> - * @apqi: an AP queue index
> - *
> - * Verifies that the AP queue with @apid/@apqi is reserved by the VFIO AP device
> - * driver according to the following rules:
> - *
> - * - If both @apid and @apqi are not NULL, then there must be an AP queue
> - *   device bound to the vfio_ap driver with the APQN identified by @apid and
> - *   @apqi
> - *
> - * - If only @apid is not NULL, then there must be an AP queue device bound
> - *   to the vfio_ap driver with an APQN containing @apid
> - *
> - * - If only @apqi is not NULL, then there must be an AP queue device bound
> - *   to the vfio_ap driver with an APQN containing @apqi
> - *
> - * Returns 0 if the AP queue is reserved; otherwise, returns -EADDRNOTAVAIL.
> - */
> -static int vfio_ap_verify_queue_reserved(unsigned long *apid,
> -					 unsigned long *apqi)
> -{
> -	int ret;
> -	struct vfio_ap_queue_reserved qres;
> -
> -	qres.apid = apid;
> -	qres.apqi = apqi;
> -	qres.reserved = false;
> -
> -	ret = driver_for_each_device(&matrix_dev->vfio_ap_drv->driver, NULL,
> -				     &qres, vfio_ap_has_queue);
> -	if (ret)
> -		return ret;
> -
> -	if (qres.reserved)
> -		return 0;
> -
> -	return -EADDRNOTAVAIL;
> -}
> -
> -static int
> -vfio_ap_mdev_verify_queues_reserved_for_apid(struct ap_matrix_mdev *matrix_mdev,
> -					     unsigned long apid)
> -{
> -	int ret;
> -	unsigned long apqi;
> -	unsigned long nbits = matrix_mdev->matrix.aqm_max + 1;
> -
> -	if (find_first_bit_inv(matrix_mdev->matrix.aqm, nbits) >= nbits)
> -		return vfio_ap_verify_queue_reserved(&apid, NULL);
> -
> -	for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, nbits) {
> -		ret = vfio_ap_verify_queue_reserved(&apid, &apqi);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return 0;
> -}
> -
>   /**
>    * vfio_ap_mdev_verify_no_sharing
>    *
> @@ -236,18 +120,26 @@ vfio_ap_mdev_verify_queues_reserved_for_apid(struct ap_matrix_mdev *matrix_mdev,
>    * and AP queue indexes comprising the AP matrix are not configured for another
>    * mediated device. AP queue sharing is not allowed.
>    *
> - * @matrix_mdev: the mediated matrix device
> + * @mdev_apm: the mask identifying the adapters assigned to mdev
> + * @mdev_apm: the mask identifying the adapters assigned to mdev
>    *
>    * Returns 0 if the APQNs are not shared, otherwise; returns -EADDRINUSE.
>    */
> -static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
> +static int vfio_ap_mdev_verify_no_sharing(unsigned long *mdev_apm,
> +					  unsigned long *mdev_aqm)
>   {
>   	struct ap_matrix_mdev *lstdev;
>   	DECLARE_BITMAP(apm, AP_DEVICES);
>   	DECLARE_BITMAP(aqm, AP_DOMAINS);
>   
>   	list_for_each_entry(lstdev, &matrix_dev->mdev_list, node) {
> -		if (matrix_mdev == lstdev)
> +		/*
> +		 * If either of the input masks belongs to the mdev to which an
> +		 * AP resource is being assigned, then we don't need to verify
> +		 * that mdev's masks.
> +		 */
> +		if ((mdev_apm == lstdev->matrix.apm) ||
> +		    (mdev_aqm == lstdev->matrix.aqm))
>   			continue;

Is it possible that mdev_apm and mdev_aqm do not belong to the same 
mediated device?

...snip...


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
