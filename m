Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726014AbgK0JVa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Nov 2020 04:21:30 -0500
Subject: Re: [PATCH] scsi: zfcp: fix use-after-free in zfcp_unit_remove
References: <20201120074854.31754-1-miaoqinglang@huawei.com>
 <20201125170658.GB8578@t480-pf1aa2c2>
 <4c65bead-2553-171e-54d2-87a9de0330e8@huawei.com>
 <20201126091353.50cf6ab6.cohuck@redhat.com>
 <20201126094259.GE8578@t480-pf1aa2c2>
 <9ba663ad-97fe-6c2a-e15a-45f2de1f0af0@huawei.com>
 <20201126151242.GI8578@t480-pf1aa2c2>
From: Steffen Maier <maier@linux.ibm.com>
Message-ID: <90356c8e-f523-1d16-45a2-0c8b9fae15c0@linux.ibm.com>
Date: Fri, 27 Nov 2020 10:21:16 +0100
MIME-Version: 1.0
In-Reply-To: <20201126151242.GI8578@t480-pf1aa2c2>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Benjamin Block <bblock@linux.ibm.com>, Qinglang Miao <miaoqinglang@huawei.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org

On 11/26/20 4:12 PM, Benjamin Block wrote:
> On Thu, Nov 26, 2020 at 08:07:32PM +0800, Qinglang Miao wrote:
>> 在 2020/11/26 17:42, Benjamin Block 写道:
>>> On Thu, Nov 26, 2020 at 09:13:53AM +0100, Cornelia Huck wrote:
>>>> On Thu, 26 Nov 2020 09:27:41 +0800
>>>> Qinglang Miao <miaoqinglang@huawei.com> wrote:
>>>>> 在 2020/11/26 1:06, Benjamin Block 写道:
>>>>>> On Fri, Nov 20, 2020 at 03:48:54PM +0800, Qinglang Miao wrote:
> ....
>>> Let's go by example. If we assume the reference count of `unit->dev` is
>>> R, and the function starts with R = 1 (otherwise the deivce would've
>>> been freed already), we get:
>>>
>>>       int zfcp_unit_remove(struct zfcp_port *port, u64 fcp_lun)
>>>       {
>>>       	struct zfcp_unit *unit;
>>>       	struct scsi_device *sdev;
>>>       	write_lock_irq(&port->unit_list_lock);
>>> // unit->dev (R = 1)
>>>       	unit = _zfcp_unit_find(port, fcp_lun);
>>> // get_device(&unit->dev)
>>> // unit->dev (R = 2)
>>>       	if (unit)
>>>       		list_del(&unit->list);
>>>       	write_unlock_irq(&port->unit_list_lock);
>>>       	if (!unit)
>>>       		return -EINVAL;
>>>       	sdev = zfcp_unit_sdev(unit);
>>>       	if (sdev) {
>>>       		scsi_remove_device(sdev);
>>>       		scsi_device_put(sdev);
>>>       	}
>>> // unit->dev (R = 2)
>>>       	put_device(&unit->dev);
>>> // unit->dev (R = 1)
>>>       	device_unregister(&unit->dev);
>>> // unit->dev (R = 0)
>>>       	return 0;
>>>       }
>>>
>>> If we now apply this patch, we'd end up with R = 1 after
>>> `device_unregister()`, and the device would not be properly removed.
>>>
>>> If you still think that's wrong, then you'll need to better explain why.
>>>
>> Hi Banjamin and Cornelia,
>>
>> Your replies make me reliaze that I've been holding a mistake understanding
>> of put_device() as well as reference count.
>>
>> Thanks for you two's patient explanation !!
>>
>> BTW, should I send a v2 on these two patches to move the position of
>> put_device()?
> 
> Feel free to do so.
> 
> I think having the `put_device()` call after `device_unregister()` in
> both `zfcp_unit_remove()` and `zfcp_sysfs_port_remove_store()` is more
> natural, because it ought to be the last time we touch the object in
> both functions.

If you move put_device(), you could add a comment like we did here to explain 
which (hidden) get_device is undone:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/s390/scsi?id=ef4021fe5fd77ced0323cede27979d80a56211ca
("scsi: zfcp: fix to prevent port_remove with pure auto scan LUNs (only sdevs)")
So in this patch it could be:
	put_device(&unit->dev); /* undo _zfcp_unit_find() */
And in the other patch it could be:
	put_device(&port->dev); /* undo zfcp_get_port_by_wwpn() */
Then it would be clearer next time somebody looks at the code.

Especially for the other patch on zfcp_sysfs_port_remove_store() moving the 
put_device(&port->dev) to at least *after* the call of 
zfcp_erp_port_shutdown(port, 0, "syprs_1") would make the code cleaner to me. 
Along the idead of passing the port to zfcp_erp_port_shutdown with the 
reference we got from zfcp_get_port_by_wwpn(). That said, the current code is 
of course still correct as we currently have the port ref of the earlier 
device_register so passing the port to zfcp_erp_port_shutdown() is safe.

If we wanted to make the gets and puts nicely nested, then we could move the 
puts to just before the device_unregister, but that's bike shedding:
	device_register()   --+
	get_device() --+      |
	put_device() --+      |
	device_unregister() --+

Benjamin's suggested move location works for me, too. After all, the kdoc of 
device_unregister explicitly mentions the possibility that other refs might 
continue to exist after device_unregister was called:
	device_register()   --+
	get_device() ---------|--+
	device_unregister() --+  |
	put_device() ------------+

-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z Development

https://www.ibm.com/privacy/us/en/
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
