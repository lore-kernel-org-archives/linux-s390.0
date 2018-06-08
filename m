From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v5 11/13] KVM: s390: implement mediated device open
 callback
Date: Fri, 8 Jun 2018 17:59:17 -0400
Message-ID: <f1cc0d71-d2ff-6461-c450-07cc73a2973c@linux.ibm.com>
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
 <b7215f0e-6ceb-2738-4584-1af7c30bd595@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b7215f0e-6ceb-2738-4584-1af7c30bd595@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 06/07/2018 01:15 PM, Pierre Morel wrote:
>
>>>
>>>
>>> We have internal structures like the ap_matrix and kvm_ap_matrix
>>> which look like the bus/devices we had previously but are differently
>>> or not at all integrated with the LDD.
>>
>> What is LDD? Are you talking about dependencies between the vfio_ap 
>> device
>> driver and KVM? If so, see my arguments below.
>>
>>>
>>>
>>> Also I think that with a little data structure refactoring you can 
>>> avoid most of
>>> the code in the arch/s390/kvm.
>>
>> How will structure refactoring help us avoid the code for updating 
>> the CRYCB
>> in the guest's SIE state description.
>>
>>>
>>>
>>> For example, storing the kvm pointer inside the kvm_ap_matrix and
>>> maintaining a list of the kvm_ap_matrix structures allows to easily 
>>> know
>>> if a guest already has an associated mediated device.
>>
>> How is that easier than storing the kvm pointer inside of the 
>> mediated matrix
>> device (i.e., struct ap_matrix_mdev) which also contains the struct 
>> kvm_ap_matrix?
>
> you can put it in ap_matrix_mdev but just the name "kvm_ap_matrix" 
> make the
> last one a better candidate for my opinion.

It's been in ap_matrix_mdev since v2, but I'll consider moving it to 
kvm_ap_matrix.

>
>
>> How does that allow us to avoid the code in arch/s390/kvm?
>
> This alone does not.
>
>> We still need the code
>> to update the CRYCB in the SIE block. I can obviously avoid placing 
>> that code in
>> kvm-ap.c and move it to the driver, but I already explained my 
>> reasoning for
>> keeping it in KVM. Let's face it, there is no way around the 
>> dependency between
>> the vfio_ap device driver and KVM unless guest matrix configuration 
>> is managed
>> solely by KVM through KVM interfaces.
>
> We get the pointer to KVM from the VFIO interface.
> That we both discuss on this is sterile.
> The only one who could say what is right is a S390 KVM maintainer.
> This would end the discussion.
> My point was just to say that we have an alternative.
>
>
>>
>> Why maintain a list of kvm_ap_matrix structures if we don't have to; 
>> it is stored
>> with the mediated matrix device which is passed in to all of the 
>> vfio_ap driver
>> callbacks.
>
> Because using the vm_list which is a static in kvm makes you stick 
> inside the kvm code.

I understand your point here, but even if we did maintain a list of 
kvm_ap_matrix structures,
we still need the kvm code to configure the guest's CRYCB and eventually 
ECA.28. There is
also code in kvm-ap.c that is called from KVM. The idea behind kvm-ap.c 
is that all code
related to configuration of AP structures in KVM is in this one spot.

>
>
>
