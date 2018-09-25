From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v10 11/26] s390: vfio-ap: implement mediated device open
 callback
Date: Tue, 25 Sep 2018 21:55:26 +0200
Message-ID: <76ee84e1-e7a7-10bf-ade1-008e48cba0ad@redhat.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-12-git-send-email-akrowiak@linux.vnet.ibm.com>
 <e1ff9918-a1ab-31b1-0b32-a3980770d2ac@linux.ibm.com>
 <09a6b9e5-e335-14cf-debd-de0f92dafd5e@redhat.com>
 <ebe81ebf-9b61-dbf6-743e-6145162cdcfb@linux.ibm.com>
 <69b5e3d3-5d44-37c0-ca10-720345852134@redhat.com>
 <df269178-b486-b091-4da4-731fc3f77e85@linux.ibm.com>
 <a59965e3-0624-65e7-f1dd-8656219dcbe2@redhat.com>
 <1a457c48-35f3-cb73-4db8-d3b50a82f211@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1a457c48-35f3-cb73-4db8-d3b50a82f211@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 25/09/2018 21:54, Tony Krowiak wrote:
> On 09/24/2018 03:55 PM, David Hildenbrand wrote:
>> On 24/09/2018 21:46, Tony Krowiak wrote:
>>> On 09/24/2018 02:40 PM, David Hildenbrand wrote:
>>>> On 24/09/2018 18:07, Tony Krowiak wrote:
>>>>> On 09/24/2018 04:40 AM, David Hildenbrand wrote:
>>>>>>
>>>>>>>      /**
>>>>>>> - * Verify that the AP instructions are available on the guest. This is
>>>>>>> indicated
>>>>>>> - * via the  KVM_S390_VM_CPU_FEAT_AP CPU model feature.
>>>>>>> + * Verify that the AP instructions are being interpreted by firmware
>>>>>>> for the
>>>>>>> + * guest. This is indicated by the kvm->arch.crypto.apie flag.
>>>>>>>       */
>>>>>>>      static int kvm_ap_validate_crypto_setup(struct kvm *kvm)
>>>>>>>      {
>>>>>>> -	if (test_bit_inv(KVM_S390_VM_CPU_FEAT_AP, kvm->arch.cpu_feat))
>>>>>>> +	if (kvm->arch.crypto.apie)
>>>>>>>      		return 0;
>>>>>>
>>>>>> I wonder if this check makes sense, because apie can be toggled during
>>>>>> runtime. I guess it would be sufficient to check if the ap control block
>>>>>> is available and apie is supported by the HW.
>>>>>
>>>>> I am not clear about what you are getting at here, but I'll attempt
>>>>> to respond. There is no need to check if the AP control block (CRYCB)
>>>>> is available as the address is set in the CRYCBD three instructions
>>>>> above, even if AP instructions are not available. Regarding whether apie
>>>>> is supported by the hardware, the value of vcpu->kvm->arch.crypto.apie
>>>>> can not be set unless it is supported by the HW. In the patch (24/26)
>>>>> that provides the VM attributes to toggle this value, it can only be
>>>>> turned on if the AP instructions are available. I might also note that
>>>>> the kvm_ap_validate_crypto_setup() function is called whenever one of
>>>>> the VM crypto attributes is changed, so it makes sense that decisions
>>>>> made in this function are based on a change to a VM crypto attribute. In
>>>>> my first pass at changing this function, I checked
>>>>> ap_instructions_available() here, but after considering all of the
>>>>> above, it made sense to me to check the apie flag.
>>>>>
>>>>
>>>> I prefer ap_instructions_available(). As I said, kvm->arch.crypto.apie
>>>> is a moving target.
>>>
>>> Looking at this again, I think I responded before my brain shifted from
>>> digesting comments about patch 24/26 (enable/disable APIE) to the
>>> context for your comment here; namely, the device open callback. My
>>> comment above makes no sense in this context. From the perspective of
>>> the vfio_ap device driver, there is one requirement that must be met in
>>> order to provide pass-through functionality: The AP instructions must be
>>> must be interpreted by the HW (i.e., ECA.28 == 1). Checking whether AP
>>> instructions are available does not tell us whether they are being
>>> interpreted by HW. Checking whether the AP control block (i.e., CRYCB)
>>> is available, even when combined with the instruction availability
>>> check, does not provide any more insight into the value of ECA.28
>>> becuase the CRYCB will be provided if the MSAX3 facility is installed
>>> (STFLE.76) for the guest regardless of whether AP instructions are
>>> available or not. There is no doubt that if the AP instructions are
>>> not available, then the mdev open callback should fail, but it doesn't
>>> tell the whole story.
>>>
>>> I realize that our CPU model protects against configuring a vfio-ap
>>> device for the guest if ap=off, but this function knows nothing about
>>> userspace. I can make a similar argument that kvm->arch.crypto.apie
>>> will be switched on only if ap=on but again, that is userspace
>>> configuration.
>>>
>>> Having said all of the above, maybe it doesn't really matter whether
>>> AP instructions are being interpreted or not. If ECA.28 == 0, then
>>> the AP masks may very well be ignored since all AP instructions will
>>> be intercepted; so, maybe checking AP instruction availability is all
>>> that is needed. I will verify this and if I'm correct, I'll make the
>>> change you suggested.
>>
>> Yes, that was exactly what I had in mind - we just have to make sure
>> that the ap control block exists, so we can set the right mask bits. If
>> QEMU asks for an intercept, it shall get an intercept.
>>
>> But please proceed with whatever you think is best!
> 
> After discussing this with Halil, here's what I decided:
> * There will be no check for kvm->arch.crypto.apie here
> * A check for ap_instructions_available() will not be executed
>    here, but inserted into the vfio_ap module init function.
>    The module init function will fail (ENODEV) if the AP
>    instructions are not installed. In my (our) opinion that
>    makes more sense given the purpose of the vfio_ap driver is
>    to pass through the AP instructions to the guest.
> * A check will be added here to verify the CRYCB is available (i.e.,
>    matrix_mdev->kvm->arch.crypto.crycbd != 0).
> 

Sounds good to me!


-- 

Thanks,

David / dhildenb
