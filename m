Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35611 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726366AbgD2J4I (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Apr 2020 05:56:08 -0400
Subject: Re: [PATCH v2 08/10] s390x: smp: Wait for sigp completion
References: <20200423091013.11587-1-frankja@linux.ibm.com>
 <20200423091013.11587-9-frankja@linux.ibm.com>
 <6084d368-86d6-b8fd-d4d3-5e0d72cef590@redhat.com>
 <18b6f022-81b7-6e0d-996d-3abcffceca41@linux.ibm.com>
 <be5ed01e-f4f6-6e3a-deb0-8f983e658e0f@linux.ibm.com>
 <8182df06-8190-001d-ad02-ae13fb99ec72@redhat.com>
 <802601e1-0bc0-faba-b802-2b0e24e3d96b@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5ef08433-10fd-ccca-eb13-5a93bd462c4c@redhat.com>
Date: Wed, 29 Apr 2020 11:55:59 +0200
MIME-Version: 1.0
In-Reply-To: <802601e1-0bc0-faba-b802-2b0e24e3d96b@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com

On 29.04.20 11:37, Janosch Frank wrote:
> On 4/29/20 11:06 AM, David Hildenbrand wrote:
>> On 29.04.20 10:57, Janosch Frank wrote:
>>> On 4/24/20 1:40 PM, Janosch Frank wrote:
>>>> On 4/24/20 12:11 PM, David Hildenbrand wrote:
>>>>> On 23.04.20 11:10, Janosch Frank wrote:
>>>>>> Sigp orders are not necessarily finished when the processor finish=
ed
>>>>>> the sigp instruction. We need to poll if the order has been finish=
ed
>>>>>> before we continue.
>>>>>>
>>>>>> For (re)start and stop we already use sigp sense running and sigp
>>>>>> sense loops. But we still lack completion checks for stop and stor=
e
>>>>>> status, as well as the cpu resets.
>>>>>>
>>>>>> Let's add them.
>>>>>>
>>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>>>>> ---
>>>>>>  lib/s390x/smp.c | 8 ++++++++
>>>>>>  lib/s390x/smp.h | 1 +
>>>>>>  s390x/smp.c     | 4 ++++
>>>>>>  3 files changed, 13 insertions(+)
>>>>>>
>>>>>> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
>>>>>> index 6ef0335..2555bf4 100644
>>>>>> --- a/lib/s390x/smp.c
>>>>>> +++ b/lib/s390x/smp.c
>>>>>> @@ -154,6 +154,14 @@ int smp_cpu_start(uint16_t addr, struct psw p=
sw)
>>>>>>  	return rc;
>>>>>>  }
>>>>>> =20
>>>>>> +void smp_cpu_wait_for_completion(uint16_t addr)
>>>>>> +{
>>>>>> +	uint32_t status;
>>>>>> +
>>>>>> +	/* Loops when cc =3D=3D 2, i.e. when the cpu is busy with a sigp=
 order */
>>>>>> +	sigp_retry(1, SIGP_SENSE, 0, &status);
>>>>>> +}
>>>>>> +
>>>>>>  int smp_cpu_destroy(uint16_t addr)
>>>>>>  {
>>>>>>  	struct cpu *cpu;
>>>>>> diff --git a/lib/s390x/smp.h b/lib/s390x/smp.h
>>>>>> index ce63a89..a8b98c0 100644
>>>>>> --- a/lib/s390x/smp.h
>>>>>> +++ b/lib/s390x/smp.h
>>>>>> @@ -45,6 +45,7 @@ int smp_cpu_restart(uint16_t addr);
>>>>>>  int smp_cpu_start(uint16_t addr, struct psw psw);
>>>>>>  int smp_cpu_stop(uint16_t addr);
>>>>>>  int smp_cpu_stop_store_status(uint16_t addr);
>>>>>> +void smp_cpu_wait_for_completion(uint16_t addr);
>>>>>>  int smp_cpu_destroy(uint16_t addr);
>>>>>>  int smp_cpu_setup(uint16_t addr, struct psw psw);
>>>>>>  void smp_teardown(void);
>>>>>> diff --git a/s390x/smp.c b/s390x/smp.c
>>>>>> index 7462211..48321f4 100644
>>>>>> --- a/s390x/smp.c
>>>>>> +++ b/s390x/smp.c
>>>>>> @@ -75,6 +75,7 @@ static void test_stop_store_status(void)
>>>>>>  	lc->prefix_sa =3D 0;
>>>>>>  	lc->grs_sa[15] =3D 0;
>>>>>>  	smp_cpu_stop_store_status(1);
>>>>>> +	smp_cpu_wait_for_completion(1);
>>>>>>  	mb();
>>>>>>  	report(lc->prefix_sa =3D=3D (uint32_t)(uintptr_t)cpu->lowcore, "=
prefix");
>>>>>>  	report(lc->grs_sa[15], "stack");
>>>>>> @@ -85,6 +86,7 @@ static void test_stop_store_status(void)
>>>>>>  	lc->prefix_sa =3D 0;
>>>>>>  	lc->grs_sa[15] =3D 0;
>>>>>>  	smp_cpu_stop_store_status(1);
>>>>>
>>>>> Just curious: Would it make sense to add that inside
>>>>> smp_cpu_stop_store_status() instead?
>>>>>
>>>>
>>>> I think so, we also wait for stop and start to finish, so why not fo=
r
>>>> this order code.
>>>>
>>>
>>> I've moved the waiting into the smp library and now the prefix check =
for
>>> stop and store status fails every so often if executed repeatedly.
>>>
>>> I've tried making the lc ptr volatile, a print of the prefix before t=
he
>>> report seems to fix the issue, a print after the report still shows t=
he
>>> issue but according to the print both values are the same.
>>>
>>> I'm currently at a loss...
>>
>> Are you missing a barrier() somewhere?
>>
>=20
> Maybe, but the question is where?
>=20
> There's already one before the report:
> smp_cpu_stop_store_status(1);
> mb();
> report(lc->prefix_sa =3D=3D (uint32_t)(uintptr_t)cpu->lowcore, "prefix"=
);

The issue here is:

SIGP_SENSE is always handled in the kernel for KVM. Meaning, it will
complete even before the target CPU executed the stop and store (in QEMU)=
.

Reading the PoP:

"One of the following conditions exists at the
addressed CPU: ... A previously issued stop-
and-store-status ... has been accepted by the
addressed CPU, and execution of the func-
tion requested by the order has not yet been
completed.

"If the currently specified order is sense ... then the order
is rejected, and condition code 2 is set."

So, in case of KVM, SENSE does not wait for completion of the previous
order. I remember that was a performance improvements, because we wanted
to avoid going to user space just to sense if another CPU is running.
(and I remember that the documentation was inconsistent)

Let me guess, under TCG it works all the time?

--=20
Thanks,

David / dhildenb
