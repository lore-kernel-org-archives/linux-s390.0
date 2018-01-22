From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 03/22] s390/mm: add gmap PMD invalidation
 notification
Date: Mon, 22 Jan 2018 14:13:37 +0100
Message-ID: <c154cb64-59be-34fe-44e0-7ee19c6b5440@linux.vnet.ibm.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-4-git-send-email-frankja@linux.vnet.ibm.com>
 <edb33737-5f1d-b74e-6dbf-f5174b790fee@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ps6cMvpXymYuMMLKaRDxhGe5yFdG6oxSU"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <edb33737-5f1d-b74e-6dbf-f5174b790fee@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ps6cMvpXymYuMMLKaRDxhGe5yFdG6oxSU
Content-Type: multipart/mixed; boundary="PPiQ9b9QZnNw5vdsA3Xf2IGy85KjcKySN";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <c154cb64-59be-34fe-44e0-7ee19c6b5440@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 03/22] s390/mm: add gmap PMD invalidation
 notification
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-4-git-send-email-frankja@linux.vnet.ibm.com>
 <edb33737-5f1d-b74e-6dbf-f5174b790fee@redhat.com>
In-Reply-To: <edb33737-5f1d-b74e-6dbf-f5174b790fee@redhat.com>

--PPiQ9b9QZnNw5vdsA3Xf2IGy85KjcKySN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.01.2018 12:46, David Hildenbrand wrote:
> On 13.12.2017 13:53, Janosch Frank wrote:
>> For later migration of huge pages we want to write-protect guest
>> PMDs. While doing this, we have to make absolutely sure, that the
>> guest's lowcore is always accessible when the VCPU is running. With
>> PTEs, this is solved by marking the PGSTEs of the lowcore pages with
>> the invalidation notification bit and kicking the guest out of the SIE=

>> via a notifier function if we need to invalidate such a page.
>>
>> With PMDs we do not have PGSTEs or some other bits we could use in the=

>> host PMD. Instead we pick one of the free bits in the gmap PMD. Every
>> time a host pmd will be invalidated, we will check if the respective
>> gmap PMD has the bit set and in that case fire up the notifier.
>>
>> In the first step we only support setting the invalidation bit, but we=

>> do not support restricting access of guest pmds. It will follow
>> shortly.
>=20
> I am wondering if we could avoid having invalidation bits on PMDs
> completely by always splitting up a PMD huge page into PTEs.
>=20
> I assume this would make the code easier - as we need split up of PMDs
> either way when protecting for the shadow gmap.
>=20
> This would imply that also our notification handler only has to be
> called for 4k pages, which also makes that part easier.

Except for 1MB shadowed segments which still need an invalidation handler=
=2E

>=20
> This would mean, that the 1MB segments where the prefixes live would
> always be split into 4k pages - but do we care?

Hmm, I currently don't see a medium to huge benefit from it.

>=20
> I somehow dislike that somebody registers a notifier for some subregion=

> (e.g. 8k) but gets notified about a huge page (1mb).
>=20
> Opinions?

Well, if you start bending reality to your will, things get messy.

Having two tables with different depths is a risk, as I can't be sure if
at some point a common code function will touch a split pte and set a
problematic value. But then again, we already do that anyhow.

As I'd need to rearrange patches again, I'd either do that after this
series or leave it be.


--PPiQ9b9QZnNw5vdsA3Xf2IGy85KjcKySN--

--ps6cMvpXymYuMMLKaRDxhGe5yFdG6oxSU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaZeOBAAoJEBcO/8Q8ZEV5N2QQALpKTwsdHGuXUL5bStgtgjTC
ioRFq66Arpe+Hs8CnoVfuREARNOivalpxRcTZIkoAS5y9ypOSz0zoalfRKJPwNsw
PNrK7pJL77FpCzXJmcS+YqX7NzNZB6vRJJytP78LCxeJMe9rVHyUA7+BUy+wmX6k
liXFui/645B+z0SH94mycZ3cWyZNJngnKUoqireC7gW0qC78P0b6uMO2EO+JXO6Z
XGFXIy3jYv5Krwgt+GgTPX7Ka3+0zTUtACKBQGM0nuFtP1riS0TWC5+a79TDfc43
GOGUz9viPVl2g5fqaFUUgz9KhyRNxPXKYPfRFPMX7Z93nVwkfBo+9u0wO4RiTp6l
7fO91MNwJOWHXsHD260/B8lW6cKn8GRFpShzArw36ahbTzAmnbGZch55ppgbeNjC
v01REU8URzki770NIkKKIiqa9L6wrTXoz9NSulwvvPQkGfZ3D7hri4thtY6B/Cle
AfTwINJmI0imRZY5zKO7bmbOxNI6q7rhWfknOaFdyodlCXX9mIa1SNta3l7cFvxn
U7eRp3ihyUE+0eW7dhb/KZUk/00g1nqAt9n0EGL2q48hz/qqR3bscp4YdhAjUsY/
fG9MebdXAHF4puI15E4VRGThhj6haVYN01wkIIXgcdd1HINV3bu4r65Zqbtx4gcL
td1m8EysNraUA6qrIJ/+
=JRHn
-----END PGP SIGNATURE-----

--ps6cMvpXymYuMMLKaRDxhGe5yFdG6oxSU--
