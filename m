From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 27 Apr 2018 13:34:39 +0000
Subject: Re: [PATCH v1 0/3] KVM: s390: remaining cleanups
Message-Id: <4a631bc2-7bb4-effc-f7e8-29bde9ddae49@linux.ibm.com>
In-Reply-To: <20180427123613.20624-1-david@redhat.com>
References: <20180427123613.20624-1-david@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--ohgp1vuuEoqcBXwoRL9uNHi1c1DyWszpu"
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ohgp1vuuEoqcBXwoRL9uNHi1c1DyWszpu
Content-Type: multipart/mixed; boundary="J2LybhZylkoQl9PtYNkpDnNqSZJJHbmGE";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, KVM <kvm@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, Christian Borntraeger
 <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Janosch Frank <frankja@linux.vnet.ibm.com>,
 Collin Walling <walling@linux.ibm.com>
Message-ID: <4a631bc2-7bb4-effc-f7e8-29bde9ddae49@linux.ibm.com>
Subject: Re: [PATCH v1 0/3] KVM: s390: remaining cleanups
References: <20180427123613.20624-1-david@redhat.com>
In-Reply-To: <20180427123613.20624-1-david@redhat.com>

--J2LybhZylkoQl9PtYNkpDnNqSZJJHbmGE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.04.2018 14:36, David Hildenbrand wrote:
> Some cleanups that were lying around for way too long on my hard drive.=

>=20
> 2 and 3 were already part of "[PATCH RFC 0/6] KVM: s390: Multiple-epoch=

> facility fixes"
>=20
> David Hildenbrand (3):
>   KVM: s390: introduce defines for control registers
>   KVM: s390: no need to inititalize kvm->arch members to 0
>   KVM: s390: generalize kvm_s390_get_tod_clock_ext()
>=20
>  arch/s390/include/asm/ctl_reg.h | 12 ++++++++++++
>  arch/s390/kvm/guestdbg.c        |  2 +-
>  arch/s390/kvm/interrupt.c       | 16 ++++++++--------
>  arch/s390/kvm/kvm-s390.c        | 40 +++++++++++++++++----------------=
-------
>  4 files changed, 38 insertions(+), 32 deletions(-)
>=20

Adding Collin to this.


--J2LybhZylkoQl9PtYNkpDnNqSZJJHbmGE--

--ohgp1vuuEoqcBXwoRL9uNHi1c1DyWszpu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJa4yb3AAoJEBcO/8Q8ZEV5Da8P/3Wtsc/zW6t8A57SZHeA+VH8
FXVh85JGrGhsHU4kC1UdeeCotgSnQKmpnDoq0a5KuqjC0HXez8Abz26jTsGwPb/d
1CdYk03gGj+l1KzgUIlRuv+vwVirJ8CT3HIIjBff/Kl9wysOtdR1M4Uai7bZ2vNj
0gc1WqgbGlG4gqECiuYvfupfXzLprTLOsKZIyFo2OkY0GPLsxk44eSjrezqieLiE
96lHOPuveaaYeZny0qI24capHUU3hHy2xNFC8oLdYEpm5NYDMe8nrdgLF4QkdVaQ
pDGkdyLqCg+0ok36DsXzPQp0FEkqiY7lXHXFmru15gUQ6EhCwIroMtzqWoV4V5R3
pBCmaxP18J18ItO2gisIYBcY6MwmeVQ081Dn/quLM5MVWWiQL+LYoSNS8bS4NpLa
CkIi/BxLcUpVR3MEvL9V1V2GEIE9UinbO+Ht55XGZPnuaHx3GK+Hpu/roj/lB2ix
eJlV20MAnHD0VLmvEKzGyNqxWmig2ETj6TjQLk8C07JfWvhsQMddkRLMaEVduj2j
ZAUUfeBZ90NxoV6NoHfqmdNXfUyA9QpKraiOjkaZz87CiVpQV/1OsW6fEalfdKXv
Z4r4d5y2tx3f81sy5q6L+LP0+aJUTtuRT2TyYyuVjRwzfSmul+6pqQcSmb88VfJa
Kk+SvUD/KQI4efzXBAu7
=+p5D
-----END PGP SIGNATURE-----

--ohgp1vuuEoqcBXwoRL9uNHi1c1DyWszpu--
