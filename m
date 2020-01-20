Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45896 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726901AbgATOrX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Jan 2020 09:47:23 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KElD6H003618
        for <linux-s390@vger.kernel.org>; Mon, 20 Jan 2020 09:47:22 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xmg39v87u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 20 Jan 2020 09:47:22 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 20 Jan 2020 14:47:19 -0000
Subject: Re: [kvm-unit-tests PATCH v3 4/9] s390x: smp: Rework cpu start and
 active tracking
References: <20200117104640.1983-1-frankja@linux.ibm.com>
 <20200117104640.1983-5-frankja@linux.ibm.com>
 <0f9984f0-9768-dba8-5e36-8e667bc05c88@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 20 Jan 2020 15:47:16 +0100
MIME-Version: 1.0
In-Reply-To: <0f9984f0-9768-dba8-5e36-8e667bc05c88@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KOdSjoAB2gYn745p196SwsiGtcx1V8EzA"
Message-Id: <22cbcc9d-1d32-a5c9-4f3f-7892e28bc705@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KOdSjoAB2gYn745p196SwsiGtcx1V8EzA
Content-Type: multipart/mixed; boundary="jO04UJUHdqOPRYm7j9vIYaQvpmhDMYfnj"

--jO04UJUHdqOPRYm7j9vIYaQvpmhDMYfnj
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/20/20 1:06 PM, David Hildenbrand wrote:
> On 17.01.20 11:46, Janosch Frank wrote:
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
>=20
> I'd exchange these two (reverse christmas tree)

Christmas is over

>=20
>> +
>> +	if (!cpu)
>> +		return -1;
>=20
> -EINVAL?
>=20
>> +	if (psw) {
>> +		cpu->lowcore->restart_new_psw.mask =3D psw->mask;
>> +		cpu->lowcore->restart_new_psw.addr =3D psw->addr;
>> +	}
>=20
> Does this make sense to have optional? (the other CPU will execute
> random crap if not set, won't it?)

Well, I have restarts in the smp test and I don't want to always pass a
psw if I know what the last restart psw was.
Simply restarting into test_func or wait_for_flag is certainly no problem=
=2E

>=20
>> +	rc =3D sigp(addr, SIGP_RESTART, 0, NULL);
>> +	if (rc)
>> +		return rc;
>> +	/*
>> +	 * The order has been accepted, but the actual restart may not
>> +	 * have been performed yet, so wait until the cpu is running.
>> +	 */
>> +	while (!smp_cpu_running(addr))
>> +		mb();
>=20
> Should you make sure to stop the CPU before issuing the restart?
> Otherwise you will get false positives if it is still running (but
> hasn't processed the RESTART yet)

Good point


--jO04UJUHdqOPRYm7j9vIYaQvpmhDMYfnj--

--KOdSjoAB2gYn745p196SwsiGtcx1V8EzA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4lvXQACgkQ41TmuOI4
ufg5Mw//VX5Z5VodE6UDAiKnftzOTCj1dMaRaxhmxXhk3HhNC7F1px8jIlZIKBgK
DY/FUarnT7fbbKaQ73QWSN7jcHB04Oty8AjkFHIx8AV7pEI5r7e3r7kWql/X5lrr
EienfgpMPTmYqsKJLixIywc9Zim9+tvxqN2FNvym7EuoBJ1I6itSZxRREot8peZu
+kkg5rVnIdZ/8Sur10a+UQ242gkZl41XNBkx5PnISAfqcqQdSq5gvymlT+9JYQPx
/whuHVzZjfj9ox8UbeOkYFKQK83bHAHpL5x6RlqIk9E/NuJS706Z1sDtjCJ/3iB0
Gcgd5AnP7LrnGIxdh5AmjXYvCTUv3kfX+OzyJWcSnRgQSOgHWL8Wh4rJxZ5cnzT4
lchdc363ugm8doYtVgggLoF2+gIpUSrSbNIdHnoWmuNoU82wQxxs1BjVJBfx+zxj
4IffGCvYmmGCTWHrzC/woQJa6+/0ixTEIY5qj+WvkcIBZOIYgACw2r+pYyRURfub
UDZLeUVrLbdrabFLPItfWr645dy75/9t7+3e1TTBRW8P3pgDW17DUrozrGTHha23
kpuhQssETbjeaX30LabN6UG3LGbIrKjvlVtDn1NmnjwTL8Vc1t05hyAg+HA+yeN5
VnsvMwvI3mEhn1+QbwRyb9asBGw/S4J54MzyrM/Yn7H6mg6m7fo=
=XxTY
-----END PGP SIGNATURE-----

--KOdSjoAB2gYn745p196SwsiGtcx1V8EzA--
