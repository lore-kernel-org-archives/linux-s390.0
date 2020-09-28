Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726565AbgI1JNd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 28 Sep 2020 05:13:33 -0400
Subject: Re: [RFC Patch 0/2] KVM: SVM: Cgroup support for SVM SEV ASIDs
References: <20200922004024.3699923-1-vipinsh@google.com>
 <20200922014836.GA26507@linux.intel.com>
 <45117fcc-d6b8-fab9-11dc-79181058ed62@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <b896ea83-7b98-7c86-f147-446faf2dbc44@linux.ibm.com>
Date: Mon, 28 Sep 2020 11:12:58 +0200
MIME-Version: 1.0
In-Reply-To: <45117fcc-d6b8-fab9-11dc-79181058ed62@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VfA9Q2MEC6jqxTvBZM48CGM7TI8K8VyRY"
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Vipin Sharma <vipinsh@google.com>
Cc: thomas.lendacky@amd.com, tj@kernel.org, lizefan@huawei.com, joro@8bytes.org, corbet@lwn.net, brijesh.singh@amd.com, jon.grimm@amd.com, eric.vantassell@amd.com, gingell@google.com, rientjes@google.com, kvm@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Paul Mackerras <paulus@ozlabs.org>, Christian Borntraeger <borntraeger@de.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VfA9Q2MEC6jqxTvBZM48CGM7TI8K8VyRY
Content-Type: multipart/mixed; boundary="Kz97w4axyoHn1iOg02JLWtj5V7UOUmbLC"

--Kz97w4axyoHn1iOg02JLWtj5V7UOUmbLC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/23/20 2:47 PM, Paolo Bonzini wrote:
> On 22/09/20 03:48, Sean Christopherson wrote:
>> This should be genericized to not be SEV specific.  TDX has a similar
>> scarcity issue in the form of key IDs, which IIUC are analogous to SEV=
 ASIDs
>> (gave myself a quick crash course on SEV ASIDs).  Functionally, I doub=
t it
>> would change anything, I think it'd just be a bunch of renaming.  The =
hardest
>> part would probably be figuring out a name :-).
>>
>> Another idea would be to go even more generic and implement a KVM cgro=
up
>> that accounts the number of VMs of a particular type, e.g. legacy, SEV=
,
>> SEV-ES?, and TDX.  That has potential future problems though as it fal=
ls
>> apart if hardware every supports 1:MANY VMs:KEYS, or if there is a nee=
d to
>> account keys outside of KVM, e.g. if MKTME for non-KVM cases ever sees=
 the
>> light of day.
>=20
> Or also MANY:1 (we are thinking of having multiple VMs share the same
> SEV ASID).
>=20
> It might even be the same on s390 and PPC, in which case we probably
> want to implement this in virt/kvm.  Paul, Janosch, do you think this
> would make sense for you?  The original commit message is below.
>=20
> Paolo
>=20
>> On Mon, Sep 21, 2020 at 05:40:22PM -0700, Vipin Sharma wrote:
>>> Hello,
>>>
>>> This patch series adds a new SEV controller for tracking and limiting=

>>> the usage of SEV ASIDs on the AMD SVM platform.
>>>
>>> SEV ASIDs are used in creating encrypted VM and lightweight sandboxes=

>>> but this resource is in very limited quantity on a host.
>>>
>>> This limited quantity creates issues like SEV ASID starvation and
>>> unoptimized scheduling in the cloud infrastructure.
>>>
>>> SEV controller provides SEV ASID tracking and resource control
>>> mechanisms.
>=20

On s390 we currently support a few million protected guests per LPAR so
guest IDs are not exactly scarce. However having accounting for them
might add some value nevertheless, especially when having large amount
of protected containers.

@Christian: Any thoughts on this?


--Kz97w4axyoHn1iOg02JLWtj5V7UOUmbLC--

--VfA9Q2MEC6jqxTvBZM48CGM7TI8K8VyRY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl9xqRoACgkQ41TmuOI4
ufiRzw//RQLYgVIDnvQ53hh7q4lVn4eqNunUK4JM6ZVR6uv5/qUq49XGb1Qhnxf7
HCNyzi4jR30hu/gs+Bp6YPAlyjc8KLQUDSFvHYSWwrkeJuQQ/MZAQfxOR6xX0lo4
/TP3WrtxU+9gQSoa0Zr1QdZBmgMC2bkqgST7JEwVMrY9zNqQR9BfFPxcyEHoOcq9
6dBqP4icN5fNA8p7naD/do70gNR80yji0InDPmKvNP4HEczXwH/gDEYt6LECwIKq
cwL3MX6iJI0BHBrOxSHKvYvQlR7df0VyUPpdsTNXZrUUYpLyA7drX5jsJdRz5Fmq
cOIJlmawm0LxAzYP9EtvzCIsSrysuSrgzqznCRWyi8dnJB2paEqKZ/UCs2nXH28v
lWEu/B7UCEDKDZnZG/KStBiTkwvepN1Dvo2jGlee9S8zEzcniTVtIdl+lfyB4c/m
ozSco0feBmH6m2KC3c6MHkYZTJR8eiLb7aZflWlxm5Mx0lrurH2vr8lTXC5BOrpw
WTxc/OEJ3hxwdW0e7WecjvaAKMckDaJaS5bD2uJP1Lg5YZKcx7icp4Jn/DjXut98
b4EzqcAlj8D9PwZXZizo135eyasTQ9b4GpZEUX5E5Yq2m53/GNdO1BhP4iP+B87W
6oAKnmpbrgsGkuZaQlfmUMvxG0JEuq88gbRX15BvTKkivnPJG/c=
=WSBY
-----END PGP SIGNATURE-----

--VfA9Q2MEC6jqxTvBZM48CGM7TI8K8VyRY--
