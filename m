From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH/RFC] KVM: s390: Add S390 configuration and control kvm device
Date: Tue, 1 Apr 2014 21:37:42 +0200
Message-ID: <53585DF1-2868-407C-91E7-1A494F9D17EF@suse.de>
References: <1396363663-50450-1-git-send-email-borntraeger@de.ibm.com> <1396363663-50450-2-git-send-email-borntraeger@de.ibm.com> <533AD42D.8060504@suse.de> <533AD593.5020804@de.ibm.com> <533AD752.5010605@suse.de> <533B1130.9030207@de.ibm.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <533B1130.9030207@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 01.04.2014, at 21:19, Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 01/04/14 17:12, Alexander Graf wrote:
>> On 04/01/2014 05:04 PM, Christian Borntraeger wrote:
>>> On 01/04/14 16:58, Alexander Graf wrote:
>>>> On 04/01/2014 04:47 PM, Christian Borntraeger wrote:
>>>>> From: Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>
>>>>> 
>>>>> Add KVM_DEV_TYPE_S390_CONFIG kvm device that contains
>>>>> configuration and control attributes of particular vm.
>>>>> The device is created by KVM_CREATE_DEVICE ioctl.
>>>>> The attributes may be retrieved and stored by calling
>>>>> KVM_GET_DEVICE_ATTR and KVM_SET_DEVICE_ATTR ioctls.
>>>>> 
>>>>> Signed-off-by: Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>
>>>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> I don't think a device is particularly the best fit. A device can usually be instantiated multiple times. The configuration device can only be created once. A device also gets created by user space which enables it to receive the fd to drive it. Your device has to be created during VM creation.
>>> I remember some discussion a year or 2 ago, and IIRC a config device
>>> was actually your idea ;-) (The other idea that we had, was ONE_REG for the VM)
>> 
>> Omg, really? :o
>> 
>> A device would make sense for a specific "system information" instruction trap that we handle in-kernel for whatever reason (usually because it's performance critical) and some mandatory say to make sure user space always creates it. And some checks to make sure it can't get created twice.
> 
> Well the device created twice problem  is also true for all existing KVM devices. 
> The only missing piece is the check in the config device, no?
> 
>> 
>> Speaking of which, why don't we just forward STSI to user space with an ENABLE_CAP and handle all of this there? It's not performance critical at all, right?
> 
> No, performance is not critical.
> The thing is, that we definitely need the kernel to handle parts of STSI, as we have to provide information from the upper hipervisor (LPAR or zVM). This information is only available in kernel space. So in essence we could only forward a small subset of STSI, namely stsi3_2_2. But we still have to call stsi_3_2_2 in the kernel,
> as 3_2_2 does contain the list of hipervisors underneath us (KVM under z/VM). 
> 
> So then only thing that we could do is to forward STSI_3_2_2 to qemu when a capability is set and after the kernel has filled in the upper layers. 
> QEMU then has to modify the page that the kernel touched and go back. Would work, but needs a capability and preferably an own exit. An new ioctl or
> a subcode of an ioctl (attr/group whatever) seems easier.

I would consider these 2 orthogonal bits of information. User space wants to get information about its underlying hypervisors regardless of KVM, no? So we should have some interface to bubble STSI information of the current system to user space either way.

QEMU could use that and add a few bits of its own. That way we could handle all of STSI in QEMU and get out of the business of defining complicated interfaces.

> 
>> 
>>>> I think VM configuration is common enough to just make this a separate interface.
>>> So you propose to define a new base ioctl (e.g. VM_REG) on the vm fd, instead?
>>> Seems like an easy enough change. Would you reuse the kvm_attr structure for that?
>> 
>> Yeah, reuse whatever we can. Basically just remove the device boilerplate - I don't think it's impressively useful for a non-device.
> 
> See above, name is just a simple first user.  
> The thing is, that we have to have the ioctl either define a proper namespace (unique groups attrs) or to make it s390 specific. The device approach does help us here. 

If you like the device approach, make sure to create it on VM creation and only implement a specific ioctl to fetch its fd. We don't create the configuration information pseudo device after VM creation - it's always there :).

> I personally dont mind which way to go, as long as Paolo is fine with the approach, and nobody complains about the functions being non-QOM.

I think the most obvious and straight forward way would be to deal with all of STSI in user space. Make it a separate exit type similar to hypercalls and don't worry about QOM'ification of anything. This thing is on the same level as CPUID really - just VM wide :).


Alex
