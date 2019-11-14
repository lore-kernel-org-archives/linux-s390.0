Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55666 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726115AbfKNML0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 14 Nov 2019 07:11:26 -0500
Subject: Re: [PATCH v1 1/4] s390x: saving regs for interrupts
References: <c7d6c21e-3746-b31a-aff9-d19549feb24c@linux.ibm.com>
 <CD5636A0-3C33-4DC4-9217-68A00137E3F4@redhat.com>
 <ef5cc0aa-d1fe-874f-8f61-863c793a23d4@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b88be625-26b1-9780-fde4-000e3065bdaf@redhat.com>
Date: Thu, 14 Nov 2019 13:11:18 +0100
MIME-Version: 1.0
In-Reply-To: <ef5cc0aa-d1fe-874f-8f61-863c793a23d4@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com

On 14.11.19 12:57, Pierre Morel wrote:
>=20
> On 2019-11-14 11:28, David Hildenbrand wrote:
>>
>>> Am 14.11.2019 um 11:11 schrieb Pierre Morel <pmorel@linux.ibm.com>:
>>>
>>> =EF=BB=BF
>>>> On 2019-11-13 17:12, Janosch Frank wrote:
>>>>> On 11/13/19 1:23 PM, Pierre Morel wrote:
>>>>> If we use multiple source of interrupts, for exemple, using SCLP cons=
ole
>>>>> to print information while using I/O interrupts or during exceptions,=
 we
>>>>> need to have a re-entrant register saving interruption handling.
>>>>>
>>>>> Instead of saving at a static place, let's save the base registers on
>>>>> the stack.
>>>>>
>>>>> Note that we keep the static register saving that we need for the RES=
ET
>>>>> tests.
>>>>>
>>>>> We also care to give the handlers a pointer to the save registers in
>>>>> case the handler needs it (fixup_pgm_int needs the old psw address).
>>>> So you're still ignoring the FPRs...
>>>> I disassembled a test and looked at all stds and it looks like printf
>>>> and related functions use them. Wouldn't we overwrite test FPRs if
>>>> printing in a handler?
>>> If printf uses the FPRs in my opinion we should modify the compilation =
options for the library.
>>>
>>> What is the reason for printf and related functions to use floating poi=
nt?
>>>
>> Register spilling. This can and will be done.
>=20
>=20
> Hum, can you please clarify?
>=20
> AFAIK register spilling is for a compiler, to use memory if it has not
> enough registers.

Not strictly memory. If the compiler needs more GPRS, it can=20
save/restore GPRS to FPRS.

Any function the compiler generates is free to use the FPRS..

>=20
> So your answer is for the my first sentence, meaning yes register
> spilling will be done
> or
> do you mean register spilling is the reason why the compiler use FPRs
> and it must be done so?

Confused by both options :D The compiler might generate code that uses=20
the FPRS although no floating point instructions are in use. That's why=20
we have to enable the AFP control and properly take care of FPRS being used=
.


--=20

Thanks,

David / dhildenb
