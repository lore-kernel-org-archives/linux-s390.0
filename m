From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC 19/19] s390/facilities: enable AP facilities needed by guest
Date: Fri, 3 Nov 2017 09:47:43 +0100
Message-ID: <35f17b01-49e0-eafb-ad05-c642c579dd3a@de.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1507916344-3896-20-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20171016112510.39e9c330@mschwideX1>
 <3e836f59-3ef1-57d8-d6df-b66011c173c4@de.ibm.com>
 <af1bb867-f9a0-458b-b7b2-c0bb9456eb7f@linux.vnet.ibm.com>
 <6d9ae0c1-6f64-1562-bf10-864cf66e3a08@de.ibm.com>
 <40cdab64-9eeb-02bd-f260-80e9da8c9034@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <40cdab64-9eeb-02bd-f260-80e9da8c9034@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, freude@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, heiko.carstens@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 11/02/2017 07:49 PM, Tony Krowiak wrote:
> On 11/02/2017 11:53 AM, Christian Borntraeger wrote:
>>
>> On 11/02/2017 04:36 PM, Tony Krowiak wrote:
>>> On 11/02/2017 08:08 AM, Christian Borntraeger wrote:
>>>> On 10/16/2017 11:25 AM, Martin Schwidefsky wrote:
>>>>> On Fri, 13 Oct 2017 13:39:04 -0400
>>>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>>>
>>>>>> Sets up the following facilities bits to enable the specified AP
>>>>>> facilities for the guest VM:
>>>>>>      * STFLE.12: Enables the AP Query Configuration Information
>>>>>>                  facility. The AP bus running in the guest uses
>>>>>>                  the information returned from this instruction
>>>>>>                  to configure AP adapters and domains for the
>>>>>>                  guest machine.
>>>>>>      * STFLE.15: Indicates the AP facilities test is available.
>>>>>>                  The AP bus running in the guest uses the
>>>>>>                  information.
>>>>>>
>>>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>>>>> ---
>>>>>>   arch/s390/tools/gen_facilities.c |    2 ++
>>>>>>   1 files changed, 2 insertions(+), 0 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
>>>>>> index 70dd8f1..eeaa7db 100644
>>>>>> --- a/arch/s390/tools/gen_facilities.c
>>>>>> +++ b/arch/s390/tools/gen_facilities.c
>>>>>> @@ -74,8 +74,10 @@ struct facility_def {
>>>>>>               8,  /* enhanced-DAT 1 */
>>>>>>               9,  /* sense-running-status */
>>>>>>               10, /* conditional sske */
>>>>>> +            12, /* AP query configuration */
>>>>>>               13, /* ipte-range */
>>>>>>               14, /* nonquiescing key-setting */
>>>>>> +            15, /* AP special-command facility */
>>>>>>               73, /* transactional execution */
>>>>>>               75, /* access-exception-fetch/store indication */
>>>>>>               76, /* msa extension 3 */
>>>>> With this all KVM guests will always have the AP instructions available, no?
>>>>> In principles I like this approach, but it differs from the way z/VM does things,
>>>>> there the guest will get an exception if it tries to execute an AP instruction
>>>>> if there are no AP devices assigned to the guest. I wonder if there is a reason
>>>>> why z/VM does it the way it does.
>>>> A good question. For LPAR it seems that you have AP instructions even if you have
>>>> no crypto cards.
>>>>
>>> I don't believe these facilities control whether or not AP instructions will be available
>>>
>>> to the guest.
>> This is actually handled by your patch2 enabling the ECA bit.
>> I think we must decide if we want to be able to disable these instructions
>> via the cpu model. If yes we must then couple the facilities with the enablement.
> The ECA.28 bit controls whether instructions are intercepted or interpreted - i.e., handled via hardware
> virtualization. If set, as is done in patch2, then instructions will be interpreted. I don't see how
> that affects enabling or disabling AP instructions, unless we don't set ECA.28, intercept every instruction
> and program check. Am I missing something here?

If we do not set ECA.28 these instructions intercept and we (the hypervisor) can then
decide what to do. For example we can give an PIC01 operation exception (illegal
instruction) - thats what we do today.

Now: if we want to be able to migrate a guest from a new kernel back to an old kernel,
there must be a way to disable the new behaviour so that the user can configure a guest
that does NOT have these 3 instructions. That means, I want to bind the ap instruction
to a cpu model feature, so that we only enable ECA.28 and the facility bits, if the
feature is enabled in the CPU model. Otherwise we have no control on what happens
when the guest issues these instructions.

Imagine what happens if we not do this and you migrate from an identical hw with an
identical libvirt/qemu but from a new kernel to an old kernel:

The guest boots starts up on the new kernel
guest kernel: drivers/s390/crypto/ap_bus.c  ap_module_init -> ap_instructions_available
checks if the instructions work. They do and now the guest driver assumes that all
instructions will continue to work.

Now the guest is migrated back to an old kernel
sooner or later the ap_scan_bus kthread will run to scan the bus (or some crypto operation
is started) and the instruction will be rejected with a PIC01. kernel oops.
