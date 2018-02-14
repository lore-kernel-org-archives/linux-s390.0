From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v3 00/16] KVM/s390: Hugetlbfs enablement
Date: Wed, 14 Feb 2018 16:33:11 +0100
Message-ID: <9a8bc606-217c-db26-3a1a-85c8405c9487@linux.vnet.ibm.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <16d92e45-97bc-fbbd-55e7-36da8c1a6d73@redhat.com>
 <70de883f-4120-1b36-fb0f-5b940b05aab4@linux.vnet.ibm.com>
 <7dadc09b-8ada-a9e4-14c1-aca36ac0afe5@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NoUCsmGN4LuBfu817CmHGGD6tnuDXqNCh"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <7dadc09b-8ada-a9e4-14c1-aca36ac0afe5@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NoUCsmGN4LuBfu817CmHGGD6tnuDXqNCh
Content-Type: multipart/mixed; boundary="nFbFmXqVyeeat4xs4UCUTpXpYBI5OtDlz";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <9a8bc606-217c-db26-3a1a-85c8405c9487@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v3 00/16] KVM/s390: Hugetlbfs enablement
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <16d92e45-97bc-fbbd-55e7-36da8c1a6d73@redhat.com>
 <70de883f-4120-1b36-fb0f-5b940b05aab4@linux.vnet.ibm.com>
 <7dadc09b-8ada-a9e4-14c1-aca36ac0afe5@redhat.com>
In-Reply-To: <7dadc09b-8ada-a9e4-14c1-aca36ac0afe5@redhat.com>

--nFbFmXqVyeeat4xs4UCUTpXpYBI5OtDlz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.02.2018 16:07, David Hildenbrand wrote:
> On 14.02.2018 16:01, Janosch Frank wrote:
>> On 14.02.2018 15:30, David Hildenbrand wrote:
>>> On 09.02.2018 10:34, Janosch Frank wrote:
>>>> Since the z10 s390 does support 1M pages, but whereas hugetlbfs
>>>> support was added quite fast, KVM always used standard 4k pages for
>>>> guest backings.
>>>>
>>>> This patchset adds full support for 1M huge page backings for s390
>>>> KVM guests. I.e. we also support VSIE (nested vms) for these guests
>>>> and are therefore able to run all combinations of backings for all
>>>> layers of guests.
>>>>
>>>> When running a VSIE guest in a huge page backed guest, we need to
>>>> split some huge pages to be able to set granular protection. This wa=
y
>>>> we avoid a prot/unprot cycle if prefixes and VSIE pages containing
>>>> level 3 gmap DAT tables share the same segment, as the prefix has to=

>>>> be accessible at all times and the VSIE page has to be write
>>>> protected.
>>>>
>>>> Branch:
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git hlp_=
vsie
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/lo=
g/?h=3Dhlp_vsie
>>>>
>>>
>>> A general proposal: We will have split PMDs with fake PGSTE. This is
>>> nasty but needed. I think we should hinder virtualization from making=

>>> use of these. Just like we already do for vSIE.
>>>
>>> Should we make the KVM_CAP_S390_HPAGE a configuration option?
>>>
>>> Without it being set, don't allow mapping huge pages into the GMAP.
>>> Everything as usual.
>>>
>>> With it being set (by user space when it thinks we need huge pages),
>>> allow mapping huge pages into the GMAP AND
>>> - Explicitly disable CMMA. Right now we trust on user space to do the=

>>>   right thing. ecb2 &=3D ~ECB2_CMMA
>>> - Disable PFMFI -> ecb2 &=3D ~ECB2_PFMFI
>>> - Disable SKF by setting scb->ictl |=3D ICTL_ISKE | ICTL_SSKE | ICTL_=
RRBE
>>>
>>> So user space has to explicitly indicate and allow huge pages. This w=
ill
>>> result in all instructions that touch the PGSTE getting intercepted, =
so
>>> we can properly work on the huge PMDs instead.
>>
>> My only concern here is:
>> Can this coexist with the cpumodels in a coordinated way?
>>
>=20
> We already have to fake away the CMMA facility in user space. So that
> shouldn't be a problem. The other instructions
> - PFMF
> - ISKE, SSKE ...
>=20
> Will simply always be interpreted. Should not affect the CPU model.

Bear with me, it was a long day:

Would it make sense to force user space to configure HPAGE before asking
for model data, so that we can remove these model bits already from
kernel side and wouldn't need extensive handling on two points?


--nFbFmXqVyeeat4xs4UCUTpXpYBI5OtDlz--

--NoUCsmGN4LuBfu817CmHGGD6tnuDXqNCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJahFa3AAoJEBcO/8Q8ZEV5jeIP/2DXqBTOfn4yi3Ww+lt9GQkN
+qhhFQfiTtRTJC0wp+lLIIKqOgEdXowihzvHVvU/ACPFGU+huOuiWsAJz/oxWf3G
IlBeP5AeUSHjGADUwJZAVpMtlObqZ7HtcraZRg9Tv6Mp82xPPHpHoquGKiIGEdO4
x/1nsPFMZ4QzNSCEiVAo3kuxebUKlSKLqc6LFZFUud4DOcfGxvZhXb5g/Nh+ZkZ1
Xl9JyD+F+2mcWQLzbV0kEO7hmZmyOL47EEvyywTlTV+7FUgbX92q3HkiOyUwfkMc
2KduWNbDo6xCkDU8ip10TQDl9cMtVZaQAJWS6VGmGhI4yriQ+RVzBrIzWlJVmQ94
bqcAcUX9qn+zXIhiBUQyymw+dZ7F//yH7nklgatX8ql/r09sNzxYjCTtyfdCjtH5
00lNnCnkF/95Mqe7P7UgplzCzWyMIsdJPESK/WZQN0aofGhs7vuNrXfNfofXv5Iz
O5DHBdUsJtBrNnzTy5zERA6yMkF/+Qnnec6ziEBAn973gGolAul2j41Zy634kcgq
VjAxg74n3bDmX9blp9WNDFqgJFvbhQV0RySX58nwvv6WW6i34fgQu5BwVGJdnlBC
7+LGdD9oreeZzanTKej2Q7ZA3aPDWOgvvFgJeJGBkooz0+QqpVpU9g4JLw+gZX82
TbeZeHn04DPK4DXwKyJ+
=wO2U
-----END PGP SIGNATURE-----

--NoUCsmGN4LuBfu817CmHGGD6tnuDXqNCh--
