Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31943 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728834AbfKDO3q (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 09:29:46 -0500
Subject: Re: [kvm-unit-tests PATCH v2 5/5] s390x: SCLP unit test
References: <1572023194-14370-1-git-send-email-imbrenda@linux.ibm.com>
 <1572023194-14370-6-git-send-email-imbrenda@linux.ibm.com>
 <1df14176-20a7-a9af-5622-2853425d973e@redhat.com>
 <20191104122931.0774ff7a@p-imbrenda.boeblingen.de.ibm.com>
 <56ce2fe9-1a6a-ffd6-3776-0be1b622032b@redhat.com>
 <20191104124912.7cb58664@p-imbrenda.boeblingen.de.ibm.com>
 <73d233c8-6599-ab1c-6da3-88a4fa719c82@redhat.com>
 <20191104130626.460261a1@p-imbrenda.boeblingen.de.ibm.com>
 <3a551500-102b-c80e-8b4e-9ff2c498d5df@redhat.com>
 <20191104152439.677b97ea@p-imbrenda.boeblingen.de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0732eeb8-c2b2-a7ca-28ad-cbdf4f9c1d68@redhat.com>
Date: Mon, 4 Nov 2019 15:29:30 +0100
MIME-Version: 1.0
In-Reply-To: <20191104152439.677b97ea@p-imbrenda.boeblingen.de.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On 04.11.19 15:24, Claudio Imbrenda wrote:
> On Mon, 4 Nov 2019 14:47:54 +0100
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> On 04.11.19 13:06, Claudio Imbrenda wrote:
>>> On Mon, 4 Nov 2019 12:55:48 +0100
>>> David Hildenbrand <david@redhat.com> wrote:
>>>   =20
>>>> On 04.11.19 12:49, Claudio Imbrenda wrote:
>>>>> On Mon, 4 Nov 2019 12:31:32 +0100
>>>>> David Hildenbrand <david@redhat.com> wrote:
>>>>>      =20
>>>>>> On 04.11.19 12:29, Claudio Imbrenda wrote:
>>>>>>> On Mon, 4 Nov 2019 11:58:20 +0100
>>>>>>> David Hildenbrand <david@redhat.com> wrote:
>>>>>>>
>>>>>>> [...]
>>>>>>>         =20
>>>>>>>> Can we just please rename all "cx" into something like "len"?
>>>>>>>> Or is there a real need to have "cx" in there?
>>>>>>>
>>>>>>> if cx is such a nuisance to you, sure, I can rename it to i
>>>>>>
>>>>>> better than random characters :)
>>>>>
>>>>> will be in v3
>>>>>      =20
>>>>>>>         =20
>>>>>>>> Also, I still dislike "test_one_sccb". Can't we just just do
>>>>>>>> something like
>>>>>>>>
>>>>>>>> expect_pgm_int();
>>>>>>>> rc =3D test_one_sccb(...)
>>>>>>>> report("whatever pgm", rc =3D=3D WHATEVER);
>>>>>>>> report("whatever rc", lc->pgm_int_code =3D=3D WHATEVER);
>>>>>>>>
>>>>>>>> In the callers to make these tests readable and cleanup
>>>>>>>> test_one_sccb(). I don't care if that produces more LOC as long
>>>>>>>> as I can actually read and understand the test cases.
>>>>>>>
>>>>>>> if you think that makes it more readable, ok I guess...
>>>>>>>
>>>>>>> consider that the output will be unreadable, though
>>>>>>>         =20
>>>>>>
>>>>>> I think his will turn out more readable.
>>>>>
>>>>> two output lines per SCLP call? I  don't think so
>>>>
>>>> To clarify, we don't always need two checks. E.g., I would like to
>>>> see instead of
>>>>
>>>> +static void test_sccb_too_short(void)
>>>> +{
>>>> +=09int cx;
>>>> +
>>>> +=09for (cx =3D 0; cx < 8; cx++)
>>>> +=09=09if (!test_one_run(valid_code, pagebuf, cx, 8,
>>>> PGM_BIT_SPEC, 0))
>>>> +=09=09=09break;
>>>> +
>>>> +=09report("SCCB too short", cx =3D=3D 8);
>>>> +}
>>>>
>>>> Something like
>>>>
>>>> static void test_sccb_too_short(void)
>>>> {
>>>> =09int i;
>>>>
>>>> =09for (i =3D 0; i < 8; i++) {
>>>> =09=09expect_pgm_int();
>>>> =09=09test_one_sccb(...); // or however that will be
>>>> called check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
>>>> =09}
>>>> }
>>>>
>>>> If possible.
>>>>  =20
>>>
>>> so, thousands of output lines for the whole test, ok
>>>   =20
>>
>> A couple of things to note
>>
>> a) You perform 8 checks, so report the result of 8 checks
>> b) We really don't care about the number of lines in a log file as
>> long as we can roughly identify what went wrong (e.g., push/pop a
>> prefix here) c) We really *don't* need full coverage here. The same
>> applies to other tests. Simply testing against the boundary
>> conditions is good enough.
>>
>>
>> expect_pgm_int();
>> test_one_sccb(..., 0, ...);
>> check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
>>
>> expect_pgm_int();
>> test_one_sccb(..., 7, ...);
>> check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
>>
>> Just as we handle it in other tests.
>=20
> the fact that the other test are not as extensive as they should be
> doesn't mean this test should cover less.

All I'm saying is that you might test too much and I am not sure if that=20
is really needed everywhere in this patch. But I'll leave that up to you.

--=20

Thanks,

David / dhildenb
