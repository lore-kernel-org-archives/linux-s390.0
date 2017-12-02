From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [RFC 19/19] s390/facilities: enable AP facilities needed by guest
Date: Fri, 1 Dec 2017 20:30:19 -0500
Message-ID: <8c8c7a0e-2ae4-443b-9444-e2022436c3ee@linux.vnet.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1507916344-3896-20-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20171016112510.39e9c330@mschwideX1>
 <3e836f59-3ef1-57d8-d6df-b66011c173c4@de.ibm.com>
 <af1bb867-f9a0-458b-b7b2-c0bb9456eb7f@linux.vnet.ibm.com>
 <6d9ae0c1-6f64-1562-bf10-864cf66e3a08@de.ibm.com>
 <40cdab64-9eeb-02bd-f260-80e9da8c9034@linux.vnet.ibm.com>
 <35f17b01-49e0-eafb-ad05-c642c579dd3a@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <35f17b01-49e0-eafb-ad05-c642c579dd3a@de.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, freude@de.ibm.com, pmorel@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, heiko.carstens@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 11/03/2017 04:47 AM, Christian Borntraeger wrote:
>
> On 11/02/2017 07:49 PM, Tony Krowiak wrote:
>> On 11/02/2017 11:53 AM, Christian Borntraeger wrote:
>>> On 11/02/2017 04:36 PM, Tony Krowiak wrote:
>>>> On 11/02/2017 08:08 AM, Christian Borntraeger wrote:
>>>>> On 10/16/2017 11:25 AM, Martin Schwidefsky wrote:
>>>>>> On Fri, 13 Oct 2017 13:39:04 -0400
>>>>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>>>>
>>>>>>> Sets up the following facilities bits to enable the specified AP
>>>>>>> facilities for the guest VM:
>>>>>>>       * STFLE.12: Enables the AP Query Configuration Information
>>>>>>>                   facility. The AP bus running in the guest uses
>>>>>>>                   the information returned from this instruction
>>>>>>>                   to configure AP adapters and domains for the
>>>>>>>                   guest machine.
>>>>>>>       * STFLE.15: Indicates the AP facilities test is available.
>>>>>>>                   The AP bus running in the guest uses the
>>>>>>>                   information.
>>>>>>>
>>>>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>>>>>> ---
>>>>>>>    arch/s390/tools/gen_facilities.c |    2 ++
>>>>>>>    1 files changed, 2 insertions(+), 0 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
>>>>>>> index 70dd8f1..eeaa7db 100644
>>>>>>> --- a/arch/s390/tools/gen_facilities.c
>>>>>>> +++ b/arch/s390/tools/gen_facilities.c
>>>>>>> @@ -74,8 +74,10 @@ struct facility_def {
>>>>>>>                8,  /* enhanced-DAT 1 */
>>>>>>>                9,  /* sense-running-status */
>>>>>>>                10, /* conditional sske */
>>>>>>> +            12, /* AP query configuration */
>>>>>>>                13, /* ipte-range */
>>>>>>>                14, /* nonquiescing key-setting */
>>>>>>> +            15, /* AP special-command facility */
>>>>>>>                73, /* transactional execution */
>>>>>>>                75, /* access-exception-fetch/store indication */
>>>>>>>                76, /* msa extension 3 */
>>>>>> With this all KVM guests will always have the AP instructions available, no?
>>>>>> In principles I like this approach, but it differs from the way z/VM does things,
>>>>>> there the guest will get an exception if it tries to execute an AP instruction
>>>>>> if there are no AP devices assigned to the guest. I wonder if there is a reason
>>>>>> why z/VM does it the way it does.
>>>>> A good question. For LPAR it seems that you have AP instructions even if you have
>>>>> no crypto cards.
>>>>>
>>>> I don't believe these facilities control whether or not AP instructions will be available
>>>>
>>>> to the guest.
>>> This is actually handled by your patch2 enabling the ECA bit.
>>> I think we must decide if we want to be able to disable these instructions
>>> via the cpu model. If yes we must then couple the facilities with the enablement.
>> The ECA.28 bit controls whether instructions are intercepted or interpreted - i.e., handled via hardware
>> virtualization. If set, as is done in patch2, then instructions will be interpreted. I don't see how
>> that affects enabling or disabling AP instructions, unless we don't set ECA.28, intercept every instruction
>> and program check. Am I missing something here?
> If we do not set ECA.28 these instructions intercept and we (the hypervisor) can then
> decide what to do. For example we can give an PIC01 operation exception (illegal
> instruction) - thats what we do today.
>
> Now: if we want to be able to migrate a guest from a new kernel back to an old kernel,
> there must be a way to disable the new behaviour so that the user can configure a guest
> that does NOT have these 3 instructions. That means, I want to bind the ap instruction
> to a cpu model feature, so that we only enable ECA.28 and the facility bits, if the
> feature is enabled in the CPU model. Otherwise we have no control on what happens
> when the guest issues these instructions.
>
> Imagine what happens if we not do this and you migrate from an identical hw with an
> identical libvirt/qemu but from a new kernel to an old kernel:
>
> The guest boots starts up on the new kernel
> guest kernel: drivers/s390/crypto/ap_bus.c  ap_module_init -> ap_instructions_available
> checks if the instructions work. They do and now the guest driver assumes that all
> instructions will continue to work.
>
> Now the guest is migrated back to an old kernel
> sooner or later the ap_scan_bus kthread will run to scan the bus (or some crypto operation
> is started) and the instruction will be rejected with a PIC01. kernel oops.
There are several scenarios that have to be accounted for, such as:
* Migrating from a linux host where both the KVM/kernel and QEMU support 
AP matrix
   devices to a guest host where neither the KVM/kernel nor QEMU support 
AP matrix
   devices;
* Migrating from a linux host where both the KVM/kernel and QEMU support 
AP matrix
   devices to a guest host where the KVM/kernel does not support AP 
matrix devices
   but QEMU does;
* Starting a guest on a linux host where QEMU supports AP matrix devices 
and
   the KVM/kernel does not;
* etc.

I agree with your suggestion that defining a new CPU model feature is 
probably
the best way to resolve this issue. The question is, should we define a 
single
feature indicating whether AP instructions are installed and set 
features bits
for the guest based on whether or not they are set in the linux host, or 
should
we define additional CPU model features for turning features bits on and 
off?
I guess it boils down to what behavior is expected for the AP bus 
running on
the linux guest. Here is a rundown of the facilities bits associated 
with AP
and how they affect the behavior of the AP bus:

* STFLE.12 indicates whether the AP query function is available. If this 
bit
   is not set, then the AP bus scan will only test domains 0-15. For 
example,
   if adapters 4, 5, and 6 and domains 12 and 71 (0x47) are installed, 
then AP
   queues 04.0047, 05.0047 and 06.0047 will not be made available.

* STFLE.15 indicates whether the AP facilities test function is 
available. If
   this bit is not set, then the CEX4, CEX5 and CEX6 device drivers 
discovered
   by the AP bus scan will not get bound to any AP device drivers. Since 
the
   AP matrix model supports only CEX4 and greater, no devices will be bound
   to any driver for a guest.

* STFLE.65 indicates whether AP interrupts are available. If this bit is not
   set, then the AP bus will use polling instead of using interrupt handlers
   to process AP events.

If the AP bus running on the guest is expected to mimic the behavior of an
AP bus running on the host, then I think we need a CPU model feature for 
each
facility. Otherwise, I think we can group them within a CPU model feature
that indicates AP matrix devices are supported. What say you?
>
>
