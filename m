Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236886AbhBDOm1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 4 Feb 2021 09:42:27 -0500
Subject: Re: [RFC v2 1/1] PCI: Add s390 specific UID uniqueness attribute
References: <20210204094353.63819-1-schnelle@linux.ibm.com>
 <20210204094353.63819-2-schnelle@linux.ibm.com> <YBvPBD+fCtQkCFFD@kroah.com>
 <7b85c218-88a4-b6db-e5de-7004475564ee@linux.ibm.com>
 <YBv45HFPe109GT9e@kroah.com>
From: Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <7631ff35-ef7d-dff7-2295-69f8fb96238c@linux.ibm.com>
Date: Thu, 4 Feb 2021 15:41:29 +0100
MIME-Version: 1.0
In-Reply-To: <YBv45HFPe109GT9e@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Peter Oberparleiter <oberpar@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>



On 2/4/21 2:38 PM, Greg Kroah-Hartman wrote:
> On Thu, Feb 04, 2021 at 01:02:51PM +0100, Niklas Schnelle wrote:
>>
>>
>> On 2/4/21 11:40 AM, Greg Kroah-Hartman wrote:
>>> On Thu, Feb 04, 2021 at 10:43:53AM +0100, Niklas Schnelle wrote:
>>>> The global UID uniqueness attribute exposes whether the platform
>>>> guarantees that the user-defined per-device UID attribute values
>>>> (/sys/bus/pci/device/<dev>/uid) are unique and can thus be used as
>>>> a global identifier for the associated PCI device. With this commit
>>>> it is exposed at /sys/bus/pci/zpci/unique_uids
>>>>
>>>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>>> ---
>>>>  Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
>>>>  drivers/pci/pci-sysfs.c                 | 21 +++++++++++++++++++++
>>>>  2 files changed, 30 insertions(+)
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
>>>> index 25c9c39770c6..812dd9d3f80d 100644
>>>> --- a/Documentation/ABI/testing/sysfs-bus-pci
>>>> +++ b/Documentation/ABI/testing/sysfs-bus-pci
>>>> @@ -375,3 +375,12 @@ Description:
>>>>  		The value comes from the PCI kernel device state and can be one
>>>>  		of: "unknown", "error", "D0", D1", "D2", "D3hot", "D3cold".
>>>>  		The file is read only.
>>>> +What:		/sys/bus/pci/zpci/unique_uids
>>>
>>> No blank line before this new line?
>>
>> Good catch, thanks!
>>
>>>
>>> And why "zpci"?
>>
>> There doesn't seem to be a precedent for arch specific attributes under
>> /sys/bus/pci so I went with a separate group for the RFC.
> 
> Why?  There's nothing arch-specific here, right?  Either the file is
> present or not.

Good point, will change this to /sys/bus/pci/unique_uids

> 
>> "zpci" since that's what we've been calling the s390 specific PCI.
>> I'm not attached to that name or having a separate group, from
>> my perspective /sys/bus/pci/unique_uids would actually be ideal
>> if Bjorn is okay with that, we don't currently foresee any additional
>> global attributes and no one else seems to have them but
>> one never knows and a separate group would then of course,
>> well group them.
> 
> Why not just a simple file, no need for arch-specific names if this
> really can show up under other arches?

I guess other arches would be free to implement the same UID concept
as above I'm happy to change this to a simple file.

> 
>>>> +Date:		February 2021
>>>> +Contact:	Niklas Schnelle <schnelle@linux.ibm.com>
>>>> +Description:
>>>> +		This attribute exposes the global state of UID Uniqueness on an
>>>> +		s390 Linux system. If this file contains '1' the per-device UID
>>>> +		attribute is guaranteed to provide a unique user defined
>>>> +		identifier for that PCI device. If this file contains '0' UIDs
>>>> +		may collide and do not provide a unique identifier.
>>>
>>> What are they "colliding" with?  And where does the UID come from, the
>>> device itself or somewhere else?
>>
>> If this attribute is 0 multiple PCI devices seen by Linux may have the same UID i.e.
>> they may collide with each other on the same Linux instance.
> 
> So can't userspace figure this out on its own?

Userspace can figure out that they do not currently collide but
without this attribute it doesn't know that the platform also guarantees
that no collision will be introduced by e.g. hotplug. We are however
pushing to have this always turned on so yes over time this attribute
will hopefully be always 1 but this will take years.

> 
>> The
>> UIDs are exposed under /sys/bus/pci/devices/<dev>/uid. Even if the attribute is 1
>> multiple Linux instances will often see the same UID. The main use case
>> we currently envision is naming PCI based network interfaces "eno<UID>"
>> which of course only works if the UIDs are unique for that Linux.
>> On the same mainframe multiple Linux instances may then e.g. use the same
>> UID for VFs from the same physical PCI network card or different cards
>> but the same physical network all defined by an administrator/management
>> system.
>>
>> The UIDs come from the platform/firmware/hypervisor and are provided
>> for each device by the CLP List PCI Functions "instruction" that is used
>> on s390x where an OS can't probe the physical PCI bus but instead
>> that is done by firmware. On QEMU/KVM they can be set on the QEMU cli,
>> on our machine hypervisor they are defined by the machine administrator/management
>> software as part of the definition of VMs/Partitions on that mainframe which includes
>> everything from the number of CPUs, memory, I/O devices etc. With the exposed UID uniqueness
>> attribute the platform then certifies that it will ensure that a UID is set to
>> a unique non-zero value. I can of course add more of this explanation
>> in the documentation too.
> 
> Please explain it more, but why would userspace care about this?  If
> userspace sees a UID "collision" then it just adds something else to the
> end of the name to make it unique.

The idea is that userspace can be sure that no collisions will ever
happen. Consequently we can tell users that if they have UID uniqueness
checking on in their partition definition and they add a PCIe NIC with UID
X the network device will be named "enoX". This is particularly important
since during installation users might have to specify the interface name
as part of the installer's boot parameters _before_ Linux even boots.
Note that in our usual environments a lot of customers do not use things
like DHCP and might have very strict rules which interfaces will be
used for what. Similarly this would allow users to know exact interface
names when specifying e.g a Cloud Init configuration.

> 
> What is it supposed to do differently based on the value/presense of
> this file?

When UIDs are not guaranteed to be unique they are often unset that
is 0 and then the most stable identifier for a PCI function that a user
can know before even booting Linux is /sys/bus/pci/function_id.
This Function ID (FID) is also used as the hotplug slot
number and thus the X in "ensX.." interface names.
Thus, this would instead be the preferred interface naming scheme that
still allows the user to relate the interface names inside Linux
to what they can see in their machine/hypervisor configuration.

It should be noted that in our environments often the Linux admin(s)
will be a different group with very different background then the machine/mainframe
admin and the FID and UID are ofent the only per device information both
sides can see to identify an interface. Currently not even
the MAC address can be seen from the machine configuration or
even when listing devices in the z/VM hypervisor so we really want to use
either the FID or the UID in interface names.

In the future similar considerations may apply to other PCI devices.

> 
>> Both the uniqueness guarantee (this attribute) as well as the UIDs themselves
>> are part of the Z (s390x) architecture so fall under the mainframe typical
>> backwards compatibility considerations.
> 
> So what can userspace do with this?  What tool is going to rely on this?

We have a systemd/udev patch waiting on this RFC discussion
that will use this attribute for the aforementioned decision of either
preferring the existing "ens<hotplug_slot_numnber>…" or "eno<UID>…"
interface names based on this value.

As I mentioned in the cover letter we are also
considering instead going for /sys/firmware/.. but as far as
I can see that currently really needs much uglier raw kobject handling and
would lose the direct relation to PCI and creates the question
why PCI code puts stuff in /sys/firmware/… or alternatively which
other code deals with a PCI specific value.

> 
> thanks,
> 
> greg k-h
> 
