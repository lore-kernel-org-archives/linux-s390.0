Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39654 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726401AbfK1TsG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 28 Nov 2019 14:48:06 -0500
Received: by mail-wr1-f70.google.com with SMTP id y1so14400344wrl.0
        for <linux-s390@vger.kernel.org>; Thu, 28 Nov 2019 11:48:04 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [kvm-unit-tests PATCH v2 2/9] s390x: Define the PSW bits
Date: Thu, 28 Nov 2019 20:48:00 +0100
Message-Id: <30DD27E7-BE6E-4986-AD69-7718E6B9A730@redhat.com>
References: <7abb4725-b814-8b43-8a4f-e0e2cf7a44f8@linux.ibm.com>
In-Reply-To: <7abb4725-b814-8b43-8a4f-e0e2cf7a44f8@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, thuth@redhat.com, cohuck@redhat.com



> Am 28.11.2019 um 20:16 schrieb Pierre Morel <pmorel@linux.ibm.com>:
>=20
> =EF=BB=BF
>> On 2019-11-28 15:36, David Hildenbrand wrote:
>>> On 28.11.19 13:46, Pierre Morel wrote:
>>> Let's define the PSW bits  explicitly, it will clarify their
>>> usage.
>>>=20
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>  lib/s390x/asm/arch_bits.h | 20 ++++++++++++++++++++
>>>  lib/s390x/asm/arch_def.h  |  6 ++----
>> I'm sorry, but I don't really see a reason to move these 4/5 defines to
>> a separate header. Can you just keep them in arch_def.h and extend?
>=20
> no because arch_def.h contains C structures and inline.

(resend because the iOS Mail app does crazy html thingies)

You=E2=80=98re looking for

#ifndef __ASSEMBLER__
...

See lib/s390x/asm/sigp.h
