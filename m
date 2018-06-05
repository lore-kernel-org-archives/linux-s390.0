From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v5 11/13] KVM: s390: implement mediated device open
 callback
Date: Tue, 5 Jun 2018 14:19:53 +0200
Message-ID: <736a1346-f81a-7f71-7d13-38729ff78e4f@linux.ibm.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-12-git-send-email-akrowiak@linux.vnet.ibm.com>
 <98ea7ce2-2539-e2ff-4bb4-297e784d87bd@linux.ibm.com>
 <7bb480ac-5723-83ff-c797-53c1ab0458c1@linux.vnet.ibm.com>
 <93cd0f46-a410-51c8-00b9-810c1b3d3ae2@linux.ibm.com>
 <0f37dc39-7355-19e5-40c9-a02a1ea58c2d@linux.vnet.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0f37dc39-7355-19e5-40c9-a02a1ea58c2d@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 30/05/2018 16:33, Tony Krowiak wrote:
> On 05/24/2018 05:08 AM, Pierre Morel wrote:
>> On 23/05/2018 16:45, Tony Krowiak wrote:
>>> On 05/16/2018 04:03 AM, Pierre Morel wrote:
>>>> On 07/05/2018 17:11, Tony Krowiak wrote:
>>>>> Implements the open callback on the mediated matrix device.
>>>>> The function registers a group notifier to receive notification
>>>>> of the VFIO_GROUP_NOTIFY_SET_KVM event. When notified,
>>>>> the vfio_ap device driver will get access to the guest's
>>>>> kvm structure. With access to this structure the driver will:
>>>>>
>>>>> 1. Ensure that only one mediated device is opened for the guest
>>
>> You should explain why.
>>
>>>>>
>>>>> 2. Configure access to the AP devices for the guest.
>>>>>
>> ...snip...
>>>>> +void kvm_ap_refcount_inc(struct kvm *kvm)
>>>>> +{
>>>>> +    atomic_inc(&kvm->arch.crypto.aprefs);
>>>>> +}
>>>>> +EXPORT_SYMBOL(kvm_ap_refcount_inc);
>>>>> +
>>>>> +void kvm_ap_refcount_dec(struct kvm *kvm)
>>>>> +{
>>>>> +    atomic_dec(&kvm->arch.crypto.aprefs);
>>>>> +}
>>>>> +EXPORT_SYMBOL(kvm_ap_refcount_dec);
>>>>
>>>> Why are these functions inside kvm-ap ?
>>>> Will anyone use this outer of vfio-ap ?
>>>
>>> As I've stated before, I made the choice to contain all interfaces that
>>> access KVM in kvm-ap because I don't think it is appropriate for the 
>>> device
>>> driver to have to have "knowledge" of the inner workings of KVM. Why 
>>> does
>>> it matter whether any entity outside of the vfio_ap device driver calls
>>> these functions? I could ask a similar question if the interfaces were
>>> contained in vfio-ap; what if another device driver needs access to 
>>> these
>>> interfaces?
>>
>> This is very driver specific and only used during initialization.
>> It is not a common property of the cryptographic interface.
>>
>> I really think you should handle this inside the driver.
>
> We are going to have to agree to disagree on this one. Is it not possible
> that future drivers - e.g., when full virtualization is implemented - 
> will
> require access to KVM?

I do not think that an access to KVM is required for full virtualization.


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
