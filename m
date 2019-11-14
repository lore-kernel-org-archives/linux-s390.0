Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61074 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726567AbfKNP5F (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 10:57:05 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEFsTSp028236
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 10:57:04 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w974901br-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 10:57:01 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 14 Nov 2019 15:55:51 -0000
Subject: Re: [RFC 17/37] DOCUMENTATION: protvirt: Instruction emulation
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-18-frankja@linux.ibm.com>
 <20191114161526.1100f4fe.cohuck@redhat.com>
 <20191114162024.13f17aa9@p-imbrenda.boeblingen.de.ibm.com>
 <20191114164136.0be3f058.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 14 Nov 2019 16:55:46 +0100
MIME-Version: 1.0
In-Reply-To: <20191114164136.0be3f058.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7oTW1KzE7oZpXbnhSASZuIPVL0KnmW5c6"
Message-Id: <b94125ec-256c-7d7b-929e-fdbabcacb142@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7oTW1KzE7oZpXbnhSASZuIPVL0KnmW5c6
Content-Type: multipart/mixed; boundary="SFGLotJ7JEKaTdK83l8JHuGv6NCstqEFP"

--SFGLotJ7JEKaTdK83l8JHuGv6NCstqEFP
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/14/19 4:41 PM, Cornelia Huck wrote:
> On Thu, 14 Nov 2019 16:20:24 +0100
> Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:
>=20
>> On Thu, 14 Nov 2019 16:15:26 +0100
>> Cornelia Huck <cohuck@redhat.com> wrote:
>>
>>> On Thu, 24 Oct 2019 07:40:39 -0400
>>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>>  =20
>>>> As guest memory is inaccessible and information about the guest's
>>>> state is very limited, new ways for instruction emulation have been
>>>> introduced.
>>>>
>>>> With a bounce area for guest GRs and instruction data, guest state
>>>> leaks can be limited by the Ultravisor. KVM now has to move
>>>> instruction input and output through these areas.
>>>>
>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>> ---
>>>>  Documentation/virtual/kvm/s390-pv.txt | 47
>>>> +++++++++++++++++++++++++++ 1 file changed, 47 insertions(+)
>>>>
>>>> diff --git a/Documentation/virtual/kvm/s390-pv.txt
>>>> b/Documentation/virtual/kvm/s390-pv.txt index
>>>> e09f2dc5f164..cb08d78a7922 100644 ---
>>>> a/Documentation/virtual/kvm/s390-pv.txt +++
>>>> b/Documentation/virtual/kvm/s390-pv.txt @@ -48,3 +48,50 @@
>>>> interception codes have been introduced. One which tells us that
>>>> CRs have changed. And one for PSW bit 13 changes. The CRs and the
>>>> PSW in the state description only contain the mask bits and no
>>>> further info like the current instruction address. +
>>>> +
>>>> +Instruction emulation:
>>>> +With the format 4 state description the SIE instruction already    =

>>>
>>> s/description/description,/
>>>  =20
>>>> +interprets more instructions than it does with format 2. As it is
>>>> not +able to interpret all instruction, the SIE and the UV
>>>> safeguard KVM's   =20
>>>
>>> s/instruction/instructions/
>>>  =20
>>>> +emulation inputs and outputs.
>>>> +
>>>> +Guest GRs and most of the instruction data, like IO data
>>>> structures   =20
>>>
>>> Hm, what 'IO data structures'? =20
>>
>> the various IRB and ORB of I/O instructions
>=20
> Would be good to mention them as examples :)
>=20
>>
>>>> +are filtered. Instruction data is copied to and from the Secure
>>>> +Instruction Data Area. Guest GRs are put into / retrieved from the
>>>> +Interception-Data block.
>>>> +
>>>> +The Interception-Data block from the state description's offset
>>>> 0x380 +contains GRs 0 - 16. Only GR values needed to emulate an
>>>> instruction +will be copied into this area.
>>>> +
>>>> +The Interception Parameters state description field still contains
>>>> the +the bytes of the instruction text but with pre-set register
>>>> +values. I.e. each instruction always uses the same instruction
>>>> text, +to not leak guest instruction text.
>>>> +
>>>> +The Secure Instruction Data Area contains instruction storage
>>>> +data. Data for diag 500 is exempt from that and has to be moved
>>>> +through shared buffers to KVM.   =20
>>>
>>> I find this paragraph a bit confusing. What does that imply for diag
>>> 500 interception? Data is still present in gprs 1-4? =20
>>
>> no registers are leaked in the registers. registers are always only
>> exposed through the state description.
>=20
> So, what is so special about diag 500, then?

That's mostly a confusion on my side.
The SIDAD is 4k max, so we can only move IO "management" data over it
like ORBs and stuff. My intention was to point out, that the data which
is to be transferred (disk contents, etc.) can't go over the SIDAD but
needs to be in a shared page.

diag500 was mostly a notification mechanism without a lot of data, right?=


>=20
>>
>>> (Also, why only diag 500? Because it is the 'reserved for kvm'
>>> diagnose call?)
>>>  =20
>>>> +
>>>> +When SIE intercepts an instruction, it will only allow data and
>>>> +program interrupts for this instruction to be moved to the guest
>>>> via +the two data areas discussed before. Other data is ignored or
>>>> results +in validity interceptions.
>>>> +
>>>> +
>>>> +Instruction emulation interceptions:
>>>> +There are two types of SIE secure instruction intercepts. The
>>>> normal +and the notification type. Normal secure instruction
>>>> intercepts will +make the guest pending for instruction completion
>>>> of the intercepted +instruction type, i.e. on SIE entry it is
>>>> attempted to complete +emulation of the instruction with the data
>>>> provided by KVM. That might +be a program exception or instruction
>>>> completion. +
>>>> +The notification type intercepts inform KVM about guest environment=

>>>> +changes due to guest instruction interpretation. Such an
>>>> interception   =20
>>>
>>> 'interpretation by SIE' ?
>>>  =20
>>>> +is recognized for the store prefix instruction and provides the new=

>>>> +lowcore location for mapping change notification arming. Any KVM
>>>> data +in the data areas is ignored, program exceptions are not
>>>> injected and +execution continues on next SIE entry, as if no
>>>> intercept had +happened.   =20
>>>  =20
>>
>=20



--SFGLotJ7JEKaTdK83l8JHuGv6NCstqEFP--

--7oTW1KzE7oZpXbnhSASZuIPVL0KnmW5c6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3NeQMACgkQ41TmuOI4
ufjymxAAkKvX6s0mMCFk64FWdTfj9/62C/uTkTBXN7gGMnyYjYcBsyaIMbXA2OZ5
Ca7vMI4oIXHAPn08v4VNXtqgZu2vrsFCnrdnuws9mHNDdoPn9p4vl3Q8ECvVzG1m
WxtjtXKbtzUFDGvSfET3vLBJJjw1F3vtBWBLvbwyvLY24GhG8x4Zcagz9AoJhEzr
fKL4rwWyUD9RF7f525UYFUsPnoajW5korofNteYnyUxCQzuASZzC9cGTNjRw2h+a
3INbuX6nzq9hgrth9YQqhU/X0kGTQVC1A3qwc41EHtcMLXsUhm2anxBqNltsZsgy
FPe3ccMnqcecCM03IT7G3gbFlHT3ZOPs3EqS9wugFrhaRNgeEQbHbqbtOqUFjFAi
G58EpRQaJgaCVIzX44x68MapzQ0683AZZw9UEbHuegnG8w+crVqYQwIWIwZiAlFu
nIg9SWkNDmc+9wqbZvXpUAUVurBA3my3CxodL0YEvosyOF159YTVGufMUHqMefSI
dA6wjhYjZdZngg/dMzvJz9tV8L9D9RVYqttI8kZJgRUuuVPsqBUTach0RKDD43Ta
CMbzXndtoiVkuBitrUCvl7ujpj9dSlunMwJnjKb/Zfn0b6BeaEeVfTgWjXu48U2L
S4Bv6BkGyq8xbHxZuW569MSQrJvuuiUAPJ2t4u9ZPvCgGZTLDFA=
=R0AQ
-----END PGP SIGNATURE-----

--7oTW1KzE7oZpXbnhSASZuIPVL0KnmW5c6--
