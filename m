From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH/RFC] KVM: s390: Add S390 configuration and control kvm
 device
Date: Tue, 01 Apr 2014 21:19:12 +0200
Message-ID: <533B1130.9030207@de.ibm.com>
References: <1396363663-50450-1-git-send-email-borntraeger@de.ibm.com> <1396363663-50450-2-git-send-email-borntraeger@de.ibm.com> <533AD42D.8060504@suse.de> <533AD593.5020804@de.ibm.com> <533AD752.5010605@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <533AD752.5010605@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 01/04/14 17:12, Alexander Graf wrote:
> On 04/01/2014 05:04 PM, Christian Borntraeger wrote:
>> On 01/04/14 16:58, Alexander Graf wrote:
>>> On 04/01/2014 04:47 PM, Christian Borntraeger wrote:
>>>> From: Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>
>>>>
>>>> Add KVM_DEV_TYPE_S390_CONFIG kvm device that contains
>>>> configuration and control attributes of particular vm.
>>>> The device is created by KVM_CREATE_DEVICE ioctl.
>>>> The attributes may be retrieved and stored by calling
>>>> KVM_GET_DEVICE_ATTR and KVM_SET_DEVICE_ATTR ioctls.
>>>>
>>>> Signed-off-by: Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>
>>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> I don't think a device is particularly the best fit. A device can usually be instantiated multiple times. The configuration device can only be created once. A device also gets created by user space which enables it to receive the fd to drive it. Your device has to be created during VM creation.
>> I remember some discussion a year or 2 ago, and IIRC a config device
>> was actually your idea ;-) (The other idea that we had, was ONE_REG for the VM)
> 
> Omg, really? :o
> 
> A device would make sense for a specific "system information" instruction trap that we handle in-kernel for whatever reason (usually because it's performance critical) and some mandatory say to make sure user space always creates it. And some checks to make sure it can't get created twice.

Well the device created twice problem  is also true for all existing KVM devices. 
The only missing piece is the check in the config device, no?

> 
> Speaking of which, why don't we just forward STSI to user space with an ENABLE_CAP and handle all of this there? It's not performance critical at all, right?

No, performance is not critical.
The thing is, that we definitely need the kernel to handle parts of STSI, as we have to provide information from the upper hipervisor (LPAR or zVM). This information is only available in kernel space. So in essence we could only forward a small subset of STSI, namely stsi3_2_2. But we still have to call stsi_3_2_2 in the kernel,
as 3_2_2 does contain the list of hipervisors underneath us (KVM under z/VM). 

So then only thing that we could do is to forward STSI_3_2_2 to qemu when a capability is set and after the kernel has filled in the upper layers. 
QEMU then has to modify the page that the kernel touched and go back. Would work, but needs a capability and preferably an own exit. An new ioctl or
a subcode of an ioctl (attr/group whatever) seems easier.

> 
>>> I think VM configuration is common enough to just make this a separate interface.
>> So you propose to define a new base ioctl (e.g. VM_REG) on the vm fd, instead?
>> Seems like an easy enough change. Would you reuse the kvm_attr structure for that?
> 
> Yeah, reuse whatever we can. Basically just remove the device boilerplate - I don't think it's impressively useful for a non-device.

See above, name is just a simple first user.  
The thing is, that we have to have the ioctl either define a proper namespace (unique groups attrs) or to make it s390 specific. The device approach does help us here. 

I personally dont mind which way to go, as long as Paolo is fine with the approach, and nobody complains about the functions being non-QOM.

Christian
