From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 11/13] KVM: s390: implement mediated device open
 callback
Date: Thu, 7 Jun 2018 09:52:28 -0400
Message-ID: <2b128772-f2c2-25fe-e6a8-358711745a94@linux.vnet.ibm.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-12-git-send-email-akrowiak@linux.vnet.ibm.com>
 <98ea7ce2-2539-e2ff-4bb4-297e784d87bd@linux.ibm.com>
 <7bb480ac-5723-83ff-c797-53c1ab0458c1@linux.vnet.ibm.com>
 <93cd0f46-a410-51c8-00b9-810c1b3d3ae2@linux.ibm.com>
 <0f37dc39-7355-19e5-40c9-a02a1ea58c2d@linux.vnet.ibm.com>
 <736a1346-f81a-7f71-7d13-38729ff78e4f@linux.ibm.com>
 <8f68183d-8385-8025-1898-23cad604ae94@linux.vnet.ibm.com>
 <9e30c9b0-a04c-0c4e-9d3d-37e7a53a7f72@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9e30c9b0-a04c-0c4e-9d3d-37e7a53a7f72@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 06/06/2018 12:08 PM, Pierre Morel wrote:
> On 06/06/2018 16:28, Tony Krowiak wrote:
>> On 06/05/2018 08:19 AM, Pierre Morel wrote:
>>> On 30/05/2018 16:33, Tony Krowiak wrote:
>>>> On 05/24/2018 05:08 AM, Pierre Morel wrote:
>>>>> On 23/05/2018 16:45, Tony Krowiak wrote:
>>>>>> On 05/16/2018 04:03 AM, Pierre Morel wrote:
>>>>>>> On 07/05/2018 17:11, Tony Krowiak wrote:
>>>>>>>> Implements the open callback on the mediated matrix device.
>>>>>>>> The function registers a group notifier to receive notification
>>>>>>>> of the VFIO_GROUP_NOTIFY_SET_KVM event. When notified,
>>>>>>>> the vfio_ap device driver will get access to the guest's
>>>>>>>> kvm structure. With access to this structure the driver will:
>>>>>>>>
>>>>>>>> 1. Ensure that only one mediated device is opened for the guest
>>>>>
>>>>> You should explain why.
>>>>>
>>>>>>>>
>>>>>>>> 2. Configure access to the AP devices for the guest.
>>>>>>>>
>>>>> ...snip...
>>>>>>>> +void kvm_ap_refcount_inc(struct kvm *kvm)
>>>>>>>> +{
>>>>>>>> +    atomic_inc(&kvm->arch.crypto.aprefs);
>>>>>>>> +}
>>>>>>>> +EXPORT_SYMBOL(kvm_ap_refcount_inc);
>>>>>>>> +
>>>>>>>> +void kvm_ap_refcount_dec(struct kvm *kvm)
>>>>>>>> +{
>>>>>>>> +    atomic_dec(&kvm->arch.crypto.aprefs);
>>>>>>>> +}
>>>>>>>> +EXPORT_SYMBOL(kvm_ap_refcount_dec);
>>>>>>>
>>>>>>> Why are these functions inside kvm-ap ?
>>>>>>> Will anyone use this outer of vfio-ap ?
>>>>>>
>>>>>> As I've stated before, I made the choice to contain all 
>>>>>> interfaces that
>>>>>> access KVM in kvm-ap because I don't think it is appropriate for 
>>>>>> the device
>>>>>> driver to have to have "knowledge" of the inner workings of KVM. 
>>>>>> Why does
>>>>>> it matter whether any entity outside of the vfio_ap device driver 
>>>>>> calls
>>>>>> these functions? I could ask a similar question if the interfaces 
>>>>>> were
>>>>>> contained in vfio-ap; what if another device driver needs access 
>>>>>> to these
>>>>>> interfaces?
>>>>>
>>>>> This is very driver specific and only used during initialization.
>>>>> It is not a common property of the cryptographic interface.
>>>>>
>>>>> I really think you should handle this inside the driver.
>>>>
>>>> We are going to have to agree to disagree on this one. Is it not 
>>>> possible
>>>> that future drivers - e.g., when full virtualization is implemented 
>>>> - will
>>>> require access to KVM?
>>>
>>> I do not think that an access to KVM is required for full 
>>> virtualization.
>>
>> You may be right, but at this point, there is no guarantee. I stand 
>> by my
>> design on this one.
>
> I really regret that we abandoned the initial design with the matrix 
> bus and one
> single parent matrix device per guest.

This is an interesting time to be bringing this up.

> We would not have the problem of these KVM dependencies.

How does that eliminate these KVM dependencies? We would still have to 
configure
the guest's SIE state description - i.e., ECA.28 and the CRYCB - regardless
of the number or purpose of the matrix devices. To what KVM dependencies are
you referring?

>
>
> It had the advantage of taking care of having only one device per guest
> (available_instance = 1), 

Maybe you didn't state this as you intended, but when you refer to
available_instances, you are referring to mediated devices. We allow
only one mediated device per guest in the current design. I suspect
that is not what you meant here.

> could take care of provisioning as you have
> sysfs entries available for a matrix without having a guest and a 
> mediated
> device.

I assume here that you are saying that the matrix configuration would be
done via sysfs files for the matrix device as opposed to the mediated
device?

>
>
> it also had advantage for virtualization to keep host side and guest 
> side matrix
> separate inside parent (host side) and mediated device (guest side).

In my opinion, since the AP devices assigned to the matrix device are 
used only by
a guest (i.e., pass-through) and never by the host, it is all guest side 
configuration.
Even if we map virtual AP devices to real AP devices, the mapping is still
guest side configuration from my perspective. I think this can all be 
handled
by using differing mediated device types for pass-through, virtualized 
and emulated
devices. In fact, early on I prototyped the mediated device sysfs 
structures for
configuring all three mediated device types if you recall. I see no 
advantage
to keeping separate configurations for host and guest sides and in fact 
think it
complicates things.


>
>
> Shouldn't we treat this problem with a design using standard interfaces
> Instead of adding new dedicated interfaces?

I do not understand this question. I believe we are using standard 
interfaces.
We use the bind/unbind interface to reserve queues for use by guests and 
have
sysfs attributes for the mediated devices that map directly to the APM, AQM
and ADM. What do you mean by dedicated interfaces?

In fact, I think the design about which you speak introduces a need for
non-standard and confusing interfaces. For example, think about securing
AP queues; you'd have to unbind the queues from a device driver on the
AP bus and bind them to a driver on a different bus, the matrix bus.
This would require radical design changes to and/or introduction of 
non-standard
interfaces on the AP bus. It would also introduce some unusual sysfs 
interfaces
on the matrix driver to validate and commit the matrix - i.e., APM, AQM 
- created
from the queues bound to it.

>
> Regards,
>
> Pierre
>
>
