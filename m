From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 31 Jul 2018 12:00:47 +0000
Subject: Re: [PATCH v7 10/22] s390: vfio-ap: sysfs interfaces to configure adapters
Message-Id: <15f9fdcd-7cb9-cb22-59f7-a3d7078e5a51@de.ibm.com>
In-Reply-To: <20180730151809.2bb50fb3.cohuck@redhat.com>
References: <20180730151809.2bb50fb3.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 07/30/2018 03:18 PM, Cornelia Huck wrote:
> On Thu, 26 Jul 2018 21:54:17 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
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
>> +	int ret;
>> +	unsigned long apid;
>> +	struct mdev_device *mdev = mdev_from_dev(dev);
>> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +	unsigned long max_apid = matrix_mdev->matrix.apm_max;
>> +
>> +	ret = kstrtoul(buf, 0, &apid);
>> +	if (ret || (apid > max_apid)) {
>> +		pr_warn("%s: %s: adapter id '%s' not a value from 0 to %02lu(%#04lx)\n",
>> +		       VFIO_AP_MODULE_NAME, __func__, buf, max_apid, max_apid);
> 
> I'm not sure how helpful a message to the syslog is if you are writing
> to sysfs attributes. If you decide to drop the message, you could do
> 
> if (apid > max_apid)
> 	ret = -EINVAL;
> 
> if (ret)
> 	return ret;
> 
> which looks more straightforward to me.

Yes, makes sense. pr_* usage should be reduced in this patch series
