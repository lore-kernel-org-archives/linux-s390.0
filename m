From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v3 02/16] s390/mm: Abstract gmap notify bit setting
Date: Tue, 13 Feb 2018 15:31:27 +0100
Message-ID: <db905458-fe1c-5a0d-fcf0-387753911a6a@linux.vnet.ibm.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518168864-147803-3-git-send-email-frankja@linux.vnet.ibm.com>
 <316974c5-2cdd-3cac-f424-cc2f728f2175@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZUKD1WVPf9Dz4mqY23qzainItog3w816O"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <316974c5-2cdd-3cac-f424-cc2f728f2175@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZUKD1WVPf9Dz4mqY23qzainItog3w816O
Content-Type: multipart/mixed; boundary="xSZ46AwXKoy05ryztZoYdpI51ln29m2Uf";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <db905458-fe1c-5a0d-fcf0-387753911a6a@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v3 02/16] s390/mm: Abstract gmap notify bit setting
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518168864-147803-3-git-send-email-frankja@linux.vnet.ibm.com>
 <316974c5-2cdd-3cac-f424-cc2f728f2175@redhat.com>
In-Reply-To: <316974c5-2cdd-3cac-f424-cc2f728f2175@redhat.com>

--xSZ46AwXKoy05ryztZoYdpI51ln29m2Uf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.02.2018 15:10, David Hildenbrand wrote:
> On 09.02.2018 10:34, Janosch Frank wrote:
>> Currently we use the software PGSTE bits PGSTE_IN_BIT and PGSTE_VSIE_B=
IT
>> to notify before an invalidation occurs on a prefix page or a VSIE pag=
e
>> respectively. Both bits only work for a PGSTE, which only exists for
>> page tables.
>>
>> For huge page support we also need such bits for segments (pmds) so
>> let's introduce abstract GMAP_NOTIFY_* bits that will be realized into=

>> the respective bits when gmap DAT table entries are protected.
>=20
> This comment is stale.

Yes, I'm currently polishing. This version gives an impression how the
series looks like after shuffling it.
Correct comments have not been a priority yet, but I take every hint I ge=
t.

>=20
> This patch is no longer needed but also doesn't hurt.

I kept this patch, as I disliked the PGSTE constants being used for
notification requests. I wouldn't have a lot of hard feelings dropping it=
=2E


--xSZ46AwXKoy05ryztZoYdpI51ln29m2Uf--

--ZUKD1WVPf9Dz4mqY23qzainItog3w816O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJagvbXAAoJEBcO/8Q8ZEV5j28P/Atw8v/z/1q6hbJxghdykogY
TY+rZlQtU2p+cirDB+dhZVvACVTg5a0LaIU4lWDrP6Hc1fvhqBhPNo+NbM4L+rV/
RQBUr0bMQdBKpga8z6bf8bdqTXCUhwPJ43HgGkOS9Xv/uy3objibvbjqyxJD7zR1
n81W3A8GcUMvfTHOgOAe0JmHPbv/RcpykHtt9V6ttddhuSm69Xu2XSQWPL76QvUa
BhEijH/buNMoP74qV9jLPJ1+GVT/uJHN8N+GDsIdhYreFnLLjATM97D/iWVS2fFA
BG8KJ7/Wkbd9PZYixf6Ni4Ct4w7R1PYDrSFCrQ6ej6FIBXWqnS2fjM/shAyhlafC
teReFNSo4NhSQDHvf/BxEV/lugjhIM2sZqP5htauXirRazIReA4hBJixPZP0W4nj
sufWewfjlpTEvP+qamCc4Jxr0MBwv4Ct6abLGSjdggliM2HqCbUBUVkjxPy56y8J
nBSDnlFEyGMBnhuJkm1OH+BP5hyhdI9HQx/MzRGtbPL3QO16sNfADQ/YBbml6efa
qP2wVbI6AwQW0xsZMUpbS5hJje42wp9jmQAPG9t1ICzJHpwlizLpobosiXTkMyi7
NXFbj18OwmEouf7eqYXjzPD9zS760r3UBUGfQotmn81BXnbZysiAtvPFK9OCrjrg
/16NV+NOHJMDid4OSYbm
=GwUD
-----END PGP SIGNATURE-----

--ZUKD1WVPf9Dz4mqY23qzainItog3w816O--
