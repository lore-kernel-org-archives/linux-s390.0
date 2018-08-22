From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v9 21/22] KVM: s390: CPU model support for AP
 virtualization
Date: Wed, 22 Aug 2018 16:16:28 -0400
Message-ID: <7e7a35f5-d1eb-7719-c5e8-57d6f19db675@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <2c2c4859-ed3e-a492-dd59-78529c7768b2@redhat.com>
 <95e6ee74-69aa-9805-3233-b9ec81fce516@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <95e6ee74-69aa-9805-3233-b9ec81fce516@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 08/22/2018 07:24 AM, David Hildenbrand wrote:
> On 22.08.2018 13:19, David Hildenbrand wrote:
>> On 13.08.2018 23:48, Tony Krowiak wrote:
>>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>>
>>> Introduces a new CPU model feature and two CPU model
>>> facilities to support AP virtualization for KVM guests.
>>>
>>> CPU model feature:
>>>
>>> The KVM_S390_VM_CPU_FEAT_AP feature indicates that
>>> AP instructions are available on the guest. This
>>> feature will be enabled by the kernel only if the AP
>>> instructions are installed on the linux host. This feature
>>> must be specifically turned on for the KVM guest from
>>> userspace to use the VFIO AP device driver for guest
>>> access to AP devices.
>>>
>>> CPU model facilities:
>>>
>>> 1. AP Query Configuration Information (QCI) facility is installed.
>>>
>>>     This is indicated by setting facilities bit 12 for
>>>     the guest. The kernel will not enable this facility
>>>     for the guest if it is not set on the host.
>>>
>>>     If this facility is not set for the KVM guest, then only
>>>     APQNs with an APQI less than 16 will be used by a Linux
>>>     guest regardless of the matrix configuration for the virtual
>>>     machine. This is a limitation of the Linux AP bus.
>>>
>>> 2. AP Facilities Test facility (APFT) is installed.
>>>
>>>     This is indicated by setting facilities bit 15 for
>>>     the guest. The kernel will not enable this facility for
>>>     the guest if it is not set on the host.
>>>
>>>     If this facility is not set for the KVM guest, then no
>>>     AP devices will be available to the guest regardless of
>>>     the guest's matrix configuration for the virtual
>>>     machine. This is a limitation of the Linux AP bus.
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>   arch/s390/kvm/kvm-s390.c         |    5 +++++
>>>   arch/s390/tools/gen_facilities.c |    2 ++
>>>   2 files changed, 7 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index 1e8cb67..d5e04d2 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -367,6 +367,11 @@ static void kvm_s390_cpu_feat_init(void)
>>>   
>>>   	if (MACHINE_HAS_ESOP)
>>>   		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);
>>> +
>>> +	/* Check if AP instructions installed on host */
>>> +	if (ap_instructions_available())
>>> +		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_AP);
>>> +
>>>   	/*
>>>   	 * We need SIE support, ESOP (PROT_READ protection for gmap_shadow),
>>>   	 * 64bit SCAO (SCA passthrough) and IDTE (for gmap_shadow unshadowing).
>>> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
>>> index 90a8c9e..a52290b 100644
>>> --- a/arch/s390/tools/gen_facilities.c
>>> +++ b/arch/s390/tools/gen_facilities.c
>>> @@ -106,6 +106,8 @@ struct facility_def {
>>>   
>>>   		.name = "FACILITIES_KVM_CPUMODEL",
>>>   		.bits = (int[]){
>>> +			12, /* AP Query Configuration Information */
>>> +			15, /* AP Facilities Test */
>>>   			-1  /* END */
>>>   		}
>>>   	},
>>>
>> I really wonder if we should also export the APXA facility.
>>
>> We can probe and allow that CPU feature. However, we cannot disable it
>> (as of now).
>>
>> We have other CPU features where it is the same case (basically all
>> subfunctions). See kvm_s390_get_processor_subfunc(). We probe them and
>> export them, but support to disable them has never been implemented.
>>
>> On a high level, we could then e.g. deny to start a QEMU guest if APXA
>> is available but has been disabled. (until we know that disabling it
>> actually works - if ever).
>>
>> This helps to catch nasty migration bugs (e.g. APXA suddenly
>> disappearing). Although unlikely, definitely possible.
>>
>>
>> Are there any other AP related facilities that the guest can from now on
>> probe that should also become part of the CPU model?
>>
> To be more precise, shouldn't PQAP(QCI) be handled just like other
> subfunctions? (I remember it should)

When you suggest PQAP(QCI) be handled like other subfunctions, are you
suggesting that there should be a field in struct kvm_s390_vm_cpu_subfunc
with a bit indicating the QCI subfunction is available? The availability
of the QCI subfunction of the PQAP instruction is determined by facilities
bit 12. Is it not enough to export facilities bit 12?

>
> That would imply that there is actually theoretically a way to fake away
> certain AP facilities.
>
