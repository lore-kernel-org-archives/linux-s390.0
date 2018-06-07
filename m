From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v5 11/13] KVM: s390: implement mediated device open
 callback
Date: Thu, 7 Jun 2018 19:15:08 +0200
Message-ID: <b7215f0e-6ceb-2738-4584-1af7c30bd595@linux.ibm.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-12-git-send-email-akrowiak@linux.vnet.ibm.com>
 <98ea7ce2-2539-e2ff-4bb4-297e784d87bd@linux.ibm.com>
 <7bb480ac-5723-83ff-c797-53c1ab0458c1@linux.vnet.ibm.com>
 <93cd0f46-a410-51c8-00b9-810c1b3d3ae2@linux.ibm.com>
 <0f37dc39-7355-19e5-40c9-a02a1ea58c2d@linux.vnet.ibm.com>
 <736a1346-f81a-7f71-7d13-38729ff78e4f@linux.ibm.com>
 <8f68183d-8385-8025-1898-23cad604ae94@linux.vnet.ibm.com>
 <9e30c9b0-a04c-0c4e-9d3d-37e7a53a7f72@linux.ibm.com>
 <d6455b0b-804f-b58e-41bc-83731979911a@linux.ibm.com>
 <f74f2d2d-36d3-7910-5511-3691a483b89f@linux.vnet.ibm.com>
 <ea5c2c2f-27fe-b2bf-2aa8-fbe80e77ce81@linux.ibm.com>
 <5f9c3f97-34e2-bf68-b8ca-ac9288ea5efa@linux.vnet.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5f9c3f97-34e2-bf68-b8ca-ac9288ea5efa@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 07/06/2018 18:30, Tony Krowiak wrote:
> On 06/07/2018 11:20 AM, Pierre Morel wrote:
>> On 07/06/2018 15:54, Tony Krowiak wrote:
>>> On 06/06/2018 01:40 PM, Pierre Morel wrote:
>>>> On 06/06/2018 18:08, Pierre Morel wrote:
>>>>> On 06/06/2018 16:28, Tony Krowiak wrote:
>>>>>> On 06/05/2018 08:19 AM, Pierre Morel wrote:
>>>>>>> On 30/05/2018 16:33, Tony Krowiak wrote:
>>>>>>>> On 05/24/2018 05:08 AM, Pierre Morel wrote:
>>>>>>>>> On 23/05/2018 16:45, Tony Krowiak wrote:
>>>>>>>>>> On 05/16/2018 04:03 AM, Pierre Morel wrote:
>>>>>>>>>>> On 07/05/2018 17:11, Tony Krowiak wrote:
>>>>>>>>>>>> Implements the open callback on the mediated matrix device.
>>>>>>>>>>>> The function registers a group notifier to receive 
>>>>>>>>>>>> notification
>>>>>>>>>>>> of the VFIO_GROUP_NOTIFY_SET_KVM event. When notified,
>>>>>>>>>>>> the vfio_ap device driver will get access to the guest's
>>>>>>>>>>>> kvm structure. With access to this structure the driver will:
>>>>>>>>>>>>
>>>>>>>>>>>> 1. Ensure that only one mediated device is opened for the 
>>>>>>>>>>>> guest
>>>>>>>>>
>>>>>>>>> You should explain why.
>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> 2. Configure access to the AP devices for the guest.
>>>>>>>>>>>>
>>>>>>>>> ...snip...
>>>>>>>>>>>> +void kvm_ap_refcount_inc(struct kvm *kvm)
>>>>>>>>>>>> +{
>>>>>>>>>>>> + atomic_inc(&kvm->arch.crypto.aprefs);
>>>>>>>>>>>> +}
>>>>>>>>>>>> +EXPORT_SYMBOL(kvm_ap_refcount_inc);
>>>>>>>>>>>> +
>>>>>>>>>>>> +void kvm_ap_refcount_dec(struct kvm *kvm)
>>>>>>>>>>>> +{
>>>>>>>>>>>> + atomic_dec(&kvm->arch.crypto.aprefs);
>>>>>>>>>>>> +}
>>>>>>>>>>>> +EXPORT_SYMBOL(kvm_ap_refcount_dec);
>>>>>>>>>>>
>>>>>>>>>>> Why are these functions inside kvm-ap ?
>>>>>>>>>>> Will anyone use this outer of vfio-ap ?
>>>>>>>>>>
>>>>>>>>>> As I've stated before, I made the choice to contain all 
>>>>>>>>>> interfaces that
>>>>>>>>>> access KVM in kvm-ap because I don't think it is appropriate 
>>>>>>>>>> for the device
>>>>>>>>>> driver to have to have "knowledge" of the inner workings of 
>>>>>>>>>> KVM. Why does
>>>>>>>>>> it matter whether any entity outside of the vfio_ap device 
>>>>>>>>>> driver calls
>>>>>>>>>> these functions? I could ask a similar question if the 
>>>>>>>>>> interfaces were
>>>>>>>>>> contained in vfio-ap; what if another device driver needs 
>>>>>>>>>> access to these
>>>>>>>>>> interfaces?
>>>>>>>>>
>>>>>>>>> This is very driver specific and only used during initialization.
>>>>>>>>> It is not a common property of the cryptographic interface.
>>>>>>>>>
>>>>>>>>> I really think you should handle this inside the driver.
>>>>>>>>
>>>>>>>> We are going to have to agree to disagree on this one. Is it 
>>>>>>>> not possible
>>>>>>>> that future drivers - e.g., when full virtualization is 
>>>>>>>> implemented - will
>>>>>>>> require access to KVM?
>>>>>>>
>>>>>>> I do not think that an access to KVM is required for full 
>>>>>>> virtualization.
>>>>>>
>>>>>> You may be right, but at this point, there is no guarantee. I 
>>>>>> stand by my
>>>>>> design on this one.
>>>>>
>>>>> I really regret that we abandoned the initial design with the 
>>>>> matrix bus and one
>>>>> single parent matrix device per guest.
>>>>> We would not have the problem of these KVM dependencies.
>>>>>
>>>>> It had the advantage of taking care of having only one device per 
>>>>> guest
>>>>> (available_instance = 1), could take care of provisioning as you have
>>>>> sysfs entries available for a matrix without having a guest and a 
>>>>> mediated
>>>>> device.
>>>>>
>>>>> it also had advantage for virtualization to keep host side and 
>>>>> guest side matrix
>>>>> separate inside parent (host side) and mediated device (guest side).
>>>>>
>>>>> Shouldn't we treat this problem with a design using standard 
>>>>> interfaces
>>>>> Instead of adding new dedicated interfaces?
>>>>>
>>>>> Regards,
>>>>>
>>>>> Pierre
>>>>>
>>>>>
>>>>
>>>> Forget it.
>>>>
>>>> I am not happy with the design but the design I was speaking of may 
>>>> not be the solution either.
>>>
>>> The AP architecture makes virtualization of AP devices complex. We 
>>> tried the solution you
>>> described and found it to be sorely lacking which is why we ended up 
>>> where we are now.
>>
>> I did not see any explanation on why between v1 and v2 as it was 
>> abandoned.
>>
>>
>> We have internal structures like the ap_matrix and kvm_ap_matrix
>> which look like the bus/devices we had previously but are differently
>> or not at all integrated with the LDD.
>
> What is LDD? Are you talking about dependencies between the vfio_ap 
> device
> driver and KVM? If so, see my arguments below.
>
>>
>>
>> Also I think that with a little data structure refactoring you can 
>> avoid most of
>> the code in the arch/s390/kvm.
>
> How will structure refactoring help us avoid the code for updating the 
> CRYCB
> in the guest's SIE state description.
>
>>
>>
>> For example, storing the kvm pointer inside the kvm_ap_matrix and
>> maintaining a list of the kvm_ap_matrix structures allows to easily know
>> if a guest already has an associated mediated device.
>
> How is that easier than storing the kvm pointer inside of the mediated 
> matrix
> device (i.e., struct ap_matrix_mdev) which also contains the struct 
> kvm_ap_matrix?

you can put it in ap_matrix_mdev but just the name "kvm_ap_matrix" make the
last one a better candidate for my opinion.

> How does that allow us to avoid the code in arch/s390/kvm?

This alone does not.

> We still need the code
> to update the CRYCB in the SIE block. I can obviously avoid placing 
> that code in
> kvm-ap.c and move it to the driver, but I already explained my 
> reasoning for
> keeping it in KVM. Let's face it, there is no way around the 
> dependency between
> the vfio_ap device driver and KVM unless guest matrix configuration is 
> managed
> solely by KVM through KVM interfaces.

We get the pointer to KVM from the VFIO interface.
That we both discuss on this is sterile.
The only one who could say what is right is a S390 KVM maintainer.
This would end the discussion.
My point was just to say that we have an alternative.

>
> Why maintain a list of kvm_ap_matrix structures if we don't have to; 
> it is stored
> with the mediated matrix device which is passed in to all of the 
> vfio_ap driver
> callbacks.

Because using the vm_list which is a static in kvm makes you stick 
inside the kvm code.


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
