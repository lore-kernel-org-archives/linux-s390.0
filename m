From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 01/14] KVM: s390: refactor crypto initialization
Date: Thu, 15 Mar 2018 10:48:02 -0400
Message-ID: <d0b44d6e-8b98-f8ca-7cf5-dfcdf38c79f6@linux.vnet.ibm.com>
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1521051954-25715-2-git-send-email-akrowiak@linux.vnet.ibm.com>
 <f87a6adb-8982-c194-7925-0c88060ebef2@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f87a6adb-8982-c194-7925-0c88060ebef2@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 03/15/2018 08:26 AM, Pierre Morel wrote:
> On 14/03/2018 19:25, Tony Krowiak wrote:
>> This patch refactors the code that initializes the crypto
>> configuration for a guest. The crypto configuration is contained in
>> a crypto control block (CRYCB) which is a satellite control block to
>> our main hardware virtualization control block. The CRYCB is
>> attached to the main virtualization control block via a CRYCB
>> designation (CRYCBD) designation field containing the address of
>> the CRYCB as well as its format.
>>
>> Prior to the introduction of AP device virtualization, there was
>> no need to provide access to or specify the format of the CRYCB for
>> a guest unless the MSA extension 3 (MSAX3) facility was installed
>> on the host system. With the introduction of AP device virtualization,
>> the CRYCB and its format must be made accessible to the guest
>> regardless of the presence of the MSAX3 facility.
>>
>> The crypto initialization code is restructured as follows:
>>
>> * A new compilation unit is introduced to contain all interfaces
>>    and data structures related to configuring a guest's CRYCB for
>>    both the refactoring of crypto initialization as well as all
>>    subsequent patches introducing AP virtualization support.
>>
>> * Currently, the asm code for querying the AP configuration is
>>    duplicated in the AP bus as well as in KVM. Since the KVM
>>    code was introduced, the AP bus has externalized the interface
>>    for querying the AP configuration. The KVM interface will be
>>    replaced with a call to the AP bus interface. Of course, this
>>    will be moved to the new compilation unit mentioned above.
>>
>> * An interface to format the CRYCBD field will be provided via
>>    the new compilation unit and called from the KVM vm
>>    initialization.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>   MAINTAINERS                      |   10 ++++++
>>   arch/s390/include/asm/kvm-ap.h   |   16 ++++++++++
>>   arch/s390/include/asm/kvm_host.h |    1 +
>>   arch/s390/kvm/Kconfig            |    1 +
>>   arch/s390/kvm/Makefile           |    2 +-
>>   arch/s390/kvm/kvm-ap.c           |   48 +++++++++++++++++++++++++++++
>>   arch/s390/kvm/kvm-s390.c         |   61 
>> ++++---------------------------------
>>   7 files changed, 84 insertions(+), 55 deletions(-)
>>   create mode 100644 arch/s390/include/asm/kvm-ap.h
>>   create mode 100644 arch/s390/kvm/kvm-ap.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0ec5881..72742d5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -11875,6 +11875,16 @@ W: 
>> http://www.ibm.com/developerworks/linux/linux390/
>>   S:    Supported
>>   F:    drivers/s390/crypto/
>>
>> +S390 VFIO AP DRIVER
>> +M:    Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> +M:    Christian Borntraeger <borntraeger@de.ibm.com>
>> +M:    Martin Schwidefsky <schwidefsky@de.ibm.com>
>> +L:    linux-s390@vger.kernel.org
>> +W:    http://www.ibm.com/developerworks/linux/linux390/
>> +S:    Supported
>> +F:    arch/s390/include/asm/kvm/kvm-ap.h
>> +F:    arch/s390/kvm/kvm-ap.c
>> +
>>   S390 ZFCP DRIVER
>>   M:    Steffen Maier <maier@linux.vnet.ibm.com>
>>   M:    Benjamin Block <bblock@linux.vnet.ibm.com>
>> diff --git a/arch/s390/include/asm/kvm-ap.h 
>> b/arch/s390/include/asm/kvm-ap.h
>> new file mode 100644
>> index 0000000..362846c
>> --- /dev/null
>> +++ b/arch/s390/include/asm/kvm-ap.h
>> @@ -0,0 +1,16 @@
>> +/*
>> + * Adjunct Processor (AP) configuration management for KVM guests
>> + *
>> + * Copyright IBM Corp. 2017
>> + *
>> + * Author(s): Tony Krowiak <akrowia@linux.vnet.ibm.com>
>> + */
>> +
>> +#ifndef _ASM_KVM_AP
>> +#define _ASM_KVM_AP
>> +#include <linux/types.h>
>> +#include <linux/kvm_host.h>
>> +
>> +void kvm_ap_build_crycbd(struct kvm *kvm);
>> +
>> +#endif /* _ASM_KVM_AP */
>> diff --git a/arch/s390/include/asm/kvm_host.h 
>> b/arch/s390/include/asm/kvm_host.h
>> index 34c9b5b..65a944e 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -257,6 +257,7 @@ struct kvm_s390_sie_block {
>>       __u8    reservedf0[12];        /* 0x00f0 */
>>   #define CRYCB_FORMAT1 0x00000001
>>   #define CRYCB_FORMAT2 0x00000003
>> +#define CRYCB_FORMAT_MASK 0x00000003
>>       __u32    crycbd;            /* 0x00fc */
>>       __u64    gcr[16];        /* 0x0100 */
>>       __u64    gbea;            /* 0x0180 */
>> diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
>> index a3dbd45..4ca9077 100644
>> --- a/arch/s390/kvm/Kconfig
>> +++ b/arch/s390/kvm/Kconfig
>> @@ -33,6 +33,7 @@ config KVM
>>       select HAVE_KVM_INVALID_WAKEUPS
>>       select SRCU
>>       select KVM_VFIO
>> +    select ZCRYPT
>
> I do not think it is a good solution to *always* enable ZCRYPT
> when we have KVM.
If CONFIG_ZCRYPT is not selected, then the kvm_ap_apxa_installed() 
function will not compile
because it calls a zcrypt interface. How would you suggest we make sure 
zcrypt interfaces
used in KVM are built if CONFIG_ZCRYPT is not selected?
>
> Pierre
>
>
