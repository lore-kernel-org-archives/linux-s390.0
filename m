Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726189AbgAPOob (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jan 2020 09:44:31 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GEgVmx140938
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2020 09:44:30 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xj5xbqv65-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2020 09:44:30 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 16 Jan 2020 14:44:28 -0000
Subject: Re: [kvm-unit-tests PATCH v2 4/7] s390x: smp: Rework cpu start and
 active tracking
References: <20200116120513.2244-1-frankja@linux.ibm.com>
 <20200116120513.2244-5-frankja@linux.ibm.com>
 <20200116151453.186cbf94.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 16 Jan 2020 15:44:24 +0100
MIME-Version: 1.0
In-Reply-To: <20200116151453.186cbf94.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BcebWQbut8qV6eRk3aeIJ62QBU7JePeP1"
Message-Id: <4e4587a6-efba-6f40-306b-3704e53aafc3@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BcebWQbut8qV6eRk3aeIJ62QBU7JePeP1
Content-Type: multipart/mixed; boundary="Kd575vZIqmTQuNyzNIcgrVUnpbkISgq0C"

--Kd575vZIqmTQuNyzNIcgrVUnpbkISgq0C
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/16/20 3:14 PM, Cornelia Huck wrote:
> On Thu, 16 Jan 2020 07:05:10 -0500
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> sigp is not synchronous on all hypervisors, so we need to wait until
>=20
> "The architecture specifies that processing sigp orders may be
> asynchronous, and this is indeed the case on some hypervisors, so..."
>=20
> ? (Or is that overkill?)
>=20
>> the cpu runs until we return from the setup/start function.
>=20
> s/until we return/before we return/
>=20
>>
>> As there was a lot of duplicate code a common function for cpu
>=20
> s/code/code,/
>=20
>> restarts has been intropduced.
>=20
> s/intropduced/introduced/
>=20
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  lib/s390x/smp.c | 45 ++++++++++++++++++++++++---------------------
>>  1 file changed, 24 insertions(+), 21 deletions(-)
>>
>> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
>> index f57f420..f984a34 100644
>> --- a/lib/s390x/smp.c
>> +++ b/lib/s390x/smp.c
>> @@ -104,35 +104,41 @@ int smp_cpu_stop_store_status(uint16_t addr)
>>  	return rc;
>>  }
>> =20
>> +static int smp_cpu_restart_nolock(uint16_t addr, struct psw *psw)
>> +{
>> +	int rc;
>> +	struct cpu *cpu =3D smp_cpu_from_addr(addr);
>> +
>> +	if (!cpu)
>> +		return -1;
>> +	if (psw) {
>> +		cpu->lowcore->restart_new_psw.mask =3D psw->mask;
>> +		cpu->lowcore->restart_new_psw.addr =3D psw->addr;
>> +	}
>> +	rc =3D sigp(addr, SIGP_RESTART, 0, NULL);
>> +	if (rc)
>> +		return rc;
>> +	while (!smp_cpu_running(addr)) { mb(); }
>=20
> Maybe split this statement? Also, maybe add a comment

/* Wait until the target cpu is running */
?

This is not QEMU with two line ifs taking up 3 lines :)

>=20
> /*
>  * The order has been accepted, but the actual restart may not
>  * have been performed yet, so wait until the cpu is running.
>  */
>=20
> ?
>=20
>> +	cpu->active =3D true;
>> +	return 0;
>> +}
>=20
> The changes look good to me AFAICS.
>=20
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Thanks!



--Kd575vZIqmTQuNyzNIcgrVUnpbkISgq0C--

--BcebWQbut8qV6eRk3aeIJ62QBU7JePeP1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4gdsgACgkQ41TmuOI4
ufj9fg/9HjnsoSw3kffHLA8+LSOCgnQ/j57pz0xtL7gbeerYybSutikwydJ+JuIq
yA8OTqLo9KMsJtksEbG9oV2piq7xPT/h7pyI6Yu7RsAuGvBLz1HjmXIHCJviYT10
8CcMLcBKcRNVxCR5IHnDzODfMnOd3AI6oTHqnccJqgPEO9zWvcKHDH7vj3te7Qzo
OIOOlhGFCWCLsnRg67ecOUHsNSwyiQHp5TQCTQE7piW1uKD3krXytLES90fUAHdr
0l4fY1dUoyb+Zg+FNiJYeEzWEPAtrUy9xbasZES5+ChP0czTeA4oAYRIhg4EFUE8
EgJxIy4alkZwqjgaMbJimoHZn8hgpaH07VkEUOGq8VeZ+IzSCklhC81CI32qFX/Y
0hSdrmKMtSvjodzM0R2BoHbFLnhU4qxfpaRq9jhUPLFi5x9+OW4HRHZbZYLMqmHy
HYkKmVzdDASBl5M4LLSHH9CVay6QnhLwqgfErVRxEk4GLXLcYMlWlQtnaloITONN
cqOkyVQsJyBl9K2g7k6lM1HcPNKLUTbtoX6jJM25K6jtcMihRKwhq9MreHkW9u8I
h90db+ovC8Vt83rXJ2DH3xS3tPoVOPQJwGeDLXrf/y4HLf55xfYQlfWHX46JjTYu
mmls7zuWx+ePtS5rTgqldwTRE7XJw+ai8PmRxfsg4pq7WuFgML8=
=cIDe
-----END PGP SIGNATURE-----

--BcebWQbut8qV6eRk3aeIJ62QBU7JePeP1--
