From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 01/15] s390: zcrypt: externalize AP instructions
 available function
Date: Tue, 17 Apr 2018 09:31:00 -0400
Message-ID: <e2738909-bc81-4299-a25a-cb4b3cfad69c@linux.vnet.ibm.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-2-git-send-email-akrowiak@linux.vnet.ibm.com>
 <77bbd4ca-8412-e59d-e1ca-9a114cf495a6@linux.vnet.ibm.com>
 <20180416141136.04be5558.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180416141136.04be5558.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, freude@de.ibm.com, buendgen@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 04/16/2018 08:11 AM, Cornelia Huck wrote:
> On Mon, 16 Apr 2018 10:44:53 +0200
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>
>> On 15/04/2018 23:22, Tony Krowiak wrote:
>>> If the AP instructions are not available on the linux host, then
>>> AP devices can not be interpreted by the SIE. The AP bus has a
>>> function it uses to determine if the AP instructions are
>>> available. This patch provides a new function that wraps the
>>> AP bus's function to externalize it for use by KVM.
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>>> Reviewed-by: Harald Freudenberger <freude@linux.vnet.ibm.com>
>>> ---
>>>    arch/s390/include/asm/ap.h     |    7 +++++++
>>>    arch/s390/include/asm/kvm-ap.h |   23 +++++++++++++++++++++++
>>>    arch/s390/kvm/Makefile         |    2 +-
>>>    arch/s390/kvm/kvm-ap.c         |   21 +++++++++++++++++++++
>>>    drivers/s390/crypto/ap_bus.c   |    6 ++++++
>>>    5 files changed, 58 insertions(+), 1 deletions(-)
>>>    create mode 100644 arch/s390/include/asm/kvm-ap.h
>>>    create mode 100644 arch/s390/kvm/kvm-ap.c
>>> diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
>>> new file mode 100644
>>> index 0000000..1267588
>>> --- /dev/null
>>> +++ b/arch/s390/kvm/kvm-ap.c
>>> @@ -0,0 +1,21 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Adjunct Processor (AP) configuration management for KVM guests
>>> + *
>>> + * Copyright IBM Corp. 2018
>>> + *
>>> + * Author(s): Tony Krowiak <akrowia@linux.vnet.ibm.com>
>>> + */
>>> +#include <linux/kernel.h>
>>> +#include <asm/kvm-ap.h>
>>> +#include <asm/ap.h>
>>> +
>>> +int kvm_ap_instructions_installed(void)
>>> +{
>>> +#ifdef CONFIG_ZCRYPT
>> I did not give my R-B for this.
>> please change it or suppress my R-B
>>
>> I think you should review the way you wrap functions
>> calling the AP interface.
>> Having all of them together would simplify code and review.
> I don't like the ifdeffery either (especially as there's more later).

I'm not crazy about it myself (see below)

>
> Consolidating all functions for querying basic ap capabilities sounds
> like a good idea. What about collecting them in a ap-util file and
> either always building it or selecting it from both zcrypt and kvm?

My preference would be one of the following:

1. All of the interfaces defined in arch/s390/include/asm/ap.h
    are implemented in a file that is built whether ZCRYPT is
    built or not.

2. The drivers/s390/crypto/ap_asm.h file containing the functions
    that execute the AP instructions are made available outside of
    the AP bus, for example; arch/s390/include/asm

I requested this from the maintainer but was told we don't want to
have any crypto adapter support when the host AP functionality is
disabled (CONFIG_ZCRYPT=n). This makes sense, however; I think it is
a bit confusing to have a header file (arch/s390/include/asm/ap.h)
with interfaces that are conditionally built.

This is why I chose the ifdeffery (as you call it) approach. The
only other solution I can conjure is to duplicate the asm code for
the AP instructions needed in KVM and bypass using the AP bus
interfaces.

>
>>> +	return ap_instructions_installed();
>>> +#else
>>> +	return 0;
>>> +#endif
>>> +}
>>> +EXPORT_SYMBOL(kvm_ap_instructions_installed);
>>> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
>>> index 35a0c2b..9d108b6 100644
>>> --- a/drivers/s390/crypto/ap_bus.c
>>> +++ b/drivers/s390/crypto/ap_bus.c
>>> @@ -210,6 +210,12 @@ int ap_query_configuration(struct ap_config_info *info)
>>>    }
>>>    EXPORT_SYMBOL(ap_query_configuration);
>>>
>>> +int ap_instructions_installed(void)
>>> +{
>>> +	return (ap_instructions_available() == 0);
>>> +}
>>> +EXPORT_SYMBOL(ap_instructions_installed);
>>> +
>>>    /**
>>>     * ap_init_configuration(): Allocate and query configuration array.
>>>     */
>>
