From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 01/15] s390: zcrypt: externalize AP instructions
 available function
Date: Tue, 17 Apr 2018 14:14:49 -0400
Message-ID: <812e4644-6315-7ec9-6eac-17bfd3b68f20@linux.vnet.ibm.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-2-git-send-email-akrowiak@linux.vnet.ibm.com>
 <77bbd4ca-8412-e59d-e1ca-9a114cf495a6@linux.vnet.ibm.com>
 <20180416141136.04be5558.cohuck@redhat.com>
 <e2738909-bc81-4299-a25a-cb4b3cfad69c@linux.vnet.ibm.com>
 <20180417185646.5b43c911.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180417185646.5b43c911.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, freude@de.ibm.com, buendgen@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 04/17/2018 12:56 PM, Cornelia Huck wrote:
> On Tue, 17 Apr 2018 09:31:00 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> My preference would be one of the following:
>>
>> 1. All of the interfaces defined in arch/s390/include/asm/ap.h
>>      are implemented in a file that is built whether ZCRYPT is
>>      built or not.
>>
>> 2. The drivers/s390/crypto/ap_asm.h file containing the functions
>>      that execute the AP instructions are made available outside of
>>      the AP bus, for example; arch/s390/include/asm
>>
>> I requested this from the maintainer but was told we don't want to
>> have any crypto adapter support when the host AP functionality is
>> disabled (CONFIG_ZCRYPT=n). This makes sense, however; I think it is
>> a bit confusing to have a header file (arch/s390/include/asm/ap.h)
>> with interfaces that are conditionally built.
>>
>> This is why I chose the ifdeffery (as you call it) approach. The
>> only other solution I can conjure is to duplicate the asm code for
>> the AP instructions needed in KVM and bypass using the AP bus
>> interfaces.
> I think at the root of this is an unfortunate mixup in the
> architecture: The format of the crycb changes depending on some ap
> feature being installed. Providing the crycb does not have anything to
> do with ap device usage in the host, but we need to issue an ap
> instruction to get this right. [Correct me if I'm wrong; but that's
> what I get without being able to consult the actual architecture.]

That sums it up.

>
> So, exporting *all* of the interfaces is probably not needed anyway. I
> think it boils down to either "export the interfaces where a mixup
> happened, and keep the rest to zcrypt only", or "duplicate the
> instructions for kvm usage".

I only suggested exporting all of the interfaces because the others may
be needed down the road when interception is implemented for full
virtualization of AP devices.

>
> I hope we can find a solution here, as this seems to be one of the main
> discussion points :/ (FWIW, I think the basic driver interface is sane.)

I will work on coming up with something that attempts to take into 
consideration
all of the comments thus far. In the meantime, I will keep my eyes on this
space if anybody comes up with a better, concrete resolution.

>
