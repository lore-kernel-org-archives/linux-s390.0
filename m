Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60693 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726621AbgDFJ14 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Apr 2020 05:27:56 -0400
Subject: Re: [kvm-unit-tests PATCH 04/10] s390x: smp: Test local interrupts
 after cpu reset
References: <20200324081251.28810-1-frankja@linux.ibm.com>
 <20200324081251.28810-5-frankja@linux.ibm.com>
 <b6f1d06b-aaa5-bdd5-5491-32c8338f9ead@redhat.com>
 <126883fa-6c1e-a1e3-34f0-689cd2c0b7c4@linux.ibm.com>
 <3631ad95-6920-1089-6e87-8687c9f100b6@redhat.com>
 <9c11caa4-04ff-7cc9-8f62-371d2d200048@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0971a590-500d-0b7e-3dfa-df996ee58158@redhat.com>
Date: Mon, 6 Apr 2020 11:27:49 +0200
MIME-Version: 1.0
In-Reply-To: <9c11caa4-04ff-7cc9-8f62-371d2d200048@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org

On 01.04.20 09:19, Janosch Frank wrote:
> On 3/31/20 7:27 PM, David Hildenbrand wrote:
>> On 31.03.20 11:28, Janosch Frank wrote:
>>> On 3/31/20 11:07 AM, David Hildenbrand wrote:
>>>> On 24.03.20 09:12, Janosch Frank wrote:
>>>>> Local interrupts (external and emergency call) should be cleared af=
ter
>>>>> any cpu reset.
>>>>>
>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>>> ---
>>>>>  s390x/smp.c | 22 ++++++++++++++++++++++
>>>>>  1 file changed, 22 insertions(+)
>>>>>
>>>>> diff --git a/s390x/smp.c b/s390x/smp.c
>>>>> index 8a6cd1d8b17d76c6..a8e3dd7aac0c788c 100644
>>>>> --- a/s390x/smp.c
>>>>> +++ b/s390x/smp.c
>>>>> @@ -243,6 +243,20 @@ static void test_reset_initial(void)
>>>>>  	report_prefix_pop();
>>>>>  }
>>>>> =20
>>>>> +static void test_local_ints(void)
>>>>> +{
>>>>> +	unsigned long mask;
>>>>> +
>>>>> +	expect_ext_int();
>>>>> +	/* Open masks for ecall and emcall */
>>>>> +	ctl_set_bit(0, 13);
>>>>> +	ctl_set_bit(0, 14);
>>>>> +	mask =3D extract_psw_mask();
>>>>> +	mask |=3D PSW_MASK_EXT;
>>>>> +	load_psw_mask(mask);
>>>>> +	set_flag(1);
>>>>> +}
>>>>> +
>>>>>  static void test_reset(void)
>>>>>  {
>>>>>  	struct psw psw;
>>>>> @@ -251,10 +265,18 @@ static void test_reset(void)
>>>>>  	psw.addr =3D (unsigned long)test_func;
>>>>> =20
>>>>>  	report_prefix_push("cpu reset");
>>>>> +	sigp(1, SIGP_EMERGENCY_SIGNAL, 0, NULL);
>>>>> +	sigp(1, SIGP_EXTERNAL_CALL, 0, NULL);
>>>>>  	smp_cpu_start(1, psw);
>>>>> =20
>>>>>  	sigp_retry(1, SIGP_CPU_RESET, 0, NULL);
>>>>>  	report(smp_cpu_stopped(1), "cpu stopped");
>>>>> +
>>>>> +	set_flag(0);
>>>>> +	psw.addr =3D (unsigned long)test_local_ints;
>>>>> +	smp_cpu_start(1, psw);
>>>>> +	wait_for_flag();
>>>>> +	report(true, "local interrupts cleared");
>>>>
>>>>
>>>> How can you be sure they were actually cleared/delivered?
>>>>
>>> Because cpu 1 would get a ext int it didn't expect and would do a
>>> report_abort() as pecified in lib/s390x/interrupt.c
>>
>> But what if it *didn't* get the interrupts delivered.
>=20
> Well, the target is still looping until the reset initial test is
> executed and from personal experience I can say that this test bites
> rather fast.
>=20
> We could execute an instruction with a mandatory exit which will prompt
> KVM to inject any remaining IRQs before setting the flag to 1.
>=20
> Unfortunately we do not have a polling instruction for non-IO interrupt=
s
> at the moment to verify this test.


I'd expect you should do something like this in your test instead

static void test_local_ints(void)
{
	unsigned long mask;

	/* Enable external interrupts */
	mask =3D extract_psw_mask();
	mask |=3D PSW_MASK_EXT;
	load_psw_mask(mask);

	expect_ext_int();
	/* Open masks for external call */
	ctl_set_bit(0, 13);
	if (lc->ext_int_code !=3D $TODO1)
	       return;

	expect_ext_int();
	/* Open masks for emergency call */
	ctl_set_bit(0, 14);
	if (lc->ext_int_code !=3D $TODO2)
	       return;

	set_flag(1);
}



--=20
Thanks,

David / dhildenb
