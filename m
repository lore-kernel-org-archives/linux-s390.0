Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49298 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726524AbfKEOTF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Nov 2019 09:19:05 -0500
Subject: Re: [RFC 19/37] KVM: s390: protvirt: Add new gprs location handling
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-20-frankja@linux.ibm.com>
 <2eba24a5-063d-1e93-acf0-1153963facfe@redhat.com>
 <8f7a9da4-2a49-9e3f-573e-199cd71fc99c@de.ibm.com>
 <1588a5e9-9bd9-428d-5b05-114a9307ceee@linux.ibm.com>
 <658457c3-398b-7dde-2c6d-073e4d3feac8@redhat.com>
 <6a013d0c-e056-05e4-f9e4-276a0d57b51c@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3426936a-7a7a-82af-41b2-63095aab5aba@redhat.com>
Date: Tue, 5 Nov 2019 15:18:57 +0100
MIME-Version: 1.0
In-Reply-To: <6a013d0c-e056-05e4-f9e4-276a0d57b51c@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 05.11.19 15:11, Janosch Frank wrote:
> On 11/5/19 2:55 PM, David Hildenbrand wrote:
>> On 05.11.19 13:39, Janosch Frank wrote:
>>> On 11/5/19 1:01 PM, Christian Borntraeger wrote:
>>>>
>>>>
>>>> On 04.11.19 12:25, David Hildenbrand wrote:
>>>>> On 24.10.19 13:40, Janosch Frank wrote:
>>>>>> Guest registers for protected guests are stored at offset 0x380.
>>>>>>
>>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>>>> ---
>>>>>>   =C2=A0 arch/s390/include/asm/kvm_host.h |=C2=A0 4 +++-
>>>>>>   =C2=A0 arch/s390/kvm/kvm-s390.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 11 +++++++++++
>>>>>>   =C2=A0 2 files changed, 14 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/as=
m/kvm_host.h
>>>>>> index 0ab309b7bf4c..5deabf9734d9 100644
>>>>>> --- a/arch/s390/include/asm/kvm_host.h
>>>>>> +++ b/arch/s390/include/asm/kvm_host.h
>>>>>> @@ -336,7 +336,9 @@ struct kvm_s390_itdb {
>>>>>>   =C2=A0 struct sie_page {
>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_s390_sie_block sie_block=
;
>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mcck_volatile_info mcck_info=
;=C2=A0=C2=A0=C2=A0 /* 0x0200 */
>>>>>> -=C2=A0=C2=A0=C2=A0 __u8 reserved218[1000];=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* 0x0218 */
>>>>>> +=C2=A0=C2=A0=C2=A0 __u8 reserved218[360];=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* 0x0218 */
>>>>>> +=C2=A0=C2=A0=C2=A0 __u64 pv_grregs[16];=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* 0x380 */
>>>>>> +=C2=A0=C2=A0=C2=A0 __u8 reserved400[512];
>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_s390_itdb itdb;=C2=A0=C2=
=A0=C2=A0 /* 0x0600 */
>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8 reserved700[2304];=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x0700 */
>>>>>>   =C2=A0 };
>>>>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>>>>> index 490fde080107..97d3a81e5074 100644
>>>>>> --- a/arch/s390/kvm/kvm-s390.c
>>>>>> +++ b/arch/s390/kvm/kvm-s390.c
>>>>>> @@ -3965,6 +3965,7 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu=
, int exit_reason)
>>>>>>   =C2=A0 static int __vcpu_run(struct kvm_vcpu *vcpu)
>>>>>>   =C2=A0 {
>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int rc, exit_reason;
>>>>>> +=C2=A0=C2=A0=C2=A0 struct sie_page *sie_page =3D (struct sie_page *=
)vcpu->arch.sie_block;
>>>>>>   =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We try to hold kvm->srcu du=
ring most of vcpu_run (except when run-
>>>>>> @@ -3986,8 +3987,18 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guest_enter=
_irqoff();
>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __disable_c=
pu_timer_accounting(vcpu);
>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 local_irq_e=
nable();
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kvm_s390_pv_is_prote=
cted(vcpu->kvm)) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
memcpy(sie_page->pv_grregs,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vcpu->run->s.regs.gprs,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(sie_page->pv_grregs));
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit_reason=
 =3D sie64a(vcpu->arch.sie_block,
>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vcpu->ru=
n->s.regs.gprs);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kvm_s390_pv_is_prote=
cted(vcpu->kvm)) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
memcpy(vcpu->run->s.regs.gprs,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sie_page->pv_grregs,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(sie_page->pv_grregs));
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>> sie64a will load/save gprs 0-13 from to vcpu->run->s.regs.gprs.
>>>>>
>>>>> I would have assume that this is not required for prot virt, because =
the HW has direct access via the sie block?
>>>>
>>>> Yes, that is correct. The load/save in sie64a is not necessary for pv =
guests.
>>>>
>>>>>
>>>>>
>>>>> 1. Would it make sense to have a specialized sie64a() (or a parameter=
, e.g., if you pass in NULL in r3), that optimizes this loading/saving? Eve=
ntually we can also optimize which host registers to save/restore then.
>>>>
>>>> Having 2 kinds of sie64a seems not very nice for just saving a small n=
umber of cycles.
>>>>
>>>>>
>>>>> 2. Avoid this copying here. We have to store the state to vcpu->run->=
s.regs.gprs when returning to user space and restore the state when coming =
from user space.
>>>>
>>>> I like this proposal better than the first one and
>>
>> It was actually an additional proposal :)
>>
>> 1. avoids unnecessary saving/loading/saving/restoring
>> 2. avoids the two memcpy
>>
>>>>>
>>>>> Also, we access the GPRS from interception handlers, there we might u=
se wrappers like
>>>>>
>>>>> kvm_s390_set_gprs()
>>>>> kvm_s390_get_gprs()
>>>>
>>>> having register accessors might be useful anyway.
>>>> But I would like to defer that to a later point in time to keep the ch=
anges in here
>>>> minimal?
>>>>
>>>> We can add a "TODO" comment in here so that we do not forget about thi=
s
>>>> for a future patch. Makes sense?
>>
>> While it makes sense, I guess one could come up with a patch for 2. in
>> less than 30 minutes ... but yeah, whatever you prefer. ;)
>>
>=20
> Just to get it fully right we'd need to:
> a. Synchronize registers into/from vcpu run in sync_regs/store_regs
> b. Sprinkle get/set_gpr(int nr) over most of the files in arch/s390/kvm
>=20
> That's your proposal?

Yes. Patch 1, factor out gprs access. Patch 2, avoid the memcpy by=20
fixing the gprs access functions and removing the memcpys. (both as=20
addons to this patch)

I guess that should be it ... but maybe we'll stumble over surprises :)

--=20

Thanks,

David / dhildenb
