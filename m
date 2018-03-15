From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 04/14] KVM: s390: device attribute to set AP
 interpretive execution
Date: Thu, 15 Mar 2018 17:00:03 +0100
Message-ID: <1e8a4cfc-1425-b30e-2875-2a5c5d9bcb7c@linux.vnet.ibm.com>
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1521051954-25715-5-git-send-email-akrowiak@linux.vnet.ibm.com>
 <d86ad01e-1c79-c14c-b4da-09d9a31572bd@linux.vnet.ibm.com>
 <3afd28d7-57c6-cda6-a436-18da32ef0df3@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3afd28d7-57c6-cda6-a436-18da32ef0df3@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 15/03/2018 16:23, Tony Krowiak wrote:
> On 03/14/2018 05:57 PM, Halil Pasic wrote:
>>
>> On 03/14/2018 07:25 PM, Tony Krowiak wrote:
>>> The VFIO AP device model exploits interpretive execution of AP
>>> instructions (APIE) to provide guests passthrough access to AP
>>> devices. This patch introduces a new device attribute in the
>>> KVM_S390_VM_CRYPTO device attribute group to set APIE from
>>> the VFIO AP device defined on the guest.
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>> ---
>> [..]
>>
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index a60c45b..bc46b67 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -815,6 +815,19 @@ static int kvm_s390_vm_set_crypto(struct kvm 
>>> *kvm, struct kvm_device_attr *attr)
>>> sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
>>>           VM_EVENT(kvm, 3, "%s", "DISABLE: DEA keywrapping support");
>>>           break;
>>> +    case KVM_S390_VM_CRYPTO_INTERPRET_AP:
>>> +        if (attr->addr) {
>>> +            if (!test_kvm_cpu_feat(kvm, KVM_S390_VM_CPU_FEAT_AP))
>> Unlock mutex before returning?
> The mutex is unlocked prior to return at the end of the function.
>>
>> Maybe flip conditions (don't allow manipulating apie if feature not 
>> there).
>> Clearing the anyways clear apie if feature not there ain't too bad, but
>> rejecting the operation appears nicer to me.
> I think what you're saying is something like this:
>
>     if (!test_kvm_cpu_feat(kvm, KVM_S390_VM_CPU_FEAT_AP))
>         return -EOPNOTSUPP;
>
>     kvm->arch.crypto.apie = (attr->addr) ? 1 : 0;
>
> I can make arguments for doing this either way, but since the attribute
> is will most likely only be set by an AP device in userspace, I suppose
> it makes sense to allow setting of the attribute if the AP feature is
> installed. It certainly makes sense for the dedicated implementation.
>>
>>> +                return -EOPNOTSUPP;

Obviously Halil is speaking on this return statement.
Which returns without unlocking the mutex.



-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
