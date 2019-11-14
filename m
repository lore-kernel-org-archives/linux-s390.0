Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47444 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726190AbfKNK2d (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 14 Nov 2019 05:28:33 -0500
Received: by mail-wr1-f70.google.com with SMTP id 92so4150149wro.14
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 02:28:30 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 1/4] s390x: saving regs for interrupts
Date: Thu, 14 Nov 2019 11:28:28 +0100
Message-Id: <CD5636A0-3C33-4DC4-9217-68A00137E3F4@redhat.com>
References: <c7d6c21e-3746-b31a-aff9-d19549feb24c@linux.ibm.com>
In-Reply-To: <c7d6c21e-3746-b31a-aff9-d19549feb24c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com



> Am 14.11.2019 um 11:11 schrieb Pierre Morel <pmorel@linux.ibm.com>:
>=20
> =EF=BB=BF
>> On 2019-11-13 17:12, Janosch Frank wrote:
>>> On 11/13/19 1:23 PM, Pierre Morel wrote:
>>> If we use multiple source of interrupts, for exemple, using SCLP consol=
e
>>> to print information while using I/O interrupts or during exceptions, w=
e
>>> need to have a re-entrant register saving interruption handling.
>>>=20
>>> Instead of saving at a static place, let's save the base registers on
>>> the stack.
>>>=20
>>> Note that we keep the static register saving that we need for the RESET
>>> tests.
>>>=20
>>> We also care to give the handlers a pointer to the save registers in
>>> case the handler needs it (fixup_pgm_int needs the old psw address).
>> So you're still ignoring the FPRs...
>> I disassembled a test and looked at all stds and it looks like printf
>> and related functions use them. Wouldn't we overwrite test FPRs if
>> printing in a handler?
>=20
> If printf uses the FPRs in my opinion we should modify the compilation op=
tions for the library.
>=20
> What is the reason for printf and related functions to use floating point=
?
>=20

Register spilling. This can and will be done.

Cheers.

> I will have a deeper look at this.
>=20
>=20
> Regards,
>=20
> Pierre
>=20
>=20
> --=20
> Pierre Morel
> IBM Lab Boeblingen
>=20
