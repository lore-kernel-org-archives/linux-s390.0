Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23487 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726567AbgAMQGL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 13 Jan 2020 11:06:11 -0500
Subject: Re: [kvm-unit-tests PATCH v7 4/4] s390x: SCLP unit test
References: <20200110184050.191506-1-imbrenda@linux.ibm.com>
 <20200110184050.191506-5-imbrenda@linux.ibm.com>
 <8d7fb5c4-9e2c-e28a-16c0-658afcc8178d@redhat.com>
 <20200113133325.417bf657@p-imbrenda>
 <1b86b00a-261e-3d8c-fa52-c30e67463ad5@redhat.com>
 <20200113135832.1c6d3bb8@p-imbrenda>
 <22b5ce6a-18af-edec-efc6-e03450faddf8@redhat.com>
 <20200113150504.3fd218d5@p-imbrenda>
 <3db7eaf7-6020-365b-c849-9961e483352e@redhat.com>
 <20200113162439.7ae81f84@p-imbrenda>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9f0bee07-28bc-8154-3c67-402c82da8f89@redhat.com>
Date: Mon, 13 Jan 2020 17:06:05 +0100
MIME-Version: 1.0
In-Reply-To: <20200113162439.7ae81f84@p-imbrenda>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On 13.01.20 16:24, Claudio Imbrenda wrote:
> On Mon, 13 Jan 2020 15:43:28 +0100
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> On 13.01.20 15:05, Claudio Imbrenda wrote:
>>> On Mon, 13 Jan 2020 14:10:10 +0100
>>> David Hildenbrand <david@redhat.com> wrote:
>>>
>>> [...]
>>>  =20
>>>> :) I'm confused by the fact that you "expect_pgm_int()" but
>>>> actually don't expect one ...
>>>>
>>>> Please enlighten me why this isn't
>>>>
>>>> +	sclp_mark_busy();
>>>> +	h->length =3D 8;
>>>> +	sclp_setup_int();
>>>> +
>>>> +	asm volatile(
>>>> +		"       .insn   rre,0xb2204200,%1,%2\n"  /* servc
>>>> %1,%2 */
>>>> +		"       ipm     %0\n"
>>>> +		"       srl     %0,28"
>>>> +		: "=3D&d" (cc) : "d" (valid_code), "a"
>>>> (__pa(pagebuf))
>>>> +		: "cc", "memory");
>>>> +	if (!cc)
>>>> +		sclp_wait_busy();
>>>> +	report(cc =3D=3D 0, "Instruction format ignored bits");
>>>>
>>>> I feel like I am missing something important. =20
>>>
>>> because if we take an unexpected pgm interrupt:
>>> * the interrupt handler will write stuff on the console using SCLP
>>> * it will wait for the busy flag to be cleared before doing so
>>> * thus it will hang.
>>>
>>> this would be solved by adding special logic to the pgm interrupt
>>> handler (as we have discussed in your previous email)
>>>  =20
>>
>> I see, so the issue should hold for all SCLP checks where we don't
>> expect an exception ... hmmm
> =20
> which is why my wrapper in the unit test is so complicated :)
>=20

so .... if we would implement my suggestion (if we get an exception on a
servc instruction, clear sclp_busy) that code would get simplified as
well? :)

It would be really beneficial if we could rely on

expect_pgm_int()
...
check_pgm_int_code(whatever)

if we *expect an interrupt and none of that if we don't. So if it's a
matter of clearing sclp_busy on PGM exceptions, that shouldn't be too
hard ... but maybe I am missing something (haven't looked again at the
whole patch ...).

--=20
Thanks,

David / dhildenb
