From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v6 05/21] KVM: s390: CPU model support for AP
 virtualization
Date: Mon, 2 Jul 2018 11:37:11 -0400
Message-ID: <276b5ae7-7f27-faae-1e5a-0d4c084139e9@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-6-git-send-email-akrowiak@linux.vnet.ibm.com>
 <ceb1d797-9bb3-cb6e-c510-657fc61a7f82@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ceb1d797-9bb3-cb6e-c510-657fc61a7f82@de.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 07/02/2018 10:38 AM, Christian Borntraeger wrote:
>
> On 06/29/2018 11:11 PM, Tony Krowiak wrote:
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
>>     for the guest if it is not set on the host. This facility
>>     must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
>>     feature is not installed.
>>
>>     If this facility is not set for the KVM guest, then only
>>     APQNs with an APQI less than 16 will be available to the
>>     guest regardless of the guest's matrix configuration. This
>>     is a limitation of the AP bus running on the guest.
>>
>> 2. AP Facilities Test facility (APFT) is installed.
>>
>>     This is indicated by setting facilities bit 15 for
>>     the guest. The kernel will not enable this facility for
>>     the guest if it is not set on the host. This facility
>>     must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
>>     feature is not installed.
>>
>>     If this facility is not set for the KVM guest, then no
>>     AP devices will be available to the guest regardless of
>>     the guest's matrix configuration. This is a limitation
>>     of the AP bus running under the guest.
>>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> I think it probably should be at the end of the series, other than that its good.

If I move this to the end of the series, the very next patch checks the

KVM_S390_VM_CPU_FEAT_AP feature?



>   
>
>
>> ---
>>   arch/s390/include/uapi/asm/kvm.h |    1 +
>>   arch/s390/kvm/kvm-s390.c         |    8 ++++++++
>>   arch/s390/tools/gen_facilities.c |    3 +++
>>   3 files changed, 12 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
>> index 4cdaa55..a580dec 100644
>> --- a/arch/s390/include/uapi/asm/kvm.h
>> +++ b/arch/s390/include/uapi/asm/kvm.h
>> @@ -130,6 +130,7 @@ struct kvm_s390_vm_cpu_machine {
>>   #define KVM_S390_VM_CPU_FEAT_PFMFI	11
>>   #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
>>   #define KVM_S390_VM_CPU_FEAT_KSS	13
>> +#define KVM_S390_VM_CPU_FEAT_AP		14
>>   struct kvm_s390_vm_cpu_feat {
>>   	__u64 feat[16];
>>   };
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 3b7a515..d2208d4 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -40,6 +40,7 @@
>>   #include <asm/sclp.h>
>>   #include <asm/cpacf.h>
>>   #include <asm/timex.h>
>> +#include <asm/ap.h>
>>   #include "kvm-s390.h"
>>   #include "gaccess.h"
>>   
>> @@ -366,6 +367,13 @@ static void kvm_s390_cpu_feat_init(void)
>>   
>>   	if (MACHINE_HAS_ESOP)
>>   		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);
>> +
>> +	/*
>> +	 * Check if AP instructions installed on host
>> +	 */
>> +	if (ap_instructions_available() == 0)
>> +		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_AP);
>> +
>>   	/*
>>   	 * We need SIE support, ESOP (PROT_READ protection for gmap_shadow),
>>   	 * 64bit SCAO (SCA passthrough) and IDTE (for gmap_shadow unshadowing).
>> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
>> index 90a8c9e..e0e2c19 100644
>> --- a/arch/s390/tools/gen_facilities.c
>> +++ b/arch/s390/tools/gen_facilities.c
>> @@ -106,6 +106,9 @@ struct facility_def {
>>   
>>   		.name = "FACILITIES_KVM_CPUMODEL",
>>   		.bits = (int[]){
>> +			12, /* AP Query Configuration Information */
>> +			15, /* AP Facilities Test */
>>   			-1  /* END */
>>   		}
>>   	},
