From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v4 3/7] s390: ap: associate a ap_vfio_queue and a matrix
 mdev
Date: Tue, 26 Feb 2019 13:14:30 -0500
Message-ID: <0c109cf1-c5f0-9a8b-7729-2ce8bbe1dedd@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-4-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550849400-27152-4-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 2/22/19 10:29 AM, Pierre Morel wrote:
> We need to associate the ap_vfio_queue, which will hold the
> per queue information for interrupt with a matrix mediated device
> which hold the configuration and the way to the CRYCB.
> 
> Let's do this when assigning a APID or a APQI to the mediated device
> and clear the relation when unassigning.
> 
> Queuing the devices on a list of free devices and testing the
> matrix_mdev pointer to the associated matrix allow us to know
> if the queue is associated to the matrix device and associated
> or not to a mediated device.
> 
> When resetting an AP queue we must wait until there are no more
> messages in the message queue before considering the queue is really
> in a clean state.
> 
> Let's do it and wait until the status response code indicate the
> queue is empty after issuing a PAPQ/ZAPQ instruction.
> 
> Being at work on the reset function, let's simplify
> vfio_ap_mdev_reset_queue and vfio_ap_mdev_reset_queues by using the
> vfio_ap_queue structure as parameter.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c | 385 +++++++++++++++++++-------------------
>   1 file changed, 189 insertions(+), 196 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 900b9cf..172d6eb 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -24,6 +24,57 @@
>   #define VFIO_AP_MDEV_TYPE_HWVIRT "passthrough"
>   #define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
>   
> +/**
> + * vfio_ap_get_queue: Retrieve a queue with a specific APQN from a list
> + * @apqn: The queue APQN
> + *
> + * Retrieve a queue with a specific APQN from the list of the
> + * devices associated with a list.
> + *
> + * Returns the pointer to the associated vfio_ap_queue
> + */
> +struct vfio_ap_queue *vfio_ap_get_queue(int apqn, struct list_head *l)
> +{
> +	struct vfio_ap_queue *q;
> +
> +	list_for_each_entry(q, l, list)
> +		if (q->apqn == apqn)
> +			return q;
> +	return NULL;
> +} > +
> +static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
> +{
> +	struct ap_queue_status status;
> +	int retry = 20;
> +
> +	do {
> +		status = ap_zapq(q->apqn);
> +		switch (status.response_code) {
> +		case AP_RESPONSE_NORMAL:
> +			while (!status.queue_empty && retry--) {
> +				msleep(20);
> +				status = ap_tapq(q->apqn, NULL);
> +			}

I am not sure the above is necessary. I have an email out to the author
of the architecture doc to verify.

> +			if (retry <= 0)
> +				pr_warn("%s: queue 0x%04x not empty\n",
> +					__func__, q->apqn);
> +			return 0;
> +		case AP_RESPONSE_RESET_IN_PROGRESS:
> +		case AP_RESPONSE_BUSY:
> +			msleep(20);
> +			break;
> +		default:
> +			/* things are really broken, give up */
> +			pr_warn("%s: zapq error %02x on apqn 0x%04x\n",
> +				__func__, status.response_code, q->apqn);
> +			return -EIO;
> +		}
> +	} while (retry--);
> +
> +	return -EBUSY;
> +}
> +
>   static void vfio_ap_matrix_init(struct ap_config_info *info,
>   				struct ap_matrix *matrix)
>   {
> @@ -45,6 +96,7 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>   		return -ENOMEM;
>   	}
>   
> +	INIT_LIST_HEAD(&matrix_mdev->qlist);
>   	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
>   	mdev_set_drvdata(mdev, matrix_mdev);
>   	mutex_lock(&matrix_dev->lock);
> @@ -113,162 +165,160 @@ static struct attribute_group *vfio_ap_mdev_type_groups[] = {
>   	NULL,
>   };
>   
> -struct vfio_ap_queue_reserved {
> -	unsigned long *apid;
> -	unsigned long *apqi;
> -	bool reserved;
> -};
> +static void vfio_ap_free_queue(int apqn, struct ap_matrix_mdev *matrix_mdev)
> +{
> +	struct vfio_ap_queue *q;
> +
> +	q = vfio_ap_get_queue(apqn, &matrix_mdev->qlist);
> +	if (!q)
> +		return;
> +	q->matrix_mdev = NULL;
> +	vfio_ap_mdev_reset_queue(q);
> +	list_move(&q->list, &matrix_dev->free_list);
> +}
>   
>   /**
> - * vfio_ap_has_queue
> - *
> - * @dev: an AP queue device
> - * @data: a struct vfio_ap_queue_reserved reference
> - *
> - * Flags whether the AP queue device (@dev) has a queue ID containing the APQN,
> - * apid or apqi specified in @data:
> + * vfio_ap_put_all_domains

>    *
> - * - If @data contains both an apid and apqi value, then @data will be flagged
> - *   as reserved if the APID and APQI fields for the AP queue device matches
> + * @matrix_mdev: the matrix mediated device for which we want to associate
> + *		 all available queues with a given apqi.
> + * @apid:	 The apid which associated with all defined APQI of the
> + *		 mediated device will define a AP queue.
>    *
> - * - If @data contains only an apid value, @data will be flagged as
> - *   reserved if the APID field in the AP queue device matches
> - *
> - * - If @data contains only an apqi value, @data will be flagged as
> - *   reserved if the APQI field in the AP queue device matches
> - *
> - * Returns 0 to indicate the input to function succeeded. Returns -EINVAL if
> - * @data does not contain either an apid or apqi.
> + * We remove the queue from the list of queues associated with the
> + * mediated device and put them back to the free list of the matrix
> + * device and clear the matrix_mdev pointer.
>    */
> -static int vfio_ap_has_queue(struct device *dev, void *data)
> +static void vfio_ap_put_all_domains(struct ap_matrix_mdev *matrix_mdev,
> +				    int apid)

I would prefer this be named:

	vfio_ap_mdev_free_queues_with_apid()

get/put is typically used to increment/decrement reference counters.
What you are doing in this function freeing all queues connected to 
specified card.

>   {
> -	struct vfio_ap_queue_reserved *qres = data;
> -	struct ap_queue *ap_queue = to_ap_queue(dev);
> -	ap_qid_t qid;
> -	unsigned long id;
> +	int apqi, apqn;
>   
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
> +	for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS) {
> +		apqn = AP_MKQID(apid, apqi);
> +		vfio_ap_free_queue(apqn, matrix_mdev);
>   	}

Maybe you should clear the bit corresponding to apid from the APM here?

> -
> -	return 0;
>   }
>   
>   /**
> - * vfio_ap_verify_queue_reserved
> - *
> - * @matrix_dev: a mediated matrix device
> - * @apid: an AP adapter ID
> - * @apqi: an AP queue index
> - *
> - * Verifies that the AP queue with @apid/@apqi is reserved by the VFIO AP device
> - * driver according to the following rules:
> + * vfio_ap_put_all_cards:
>    *
> - * - If both @apid and @apqi are not NULL, then there must be an AP queue
> - *   device bound to the vfio_ap driver with the APQN identified by @apid and
> - *   @apqi
> + * @matrix_mdev: the matrix mediated device for which we want to associate
> + *		 all available queues with a given apqi.
> + * @apqi:	 The apqi which associated with all defined APID of the
> + *		 mediated device will define a AP queue.
>    *
> - * - If only @apid is not NULL, then there must be an AP queue device bound
> - *   to the vfio_ap driver with an APQN containing @apid
> - *
> - * - If only @apqi is not NULL, then there must be an AP queue device bound
> - *   to the vfio_ap driver with an APQN containing @apqi
> - *
> - * Returns 0 if the AP queue is reserved; otherwise, returns -EADDRNOTAVAIL.
> + * We remove the queue from the list of queues associated with the
> + * mediated device and put them back to the free list of the matrix
> + * device and clear the matrix_mdev pointer.
>    */
> -static int vfio_ap_verify_queue_reserved(unsigned long *apid,
> -					 unsigned long *apqi)
> +static void vfio_ap_put_all_cards(struct ap_matrix_mdev *matrix_mdev, int apqi)

I don't like this name for the same reasons I stated above for
put_all_domains. I prefer something like:

	vfio_ap_mdev_free_queues_with_apqi()

>   {
> -	int ret;
> -	struct vfio_ap_queue_reserved qres;
> +	int apid, apqn;
>   
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
> +	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
> +		apqn = AP_MKQID(apid, apqi);
> +		vfio_ap_free_queue(apqn, matrix_mdev);
> +	}

Maybe clear the apqi from the APM here?

>   }
>   
> -static int
> -vfio_ap_mdev_verify_queues_reserved_for_apid(struct ap_matrix_mdev *matrix_mdev,
> -					     unsigned long apid)
> +static void move_and_set(struct list_head *src, struct list_head *dst,
> +			 struct ap_matrix_mdev *matrix_mdev)
>   {
> -	int ret;
> -	unsigned long apqi;
> -	unsigned long nbits = matrix_mdev->matrix.aqm_max + 1;
> -
> -	if (find_first_bit_inv(matrix_mdev->matrix.aqm, nbits) >= nbits)
> -		return vfio_ap_verify_queue_reserved(&apid, NULL);
> +	struct vfio_ap_queue *q, *qtmp;
>   
> -	for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, nbits) {
> -		ret = vfio_ap_verify_queue_reserved(&apid, &apqi);
> -		if (ret)
> -			return ret;
> +	list_for_each_entry_safe(q, qtmp, src, list) {
> +		list_move(&q->list, dst);
> +		q->matrix_mdev = matrix_mdev;
>   	}
> -
> +}
> +/**
> + * vfio_ap_get_all_domains:
> + *
> + * @matrix_mdev: the matrix mediated device for which we want to associate
> + *		 all available queues with a given apqi.
> + * @apqi:	 The apqi which associated with all defined APID of the
> + *		 mediated device will define a AP queue.
> + *
> + * We define a local list to put all queues we find on the matrix device
> + * free list when associating the apqi with all already defined apid for
> + * this matrix mediated device.
> + *
> + * If we can get all the devices we roll them to the mediated device list
> + * If we get errors we unroll them to the free list.
> + */
> +static int vfio_ap_get_all_domains(struct ap_matrix_mdev *matrix_mdev, int apid)

I'd prefer to change this name to something like:

	vfio_ap_mdev_get_queues_with_apid()



> +{
> +	int apqi, apqn;
> +	int ret = 0;
> +	struct vfio_ap_queue *q;
> +	struct list_head q_list;
> +
> +	INIT_LIST_HEAD(&q_list);
> +
> +	for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS) {
> +		apqn = AP_MKQID(apid, apqi);
> +		q = vfio_ap_get_queue(apqn, &matrix_dev->free_list);
> +		if (!q) {
> +			ret = -EADDRNOTAVAIL;
> +			goto rewind;
> +		}
> +		if (q->matrix_mdev) {
> +			ret = -EADDRINUSE;
> +			goto rewind;
> +		}
> +		list_move(&q->list, &q_list);

IMHO, all of the list moving and rewinding is over complicated and
not necessary If you simply maintain the list of queues in the
matrix_mdev.

> +	}
> +	move_and_set(&q_list, &matrix_mdev->qlist, matrix_mdev);

Maybe set the bit for the apid in the APM here instead of in the
calling function?

>   	return 0;
> +rewind:
> +	move_and_set(&q_list, &matrix_dev->free_list, NULL);
> +	return ret;
>   }
> -
>   /**
> - * vfio_ap_mdev_verify_no_sharing
> + * vfio_ap_get_all_cards:
>    *
> - * Verifies that the APQNs derived from the cross product of the AP adapter IDs
> - * and AP queue indexes comprising the AP matrix are not configured for another
> - * mediated device. AP queue sharing is not allowed.
> + * @matrix_mdev: the matrix mediated device for which we want to associate
> + *		 all available queues with a given apqi.
> + * @apqi:	 The apqi which associated with all defined APID of the
> + *		 mediated device will define a Avfio_ap_put_all_domainsP queue.
>    *
> - * @matrix_mdev: the mediated matrix device
> + * We define a local list to put all queues we find on the matrix device
> + * free list when associating the apqi with all already defined apid for
> + * this matrix mediated device.
>    *
> - * Returns 0 if the APQNs are not shared, otherwise; returns -EADDRINUSE.
> + * If we can get all the devices we roll them to the mediated device list
> + * If we get errors we unroll them to the free list.
>    */
> -static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
> +static int vfio_ap_get_all_cards(struct ap_matrix_mdev *matrix_mdev, int apqi)
>   {

I'd prefer to change this name to something like:

	vfio_ap_mdev_get_queues_with_apqi()

> -	struct ap_matrix_mdev *lstdev;
> -	DECLARE_BITMAP(apm, AP_DEVICES);
> -	DECLARE_BITMAP(aqm, AP_DOMAINS);
> -
> -	list_for_each_entry(lstdev, &matrix_dev->mdev_list, node) {
> -		if (matrix_mdev == lstdev)
> -			continue;
> -
> -		memset(apm, 0, sizeof(apm));
> -		memset(aqm, 0, sizeof(aqm));vfio_ap_put_all_domains
> -
> -		/*
> -		 * We work on full longs, as we can only exclude the leftover
> -		 * bits in non-inverse order. The leftover is all zeros.
> -		 */
> -		if (!bitmap_and(apm, matrix_mdev->matrix.apm,
> -				lstdev->matrix.apm, AP_DEVICES))
> -			continue;
> -
> -		if (!bitmap_and(aqm, matrix_mdev->matrix.aqm,
> -				lstdev->matrix.aqm, AP_DOMAINS))
> -			continue;
> -
> -		return -EADDRINUSE;
> +	int apid, apqn;
> +	int ret = 0;
> +	struct vfio_ap_queue *q;
> +	struct list_head q_list;
> +	struct ap_matrix_mdev *tmp = NULL;
> +vfio_ap_put_all_domains
> +	INIT_LIST_HEAD(&q_list);
> +
> +	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
> +		apqn = AP_MKQID(apid, apqi);
> +		q = vfio_ap_get_queue(apqn, &matrix_dev->free_list);
> +		if (!q) {
> +			ret = -EADDRNOTAVAIL;
> +			goto rewind;
> +		}
> +		if (q->matrix_mdev) {
> +			ret = -EADDRINUSE;
> +			goto rewind;
> +		}
> +		list_move(&q->list, &q_list);

IMHO, all of the list moving and rewinding is over complicated and
not necessary if you simply maintain one list of queues in the
matrix_mdev.

>   	}
> -
> +	tmp = matrix_mdev;
> +	move_and_set(&q_list, &matrix_mdev->qlist, matrix_mdev);
>   	return 0;
> +rewind:
> +	move_and_set(&q_list, &matrix_dev->free_list, NULL);
> +	return ret;
>   }
>   
>   /**
> @@ -330,21 +380,15 @@ static ssize_t assign_adapter_store(struct device *dev,
>   	 */
>   	mutex_lock(&matrix_dev->lock);
>   
> -	ret = vfio_ap_mdev_verify_queues_reserved_for_apid(matrix_mdev, apid);
> +	ret = vfio_ap_get_all_domains(matrix_mdev, apid);
>   	if (ret)
>   		goto done;
>   
>   	set_bit_inv(apid, matrix_mdev->matrix.apm);
>   
> -	ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev);
> -	if (ret)
> -		goto share_err;
> -
>   	ret = count;
>   	goto done;
>   
> -share_err:
> -	clear_bit_inv(apid, matrix_mdev->matrix.apm);
>   done:
>   	mutex_unlock(&matrix_dev->lock);
>   
> @@ -391,32 +435,13 @@ static ssize_t unassign_adapter_store(struct device *dev,
>   
>   	mutex_lock(&matrix_dev->lock);
>   	clear_bit_inv((unsigned long)apid, matrix_mdev->matrix.apm);

Maybe clear the bit in the vfio_ap_put_all_domains function (which as
I said above should be named vfio_ap_mdev_free_queues_for_apid()?

> +	vfio_ap_put_all_domains(matrix_mdev, apid);
>   	mutex_unlock(&matrix_dev->lock);
>   
>   	return count;
>   }
>   static DEVICE_ATTR_WO(unassign_adapter);
>   
> -static int
> -vfio_ap_mdev_verify_queues_reserved_for_apqi(struct ap_matrix_mdev *matrix_mdev,
> -					     unsigned long apqi)
> -{
> -	int ret;
> -	unsigned long apid;
> -	unsigned long nbits = matrix_mdev->matrix.apm_max + 1;
> -
> -	if (find_first_bit_inv(matrix_mdev->matrix.apm, nbits) >= nbits)
> -		return vfio_ap_verify_queue_reserved(NULL, &apqi);
> -
> -	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, nbits) {
> -		ret = vfio_ap_verify_queue_reserved(&apid, &apqi);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return 0;
> -}
> -
>   /**
>    * assign_domain_store
>    *
> @@ -471,21 +496,15 @@ static ssize_t assign_domain_store(struct device *dev,
>   
>   	mutex_lock(&matrix_dev->lock);
>   
> -	ret = vfio_ap_mdev_verify_queues_reserved_for_apqi(matrix_mdev, apqi);
> +	ret = vfio_ap_get_all_cards(matrix_mdev, apqi);
>   	if (ret)
>   		goto done;
>   
>   	set_bit_inv(apqi, matrix_mdev->matrix.aqm);
>   
> -	ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev);
> -	if (ret)
> -		goto share_err;
> -
>   	ret = count;
>   	goto done;
>   
> -share_err:
> -	clear_bit_inv(apqi, matrix_mdev->matrix.aqm);
>   done:
>   	mutex_unlock(&matrix_dev->lock);
>   
> @@ -533,6 +552,7 @@ static ssize_t unassign_domain_store(struct device *dev,
>   
>   	mutex_lock(&matrix_dev->lock);
>   	clear_bit_inv((unsigned long)apqi, matrix_mdev->matrix.aqm);

Maybe clear the apqi in the vfio_ap_put_all_cards() function (which I
suggested should be called vfio_ap_mdev_free_queues_with_apqi()).

> +	vfio_ap_put_all_cards(matrix_mdev, apqi);
>   	mutex_unlock(&matrix_dev->lock);
>   
>   	return count;
> @@ -790,49 +810,22 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>   	return NOTIFY_OK;
>   }
>   
> -static int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
> -				    unsigned int retry)
> -{
> -	struct ap_queue_status status;
> -
> -	do {
> -		status = ap_zapq(AP_MKQID(apid, apqi));
> -		switch (status.response_code) {
> -		case AP_RESPONSE_NORMAL:
> -			return 0;
> -		case AP_RESPONSE_RESET_IN_PROGRESS:
> -		case AP_RESPONSE_BUSY:
> -			msleep(20);
> -			break;
> -		default:
> -			/* things are really broken, give up */
> -			return -EIO;
> -		}
> -	} while (retry--);
> -
> -	return -EBUSY;
> -}
> -
>   static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
>   {
>   	int ret;
>   	int rc = 0;
> -	unsigned long apid, apqi;
>   	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	struct vfio_ap_queue *q;
>   
> -	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
> -			     matrix_mdev->matrix.apm_max + 1) {
> -		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
> -				     matrix_mdev->matrix.aqm_max + 1) {
> -			ret = vfio_ap_mdev_reset_queue(apid, apqi, 1);
> -			/*
> -			 * Regardless whether a queue turns out to be busy, or
> -			 * is not operational, we need to continue resetting
> -			 * the remaining queues.
> -			 */
> -			if (ret)
> -				rc = ret;
> -		}
> +	list_for_each_entry(q, &matrix_mdev->qlist, list) {
> +		ret = vfio_ap_mdev_reset_queue(q);
> +		/*
> +		 * Regardless whether a queue turns out to be busy, or
> +		 * is not operational, we need to continue resetting
> +		 * the remaining queues but notice the last error code.
> +		 */
> +		if (ret)
> +			rc = ret;
>   	}
>   
>   	return rc;
> 
