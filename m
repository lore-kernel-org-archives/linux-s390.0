Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60219 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2JGU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Apr 2020 05:06:20 -0400
Subject: Re: [PATCH v2 08/10] s390x: smp: Wait for sigp completion
References: <20200423091013.11587-1-frankja@linux.ibm.com>
 <20200423091013.11587-9-frankja@linux.ibm.com>
 <6084d368-86d6-b8fd-d4d3-5e0d72cef590@redhat.com>
 <18b6f022-81b7-6e0d-996d-3abcffceca41@linux.ibm.com>
 <be5ed01e-f4f6-6e3a-deb0-8f983e658e0f@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8182df06-8190-001d-ad02-ae13fb99ec72@redhat.com>
Date: Wed, 29 Apr 2020 11:06:12 +0200
MIME-Version: 1.0
In-Reply-To: <be5ed01e-f4f6-6e3a-deb0-8f983e658e0f@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com

On 29.04.20 10:57, Janosch Frank wrote:
> On 4/24/20 1:40 PM, Janosch Frank wrote:
>> On 4/24/20 12:11 PM, David Hildenbrand wrote:
>>> On 23.04.20 11:10, Janosch Frank wrote:
>>>> Sigp orders are not necessarily finished when the processor finished
>>>> the sigp instruction. We need to poll if the order has been finished
>>>> before we continue.
>>>>
>>>> For (re)start and stop we already use sigp sense running and sigp
>>>> sense loops. But we still lack completion checks for stop and store
>>>> status, as well as the cpu resets.
>>>>
>>>> Let's add them.
>>>>
>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>>> ---
>>>>  lib/s390x/smp.c | 8 ++++++++
>>>>  lib/s390x/smp.h | 1 +
>>>>  s390x/smp.c     | 4 ++++
>>>>  3 files changed, 13 insertions(+)
>>>>
>>>> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
>>>> index 6ef0335..2555bf4 100644
>>>> --- a/lib/s390x/smp.c
>>>> +++ b/lib/s390x/smp.c
>>>> @@ -154,6 +154,14 @@ int smp_cpu_start(uint16_t addr, struct psw psw=
)
>>>>  	return rc;
>>>>  }
>>>> =20
>>>> +void smp_cpu_wait_for_completion(uint16_t addr)
>>>> +{
>>>> +	uint32_t status;
>>>> +
>>>> +	/* Loops when cc =3D=3D 2, i.e. when the cpu is busy with a sigp o=
rder */
>>>> +	sigp_retry(1, SIGP_SENSE, 0, &status);
>>>> +}
>>>> +
>>>>  int smp_cpu_destroy(uint16_t addr)
>>>>  {
>>>>  	struct cpu *cpu;
>>>> diff --git a/lib/s390x/smp.h b/lib/s390x/smp.h
>>>> index ce63a89..a8b98c0 100644
>>>> --- a/lib/s390x/smp.h
>>>> +++ b/lib/s390x/smp.h
>>>> @@ -45,6 +45,7 @@ int smp_cpu_restart(uint16_t addr);
>>>>  int smp_cpu_start(uint16_t addr, struct psw psw);
>>>>  int smp_cpu_stop(uint16_t addr);
>>>>  int smp_cpu_stop_store_status(uint16_t addr);
>>>> +void smp_cpu_wait_for_completion(uint16_t addr);
>>>>  int smp_cpu_destroy(uint16_t addr);
>>>>  int smp_cpu_setup(uint16_t addr, struct psw psw);
>>>>  void smp_teardown(void);
>>>> diff --git a/s390x/smp.c b/s390x/smp.c
>>>> index 7462211..48321f4 100644
>>>> --- a/s390x/smp.c
>>>> +++ b/s390x/smp.c
>>>> @@ -75,6 +75,7 @@ static void test_stop_store_status(void)
>>>>  	lc->prefix_sa =3D 0;
>>>>  	lc->grs_sa[15] =3D 0;
>>>>  	smp_cpu_stop_store_status(1);
>>>> +	smp_cpu_wait_for_completion(1);
>>>>  	mb();
>>>>  	report(lc->prefix_sa =3D=3D (uint32_t)(uintptr_t)cpu->lowcore, "pr=
efix");
>>>>  	report(lc->grs_sa[15], "stack");
>>>> @@ -85,6 +86,7 @@ static void test_stop_store_status(void)
>>>>  	lc->prefix_sa =3D 0;
>>>>  	lc->grs_sa[15] =3D 0;
>>>>  	smp_cpu_stop_store_status(1);
>>>
>>> Just curious: Would it make sense to add that inside
>>> smp_cpu_stop_store_status() instead?
>>>
>>
>> I think so, we also wait for stop and start to finish, so why not for
>> this order code.
>>
>=20
> I've moved the waiting into the smp library and now the prefix check fo=
r
> stop and store status fails every so often if executed repeatedly.
>=20
> I've tried making the lc ptr volatile, a print of the prefix before the
> report seems to fix the issue, a print after the report still shows the
> issue but according to the print both values are the same.
>=20
> I'm currently at a loss...

Are you missing a barrier() somewhere?


--=20
Thanks,

David / dhildenb
