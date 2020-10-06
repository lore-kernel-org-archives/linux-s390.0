Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725902AbgJFQ5y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Oct 2020 12:57:54 -0400
Subject: Re: [PATCH 08/10] s390/dasd: Display FC Endpoint Security information
 via sysfs
References: <20201002193940.24012-1-sth@linux.ibm.com>
 <20201002193940.24012-9-sth@linux.ibm.com>
 <20201006122632.098149ba.cohuck@redhat.com>
From: =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>
Message-ID: <d88b8230-993e-d63d-394a-efcaf60f813d@linux.ibm.com>
Date: Tue, 6 Oct 2020 18:57:46 +0200
MIME-Version: 1.0
In-Reply-To: <20201006122632.098149ba.cohuck@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Stefan Haberland <sth@linux.ibm.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

On 10/6/20 12:26 PM, Cornelia Huck wrote:
> On Fri,  2 Oct 2020 21:39:38 +0200
> Stefan Haberland <sth@linux.ibm.com> wrote:
> 
>> From: Jan Höppner <hoeppner@linux.ibm.com>
>>
>> Add a new sysfs attribute (fc_security) per device and per operational
>> channel path. The information of the current FC Endpoint Security state
>> is received through the CIO layer.
>>
>> The state of the FC Endpoint Security can be either "Unsupported",
>> "Authentication", or "Encryption".
>>
>> For example:
>> $ cat /sys/bus/ccw/devices/0.0.c600/fc_security
>> Encryption
>>
>> If any of the operational paths is in a state different from all
>> others, the device sysfs attribute will display the additional state
>> "Inconsistent".
>>
>> The sysfs attributes per paths are organised in a new directory called
>> "paths_info" with subdirectories for each path.
>>
>> /sys/bus/ccw/devices/0.0.c600/paths_info/
>> ├── 0.38
>> │   └── fc_security
>> ├── 0.39
>> │   └── fc_security
>> ├── 0.3a
>> │   └── fc_security
>> └── 0.3b
>>     └── fc_security
>>
>> Reference-ID: IO1812
>> Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
>> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
>> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
>> ---
>>  drivers/s390/block/dasd_devmap.c | 105 +++++++++++++++++++++++++++++++
>>  drivers/s390/block/dasd_eckd.c   |  30 +++++++++
>>  drivers/s390/block/dasd_int.h    |  68 ++++++++++++++++++++
>>  3 files changed, 203 insertions(+)
>>
> 
> (...)
> 
>> +static struct kobj_type path_attr_type = {
>> +	.release	= dasd_path_release,
> 
> This function does nothing; I think there's something wrong with your
> kobject handling?

Explanation below.

> 
>> +	.default_attrs	= paths_info_attrs,
>> +	.sysfs_ops	= &kobj_sysfs_ops,
>> +};
>> +
>> +static void dasd_path_init_kobj(struct dasd_device *device, int chp)
>> +{
>> +	device->path[chp].kobj.kset = device->paths_info;
>> +	kobject_init(&device->path[chp].kobj, &path_attr_type);
> 
> This inits a static kobject; as you never free it, doesn't the code

kobject_put() frees the kobject data.

> moan about state_initialized if you try to do that a second time?

No, because we check whether we have this kobject already present
in sysfs before we try to initialize it (we have in_sysfs per path
object for this).

> 
>> +}
>> +
>> +void dasd_path_create_kobj(struct dasd_device *device, int chp)
>> +{
>> +	int rc;
>> +
>> +	if (test_bit(DASD_FLAG_OFFLINE, &device->flags))
>> +		return;
>> +	if (!device->paths_info) {
>> +		dev_warn(&device->cdev->dev, "Unable to create paths objects\n");
> 
> I guess this warns every time you come along here, is warning more than
> once useful?
> 

paths_info is a kset created during the device initialization. Do you mean,
in case the kset creation fails, this check here should only warn once?
I'm not sure about that, hm.

>> +		return;
>> +	}
>> +	if (device->path[chp].in_sysfs)
>> +		return;
>> +	if (!device->path[chp].conf_data)
> 
> Out of interest: Have you tried this with vfio-ccw under QEMU, where
> some information is simply not available?

I did not, sorry.

> 
>> +		return;
>> +
>> +	dasd_path_init_kobj(device, chp);
>> +
>> +	rc = kobject_add(&device->path[chp].kobj, NULL, "%x.%02x",
>> +			 device->path[chp].cssid, device->path[chp].chpid);
>> +	if (rc)
>> +		kobject_put(&device->path[chp].kobj);
> 
> This will eventually lead to the nop release function, which doesn't
> unset state_initialized (see above) -- but OTOH, it shouldn't muck
> around with kobject internals anyway.

The release function is supposed to free memory of the structure where
the kobject lies in (our release function is explained below).
The rest is taking care of by the kobject library.

> 
> I think the kobjects really want to be dynamically allocated; instead
> of going through a remove/add cycle, is there a way to make path
> objects "invisible" instead? Or add an "available" attribute, and error
> out reading any other attribute?
> 
>> +	device->path[chp].in_sysfs = true;
>> +}
>> +EXPORT_SYMBOL(dasd_path_create_kobj);
>> +
>> +void dasd_path_create_kobjects(struct dasd_device *device)
>> +{
>> +	u8 lpm, opm;
>> +
>> +	opm = dasd_path_get_opm(device);
>> +	for (lpm = 0x80; lpm; lpm >>= 1) {
>> +		if (!(lpm & opm))
>> +			continue;
> 
> Any reason you do not simply create objects for _all_ paths, combined
> with returning n/a or erroring out for paths where this does not apply?
> (I might be missing something obvious.)

Because we likely don't have all information required to create the kobject
for other paths, e.g. the cssid and chpid (which are required for the
proper name).

> 
>> +		dasd_path_create_kobj(device, pathmask_to_pos(lpm));
>> +	}
>> +}
>> +EXPORT_SYMBOL(dasd_path_create_kobjects);
>> +
>> +void dasd_path_remove_kobj(struct dasd_device *device, int chp)
>> +{
>> +	if (device->path[chp].in_sysfs) {
>> +		kobject_put(&device->path[chp].kobj);
>> +		device->path[chp].in_sysfs = false;
>> +	}
>> +}
>> +EXPORT_SYMBOL(dasd_path_remove_kobj);
> 
> Also, how is userspace supposed to deal with changes here? Should there
> be a uevent on the parent device to notify about changes?

I can't think of a user just yet. I'll keep this in mind for further
improvements. I certainly won't hurt to create uevents here.

> 
>>  
>>  int dasd_add_sysfs_files(struct ccw_device *cdev)
>>  {
> 
> (...)
> 
>> +static inline void dasd_path_release(struct kobject *kobj)
>> +{
>> +/* Memory for the dasd_path kobject is freed when dasd_free_device() is called */
>> +}
>> +
> 
> As already said, I don't think that's a correct way to implement this.
> 

As you correctly pointed out, our release function doesn't do anything.
This is because our path data is a (static) part of our device.
This data is critical to keep our devices operational.
We can't simply rely on allocated memory if systems are under stress. 

Having this data dynamically allocated involves a lot of rework of our
path handling as well. There are a few things that are subject to improvement
and evaluating whether our dasd_path structures can be dynamic is one of
these things. However, even then, the above concern persists and I
highly doubt that dynamic dasd_paths objects are doable for us at this
moment.

I do understand the concerns, however, we release the memory for dasd_path
structures eventually when dasd_free_device() is called. Until that point,
the data has to be kept alive. The rest is taking care of by the kobject
library.
In our path handling we also make sure that we can always verify/validate
paths information even if a system is under high memory pressure. Another
reason why it would contradictory for dasd_path objects to be dynamic.

I hope this explains the reasoning behind the release function.

so long,
Jan
