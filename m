From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v9 10/22] s390: vfio-ap: sysfs interfaces to configure
 adapters
Date: Wed, 15 Aug 2018 12:59:35 -0400
Message-ID: <4bf27c7a-34c6-9160-cdc6-19022b86202b@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-11-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180815115242.35a2a1ce.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180815115242.35a2a1ce.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 08/15/2018 05:52 AM, Cornelia Huck wrote:
> On Mon, 13 Aug 2018 17:48:07 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> +/**
>> + * assign_adapter_store
>> + *
>> + * @dev: the matrix device
>> + * @attr: a mediated matrix device attribute
>> + * @buf: a buffer containing the adapter ID (APID) to be assigned
>> + * @count: the number of bytes in @buf
>> + *
>> + * Parses the APID from @buf and assigns it to the mediated matrix device.
>> + *
>> + * Returns the number of bytes processed if the APID is valid; otherwise returns
>> + * an error.
>> + */
>> +static ssize_t assign_adapter_store(struct device *dev,
>> +				    struct device_attribute *attr,
>> +				    const char *buf, size_t count)
>> +{
>> +	int ret = 0;
> You don't need to initialize this to 0, as kstrtoul will set it in any
> case.

Right you are! Will change it.

>
>> +	unsigned long apid;
>> +	struct mdev_device *mdev = mdev_from_dev(dev);
>> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +	unsigned long max_apid = matrix_mdev->matrix.apm_max;
>> +
>> +	ret = kstrtoul(buf, 0, &apid);
>> +	if (ret)
>> +		return ret;
>> +	if (apid > max_apid)
>> +		return -EINVAL;
>> +
>> +	/* Set the bit in the AP mask (APM) corresponding to the AP adapter
>> +	 * number (APID). The bits in the mask, from most significant to least
>> +	 * significant bit, correspond to APIDs 0-255.
>> +	 */
>> +	mutex_lock(&matrix_dev.lock);
>> +
>> +	ret = vfio_ap_mdev_verify_queues_reserved_for_apid(matrix_mdev, apid);
> That function name really is a mouthful :) I don't have any better
> suggestions, though.

It is, but I think it describes exactly what the function does.

>
>> +	if (ret)
>> +		goto done;
>> +
>> +	set_bit_inv(apid, matrix_mdev->matrix.apm);
>> +
>> +	ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev);
>> +	if (ret)
>> +		goto share_err;
>> +
>> +	ret = count;
>> +	goto done;
>> +
>> +share_err:
>> +	clear_bit_inv(apid, matrix_mdev->matrix.apm);
>> +done:
>> +	mutex_unlock(&matrix_dev.lock);
>> +
>> +	return ret;
>> +}
>> +static DEVICE_ATTR_WO(assign_adapter);
>> +
>> +/**
>> + * unassign_adapter_store
>> + *
>> + * @dev: the matrix device
>> + * @attr: a mediated matrix device attribute
>> + * @buf: a buffer containing the adapter ID (APID) to be assigned
>> + * @count: the number of bytes in @buf
>> + *
>> + * Parses the APID from @buf and unassigns it from the mediated matrix device.
>> + * The APID must be a valid value
> A valid value, but not necessarily assigned, right?

You are correct, if the APID is not assigned, then the corresponding bit 
will be
cleared regardless. In a previous version, the functions failed if the 
APID is
not assigned, but a colleague removed that check. I guess it makes sense 
given
it really does not hurt anything to ask to unassign an APID that isn't 
assigned
to begin with. Would you prefer I update the comment, or do you feel the 
user
should be made aware of an attempt to unassign an APID that is not assigned?

>
>> + *
>> + * Returns the number of bytes processed if the APID is valid; otherwise returns
>> + * an error.
>> + */
>> +static ssize_t unassign_adapter_store(struct device *dev,
>> +				      struct device_attribute *attr,
>> +				      const char *buf, size_t count)
>> +{
>> +	int ret;
>> +	unsigned long apid;
>> +	struct mdev_device *mdev = mdev_from_dev(dev);
>> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +
>> +	ret = kstrtoul(buf, 0, &apid);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (apid > matrix_mdev->matrix.apm_max)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&matrix_dev.lock);
>> +	clear_bit_inv((unsigned long)apid, matrix_mdev->matrix.apm);
>> +	mutex_unlock(&matrix_dev.lock);
>> +
>> +	return count;
>> +}
>> +DEVICE_ATTR_WO(unassign_adapter);
> In general, looks good to me.

That is good news indeed.

>
