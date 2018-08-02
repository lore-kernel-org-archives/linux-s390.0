From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Thu, 02 Aug 2018 21:59:42 +0000
Subject: Re: [PATCH v7 22/22] s390: doc: detailed specifications for AP virtualization
Message-Id: <8b9476dd-cb65-ba88-cd0d-71dbc364a1ba@linux.ibm.com>
In-Reply-To: <e8a516d2-84e7-ab3e-0ddf-f4ed4f09b727@linux.ibm.com>
References: <e8a516d2-84e7-ab3e-0ddf-f4ed4f09b727@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 08/02/2018 11:25 AM, Alex Williamson wrote:
> On Wed, 1 Aug 2018 19:05:35 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> On 07/27/2018 01:44 PM, Alex Williamson wrote:
>>> On Thu, 26 Jul 2018 21:54:29 +0200
>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>> ...
>>>> +The process for reserving an AP queue for use by a KVM guest is:
>>>> +
>>>> +* The vfio-ap driver during its initialization will perform the following:
>>>> +  * Create the 'vfio_ap' root device - /sys/devices/virtual/misc/vfio_ap
>>>> +  * Create the 'matrix' device in the 'vfio_ap' root
>>>> +  * Register the matrix device with the device core
>>>> +* Register with the ap_bus for AP queue devices of type 10 devices (CEX4 and
>>>> +  newer) and to provide the vfio_ap driver's probe and remove callback
>>>> +  interfaces. The reason why older devices are not supported is because there
>>>> +  are no systems available on which to test.
>>>> +* The admin needs to reserve the AP Queue for vfio_ap driver. This can be
>>>> +  done by writing the AP adapter mask to /sys/bus/ap/apmask and the AP domain
>>>> +  mask to /sys/bus/ap/aqmask.
>>>> +
>>>> +  For example to reserve all the AP Queues on the system for vfio_ap driver:
>>>> +
>>>> +  echo 0x0000000000000000000000000000000000000000000000000000000000000000 > /sys/bus/ap/apmask
>>>> +  echo 0x0000000000000000000000000000000000000000000000000000000000000000 > /sys/bus/ap/aqmask
>>> And this is a reasonable user syntax? ;)
>> I am not a fan of writing a 256-bit bitmask as such. It is entirely too
>> difficult to
>> figure out which character to specify to indicate a bit number to be set
>> for anything
>> past the first few characters. Of course, tooling could be used to
>> accomplish this
>> task, but the sysfs interfaces should probably be user-friendly. A
>> comma-separated
>> list could be used; for example to set reserve adapters 21, 99 and 249:
>>
>> echo 21,99,249 > /sys/bus/ap/apmask
>>
>> The problem with this is how do we indicate that all bits are to be
>> cleared? Do you
>> have any suggestions for a reasonable user syntax?
> Perhaps an empty write, just a carriage return, "null".  I'd shy away
> from magic digits, like 256 to clear.

The crypto team has decided to eliminate these sysfs attributes for the 
AP bus
and rely on bind/unbind.

>
>>> ...
>>>> +  * mdev_attr_groups
>>>> +    This attribute group identifies the user-defined sysfs attributes of the
>>>> +    mediated device. When a device is registered with the VFIO mediated device
>>>> +    framework, the sysfs attributes files identified in the 'mdev_attr_groups'
>>>> +    structure will be created in the mediated matrix device's directory. The
>>>> +    sysfs attributes for a mediated matrix device are:
>>>> +    * assign_adapter:
>>>> +      A write-only file for assigning an AP adapter to the mediated matrix
>>>> +      device. To assign an adapter, the APID of the adapter is written to the
>>>> +      file.
>>>> +    * assign_domain:
>>>> +      A write-only file for assigning an AP usage domain to the mediated matrix
>>>> +      device. To assign a domain, the APQI of the AP queue corresponding to a
>>>> +      usage domain is written to the file.
>>>> +    * matrix:
>>>> +      A read-only file for displaying the APQNs derived from the adapters and
>>>> +      domains assigned to the mediated matrix device.
>>>> +    * assign_control_domain:
>>>> +      A write-only file for assigning an AP control domain to the mediated
>>>> +      matrix device. To assign a control domain, the ID of a domain to be
>>>> +      controlled is written to the file. For the initial implementation, the set
>>>> +      of control domains will always include the set of usage domains, so it is
>>>> +      only necessary to assign control domains that are not also assigned as
>>>> +      usage domains.
>>> How will the user know when this changes?  What's the transition plan
>>> to maintain compatibility when it does change?
>> I'm sorry, I don't understand the question. When you say user, about
>> whom are
>> you talking; the person doing the assignments? What changes are you talking
>> about?
> The user would be the person interaction with the sysfs attribute
> assign_control_domain where it states "[f]or the initial implementation,
> the set of control domains will always include the set of usage
> domains, so it is only necessary to assign control domains that are not
> also assigned as usage domains."  I infer from the usage of "initial
> implementation" that this behavior may not always be the case and
> therefore if it's not final what is the transition plan so that a user
> interacting with this attribute can know the current behavior.

Ah, I get your point now. I see how this verbiage would lead you to that
conclusion and it will be removed. This behavior will not change.

>
>>> ...
>>>> +4. The administrator now needs to configure the matrixes for mediated
>>>> +   devices $uuid1 (for Guest1) and $uuid2 (for Guest2).
>>>> +
>>>> +   This is how the matrix is configured for Guest1:
>>>> +
>>>> +   echo 5 > assign_adapter
>>>> +   echo 6 > assign_adapter
>>>> +   echo 4 > assign_domain
>>>> +   echo 0xab > assign_domain
>>>> +
>>>> +   For this implementation, all usage domains - i.e., domains assigned
>>>> +   via the assign_domain attribute file - will also be configured in the ADM
>>>> +   field of the KVM guest's CRYCB, so there is no need to assign control
>>>> +   domains here unless you want to assign control domains that are not
>>>> +   assigned as usage domains.
>>>> +
>>>> +   If a mistake is made configuring an adapter, domain or control domain,
>>>> +   you can use the unassign_xxx files to unassign the adapter, domain or
>>>> +   control domain.
>>> Would it be more consistent with other sysfs entries to call these
>>> "bind" and "unbind" rather than "assign" and "unassign
>> Aren't the bind and unbind sysfs interfaces typically associated with
>> binding devices to and unbinding devices from a device driver?
> Yes
>
>> In this
>> case we are talking about configuring a mediated device's AP matrix - i.e.,
>> setting bits identifying the adapters, domains and control domains defined
>> for the mediated device (i.e., a guest). Maybe there are better words we
>> could use than assign/unassign, but I find the use of bind/unbind to be
>> confusing. I'm open to suggestions.
> If we remove the 'activate' interface and dedicate resources to the
> mdev device at the point where we create an intersection in the matrix,
> wouldn't that resource be "bound" to the mdev at that time?  This is
> not a strong issue for me, I just thought "assign" seemed inconsistent
> as the operation felt more like a traditional "bind".

We are going to remove the activate for the next series, but stick with
the assign terminology because we're not really binding devices, but 
constructing a
matrix that identifies the AP queues to which the guest using the mdev
will have access.

>
>>>> +
>>>> +   To display the matrix configuration for Guest1:
>>>> +
>>>> +   cat matrix
>>>> +
>>>> +   This is how the matrix is configured for Guest2:
>>>> +
>>>> +   echo 5 > assign_adapter
>>>> +   echo 0x47 > assign_domain
>>>> +   echo 0xff > assign_domain
>>>> +
>>>> +5. The adminstrator now needs to activate the mediated devices.
>>>> +   echo 1 > activate
>>> Or optionally not.  As in reply to cover letter, I don't think this
>>> interface is sufficiently justified, or necessarily desirable.
>> To clarify your objection, let me state what I think you are saying.
>>
>> 1. You do not think there is a good reason to assign duplicate APQNs
>>      - i.e., the cross product of all adapter IDs and domain IDs assigned
>>      to the mdev.
> I think the cross product of adapters and domains is a basic part of
> the design here, what I object to is that mdevs can exist with
> overlapping cross products and which one can be activated is dependent
> on activation ordering.  For example, if I have the following mdevs:
>
> {adapters}{domains}
> A: {0,1}{0,1}
> B: {0}{0}
> C: {0}{1}
> D: {1}{0}
> E: {1}{1}
>
> Who is supposed to understand and debug that A cannot be activated
> while any of B/C/D/E are activated?  What does the debugging process
> look like?  If the mdev is not explicitly activated, only opened, how
> do we determine the fault is from a resource conflict on the mdev
> definition?  On the other hand if the cross product is committed at the
> time it's specified, then a scenario where E already exists and we're
> trying to create A might look like:
>
> 1. Specify adapter mask of {0,1}
> 2. Specify domain mask of {0,1} <-- write(2) fails with -EBUSY
>
> Here we know that one or more of the domains we've specified are not
> available on the set of adapters we've configured.

This is moot for the next series because the activate will be removed and
consistency checking will be done as adapters/domains are assigned.

>
>> 2. All mdevs should be validly configured for use regardless of when
>>      guests using them are started. In other words, libvirt should be
>>      able to depend on the fact that an mdev is ready for use at all
>>      times.
> Yes, an mdev should represent committed resources.  We support dynamic
> creation and removal if the resources need to be freed for the host or
> another mdev configuration.

See my previous response.

>
>> I will discuss this with the team when we meet on Thursday and get
>> back to you. If I am mistaken in my analysis of your concern, please
>> clarify.
>>
>> I would like to mention that when a guest using an mdev starts,
>> the mdev will be activated if not already activated. The guest
>> will not start if another activated mdev is using an APQN assigned
>> to the mdev of the guest being started.
> Understood.
>
>>>> +6. Start Guest1:
>>>> +
>>>> +   /usr/bin/qemu-system-s390x ... -cpu xxx,ap=on,apft=on \
>>>> +      -device vfio-ap,sysfsdev=/sys/devices/virtual/misc/vfio_ap/mdev_supported_types/vfio_ap-passthrough/devices/$uuid1 ...
>>>> +
>>>> +7. Start Guest2:
>>>> +
>>>> +   /usr/bin/qemu-system-s390x ... -cpu xxx,ap=on,apft=on \
>>>> +      -device vfio-ap,sysfsdev=/sys/devices/virtual/misc/vfio_ap/mdev_supported_types/vfio_ap-passthrough/devices/$uuid2 ...
>>>> +
>>>> +When the guest is shut down, the mediated matrix device may be removed.
>>>> +
>>>> +Using our example again, to remove the mediated matrix device $uuid1:
>>>> +
>>>> +   /sys/devices/virtual/misc
>>>> +      --- [vfio_ap]
>>>> +      --------- [mdev_supported_types]
>>>> +      ------------ [vfio_ap-passthrough]
>>>> +      --------------- [devices]
>>>> +      ------------------ [$uuid1]
>>>> +      --------------------- activate
>>>> +      --------------------- remove
>>>> +
>>>> +
>>>> +   echo 0 > activate
>>>> +   echo 1 > remove
>>>> +
>>>> +   This will release all the AP queues for the mediated device and
>>>> +   remove all of the mdev matrix device's sysfs structures. To
>>>> +   recreate and reconfigure the mdev matrix device, all of the steps starting
>>>> +   with step 4 will have to be performed again.
>>>> +
>>>> +   It is not necessary to remove an mdev matrix device, but one may want to
>>>> +   remove it if no guest will use it during the lifetime of the linux host. If
>>>> +   the mdev matrix device is removed, one may want to unbind the AP queues the
>>>> +   guest was using from the vfio_ap device driver and bind them back to the
>>>> +   default driver. Alternatively, the AP queues can be configured for another
>>>> +   mdev matrix (i.e., guest). In either case, one must take care to change the
>>>> +   secure key configured for the domain to which the queue is connected.
>>> This seems prime for data leakage, extremely sensitive data at that.
>>> Who's responsibility is it to prevent this?  Shouldn't closing the
>>> device reset the device, which should perhaps wipe any key
>>> configuration?
>> The device is zeroized (reset) when it is removed. The zeroize
>> instruction - to
>> the best of my knowledge - does nothing with the secure key for a given
>> queue.
>> There is also no instruction that I know of to clear keys, so it would
>> appear
>> that this is left to the system administrator.
> :-o  That seems like a pretty serious fault.  Given that this interface
> is specifically for crypto devices where such sensitive information
> seems common, doesn't it seem like the kernel, ie. the mdev vendor
> driver, should provide guarantees that should your user instance crash
> or be killed that keys are not available to the system admin?

I may have misspoke with regard to my understanding of the AP reset. I've
been told that the keys stored with the domain will be reset. I will
verify this and get back to you.

>
>>>> +
>>>> +
>>>> +Limitations
>>>> +===========
>>>> +An admin needs to be careful when writing to sysfs files
>>>> +/sys/bus/ap/apmask and /sys/bus/ap/aqmask. These files control the driver
>>>> +to which an AP queue is bound to. Once an AP queue is bound vfio_ap
>>>> +driver and assigned to a mediated device, admin should not re-assign the
>>>> +AP queues back to the default driver, because of technical limitations.
>>>> +The kernel does not prevent you from re-assigning from AP queues reserved
>>>> +for the vfio_ap driver back to default driver.  Future enhancements in
>>>> +the ap_bus and vfio_ap are likely to introduce complete support for such
>>>> +dynamic reconfiguration. But until then be extremely careful.
>>> Why don't we have these enhancements now?  Should the whole thing be
>>> marked experimental without them?  This sounds similar to a vfio-pci
>>> case where a group with multiple devices could have device which is
>>> unused by the user unbound from vfio-pci and re-bound to a native host
>>> driver.  We BUG_ON when this occurs to protect the data.
>> We have customers that have been waiting a long time and are very anxious
>> to have guest access to AP devices. In the interest of reducing time to
>> market, we have decided to simplify the initial implementation as much
>> as possible. I wouldn't necessarily call this experimental, but view it
>> more as the minimal viable product.
>>
>> As far as BUG_ON, I will discuss this with the crypto team at our
>> meeting on Thursday and get back to you.
> A minimum viable product still needs to protect the host and does not
> excuse us from later breaking the user exposed ABI.

I will have a more thorough look into it.

>
>>> Probably also need to evaluate updates to
>>> Documentation/ABI/testing/sysfs-bus-vfio-mdev, especially if libvirt is
>>> supposed to interact with an 'activate' attribute.  Thanks,
>> As it stands, libvirt will not create or modify the attributes of an mdev.
>> If a guest is started under libvirt and its mdev has not been activated,
>> it will be activated when the mdev fd is opened. Of course, if another
>> activated mdev is assigned an APQN assigned to the mdev of the guest
>> being started, the guest will be terminated.
> Exactly why I disapprove of the activated interface, but it's being
> proposed and recommended for use as a standard part of the lifecycle
> management for these devices.  Thanks,

As I stated elsewhere, we are removing the activate interface. All
consistency checking will be done as adapters/domains are assigned to
the mdev.

>
> Alex
>
