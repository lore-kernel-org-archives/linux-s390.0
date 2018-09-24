From: Harald Freudenberger <freude@linux.ibm.com>
Subject: Re: [PATCH v10 13/26] s390: vfio-ap: zeroize the AP queues
Date: Mon, 24 Sep 2018 15:22:13 +0200
Message-ID: <113e07ba-370e-bdcf-4e85-412834947552@linux.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-14-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180924133611.01fef50e.cohuck@redhat.com>
 <b2eae775-0917-8c71-4ecf-6ef921ac9b0b@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b2eae775-0917-8c71-4ecf-6ef921ac9b0b@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 24.09.2018 14:16, Halil Pasic wrote:
>
> On 09/24/2018 01:36 PM, Cornelia Huck wrote:
>> On Wed, 12 Sep 2018 15:43:03 -0400
>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>
>>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>>
>>> Let's call PAPQ(ZAPQ) to zeroize a queue for each queue configured
>>> for a mediated matrix device when it is released.
>>>
>>> Zeroizing a queue resets the queue, clears all pending
>>> messages for the queue entries and disables adapter interruptions
>>> associated with the queue.
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>  drivers/s390/crypto/vfio_ap_ops.c |   44 +++++++++++++++++++++++++++++++++++++
>>>  1 files changed, 44 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>>> index f8b276a..48b1b78 100644
>>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>>> @@ -829,6 +829,49 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>>>  	return NOTIFY_OK;
>>>  }
>>>  
>>> +static int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
>>> +				    unsigned int retry)
>>> +{
>>> +	struct ap_queue_status status;
>>> +
>>> +	do {
>>> +		status = ap_zapq(AP_MKQID(apid, apqi));
>>> +		switch (status.response_code) {
>>> +		case AP_RESPONSE_NORMAL:
>>> +			return 0;
>>> +		case AP_RESPONSE_RESET_IN_PROGRESS:
>>> +		case AP_RESPONSE_BUSY:
>>> +			msleep(20);
>>> +			break;
>>> +		default:
>>> +			/* things are really broken, give up */
>>> +			return -EIO;
>>> +		}
>>> +	} while (retry--);
>>> +
>>> +	return -EBUSY;
>> So, this function may either return 0, -EIO (things are really broken),
>> or -EBUSY (still busy after multiple tries)...
>>
>>> +}
>>> +
>>> +static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
>>> +{
>>> +	int ret;
>>> +	int rc = 0;
>>> +	unsigned long apid, apqi;
>>> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>>> +
>>> +	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
>>> +			     matrix_mdev->matrix.apm_max + 1) {
>>> +		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
>>> +				     matrix_mdev->matrix.aqm_max + 1) {
>>> +			ret = vfio_ap_mdev_reset_queue(apid, apqi, 1);
>>> +			if (ret)
>>> +				rc = ret;
>> ...and here, we return the last error of any of the resets. Two
>> questions:
>>
>> - Does it make sense to continue if we get -EIO? IOW, does "really
>>   broken" only refer to a certain tuple and other tuples still can/need
>>   to be reset?
> I think it does make sense to continue, because IMHO "things are really
> broken" is an overstatement (I mean the APQN invalid case). One could
> argue would skipping the current card (adapter) be justified or not.
>
> IMHO the current code is good enough for the first shot, and we can think
> about fine-tuning it later.
Absolutely. The -EIO case is reached for example when the APQN
is 'deconfigured' which means the crypto adapter is logically unplugged.
So the -EIO case should NOT lead to some fatal actions like panic()
or cause a KVM guest to shut down or so.
>> - Is the return code useful in any way, as we don't know which tuple it
>>   refers to?
>>
> Well, good question. It conveys that the operation can 'fail'. AFAIR -EBUSY
> is mostly fine given what the architecture say if we are satisfied with just
> reset. And the cases behind -EIO might actually be OK too in the same sense.
> My guess is, that based on the return value client code can tell if we have
> zeroize for all queues or basically just reset (like rapq). We could log that
> to some debug facility or whatever -- I guess, but at the moment we don't care.
>
> In the end I think the code is good enough as is, and if we want we can
> improve on it later.
>
> Regards,
> Halil
>
>
>>> +		}
>>> +	}
>>> +
>>> +	return rc;
>>> +}
>>> +
>>>  static int vfio_ap_mdev_open(struct mdev_device *mdev)
>>>  {
>>>  	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>>> @@ -859,6 +902,7 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
>>>  	if (matrix_mdev->kvm)
>>>  		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>>>  
>>> +	vfio_ap_mdev_reset_queues(mdev);
>>>  	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>>>  				 &matrix_mdev->group_notifier);
>>>  	matrix_mdev->kvm = NULL;
