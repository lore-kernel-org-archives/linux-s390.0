From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 04/14] KVM: s390: device attribute to set AP
 interpretive execution
Date: Thu, 15 Mar 2018 14:00:26 +0100
Message-ID: <21bd029b-3500-3461-ce98-68ad3ae9b647@linux.vnet.ibm.com>
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1521051954-25715-5-git-send-email-akrowiak@linux.vnet.ibm.com>
 <d86ad01e-1c79-c14c-b4da-09d9a31572bd@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d86ad01e-1c79-c14c-b4da-09d9a31572bd@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 14/03/2018 22:57, Halil Pasic wrote:
>
> On 03/14/2018 07:25 PM, Tony Krowiak wrote:
>> The VFIO AP device model exploits interpretive execution of AP
>> instructions (APIE) to provide guests passthrough access to AP
>> devices. This patch introduces a new device attribute in the
>> KVM_S390_VM_CRYPTO device attribute group to set APIE from
>> the VFIO AP device defined on the guest.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
> [..]
>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index a60c45b..bc46b67 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -815,6 +815,19 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
>>   			sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
>>   		VM_EVENT(kvm, 3, "%s", "DISABLE: DEA keywrapping support");
>>   		break;
>> +	case KVM_S390_VM_CRYPTO_INTERPRET_AP:
>> +		if (attr->addr) {
>> +			if (!test_kvm_cpu_feat(kvm, KVM_S390_VM_CPU_FEAT_AP))
> Unlock mutex before returning?
>
> Maybe flip conditions (don't allow manipulating apie if feature not there).
> Clearing the anyways clear apie if feature not there ain't too bad, but
> rejecting the operation appears nicer to me.
>
>> +				return -EOPNOTSUPP;
>> +			kvm->arch.crypto.apie = 1;
>> +			VM_EVENT(kvm, 3, "%s",
>> +				 "ENABLE: AP interpretive execution");
>> +		} else {
>> +			kvm->arch.crypto.apie = 0;
>> +			VM_EVENT(kvm, 3, "%s",
>> +				 "DISABLE: AP interpretive execution");
>> +		}
>> +		break;
>>   	default:
>>   		mutex_unlock(&kvm->lock);
>>   		return -ENXIO;
> I wonder how the loop after this switch works for KVM_S390_VM_CRYPTO_INTERPRET_AP:
>
>          kvm_for_each_vcpu(i, vcpu, kvm) {
>                  kvm_s390_vcpu_crypto_setup(vcpu);
>                  exit_sie(vcpu);
>          }
>
>  From not doing something like for KVM_S390_VM_CRYPTO_INTERPRET_AP
>
>          if (kvm->created_vcpus) {
>                  mutex_unlock(&kvm->lock);
>                  return -EBUSY;
> and from the aforementioned loop I guess ECA.28 can be changed
> for a running guest.
>
> If there are running vcpus when KVM_S390_VM_CRYPTO_INTERPRET_AP is
> changed (set) these will be taken out of SIE by exit_sie().  Then for the
> corresponding threads the control probably goes to QEMU (the emulator in
> the userspace). And it puts that vcpu back into the SIE, and then that
> cpu starts acting according to the new ECA.28 value.  While other vcpus
> may still work with the old value of ECA.28.
>
> I'm not saying what I describe above is necessarily something broken.
> But I would like to have it explained, why is it OK -- provided I did not
> make any errors in my reasoning (assumptions included).
>
> Can you help me understand this code?
>
> Regards,
> Halil
>
> [..]
>

I have the same concerns as Halil.

We do not need to change the virtulization type
(hardware/software) on the fly for the current use case.

Couldn't we delay this until we have one and in between only make the 
vCPU hotplug clean?

We only need to let the door open for the day we have such a use case.

Pierre



-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
