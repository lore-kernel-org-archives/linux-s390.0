Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726474AbfKNQds (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 11:33:48 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEGUpKS160200
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 11:33:46 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w9a5a93as-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 11:33:46 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 14 Nov 2019 16:33:44 -0000
Subject: Re: [RFC 11/37] DOCUMENTATION: protvirt: Interrupt injection
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-12-frankja@linux.ibm.com>
 <20191114140946.7bca2350.cohuck@redhat.com>
 <20191114142500.55f985b1@p-imbrenda.boeblingen.de.ibm.com>
 <20191114144738.19915998.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 14 Nov 2019 17:33:40 +0100
MIME-Version: 1.0
In-Reply-To: <20191114144738.19915998.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MBzN60MPSGru1NYgV1opQPDJwbSSjjNaG"
Message-Id: <f5c70db5-dbf7-f5eb-7968-a2887328f00b@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MBzN60MPSGru1NYgV1opQPDJwbSSjjNaG
Content-Type: multipart/mixed; boundary="Gbvy7fHyJc1OJBZWCoKPUEg5fomA2FJ45"

--Gbvy7fHyJc1OJBZWCoKPUEg5fomA2FJ45
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/14/19 2:47 PM, Cornelia Huck wrote:
> On Thu, 14 Nov 2019 14:25:00 +0100
> Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:
>=20
>> On Thu, 14 Nov 2019 14:09:46 +0100
>> Cornelia Huck <cohuck@redhat.com> wrote:
>>
>>> On Thu, 24 Oct 2019 07:40:33 -0400
>>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>>  =20
>>>> Interrupt injection has changed a lot for protected guests, as KVM
>>>> can't access the cpus' lowcores. New fields in the state
>>>> description, like the interrupt injection control, and masked
>>>> values safeguard the guest from KVM.
>>>>
>>>> Let's add some documentation to the interrupt injection basics for
>>>> protected guests.
>>>>
>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>> ---
>>>>  Documentation/virtual/kvm/s390-pv.txt | 27
>>>> +++++++++++++++++++++++++++ 1 file changed, 27 insertions(+)
>>>>
>>>> diff --git a/Documentation/virtual/kvm/s390-pv.txt
>>>> b/Documentation/virtual/kvm/s390-pv.txt index
>>>> 86ed95f36759..e09f2dc5f164 100644 ---
>>>> a/Documentation/virtual/kvm/s390-pv.txt +++
>>>> b/Documentation/virtual/kvm/s390-pv.txt @@ -21,3 +21,30 @@ normally
>>>> needed to be able to run a VM, some changes have been made in SIE
>>>> behavior and fields have different meaning for a PVM. SIE exits are
>>>> minimized as much as possible to improve speed and reduce exposed
>>>> guest state. +
>>>> +
>>>> +Interrupt injection:
>>>> +
>>>> +Interrupt injection is safeguarded by the Ultravisor and, as KVM
>>>> lost +access to the VCPUs' lowcores, is handled via the format 4
>>>> state +description.
>>>> +
>>>> +Machine check, external, IO and restart interruptions each can be
>>>> +injected on SIE entry via a bit in the interrupt injection control
>>>> +field (offset 0x54). If the guest cpu is not enabled for the
>>>> interrupt +at the time of injection, a validity interception is
>>>> recognized. The +interrupt's data is transported via parts of the
>>>> interception data +block.   =20
>>>
>>> "Data associated with the interrupt needs to be placed into the
>>> respective fields in the interception data block to be injected into
>>> the guest."
>>>
>>> ? =20
>>
>> when a normal guest intercepts an exception, depending on the exceptio=
n
>> type, the parameters are saved in the state description at specified
>> offsets, between 0xC0 amd 0xF8
>>
>> to perform interrupt injection for secure guests, the same fields are
>> used to specify the interrupt parameters that should be injected into
>> the guest
>=20
> Ok, maybe add that as well.
>=20
>>
>>>> +
>>>> +Program and Service Call exceptions have another layer of
>>>> +safeguarding, they are only injectable, when instructions have
>>>> +intercepted into KVM and such an exception can be an emulation
>>>> result.   =20
>>>
>>> I find this sentence hard to parse... not sure if I understand it
>>> correctly.
>>>
>>> "They can only be injected if the exception can be encountered during=

>>> emulation of instructions that had been intercepted into KVM." =20
>> =20
>> yes
>>
>>>  =20
>>>> +
>>>> +
>>>> +Mask notification interceptions:
>>>> +As a replacement for the lctl(g) and lpsw(e) interception, two new
>>>> +interception codes have been introduced. One which tells us that
>>>> CRs +0, 6 or 14 have been changed and therefore interrupt masking
>>>> might +have changed. And one for PSW bit 13 changes. The CRs and
>>>> the PSW in   =20
>>>
>>> Might be helpful to mention that this bit covers machine checks, whic=
h
>>> do not get a separate bit in the control block :)
>>>  =20
>>>> +the state description only contain the mask bits and no further
>>>> info +like the current instruction address.   =20
>>>
>>> "The CRs and the PSW in the state description only contain the bits
>>> referring to interrupt masking; other fields like e.g. the current
>>> instruction address are zero." =20
>>
>> wait state is saved too
>>
>> CC is write only, and is only inspected by hardware/firmware when
>> KVM/qemu is interpreting an instruction that expects a new CC to be se=
t,
>> and then only the expected CCs are allowed (e.g. if an instruction onl=
y
>> allows CC 0 or 3, 2 cannot be specified)
>=20
> So I'm wondering how much of that should go into the document... maybe
> just
>=20
> "The CRs and the PSW in the state description contain less information
> than for normal guests: most information that does not refer to
> interrupt masking is not available to the hypervisor."
>=20
> ?
>=20

I'm not liking that too much and I'm also asking myself it makes sense
to fix documentation via mails. How about an etherpad?


--Gbvy7fHyJc1OJBZWCoKPUEg5fomA2FJ45--

--MBzN60MPSGru1NYgV1opQPDJwbSSjjNaG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3NgeQACgkQ41TmuOI4
ufgQLxAAp5Vke5I27CoSNJLZs1wwmAkPdq6/SqqNHGmSGWVHtXL4nbR4UlH4u11K
6XRBml3bDM1IzWkL4CR3wOvzz/AVOgif6iS37RlnmcQ+QxMlGHWDcjCGSObFSo2t
GqZjZ6+JskzIzQYahM/joBDEHCYHPn7djUNOzTj50vOui7aaR4XyL9MBKvKvmQ5x
5JsFqNYwFQMDQCMvgUsJFEG0MKMcaYUrE5qQ01IiDRee9wF5rQtj3x4gdCN2VBzt
wRpoSg6IR6Rs85LMUVh9pBE6Ytz9npvK0dRFHIAi+7mmZGW58m/eZxu4JWzjrW+t
f58HmamnVsyW88t6nuvB8aehuex8rBtr4d5BKOZl3iWx0KUs/7Czc8/k81IfQIoU
KKmYucwk8MEZnOBxESEO/dj0iHsSTpKqjbyaNP+7FJ86hnIJZPKNa/EJgnfTG4Wv
fQ4qmXvpMFtA77nbpn/dIYnWY1A+zjB4dyrhZHE4Q604Kp9N86gnLcl4naZSxihA
wrAU7bzk9YU/NHBhhbYB8Wrk2U+j/0vqgcjzN78n2sabQ0fmi8lGlmkgAqALNwiw
4y2049ArgIMKuI25+fc+B9KyjMKmzTqtBcRmlZhBv08lqk6lhN3a1OInuH7/msp1
F7ysv1EnkUBPqddyySZB+qVPmho1QyMtCC5jelGpYZlZfRAChrY=
=9wRV
-----END PGP SIGNATURE-----

--MBzN60MPSGru1NYgV1opQPDJwbSSjjNaG--
