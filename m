Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725868AbgAVIZd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 Jan 2020 03:25:33 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00M8Ml6h108909
        for <linux-s390@vger.kernel.org>; Wed, 22 Jan 2020 03:25:32 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xp4gj7u0u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 22 Jan 2020 03:25:32 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 22 Jan 2020 08:25:30 -0000
Subject: Re: [kvm-unit-tests PATCH v4 4/9] s390x: smp: Rework cpu start and
 active tracking
References: <20200121134254.4570-1-frankja@linux.ibm.com>
 <20200121134254.4570-5-frankja@linux.ibm.com>
 <bf356a2c-702e-0ecd-d24c-f7a1b7c18d2a@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 22 Jan 2020 09:25:25 +0100
MIME-Version: 1.0
In-Reply-To: <bf356a2c-702e-0ecd-d24c-f7a1b7c18d2a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="k5dl6NC2QUxdYVH3dLuNpue1f1aXqx8i9"
Message-Id: <b088e6ea-bdc0-4833-7271-160a5085d9cf@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k5dl6NC2QUxdYVH3dLuNpue1f1aXqx8i9
Content-Type: multipart/mixed; boundary="paD5wABuL9wR4OGqKgXwcI10JaUWME7Qm"

--paD5wABuL9wR4OGqKgXwcI10JaUWME7Qm
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/21/20 6:40 PM, David Hildenbrand wrote:
> On 21.01.20 14:42, Janosch Frank wrote:
>> The architecture specifies that processing sigp orders may be
>> asynchronous, and this is indeed the case on some hypervisors, so we
>> need to wait until the cpu runs before we return from the setup/start
>> function.
>>
>> As there was a lot of duplicate code, a common function for cpu
>> restarts has been introduced.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  lib/s390x/smp.c | 50 ++++++++++++++++++++++++++++--------------------=
-
>>  1 file changed, 29 insertions(+), 21 deletions(-)
>>
>> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
>> index f57f420..84e681d 100644
>> --- a/lib/s390x/smp.c
>> +++ b/lib/s390x/smp.c
>> @@ -104,35 +104,46 @@ int smp_cpu_stop_store_status(uint16_t addr)
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
>> +	/*
>> +	 * The order has been accepted, but the actual restart may not
>> +	 * have been performed yet, so wait until the cpu is running.
>> +	 */
>> +	while (!smp_cpu_running(addr))
>> +		mb();
>> +	cpu->active =3D true;
>> +	return 0;
>> +}
>> +
>=20
> Just wondering what happened to my comment

It probably got lost in your other change requests :)

>=20
> "Should you make sure to stop the CPU before issuing the restart?
> Otherwise you will get false positives if it is still running (but
> hasn't processed the RESTART yet)"
>=20
> ?
>=20
> IOW, should we have a SIGP_STOP before issuing the SIGP_RESTART?

Yes, that would be cleaner.



--paD5wABuL9wR4OGqKgXwcI10JaUWME7Qm--

--k5dl6NC2QUxdYVH3dLuNpue1f1aXqx8i9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4oBvUACgkQ41TmuOI4
ufgQNw//UpqxqREtIzIp9p8i+uVbx+1Nz+juTKfrDqcnacSV8fu0jbIAU4RQH7O+
y4uKUBzqATDVFfiKYmTvfwNwGYPpl0XQ48gJOiHReGIS7ipDE8NqLJMMd9MjfT6G
7hBb5UNZ2IqYSV78EoDWr82B7NADlUglI3eMcJtXf0b0aoe1Ui4xYB5fRUjVKw4A
+JVaNAe69GrjTmvg2d6ZgZCCthEjk5r6kuKdwWZmZW4uXkgqRpviEOZE0gJOLb87
bCmkhuXHi0ku3t0HsPWkI5Lt3SqH0uo/41a6qBPH5fo0d6V+RimAc/3/CeSCwTJH
M0f5JBEcL7TdILNaNQdwLd0c5gyRoosNU6O6GnTou4Fl6NkiBWWBIikriyDP5eXX
dXP/ReZJ//4FKNj/KiiFsNXXNHPH6R+S7ez1KTIp6e2PcZ3f8XlWJuKO924t5bxf
ewOVDNnQiXD3N3EWvJWHC1YjAKnp0x5Moy4jrKw9Ti51y28jXV65aUW8+L4PMp3j
v9JUU3uvCIR1vobqUtIp867UP/KI4/jrtJ0ma9OBBw4KJOcjnVZVeB2g230eE4Iy
ScpUvWyBVZBssgllid36FcwggL3wHXsdO+NH+EbsNzmhmJlx+GQwQVsKZmYqhkl5
Fgbwxx1oD76tWVKpsByj5lrxJsJLXHftgKzEDh7RzQumSrbpLTE=
=VbqB
-----END PGP SIGNATURE-----

--k5dl6NC2QUxdYVH3dLuNpue1f1aXqx8i9--
