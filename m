Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725997AbfKLOtM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Nov 2019 09:49:12 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACEmuw5087590
        for <linux-s390@vger.kernel.org>; Tue, 12 Nov 2019 09:49:11 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w7vxjw1q9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 12 Nov 2019 09:49:08 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 12 Nov 2019 14:47:24 -0000
Subject: Re: [RFC 02/37] s390/protvirt: introduce host side setup
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-3-frankja@linux.ibm.com>
 <41fb411d-68b5-96be-fc0e-c88570df9d19@de.ibm.com>
 <20191104152603.76f50c60.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 12 Nov 2019 15:47:19 +0100
MIME-Version: 1.0
In-Reply-To: <20191104152603.76f50c60.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oZUDBCwfom9G0Dcpf96XYJ4Jpkc2BjkKx"
Message-Id: <fb5837ee-0868-85df-fe61-381484162f47@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oZUDBCwfom9G0Dcpf96XYJ4Jpkc2BjkKx
Content-Type: multipart/mixed; boundary="En3MMsjz1gQRzn0mEizSQkXYAY1vUmNKZ"

--En3MMsjz1gQRzn0mEizSQkXYAY1vUmNKZ
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/4/19 3:26 PM, Cornelia Huck wrote:
> On Fri, 1 Nov 2019 09:53:12 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>=20
>> On 24.10.19 13:40, Janosch Frank wrote:
>>> From: Vasily Gorbik <gor@linux.ibm.com>
>>>
>>> Introduce KVM_S390_PROTECTED_VIRTUALIZATION_HOST kbuild option for
>>> protected virtual machines hosting support code.
>>>
>>> Add "prot_virt" command line option which controls if the kernel
>>> protected VMs support is enabled at runtime.
>>>
>>> Extend ultravisor info definitions and expose it via uv_info struct
>>> filled in during startup.
>>>
>>> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
>>> ---
>>>  .../admin-guide/kernel-parameters.txt         |  5 ++
>>>  arch/s390/boot/Makefile                       |  2 +-
>>>  arch/s390/boot/uv.c                           | 20 +++++++-
>>>  arch/s390/include/asm/uv.h                    | 46 ++++++++++++++++-=
-
>>>  arch/s390/kernel/Makefile                     |  1 +
>>>  arch/s390/kernel/setup.c                      |  4 --
>>>  arch/s390/kernel/uv.c                         | 48 +++++++++++++++++=
++
>>>  arch/s390/kvm/Kconfig                         |  9 ++++
>>>  8 files changed, 126 insertions(+), 9 deletions(-)
>>>  create mode 100644 arch/s390/kernel/uv.c
>=20
> (...)
>=20
>>> diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
>>> index d3db3d7ed077..652b36f0efca 100644
>>> --- a/arch/s390/kvm/Kconfig
>>> +++ b/arch/s390/kvm/Kconfig
>>> @@ -55,6 +55,15 @@ config KVM_S390_UCONTROL
>>>
>>>  	  If unsure, say N.
>>>
>>> +config KVM_S390_PROTECTED_VIRTUALIZATION_HOST
>>> +	bool "Protected guests execution support"
>>> +	depends on KVM
>>> +	---help---
>>> +	  Support hosting protected virtual machines isolated from the
>>> +	  hypervisor.
>>> +
>>> +	  If unsure, say Y.
>>> +
>>>  # OK, it's a little counter-intuitive to do this, but it puts it nea=
tly under
>>>  # the virtualization menu.
>>>  source "drivers/vhost/Kconfig"
>>>  =20
>>
>> As we have the prot_virt kernel paramter there is a way to fence this =
during runtime
>> Not sure if we really need a build time fence. We could get rid of
>> CONFIG_KVM_S390_PROTECTED_VIRTUALIZATION_HOST and just use CONFIG_KVM =
instead,
>> assuming that in the long run all distros will enable that anyway.=20
>=20
> I still need to read through the rest of this patch set to have an
> informed opinion on that, which will probably take some more time.
>=20
>> If other reviewers prefer to keep that extra option what about the fol=
lowing to the
>> help section:
>>
>> ----
>> Support hosting protected virtual machines in KVM. The state of these =
machines like
>> memory content or register content is protected from the host or host =
administrators.
>>
>> Enabling this option will enable extra code that talks to a new firmwa=
re instance
>=20
> "...that allows the host kernel to talk..." ?

"allows a Linux hypervisor to talk..." ?

>=20
>> called ultravisor that will take care of protecting the guest while al=
so enabling
>> KVM to run this guest.
>>
>> This feature must be enable by the kernel command line option prot_vir=
t.
>=20
> s/enable by/enabled via/
>=20
>>
>> 	  If unsure, say Y.
>=20
> Looks better. I'm continuing to read the rest of this series before I
> say more, though :)
>=20



--En3MMsjz1gQRzn0mEizSQkXYAY1vUmNKZ--

--oZUDBCwfom9G0Dcpf96XYJ4Jpkc2BjkKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3KxfgACgkQ41TmuOI4
ufjyehAAtfdPYkB8+mybPu49oVshXYq+8dlOAuHNARIspPtWIP9ZCpz2Wh9bFCh4
K2I3r0/U2gmXrvtZ3LqYRZ2GXPvkW9U1nnwDtb8W0XYhkJrXRmc/zD4qLVzyWRJ/
RCmqb389GUDClKFGnjzo3/JnP9A8EwTFkqBWkUTrSruDqoUXoVU7kHrjZxcyG9Vk
/NI7i5pn1XhwV6Q3wCYLeSFUesUI+BuXhxji/7gTCQpQWiQi14DWeq3tDRtuSrLZ
IxThyMyJUUOP1Uji3Arz972WSg4OtKgPnbeMgbT5RwfvFGYrH0z5A5lTSps6rRrH
Frqc9g/o7FgWM2ASGcyv++44pDQBm26hHkcTm4LrSy7/S3g0Bn+pD6+VugpVRXuW
ltVE9sUIJptTCHj7llnz7Uqj/pw688KOsZLRwuF1ul0UMQ8MhidyfiMKwkNEeilv
HT+G9ygMfJ3JiXdbFrS0POVl9hT5zkCdQLvGRJPbxPKchoozVmbKdcNdThBOtJjJ
Niuem8xN+yI1hPgzepCHg5tQV18DlvVXYm6mbc8hKHLBmOlIhXc6mKqOTZmzZg8R
k4rlo5+Zk4H97queOu8zeF5trJehENWf+X24IboqPdf2MsVfaqPa+1r20snXMVmo
faG00pPoZ3i0AojPx2ziZgnQi5KynEIIn9sPWQqdbOo4YNZZBr4=
=9Ltf
-----END PGP SIGNATURE-----

--oZUDBCwfom9G0Dcpf96XYJ4Jpkc2BjkKx--
