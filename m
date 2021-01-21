Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22826 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732032AbhAURFp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 Jan 2021 12:05:45 -0500
Subject: Re: [RFC 1/1] s390/pci: expose UID checking state in sysfs
References: <20210121155445.GA2657778@bjorn-Precision-5520>
From: Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <ae24ccfb-9fb6-5fad-8495-538fab95066e@linux.ibm.com>
Date: Thu, 21 Jan 2021 18:04:52 +0100
MIME-Version: 1.0
In-Reply-To: <20210121155445.GA2657778@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lennart Poettering <mzxreary@0pointer.de>
Cc: Christian Brauner <christian.brauner@ubuntu.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>



On 1/21/21 4:54 PM, Bjorn Helgaas wrote:
> [Greg may be able to help compare/contrast this s390 UID with udev
> persistent names]
> 
> On Thu, Jan 21, 2021 at 04:31:55PM +0100, Niklas Schnelle wrote:
>> On 1/15/21 4:29 PM, Bjorn Helgaas wrote:
>>> On Fri, Jan 15, 2021 at 12:20:59PM +0100, Niklas Schnelle wrote:
>>>> On 1/14/21 5:14 PM, Greg Kroah-Hartman wrote:
>>>>> On Thu, Jan 14, 2021 at 04:51:17PM +0100, Niklas Schnelle wrote:
>>>>>> On 1/14/21 4:17 PM, Greg Kroah-Hartman wrote:
>>>>>>> On Thu, Jan 14, 2021 at 04:06:11PM +0100, Niklas Schnelle wrote:
>>>>>>>> On 1/14/21 2:58 PM, Greg Kroah-Hartman wrote:
>>>>>>>>> On Thu, Jan 14, 2021 at 02:44:53PM +0100, Christian Brauner wrote:
>>>>>>>>>> On Thu, Jan 14, 2021 at 02:20:10PM +0100, Niklas Schnelle wrote:
>>>>>>>>>>> On 1/13/21 7:55 PM, Bjorn Helgaas wrote:
>>>>>>>>>>>> On Wed, Jan 13, 2021 at 08:47:58AM +0100, Niklas Schnelle wrote:
>>>>>>>>>>>>> On 1/12/21 10:50 PM, Bjorn Helgaas wrote:
>>>> ... snip ...
>>>>
>>>>>
>>>>>> 	if (!zpci_global_kset)
>>>>>> 		return -ENOMEM;
>>>>>>
>>>>>> 	return sysfs_create_group(&zpci_global_kset->kobj, &zpci_attr_group_global);
>>>>>
>>>>> Huge hint, if in a driver, or bus subsystem, and you call sysfs_*,
>>>>> that's usually a huge clue that you are doing something wrong.
>>>>>
>>>>> Try the above again, with a simple attribute group, and name for it, and
>>>>> it should "just work".
>>>>
>>>> I'm probably missing something but I don't get how this could work
>>>> in this case. If I'm seeing this right the default attribute group
>>>> here is pci_bus_type.bus_groups and that is already set in
>>>> drivers/pci/pci-driver.c so I don't think I should set that.
>>>>
>>>> I did however find bus_create_file() which does work when using the
>>>> path /sys/bus/pci/uid_checking instead. This would work for us if
>>>> Bjorn is okay with that path and the code is really clean and simple
>>>> too.
>>>>
>>>> That said, I think we could also add something like
>>>> bus_create_group().  Then we could use that to also clean up
>>>> drivers/pci/slot.c:pci_slot_init() and get the original path
>>>> /sys/bus/pci/zpci/uid_checking.
>>>
>>> I don't think "uid_checking" is quite the right name.  It says
>>> something about the *implementation*, but it doesn't convey what that
>>> *means* to userspace.  IIUC this file tells userspace something about
>>> whether a given PCI device always has the same PCI domain/bus/dev/fn
>>> address (or maybe just the same domain?)
>>>
>>> It sounds like this feature could be useful beyond just s390, and
>>> other arches might implement it differently, without the UID concept.
>>> If so, I'm OK with something at the /sys/bus/pci/xxx level as long as
>>> the name is not s390-specific (and "uid" sounds s390-specific).
>>>
>>> I assume it would also help with the udev/systemd end if you could
>>> make this less s390 dependent.
>>
>> I've thought about this more and even implemented a proof of concept
>> patch for a global attribute using a pcibios_has_reproducible_addressing()
>> hook. 
>>
>> However after implementing it I think as a more general and
>> future proof concept it makes more sense to do this as a per device
>> attribute, maybe as another flag in "stuct pci_dev" named something
>> like "reliable_address". My reasoning behind this can be best be seen
>> with a QEMU example. While I expect that QEMU can easily guarantee
>> that one can always use "0000:01:00.0" for a virtio-pci NIC and
>> thus enp1s0 interface name, the same might be harder to guarantee
>> for a SR-IOV VF passed through with vfio-pci in that same VM and
>> even less so if a thunderbolt controller is passed through and
>> enumeration may depend on daisy chaining. The QEMU example
>> also applies to s390 and maybe others will in the future.
> 
> I'm a little wary of using the PCI geographical address
> ("0000:01:00.0") as a stable name.  Even if you can make a way to use
> that to identify a specific device instance, regardless of how it is
> plugged in or passed through, it sounds like we could end up with
> "physical PCI addresses" and "virtual PCI addresses" that look the
> same and would cause confusion.
> 
> This concept sounds similar to the udev concept of a "persistent
> device name".  What advantages does this s390 UID have over the udev
> approach?
> 
> There are optional PCI device serial numbers that we currently don't
> really make use of.  Would that be a generic way to help with this?
> 

As far as I understand systemd/udev uses the PCI geographical address
by default ("enP<domain>p<bus>s<hotplug_slot_idx>...") for PCI attached
network interfaces in many cases and a lot of users have already built
their firewall/routing rules on these.

At the same time as you said this isn't ideal. On s390 things are a
bit special since it's either really unstable, if UID Checking
is not enforced (the value I wanted to expose is 0) the domain
part and thus the interface name may change between reboots.
On the other hand when it is enforced, the Domain can be defined
in the machine configuration (IOCDS, think Domain XML but formatted
for punch cards) and the bus is always 00.
The PCI geographical address and thus network interface names are then
stable in the same way as with our CCW attached network interfaces where
the CCW addresses have been stable for a long time and are regularly
used for configuration. The interface would however still conform to
the existing systemd/udev standard theme so the only change the user
sees is that we would prefer the interface naming scheme which
does not include the hotplug slot index (ehotplug slot indices are unique
in the machine hypervisor and thus can't be the same in to guests
on the same machine). We would thus not add a new name at all and
thanks to the altname mechanism all existing rules including
persistent naming via manual udev rules would keep working.

Now taking this beyond s390 my idea is that under some circumstances
just as with UID Uniqueness for us, the platform can tell if a PCI
geographical address is a reliable identifier thus sytemd/udev
has more information about the quality of existing naming schemes
incorporating information from the geographical address.

Looking at my personal KVM guests (Ubuntu, Arch Linux, Ubuntu ARM64)
as well as my workstation (Arch Linux) all of them use a scheme
with parts of the geographical address.

So in essence my idea is all about either choosing the best existing
default name or making sure we at least know if it may not be reliable.

I hope that makes sense and I have added Lennart Poettering
as he's the one everyone likes to blame for these names or at
least can probably tell me what I missed.

Best,
Niklas
