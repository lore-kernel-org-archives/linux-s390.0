From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v10 25/26] KVM: s390: CPU model support for AP
 virtualization
Date: Mon, 24 Sep 2018 10:33:36 +0200
Message-ID: <78df86b6-55f9-f67c-d96a-9c287c0248cd@redhat.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-26-git-send-email-akrowiak@linux.vnet.ibm.com>
 <7868874f-df81-5602-a4c5-a4b58c38d1d3@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7868874f-df81-5602-a4c5-a4b58c38d1d3@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 22/09/2018 01:31, Tony Krowiak wrote:
> On 09/12/2018 03:43 PM, Tony Krowiak wrote:
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Introduces a new CPU model feature and two CPU model
>> facilities to support AP virtualization for KVM guests.
>>
>> CPU model feature:
>>
>> The KVM_S390_VM_CPU_FEAT_AP feature indicates that
>> AP instructions are available on the guest. This
>> feature will be enabled by the kernel only if the AP
>> instructions are installed on the linux host. This feature
>> must be specifically turned on for the KVM guest from
>> userspace to use the VFIO AP device driver for guest
>> access to AP devices.
>>
>> CPU model facilities:
>>
>> 1. AP Query Configuration Information (QCI) facility is installed.
>>
>>     This is indicated by setting facilities bit 12 for
>>     the guest. The kernel will not enable this facility
>>     for the guest if it is not set on the host.
>>
>>     If this facility is not set for the KVM guest, then only
>>     APQNs with an APQI less than 16 will be used by a Linux
>>     guest regardless of the matrix configuration for the virtual
>>     machine. This is a limitation of the Linux AP bus.
>>
>> 2. AP Facilities Test facility (APFT) is installed.
>>
>>     This is indicated by setting facilities bit 15 for
>>     the guest. The kernel will not enable this facility for
>>     the guest if it is not set on the host.
>>
>>     If this facility is not set for the KVM guest, then no
>>     AP devices will be available to the guest regardless of
>>     the guest's matrix configuration for the virtual
>>     machine. This is a limitation of the Linux AP bus.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   arch/s390/kvm/kvm-s390.c         |    5 +++++
>>   arch/s390/tools/gen_facilities.c |    2 ++
>>   2 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 286c2e0..f0b8e2a 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -371,6 +371,11 @@ static void kvm_s390_cpu_feat_init(void)
>>   
>>   	if (MACHINE_HAS_ESOP)
>>   		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);
>> +
>> +	/* Check if AP instructions installed on host */
>> +	if (ap_instructions_available())
>> +		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_AP);
>> +
>>   	/*
>>   	 * We need SIE support, ESOP (PROT_READ protection for gmap_shadow),
>>   	 * 64bit SCAO (SCA passthrough) and IDTE (for gmap_shadow unshadowing).
>> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
>> index 0c85aed..fd788e0 100644
>> --- a/arch/s390/tools/gen_facilities.c
>> +++ b/arch/s390/tools/gen_facilities.c
>> @@ -106,6 +106,8 @@ struct facility_def {
>>   
>>   		.name = "FACILITIES_KVM_CPUMODEL",
>>   		.bits = (int[]){
>> +			12, /* AP Query Configuration Information */
>> +			15, /* AP Facilities Test */
>>   			156, /* etoken facility */
>>   			-1  /* END */
>>   		}
>>
> 
> The fixup! patch below modifies this patch (25/26) to illustrate how
> David's recommendation will be implemented for v11 of the series. It
> is one of three fixup! patches (the other two are in responses to
> 03/26 and 11/26) included to generate discussion in v10 rather than
> waiting until v11 for comments.
> 
> -----------------------------------8<-----------------------------------
> 
> From: Tony Krowiak <akrowiak@linux.ibm.com>
> Date: Thu, 20 Sep 2018 13:28:07 -0400
> Subject: [FIXUP v10] fixup!: KVM: s390: CPU model support for AP 
> virtualization
> 
> ---
>   arch/s390/kvm/kvm-s390.c |    4 ----
>   1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index a3a7cd9..ff38251 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -372,10 +372,6 @@ static void kvm_s390_cpu_feat_init(void)
>   	if (MACHINE_HAS_ESOP)
>   		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);
> 
> -	/* Check if AP instructions installed on host */
> -	if (ap_instructions_available())
> -		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_AP);
> -
>   	/*
>   	 * We need SIE support, ESOP (PROT_READ protection for gmap_shadow),
>   	 * 64bit SCAO (SCA passthrough) and IDTE (for gmap_shadow unshadowing).
> 

Yes, looks sane.

-- 

Thanks,

David / dhildenb
