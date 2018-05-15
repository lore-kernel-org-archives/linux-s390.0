From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 06/13] KVM: s390: interfaces to manage guest's AP
 matrix
Date: Tue, 15 May 2018 12:07:52 -0400
Message-ID: <a9206728-2673-c8de-851b-323027a398fa@linux.vnet.ibm.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-7-git-send-email-akrowiak@linux.vnet.ibm.com>
 <f2646170-1aaf-8447-4c02-0679909d754f@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f2646170-1aaf-8447-4c02-0679909d754f@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 05/15/2018 10:55 AM, Pierre Morel wrote:
> On 07/05/2018 17:11, Tony Krowiak wrote:
>> Provides interfaces to manage the AP adapters, usage domains
>> and control domains assigned to a KVM guest.
>>
>> The guest's SIE state description has a satellite structure called the
>> Crypto Control Block (CRYCB) containing three bitmask fields
>> identifying the adapters, queues (domains) and control domains
>> assigned to the KVM guest:
>>
>> * The AP Adapter Mask (APM) field identifies the AP adapters assigned to
>>    the KVM guest
>>
>> * The AP Queue Mask (AQM) field identifies the AP queues assigned to
>>    the KVM guest. Each AP queue is connected to a usage domain within
>>    an AP adapter.
>>
>> * The AP Domain Mask (ADM) field identifies the control domains
>>    assigned to the KVM guest.
>>
>> Each adapter, queue (usage domain) and control domain are identified by
>> a number from 0 to 255. The bits in each mask, from most significant to
>> least significant bit, correspond to the numbers 0-255. When a bit is
>> set, the corresponding adapter, queue (usage domain) or control domain
>> is assigned to the KVM guest.
>>
>> This patch will set the bits in the APM, AQM and ADM fields of the
>> CRYCB referenced by the KVM guest's SIE state description. The process
>> used is:
>>
>> 1. Verify that the bits to be set do not exceed the maximum bit
>>     number for the given mask.
>>
>> 2. Verify that the APQNs that can be derived from the cross product
>>     of the bits set in the APM and AQM fields of the KVM guest's CRYCB
>>     are not assigned to any other KVM guest running on the same linux
>>     host.
>>
>> 3. Set the APM, AQM and ADM in the CRYCB according to the matrix
>>     configured for the mediated matrix device via its sysfs
>>     assign_adapter, assign_domain and assign_control domain attribute
>>     files respectively.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm-ap.h   |   52 ++++++++++++
>>   arch/s390/include/asm/kvm_host.h |    1 +
>>   arch/s390/kvm/kvm-ap.c           |  161 
>> ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 214 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm-ap.h 
>> b/arch/s390/include/asm/kvm-ap.h
>> index 6af1ff8..21fe9f2 100644
>> --- a/arch/s390/include/asm/kvm-ap.h
>> +++ b/arch/s390/include/asm/kvm-ap.h
>> @@ -12,8 +12,33 @@
>>
>>   #include <linux/types.h>
>>   #include <linux/kvm_host.h>
>> +#include <linux/bitops.h>
>>   #include <asm/ap.h>
>>
>> +#define KVM_AP_MASK_BYTES(n)    DIV_ROUND_UP(n, BITS_PER_BYTE)
>> +
>> +/**
>> + * The AP matrix is comprised of three bit masks identifying the 
>> adapters,
>> + * queues (domains) and control domains that belong to an AP matrix. 
>> The bits in
>> + * each mask, from least significant to most significant bit, 
>> correspond to IDs
>> + * 0 to 255. When a bit is set, the corresponding ID belongs to the 
>> matrix.
>> + *
>> + * @apm identifies the AP adapters in the matrix
>> + * @apm_max: max adapter number in @apm
>> + * @aqm identifies the AP queues (domains) in the matrix
>> + * @aqm_max: max domain number in @aqm
>> + * @adm identifies the AP control domains in the matrix
>> + * @adm_max: max domain number in @adm
>> + */
>> +struct kvm_ap_matrix {
>> +    unsigned long apm_max;
>> +    DECLARE_BITMAP(apm, 256);
>> +    unsigned long aqm_max;
>> +    DECLARE_BITMAP(aqm, 256);
>> +    unsigned long adm_max;
>> +    DECLARE_BITMAP(adm, 256);
>
> Just a possible performance impact:
> you may have interest to put all bitmaps first to take adventage
> of quadword handling (If bitmaps use it) and put unsigned longs
> at the end.

The DECLARE_BITMAP macros declare the first operand as an
array of unsigned long, so each of the fields falls on a
natural alignment boundary which I believe means the
structure or any of its fields require only one memory
access. I don't see how use of this structure will cause
performance impacts. Even if that were the case, the impact
would be negligible and completely unnoticeable by a human
IMHO. I prefer to keep the related fields together.

>
>
>> +};
>> +
>>   /**
>>    * kvm_ap_apxa_installed
>>    *
>> @@ -57,4 +82,31 @@
>>    */
>>   bool kvm_ap_instructions_available(void);
>>
>> +/**
>> + * kvm_ap_configure_matrix
>> + *
>> + * Configure the AP matrix for a KVM guest.
>> + *
>> + * @kvm:         the KVM guest
>> + * @matrix:         the matrix configuration information
>> + *
>> + * Returns 0 if:
>> + *    1. The AP instructions are installed on the guest
>> + *    2. The APQNs derived from the intersection of the set of adapter
>> + *       IDs (APM) and queue indexes (AQM) in @matrix are not 
>> configured for
>> + *       any other KVM guest running on the same linux host.
>> + * Otherwise returns an error code.
>> + */
>> +int kvm_ap_configure_matrix(struct kvm *kvm, struct kvm_ap_matrix 
>> *matrix);
>> +
>> +/**
>> + * kvm_ap_deconfigure_matrix
>> + *
>> + * Deconfigure the AP matrix for a KVM guest. Clears all of the bits 
>> in the
>> + * APM, AQM and ADM in the guest's CRYCB.
>> + *
>> + * @kvm: the KVM guest
>> + */
>> +void kvm_ap_deconfigure_matrix(struct kvm *kvm);
>> +
>>   #endif /* _ASM_KVM_AP */
>> diff --git a/arch/s390/include/asm/kvm_host.h 
>> b/arch/s390/include/asm/kvm_host.h
>> index ef4b237..8736cde 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -257,6 +257,7 @@ struct kvm_s390_sie_block {
>>       __u64    tecmc;            /* 0x00e8 */
>>       __u8    reservedf0[12];        /* 0x00f0 */
>>   #define CRYCB_FORMAT_MASK 0x00000003
>> +#define CRYCB_FORMAT0 0x00000000
>>   #define CRYCB_FORMAT1 0x00000001
>>   #define CRYCB_FORMAT2 0x00000003
>>       __u32    crycbd;            /* 0x00fc */
>> diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
>> index 00bcfb0..98b53c7 100644
>> --- a/arch/s390/kvm/kvm-ap.c
>> +++ b/arch/s390/kvm/kvm-ap.c
>> @@ -7,6 +7,7 @@
>>    * Author(s): Tony Krowiak <akrowia@linux.vnet.ibm.com>
>>    */
>>   #include <linux/kernel.h>
>> +#include <linux/bitops.h>
>>   #include <asm/kvm-ap.h>
>>
>>   #include "kvm-s390.h"
>> @@ -81,3 +82,163 @@ int kvm_ap_apxa_installed(void)
>>       return 0;
>>   }
>>   EXPORT_SYMBOL(kvm_ap_apxa_installed);
>> +
>> +static inline void kvm_ap_clear_crycb_masks(struct kvm *kvm)
>> +{
>> +    memset(&kvm->arch.crypto.crycb->apcb0, 0,
>> +           sizeof(kvm->arch.crypto.crycb->apcb0));
>
> Here you prefer to set both structure to 0 instead of testing which
> structure to erase.

The function performs the task described by its name ... it clears the
CRYCB masks (plural). This function will most likely be called only
once when the CRYCB masks are configured. I see no good reason to
change this.

>
>
>> + memset(&kvm->arch.crypto.crycb->apcb1, 0,
>> +           sizeof(kvm->arch.crypto.crycb->apcb1));
>> +}
>> +
>
> ...snip...
>
>> +/**
>> + * kvm_ap_validate_queue_sharing
>> + *
>> + * Verifies that the APQNs derived from the cross product of the AP 
>> adapter IDs
>> + * and AP queue indexes comprising the AP matrix are not configured for
>> + * another guest. AP queue sharing is not allowed.
>> + *
>> + * @kvm: the KVM guest
>> + * @matrix: the AP matrix
>> + *
>> + * Returns 0 if the APQNs are valid, otherwise; returns -EBUSY.
>> + */
>> +static int kvm_ap_validate_queue_sharing(struct kvm *kvm,
>> +                     struct kvm_ap_matrix *matrix)
>> +{
>> +    struct kvm *vm;
>> +    unsigned long *apm, *aqm;
>> +    unsigned long apid, apqi;
>> +
>> +
>> +    /* No other VM may share an AP Queue with the input VM */
>> +    list_for_each_entry(vm, &vm_list, vm_list) {
>> +        if (kvm == vm)
>> +            continue;
>> +
>> +        apm = kvm_ap_get_crycb_apm(vm);
>> +        if (!bitmap_and(apm, apm, matrix->apm, matrix->apm_max + 1))
>> +            continue;
>> +
>> +        aqm = kvm_ap_get_crycb_aqm(vm);
>> +        if (!bitmap_and(aqm, aqm, matrix->aqm, matrix->aqm_max + 1))
>> +            continue;
>> +
>> +        for_each_set_bit_inv(apid, apm, matrix->apm_max + 1)
>> +            for_each_set_bit_inv(apqi, aqm, matrix->aqm_max + 1)
>> +                kvm_ap_log_sharing_err(vm, apid, apqi);
>> +
>> +        return -EBUSY;
>> +    }
>> +
>> +    return 0;
>> +}
>
> This function (ap_validate_queue_sharing) only verifies that VM don't 
> share queues.
> What about the queues used by a host application?

How can that be verified from this function? I suppose I could put a 
check in here to
verify that the queues are reserved by the vfio_ap device driver, but 
that would
be redundant because an AP queue can not be assigned to a mediated 
matrix device
via its sysfs attributes unless it is reserved by the vfio_ap device 
driver (see
patches 7, 8 and 9).

>
>
> I understand that you want to implement  these checks within KVM but 
> this is
> related to which queue devices are bound to the matrix and which one 
> are not.

See my comments above and below about AP queue assignment to the 
mediated matrix
device. The one verification we can't do when the devices are assigned 
is whether
another guest is using the queue because assignment occurs before the 
guest using
the queue is started in which case we have no access to KVM. It makes no 
sense to
do so at assignment time anyway because it doesn't matter until the 
guest using
the mediated matrix device is started, so that check is done in KVM.

>
>
> I think that this should be related somehow to the bounded queue 
> devices and
> therefor implemented inside the matrix driver.

As I stated above, when an AP queue is assigned to the mediated matrix 
device via
its sysfs attributes, a check is done to verify that it is bound to the 
vfio_ap
device driver (see patches 7, 8 and 9). If not, then assignment will be 
rejected;
therefore, it will not be possible to configure a CRYCB with AP queues 
that are
not bound to the device driver.

>
>
> Regards,
>
> Pierre
>
