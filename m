Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [RFC 1/1] s390/pci: expose UID checking state in sysfs
References: <20210115152903.GA2086339@bjorn-Precision-5520>
From: Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <304b1ae8-0862-4986-bdbc-31ede7294fd1@linux.ibm.com>
Date: Fri, 15 Jan 2021 17:15:05 +0100
MIME-Version: 1.0
In-Reply-To: <20210115152903.GA2086339@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <christian.brauner@ubuntu.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>



On 1/15/21 4:29 PM, Bjorn Helgaas wrote:
> On Fri, Jan 15, 2021 at 12:20:59PM +0100, Niklas Schnelle wrote:
>> On 1/14/21 5:14 PM, Greg Kroah-Hartman wrote:
>>> On Thu, Jan 14, 2021 at 04:51:17PM +0100, Niklas Schnelle wrote:
>>>> On 1/14/21 4:17 PM, Greg Kroah-Hartman wrote:
>>>>> On Thu, Jan 14, 2021 at 04:06:11PM +0100, Niklas Schnelle wrote:
>>>>>> On 1/14/21 2:58 PM, Greg Kroah-Hartman wrote:
>>>>>>> On Thu, Jan 14, 2021 at 02:44:53PM +0100, Christian Brauner wrote:
>>>>>>>> On Thu, Jan 14, 2021 at 02:20:10PM +0100, Niklas Schnelle wrote:
>>>>>>>>> On 1/13/21 7:55 PM, Bjorn Helgaas wrote:
>>>>>>>>>> On Wed, Jan 13, 2021 at 08:47:58AM +0100, Niklas Schnelle wrote:
>>>>>>>>>>> On 1/12/21 10:50 PM, Bjorn Helgaas wrote:
>> ... snip ...
>>>>>>>>
>>>>>>>> Hey Niklas et al. :)
>>>>>>>>
>>>>>>>> I think this will need input from Greg. He should be best versed in
>>>>>>>> sysfs attributes. The problem with KERNEL_ATTR_* to me seems that it's
>>>>>>>> supposed to be kernel internal. Now, that might just be a matter of
>>>>>>>> renaming the macro but let's see whether Greg has any better idea or
>>>>>>>> more questions. :)
>>>>>>>
>>>>>>> The big question is, why are you needing this?
>>>>>>>
>>>>>>> No driver or driver subsystem should EVER be messing with a "raw"
>>>>>>> kobject like this.  Just use the existing DEVICE_* macros instead
>>>>>>> please.
>>>>>>>
>>>>>>> If you are using a raw kobject, please ask me how to do this properly,
>>>>>>> as that is something that should NEVER show up in the /sys/devices/*
>>>>>>> tree.  Otherwise userspace tools will break.
>>>>>>>
>>>>>>> thanks,
>>>>>>>
>>>>>>> greg k-h
>>>>>>
>>>>>> Hi Greg,
>>>>>>
>>>>>> this is for an architecture specific but global i.e. not device bound PCI
>>>>>> attribute. That's why DEVICE_ATTR_* does not work. BUS_ATTR_* would work
>>>>>> but only if we place the attribute directly under /sys/bus/pci/new_attr.
>>>>>
>>>>> Then you are doing something wrong :)
>>>>
>>>> That is very possible.
>>>>
>>>>>
>>>>> Where _exactly_ are you wanting to put this attribute?
>>>>
>>>> I'm trying for /sys/bus/pci/zpci/uid_checking, I'm using
>>>> the below code and the attribute even shows up but reading
>>>> it gives me two 0 bytes only.
>>>> The relevant code is only a slight alteration of the original patch
>>>> as follows:
>>>>
>>>> static ssize_t uid_checking_show(struct bus_type *bus, char *buf)
>>>> {
>>>> 	return sprintf(buf, "%i\n", zpci_unique_uid);
>>>> }
>>>> static BUS_ATTR_RO(uid_checking);
>>>>
>>>> static struct kset *zpci_global_kset;
>>>>
>>>> static struct attribute *zpci_attrs_global[] = {
>>>> 	&bus_attr_uid_checking.attr,
>>>> 	NULL,
>>>> };
>>>>
>>>> static struct attribute_group zpci_attr_group_global = {
>>>> 	.attrs = zpci_attrs_global,
>>>> };
>>>
>>> Name your attribute group, and then you do not have to mess with a
>>> "raw" kobject like you are below:
>>
>> Thanks for this tip and sorry for bothering you again.
>>
>>>
>>>>
>>>> int __init zpci_sysfs_init(void)
>>>> {
>>>> 	struct kset *pci_bus_kset;
>>>>
>>>> 	pci_bus_kset = bus_get_kset(&pci_bus_type);
>>>>
>>>> 	zpci_global_kset = kset_create_and_add("zpci", NULL, &pci_bus_kset->kobj);
>>>
>>> No, do not mess with at kset, just set the default attribute group for
>>> the bus to the above, and you should be fine.
>>
>> Oh ok, I got this idea from the code adding /sys/bus/pci/slots/ in
>> drivers/pci/slot.c:pci_slot_init(). See below maybe we can clean that up too.
>>
>>>
>>>> 	if (!zpci_global_kset)
>>>> 		return -ENOMEM;
>>>>
>>>> 	return sysfs_create_group(&zpci_global_kset->kobj, &zpci_attr_group_global);
>>>
>>> Huge hint, if in a driver, or bus subsystem, and you call sysfs_*,
>>> that's usually a huge clue that you are doing something wrong.
>>>
>>> Try the above again, with a simple attribute group, and name for it, and
>>> it should "just work".
>>
>> I'm probably missing something but I don't get how this could work
>> in this case. If I'm seeing this right the default attribute group
>> here is pci_bus_type.bus_groups and that is already set in
>> drivers/pci/pci-driver.c so I don't think I should set that.
>>
>> I did however find bus_create_file() which does work when using the
>> path /sys/bus/pci/uid_checking instead. This would work for us if
>> Bjorn is okay with that path and the code is really clean and simple
>> too.
>>
>> That said, I think we could also add something like
>> bus_create_group().  Then we could use that to also clean up
>> drivers/pci/slot.c:pci_slot_init() and get the original path
>> /sys/bus/pci/zpci/uid_checking.
> 
> I don't think "uid_checking" is quite the right name.  It says
> something about the *implementation*, but it doesn't convey what that
> *means* to userspace.  IIUC this file tells userspace something about
> whether a given PCI device always has the same PCI domain/bus/dev/fn
> address (or maybe just the same domain?)

Yes you're right, in fact we internally also started to think about
something more meaning oriented like "unique_uids". This indeed results
in PCI addresses which can be relied upon as stable identifiers. For us
it's enough that the domain matches as the bus is always 0 and
dev/fn are determined by the device and SR-IOV stride etc.
so will remain the same for equivalent configurations.

> 
> It sounds like this feature could be useful beyond just s390, and
> other arches might implement it differently, without the UID concept.
> If so, I'm OK with something at the /sys/bus/pci/xxx level as long as
> the name is not s390-specific (and "uid" sounds s390-specific).
> 
> I assume it would also help with the udev/systemd end if you could
> make this less s390 dependent.
> 
> Bjorn

That's a very good point! I'm absolutely open to making this a
common concept. I think the gist could be that the addressing/ids on
the bus are reproducible, there might be some user configuration
required but then they can be relied upon for stable names like
network interfaces. So maybe a name like "reproducible_addressing"?
I guess one non-s390 exclusive case of this could be virtualized
PCI under QEMU/KVM etc. versus real hardware or even UEFI/Firmware
guarantees, right?
