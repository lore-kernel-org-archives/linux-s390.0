From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 16 May 2018 14:03:44 +0000
Subject: Re: [PATCH v2 0/2] KVM: s390: vsie: fix < 8k check for the itdba
Message-Id: <1c1f3161-fe26-d835-8f80-fd4331a3db29@linux.ibm.com>
In-Reply-To: <20180509141218.5629-1-david@redhat.com>
References: <20180509141218.5629-1-david@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--Hht06HycLLWtzDNFHuDU5q19ePaBoTkz7"
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hht06HycLLWtzDNFHuDU5q19ePaBoTkz7
Content-Type: multipart/mixed; boundary="ZM6JhY7VWH9pzmgiMhQ0ikJFIetFN22pC";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, KVM <kvm@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, Christian Borntraeger
 <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <1c1f3161-fe26-d835-8f80-fd4331a3db29@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] KVM: s390: vsie: fix < 8k check for the itdba
References: <20180509141218.5629-1-david@redhat.com>
In-Reply-To: <20180509141218.5629-1-david@redhat.com>

--ZM6JhY7VWH9pzmgiMhQ0ikJFIetFN22pC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.05.2018 16:12, David Hildenbrand wrote:
> Fix the bug reported by Dan and refactore it so also I can understand
> easily again what the code I've written does.
>=20
> We will have to decide if patch #1 is CC material. It will not happen w=
ith
> KVM guests (as we always have an offset for the itdba so we can't have
> 4G alignemnt).

Thanks, applied.

Patch #1 got an:
Fixes: 166ecb3 ("KVM: s390: vsie: support transactional execution")
Cc: stable@vger.kernel.org # v4.8+

>=20
> v1 -> v2:
> - use 2 * PAGE_SIZE instead of 8192
>=20
> David Hildenbrand (2):
>   KVM: s390: vsie: fix < 8k check for the itdba
>   KVM: s390: vsie: simplify < 8k address checks
>=20
>  arch/s390/kvm/vsie.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20



--ZM6JhY7VWH9pzmgiMhQ0ikJFIetFN22pC--

--Hht06HycLLWtzDNFHuDU5q19ePaBoTkz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJa/DpBAAoJEBcO/8Q8ZEV5ASMP+wVkO9mEuyN4DJkrH35Hq63G
H2ahJE/bGRYyz5K9vM31eUOOiMMiDG3qPUzbKSsCDE8OiozvXHL/7q0QZImZRikC
yoaxtUh2xbGYM0oN3V1aglElDUav0cXITBxWduPWSJUZBSm8ZxQbmNCWCuX6UX00
aa0kd45HZOQgIwO/LC/OHPWQPVAOgqI7vOk2dnAyvhyTi60D76HPq9P3Xa7woBq4
CcUgX2munYzUfSonZqTM2evcueO1eXV/Nxb267g7ewKz5jQbqYZpRXHsXwdkrU7r
u/rBt3Eu4hZv9xqL+1fOdfJh09StrwXqshncZ+7bTgW6qTkhy9oX8u+HIZIJhaiX
dZUOIIB/tZ6oQL6TqAgapH+U6LwUr0YOoAtMqVf0TatRCpJhqwsVtj6IqteFt+Y8
e2InUkhiyLZ1k8J4DpwL9yqaxVyVgC0RNLv29+twZmHhx7KEZimcbEToKje6vtUC
DMRoi5OQz2EVidf00BEqGRVtYLuW+4hjMLxUK3+Oc5eZksjSDZKCooCegj8MOxAY
bNZWdtKTioVyJu+Jh45Eac+qrAblG//4pZ2ILNNizwoufNBaewr3eHCFLbU6XwHj
IYeZ3o1eAIoa882lCjrt9ILSS1MbQLV4svIT4SdBfoeaXb5B9GQAgw/cqbBaI0RR
W5Qv70dY42OUlrDPQy2Y
=ZNc8
-----END PGP SIGNATURE-----

--Hht06HycLLWtzDNFHuDU5q19ePaBoTkz7--
