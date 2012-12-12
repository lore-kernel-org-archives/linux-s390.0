From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 1/5] KVM: s390: Support for I/O interrupts.
Date: Wed, 12 Dec 2012 01:36:08 +0100
Message-ID: <7431B206-FFA2-4365-B076-D58A8E5BC68A@suse.de>
References: <1354883425-38531-1-git-send-email-cornelia.huck@de.ibm.com> <1354883425-38531-2-git-send-email-cornelia.huck@de.ibm.com> <93474DA5-C5FA-4F7F-A95E-15DFBB7C239A@suse.de> <20121210110957.01a6d3fd@BR9GNB5Z> <A3FC0CA6-45AE-46D0-A772-BCA34F128F0C@suse.de> <20121211134625.79288f0f@BR9GNB5Z>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20121211134625.79288f0f@BR9GNB5Z>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Avi Kivity <avi.kivity@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 11.12.2012, at 13:46, Cornelia Huck wrote:

> On Tue, 11 Dec 2012 11:22:04 +0100
> Alexander Graf <agraf@suse.de> wrote:
> 
>> 
>> On 10.12.2012, at 11:09, Cornelia Huck wrote:
>> 
>>> On Mon, 10 Dec 2012 08:33:10 +0100
>>> Alexander Graf <agraf@suse.de> wrote:
>>> 
>>>> 
>>>> On 07.12.2012, at 13:30, Cornelia Huck wrote:
>>>> 
>>>>> Add support for handling I/O interrupts (standard, subchannel-related
>>>>> ones and rudimentary adapter interrupts).
>>>>> 
>>>>> The subchannel-identifying parameters are encoded into the interrupt
>>>>> type.
>>>>> 
>>>>> I/O interrupts are floating, so they can't be injected on a specific
>>>>> vcpu.
>>>>> 
>>>>> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
>>>>> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>>>>> ---
>>>>> Documentation/virtual/kvm/api.txt |   4 ++
>>>>> arch/s390/include/asm/kvm_host.h  |   2 +
>>>>> arch/s390/kvm/interrupt.c         | 115 ++++++++++++++++++++++++++++++++++++--
>>>>> include/uapi/linux/kvm.h          |   6 ++
>>>>> 4 files changed, 122 insertions(+), 5 deletions(-)
>>>>> 
>>>>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>>>>> index 6671fdc..e298a72 100644
>>>>> --- a/Documentation/virtual/kvm/api.txt
>>>>> +++ b/Documentation/virtual/kvm/api.txt
>>>>> @@ -2068,6 +2068,10 @@ KVM_S390_INT_VIRTIO (vm) - virtio external interrupt; external interrupt
>>>>> KVM_S390_INT_SERVICE (vm) - sclp external interrupt; sclp parameter in parm
>>>>> KVM_S390_INT_EMERGENCY (vcpu) - sigp emergency; source cpu in parm
>>>>> KVM_S390_INT_EXTERNAL_CALL (vcpu) - sigp external call; source cpu in parm
>>>>> +KVM_S390_INT_IO(ai,cssid,ssid,schid) (vm) - compound value to indicate an
>>>>> +    I/O interrupt (ai - adapter interrupt; cssid,ssid,schid - subchannel);
>>>>> +    I/O interruption parameters in parm (subchannel) and parm64 (intparm,
>>>>> +    interruption subclass)
>>>>> 
>>>>> Note that the vcpu ioctl is asynchronous to vcpu execution.
>>>>> 
>>>>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>>>>> index b784154..e47f697 100644
>>>>> --- a/arch/s390/include/asm/kvm_host.h
>>>>> +++ b/arch/s390/include/asm/kvm_host.h
>>>>> @@ -76,6 +76,7 @@ struct kvm_s390_sie_block {
>>>>> 	__u64	epoch;			/* 0x0038 */
>>>>> 	__u8	reserved40[4];		/* 0x0040 */
>>>>> #define LCTL_CR0	0x8000
>>>>> +#define LCTL_CR6	0x0200
>>>>> 	__u16   lctl;			/* 0x0044 */
>>>>> 	__s16	icpua;			/* 0x0046 */
>>>>> 	__u32	ictl;			/* 0x0048 */
>>>>> @@ -127,6 +128,7 @@ struct kvm_vcpu_stat {
>>>>> 	u32 deliver_prefix_signal;
>>>>> 	u32 deliver_restart_signal;
>>>>> 	u32 deliver_program_int;
>>>>> +	u32 deliver_io_int;
>>>>> 	u32 exit_wait_state;
>>>>> 	u32 instruction_stidp;
>>>>> 	u32 instruction_spx;
>>>>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>>>>> index c30615e..070ba22 100644
>>>>> --- a/arch/s390/kvm/interrupt.c
>>>>> +++ b/arch/s390/kvm/interrupt.c
>>>>> @@ -21,11 +21,26 @@
>>>>> #include "gaccess.h"
>>>>> #include "trace-s390.h"
>>>>> 
>>>>> +#define IOINT_SCHID_MASK 0x0000ffff
>>>>> +#define IOINT_SSID_MASK 0x00030000
>>>>> +#define IOINT_CSSID_MASK 0x03fc0000
>>>>> +#define IOINT_AI_MASK 0x04000000
>>>>> +
>>>>> +static int is_ioint(u64 type)
>>>>> +{
>>>>> +	return ((type & 0xfffe0000u) != 0xfffe0000u);
>>>>> +}
>>>>> +
>>>>> static int psw_extint_disabled(struct kvm_vcpu *vcpu)
>>>>> {
>>>>> 	return !(vcpu->arch.sie_block->gpsw.mask & PSW_MASK_EXT);
>>>>> }
>>>>> 
>>>>> +static int psw_ioint_disabled(struct kvm_vcpu *vcpu)
>>>>> +{
>>>>> +	return !(vcpu->arch.sie_block->gpsw.mask & PSW_MASK_IO);
>>>>> +}
>>>>> +
>>>>> static int psw_interrupts_disabled(struct kvm_vcpu *vcpu)
>>>>> {
>>>>> 	if ((vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PER) ||
>>>>> @@ -68,7 +83,18 @@ static int __interrupt_is_deliverable(struct kvm_vcpu *vcpu,
>>>>> 	case KVM_S390_RESTART:
>>>>> 		return 1;
>>>>> 	default:
>>>>> -		BUG();
>>>>> +		if (is_ioint(inti->type)) {
>>>> 
>>>> Though I usually like if (...) { positive) } else { abort(); } coding style in general, it makes code quite hard to read when you are limited to 80 characters per line :)
>>>> 
>>>> I think it'd really help readability if you instead would write
>>>> 
>>>> if (!is_ioint(...)) {
>>>>   BUG();
>>>> }
>>>> 
>>>> and then continue without indent. That problem gets even more obvious further down the file.
>>> 
>>> Hm, "bad state last" seems to parse, though.
>> 
>> Fine with me. Extract the io bits into a separate function then :). Or maybe better even just use gcc switch magic:
>> 
>>  case 0x0 ... 0xfffdffff:
> 
> What, magic numbers? ;)

Well, in code it would be

   case KVM_S390_IOINT_MIN ... KVM_S390_IOINT_MAX:

I was just trying to make the point clear :).

> I'll check how this works out. Adding a #define for that range might
> even define better what INT_IO is.

Yup :)


Alex
