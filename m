From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v4 3/7] s390: ap: associate a ap_vfio_queue and a matrix
 mdev
Date: Tue, 12 Mar 2019 17:39:56 -0400
Message-ID: <17fc3369-2496-2113-5a1a-1630df84f067@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-4-git-send-email-pmorel@linux.ibm.com>
 <20190304030935.525f4223@oc2783563651>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190304030935.525f4223@oc2783563651>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 3/3/19 9:09 PM, Halil Pasic wrote:
> On Fri, 22 Feb 2019 16:29:56 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> We need to associate the ap_vfio_queue, which will hold the
>> per queue information for interrupt with a matrix mediated device
>> which hold the configuration and the way to the CRYCB.
> [..]
>> +static int vfio_ap_get_all_domains(struct ap_matrix_mdev *matrix_mdev, int apid)
>> +{
>> +	int apqi, apqn;
>> +	int ret = 0;
>> +	struct vfio_ap_queue *q;
>> +	struct list_head q_list;
>> +
>> +	INIT_LIST_HEAD(&q_list);
>> +
>> +	for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS) {
>> +		apqn = AP_MKQID(apid, apqi);
>> +		q = vfio_ap_get_queue(apqn, &matrix_dev->free_list);
>> +		if (!q) {
>> +			ret = -EADDRNOTAVAIL;
>> +			goto rewind;
>> +		}
>> +		if (q->matrix_mdev) {
>> +			ret = -EADDRINUSE;
> 
> You tried to get the q from matrix_dev->free_list thus modulo races
> q->matrix_mdev should be 0. This change breaks the error codes in a
> sense that it becomes impossible to provoke EADDRINUSE (the proper
> error code for taken by another matrix_mdev).

It is necessary to determine if the queue is in use by another mdev, so
it will still be necessary to traverse all of the matrix_mdev structs to
see if q is in matrix_mdev->qlist. It seems that maintaining the qlist
does not buy us much.

> 
>> +			goto rewind;
>> +		}
>> +		list_move(&q->list, &q_list);
>> +	}
>> +	move_and_set(&q_list, &matrix_mdev->qlist, matrix_mdev);
>>   	return 0;
>> +rewind:
>> +	move_and_set(&q_list, &matrix_dev->free_list, NULL);
>> +	return ret;
>>   }
>> -
>>   /**
>> - * vfio_ap_mdev_verify_no_sharing
>> + * vfio_ap_get_all_cards:
>>    *
>> - * Verifies that the APQNs derived from the cross product of the AP adapter IDs
>> - * and AP queue indexes comprising the AP matrix are not configured for another
>> - * mediated device. AP queue sharing is not allowed.
>> + * @matrix_mdev: the matrix mediated device for which we want to associate
>> + *		 all available queues with a given apqi.
>> + * @apqi:	 The apqi which associated with all defined APID of the
>> + *		 mediated device will define a AP queue.
>>    *
>> - * @matrix_mdev: the mediated matrix device
>> + * We define a local list to put all queues we find on the matrix device
>> + * free list when associating the apqi with all already defined apid for
>> + * this matrix mediated device.
>>    *
>> - * Returns 0 if the APQNs are not shared, otherwise; returns -EADDRINUSE.
>> + * If we can get all the devices we roll them to the mediated device list
>> + * If we get errors we unroll them to the free list.
>>    */
>> -static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
>> +static int vfio_ap_get_all_cards(struct ap_matrix_mdev *matrix_mdev, int apqi)
>>   {
>> -	struct ap_matrix_mdev *lstdev;
>> -	DECLARE_BITMAP(apm, AP_DEVICES);
>> -	DECLARE_BITMAP(aqm, AP_DOMAINS);
>> -
>> -	list_for_each_entry(lstdev, &matrix_dev->mdev_list, node) {
>> -		if (matrix_mdev == lstdev)
>> -			continue;
>> -
>> -		memset(apm, 0, sizeof(apm));
>> -		memset(aqm, 0, sizeof(aqm));
>> -
>> -		/*
>> -		 * We work on full longs, as we can only exclude the leftover
>> -		 * bits in non-inverse order. The leftover is all zeros.
>> -		 */
>> -		if (!bitmap_and(apm, matrix_mdev->matrix.apm,
>> -				lstdev->matrix.apm, AP_DEVICES))
>> -			continue;
>> -
>> -		if (!bitmap_and(aqm, matrix_mdev->matrix.aqm,
>> -				lstdev->matrix.aqm, AP_DOMAINS))
>> -			continue;
>> -
>> -		return -EADDRINUSE;
>> +	int apid, apqn;
>> +	int ret = 0;
>> +	struct vfio_ap_queue *q;
>> +	struct list_head q_list;
>> +	struct ap_matrix_mdev *tmp = NULL;
>> +
>> +	INIT_LIST_HEAD(&q_list);
>> +
>> +	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
>> +		apqn = AP_MKQID(apid, apqi);
>> +		q = vfio_ap_get_queue(apqn, &matrix_dev->free_list);
>> +		if (!q) {
>> +			ret = -EADDRNOTAVAIL;
>> +			goto rewind;
>> +		}
>> +		if (q->matrix_mdev) {
>> +			ret = -EADDRINUSE;
> 
> Same here!
> 
> Regards,
> Halil
> 
>> +			goto rewind;
>> +		}
>> +		list_move(&q->list, &q_list);
>>   	}
> 
> [..]
> 
