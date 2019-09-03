Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727078AbfICKx7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Sep 2019 06:53:59 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x83ArXFK080678
        for <linux-s390@vger.kernel.org>; Tue, 3 Sep 2019 06:53:58 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2usmc6n9cf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 03 Sep 2019 06:53:58 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 3 Sep 2019 11:53:56 +0100
Subject: Re: [kvm-unit-tests PATCH v3 4/5] s390x: STSI tests
References: <20190826163502.1298-1-frankja@linux.ibm.com>
 <20190826163502.1298-5-frankja@linux.ibm.com>
 <72cc113e-63a2-d389-d1fb-b0b9e84fc863@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 3 Sep 2019 12:53:51 +0200
MIME-Version: 1.0
In-Reply-To: <72cc113e-63a2-d389-d1fb-b0b9e84fc863@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WJ0H9jSHmz8ogVGCPHJRNlirSKFh2J5jA"
Message-Id: <1416cb79-09b6-8067-041f-16522860cd88@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WJ0H9jSHmz8ogVGCPHJRNlirSKFh2J5jA
Content-Type: multipart/mixed; boundary="0itr30hXF7pbH80W8UjG2VBBAufEUKvoe";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com
Message-ID: <1416cb79-09b6-8067-041f-16522860cd88@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v3 4/5] s390x: STSI tests
References: <20190826163502.1298-1-frankja@linux.ibm.com>
 <20190826163502.1298-5-frankja@linux.ibm.com>
 <72cc113e-63a2-d389-d1fb-b0b9e84fc863@redhat.com>
In-Reply-To: <72cc113e-63a2-d389-d1fb-b0b9e84fc863@redhat.com>

--0itr30hXF7pbH80W8UjG2VBBAufEUKvoe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/30/19 2:07 PM, David Hildenbrand wrote:
> On 26.08.19 18:35, Janosch Frank wrote:
>> For now let's concentrate on the error conditions.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
[...]
>> +static inline unsigned long stsi_get_fc(void *addr)
>> +{
>> +	register unsigned long r0 asm("0") =3D 0;
>> +	register unsigned long r1 asm("1") =3D 0;
>> +	int cc;
>> +
>> +	asm volatile("stsi	0(%3)\n"
>> +		     "ipm	%[cc]\n"
>> +		     "srl	%[cc],28\n"
>> +		     : "+d" (r0), [cc] "=3Dd" (cc)
>> +		     : "d" (r1), "a" (addr)
>=20
> maybe [addr], so you can avoid the %3 above

Sure, maybe Thomas can also fix that on picking for the previous patch?

>=20
>> +		     : "cc", "memory");
>> +	assert(!cc);
>> +	return r0 >> 28;
>=20
> I think I'd prefer "get_configuration_level()" and move it to an header=

> - because the fc actually allows more values (0, 15 ...) - however the
> level can be used as an fc.

The rename works for me, but that's currently used only once, so why
should it go to a header file?

I though about starting lib/s390x/asm/misc-instr.h if we have enough (>=3D=

2) instruction definitions which are shared.

>=20
>=20
>> +}
>> +
>> +static void test_fc(void)
>> +{
>> +	report("invalid fc",  stsi(pagebuf, 7, 0, 0) =3D=3D 3);
>> +	report("query fc >=3D 2",  stsi_get_fc(pagebuf) >=3D 2);
>> +}
>> +
>> +int main(void)
>> +{
>> +	report_prefix_push("stsi");
>> +	test_priv();
>> +	test_specs();
>> +	test_fc();
>> +	return report_summary();
>> +}
>> diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
>> index 9dd288a..cc79a4e 100644
>> --- a/s390x/unittests.cfg
>> +++ b/s390x/unittests.cfg
>> @@ -68,3 +68,6 @@ file =3D cpumodel.elf
>>  [diag288]
>>  file =3D diag288.elf
>>  extra_params=3D-device diag288,id=3Dwatchdog0 --watchdog-action injec=
t-nmi
>> +
>> +[stsi]
>> +file =3D stsi.elf
>>
>=20
> Apart from that
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>
>=20



--0itr30hXF7pbH80W8UjG2VBBAufEUKvoe--

--WJ0H9jSHmz8ogVGCPHJRNlirSKFh2J5jA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl1uRj8ACgkQ41TmuOI4
ufhj5RAAtLRt+3CDUSNIIoo0hlQQ357cOl/Wde/bVwqo+P3ZGIV6kDwMNvtk/tTk
cLnF9lVdefvL45f9q9ayyIf5HenVectQBR0GwsqPQaWB3Dn1C85pFnrWx28nOWm2
rW3LPgilvN+lM6NPfv/N35/aYnH7GOUSuEG8G8NQwqM6pHK+FtaRr2iWPG/8Ar8B
hbtaJTeT4oYCrversunfm/hhPFA5cKM6rCzmfxsN/j/Cw1j5wL6CmuTskESwISK9
ZnN91tTVTLYAjfawnvpGiDBllBYz2QOHbsk4aYFP40kN+rMUjpzN/dqkkWcyy+N8
JqaFVBZDLQdJbAbDAJaonY9qKuXdXSK0RqY0J6eJOLfZOPMB9naSRW8MkLVM/9sx
VWKdiPmzwbpzkAWFkGVoNmN9bhfnjKeu+2d6sGsqgcaG6pPYbC1Z9GBdmDkGlpsn
74L/ZUauZynDJ7Q72wMPOMPvTtfVlhz9al46h9ZsdsSmNYRADUXpOqrYkX6JYaFt
5sjXUpKtPJoA1J3y1BfndYbs8zhnRuLHxxPPNHz1lhP7Q2Sgo4razOGAa5IvjzoY
zjRnt9umuh5Lc7c9zRaNuLJXN/dT23Xcx6oDrN6gcqeldlNi9pzgPxU7P2nCwL+E
k25OuqAIB9sguIu+hUmrBQwrG7J3+pwEqqUwKW1ASU71RSDBjvg=
=0VhO
-----END PGP SIGNATURE-----

--WJ0H9jSHmz8ogVGCPHJRNlirSKFh2J5jA--
