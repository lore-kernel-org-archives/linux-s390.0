From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH/RFC] KVM: s390: Add S390 configuration and control kvm
 device
Date: Tue, 01 Apr 2014 17:12:18 +0200
Message-ID: <533AD752.5010605@suse.de>
References: <1396363663-50450-1-git-send-email-borntraeger@de.ibm.com> <1396363663-50450-2-git-send-email-borntraeger@de.ibm.com> <533AD42D.8060504@suse.de> <533AD593.5020804@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <533AD593.5020804@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 04/01/2014 05:04 PM, Christian Borntraeger wrote:
> On 01/04/14 16:58, Alexander Graf wrote:
>> On 04/01/2014 04:47 PM, Christian Borntraeger wrote:
>>> From: Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>
>>>
>>> Add KVM_DEV_TYPE_S390_CONFIG kvm device that contains
>>> configuration and control attributes of particular vm.
>>> The device is created by KVM_CREATE_DEVICE ioctl.
>>> The attributes may be retrieved and stored by calling
>>> KVM_GET_DEVICE_ATTR and KVM_SET_DEVICE_ATTR ioctls.
>>>
>>> Signed-off-by: Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> I don't think a device is particularly the best fit. A device can usually be instantiated multiple times. The configuration device can only be created once. A device also gets created by user space which enables it to receive the fd to drive it. Your device has to be created during VM creation.
> I remember some discussion a year or 2 ago, and IIRC a config device
> was actually your idea ;-) (The other idea that we had, was ONE_REG for the VM)

Omg, really? :o

A device would make sense for a specific "system information" 
instruction trap that we handle in-kernel for whatever reason (usually 
because it's performance critical) and some mandatory say to make sure 
user space always creates it. And some checks to make sure it can't get 
created twice.

Speaking of which, why don't we just forward STSI to user space with an 
ENABLE_CAP and handle all of this there? It's not performance critical 
at all, right?

>> I think VM configuration is common enough to just make this a separate interface.
> So you propose to define a new base ioctl (e.g. VM_REG) on the vm fd, instead?
> Seems like an easy enough change. Would you reuse the kvm_attr structure for that?

Yeah, reuse whatever we can. Basically just remove the device 
boilerplate - I don't think it's impressively useful for a non-device.


Alex
