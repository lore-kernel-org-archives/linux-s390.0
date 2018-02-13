From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v3 03/16] s390/mm: Introduce gmap_pmdp_xchg
Date: Tue, 13 Feb 2018 15:39:31 +0100
Message-ID: <0080876e-10eb-4971-2d8d-9e096befcc7d@linux.vnet.ibm.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518168864-147803-4-git-send-email-frankja@linux.vnet.ibm.com>
 <74d88194-4fc6-92ec-2fb1-e2c6940c5fe6@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8haUuqGT6hzTaxiSetjm0pmZBkUWjFWKS"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <74d88194-4fc6-92ec-2fb1-e2c6940c5fe6@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8haUuqGT6hzTaxiSetjm0pmZBkUWjFWKS
Content-Type: multipart/mixed; boundary="QbcZvtbPA6XcwgfSBaojnNgJJO1PSdVJt";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <0080876e-10eb-4971-2d8d-9e096befcc7d@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v3 03/16] s390/mm: Introduce gmap_pmdp_xchg
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518168864-147803-4-git-send-email-frankja@linux.vnet.ibm.com>
 <74d88194-4fc6-92ec-2fb1-e2c6940c5fe6@redhat.com>
In-Reply-To: <74d88194-4fc6-92ec-2fb1-e2c6940c5fe6@redhat.com>

--QbcZvtbPA6XcwgfSBaojnNgJJO1PSdVJt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.02.2018 15:16, David Hildenbrand wrote:
> On 09.02.2018 10:34, Janosch Frank wrote:
>> When changing guest pmds, we don't need to take care of the
>> corresponding host pmd. This means, we don't need to flush the host
>> TLB entries and we don't need to notify on all gmaps.
>>
>> Let's introduce a function, that exchanges a pmd and takes care of the=

>> necessary flushing and notification.
>=20
> stale comment, notification is handled in a different patch.
>=20
>>
>> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> ---
[...]
> This fits into one line

Thanks!
Fixed for all of them.

>=20
>> +	else
>> +		__pmdp_csp(pmdp);
>> +	*pmdp =3D new;
>> +}
>> +
>>  static inline void thp_split_mm(struct mm_struct *mm)
>>  {
>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>
>=20
> Apart from that, looks good to me. (although very similar to
> gmap_pmdp_idte_global -  can we reuse gmap_pmdp_xchg() in
> gmap_pmdp_idte_global?)

Hrm, we'd need to disable notifications and do the split_free only for
the idte case. I'm not convinced that we gain a lot by doing that.


--QbcZvtbPA6XcwgfSBaojnNgJJO1PSdVJt--

--8haUuqGT6hzTaxiSetjm0pmZBkUWjFWKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJagvijAAoJEBcO/8Q8ZEV5zrMP/1AsnSC0MjRvaCXFU1TwJKrU
76kN6hsdzCOOIHsPjWvcjpClEUBYyXRjDJ2eOHQmJZdwoaMzD6069R6K5fpr+dRR
DRUu/ISzDy4aeDkoxmczonaMboxjr3CjykZerm//S14C0aS+5NfVW9q5Ke7bxKps
GDvRldHWRo5xzTWVlXzQ0IhvKm+BXAjvOziYUaJ8P3T3mIM0cHPPy4Qwu1PRw/Ti
bCDUGLftChmB3+he9JAuneWHX8IunA1311BgRFkQG1QjIwkreErI0lvWJQC4Tup4
qo3h4a3FdSt2yJqgpvhbi3RaLFBZkP5o4p4DXGIdWSCLchNj5E6c+LreWrGeVacA
/B/U509QTsidRT1iA/N0QkkM1o8mjiGL7+ivXcaTpXhQksHHCBuGJvOq6aSVGTxe
Iq1F4/ir6oWZ4BWYqXzaJTsxFhMiraAMcJ8aLCexI3yeCoVGk60DF0Ls89etUkoD
EhEJzKlpyCcInj4OLKaK0PTel4213eZKLnTmKW2lM4eGvYvtQKVzflEqUFN1w573
47d+n/fuRpSNgSjjlZdVDekt67Pg6Hr6Zs1eiuH4QSM52lP1qarLp4ZD4J2g5jWi
FK0fvyr3sM9y13mNllHnK1QiqmpNftNd7Kur8FTERb1fK7Ta4wISnw44Xb6SpAZ6
+o3qRAlDdKIhfHbBkWha
=0r7v
-----END PGP SIGNATURE-----

--8haUuqGT6hzTaxiSetjm0pmZBkUWjFWKS--
