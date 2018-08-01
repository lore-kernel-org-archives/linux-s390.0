From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Wed, 01 Aug 2018 21:43:10 +0000
Subject: Re: [PATCH v7 10/22] s390: vfio-ap: sysfs interfaces to configure adapters
Message-Id: <e059db48-dd50-42ca-98d0-bf2fe2b0fe7f@linux.ibm.com>
In-Reply-To: <15f9fdcd-7cb9-cb22-59f7-a3d7078e5a51@de.ibm.com>
References: <15f9fdcd-7cb9-cb22-59f7-a3d7078e5a51@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 07/27/2018 11:04 AM, Thomas Huth wrote:
> On 07/26/2018 09:54 PM, Christian Borntraeger wrote:
> [...]
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index e4e8d738a043..07911fb9cdce 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -15,7 +15,6 @@
>>   #define VFOP_AP_MDEV_TYPE_HWVIRT "passthrough"
>>   #define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
>>   
>> -
> Unnecessary white space change.

It is indeed, to be fixed.

>
>>   static void vfio_ap_matrix_init(struct ap_config_info *info,
>>   				struct ap_matrix *matrix)
>>   {
>> @@ -103,9 +102,127 @@ static struct attribute_group *vfio_ap_mdev_type_groups[] = {
>>   	NULL,
>>   };
>>   
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
>> +	int ret;
>> +	unsigned long apid;
>> +	struct mdev_device *mdev = mdev_from_dev(dev);
>> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +	unsigned long max_apid = matrix_mdev->matrix.apm_max;
>> +
>> +	ret = kstrtoul(buf, 0, &apid);
>> +	if (ret || (apid > max_apid)) {
> You can remove the parentheses around "apid > max_apid".

My personal opinion is that the parenthesis make it easier to
understand .... there is no need to scour the mind to recall
operator precedence rules.

>
>> +		pr_warn("%s: %s: adapter id '%s' not a value from 0 to %02lu(%#04lx)\n",
>> +		       VFIO_AP_MODULE_NAME, __func__, buf, max_apid, max_apid);
>> +
>> +		if (!ret)
>> +			ret = -EINVAL;
>> +
>> +		return ret;
>> +	}
>> +
>> +	/* Set the bit in the AP mask (APM) corresponding to the AP adapter
>> +	 * number (APID). The bits in the mask, from most significant to least
>> +	 * significant bit, correspond to APIDs 0-255.
>> +	 */
>> +	mutex_lock(&matrix_dev.lock);
>> +	set_bit_inv(apid, matrix_mdev->matrix.apm);
>> +	ret = count;
>> +
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
>> +	unsigned long max_apid = matrix_mdev->matrix.apm_max;
>> +
>> +	ret = kstrtoul(buf, 0, &apid);
>> +	if (ret || (apid > max_apid)) {
> dito

ditto

>
>> +		pr_warn("%s: %s: adapter id '%s' must be a value from 0 to %02lu(%#04lx)\n",
>> +		       VFIO_AP_MODULE_NAME, __func__, buf, max_apid, max_apid);
>> +
>> +		if (!ret)
>> +			ret = -EINVAL;
>> +
>> +		return ret;
>> +	}
>> +
>> +	mutex_lock(&matrix_dev.lock);
>> +	if (!test_bit_inv(apid, matrix_mdev->matrix.apm)) {
>> +		pr_warn("%s: %s: adapter id %02lu(%#04lx) not assigned\n",
>> +		       VFIO_AP_MODULE_NAME, __func__, apid, apid);
>> +		ret = -ENODEV;
>> +		goto done;
>> +	}
>> +
>> +	clear_bit_inv((unsigned long)apid, matrix_mdev->matrix.apm);
>> +	ret = count;
>> +
>> +done:
>> +	mutex_unlock(&matrix_dev.lock);
>> +
>> +	return ret;
>> +}
>> +DEVICE_ATTR_WO(unassign_adapter);
>> +
>> +static struct attribute *vfio_ap_mdev_attrs[] = {
>> +	&dev_attr_assign_adapter.attr,
>> +	&dev_attr_unassign_adapter.attr,
>> +	NULL
>> +};
>> +
>> +static struct attribute_group vfio_ap_mdev_attr_group = {
>> +	.attrs = vfio_ap_mdev_attrs
>> +};
>> +
>> +static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
>> +	&vfio_ap_mdev_attr_group,
>> +	NULL
>> +};
>> +
>>   static const struct mdev_parent_ops vfio_ap_matrix_ops = {
>>   	.owner			= THIS_MODULE,
>>   	.supported_type_groups	= vfio_ap_mdev_type_groups,
>> +	.mdev_attr_groups	= vfio_ap_mdev_attr_groups,
>>   	.create			= vfio_ap_mdev_create,
>>   	.remove			= vfio_ap_mdev_remove,
>>   };
>>
>   Thomas
>
