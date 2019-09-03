Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728188AbfICIpA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Sep 2019 04:45:00 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x838S98q026497
        for <linux-s390@vger.kernel.org>; Tue, 3 Sep 2019 04:44:59 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2usmcc1a2j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 03 Sep 2019 04:44:59 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 3 Sep 2019 09:44:57 +0100
Subject: Re: [kvm-unit-tests PATCH 6/6] s390x: SMP test
References: <20190829121459.1708-1-frankja@linux.ibm.com>
 <20190829121459.1708-7-frankja@linux.ibm.com>
 <50b70561-f39d-6edc-600a-ccb707fe5b92@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 3 Sep 2019 10:44:53 +0200
MIME-Version: 1.0
In-Reply-To: <50b70561-f39d-6edc-600a-ccb707fe5b92@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3sXhjKLvK0fkEAFQXA1xGpPJMmpB2H03I"
Message-Id: <03b3850b-ad7d-3b2c-957e-f236849d37b3@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3sXhjKLvK0fkEAFQXA1xGpPJMmpB2H03I
Content-Type: multipart/mixed; boundary="hmNiZHtHLxTng5D3crw3X30FfVuHSnZ2D";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <03b3850b-ad7d-3b2c-957e-f236849d37b3@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH 6/6] s390x: SMP test
References: <20190829121459.1708-1-frankja@linux.ibm.com>
 <20190829121459.1708-7-frankja@linux.ibm.com>
 <50b70561-f39d-6edc-600a-ccb707fe5b92@redhat.com>
In-Reply-To: <50b70561-f39d-6edc-600a-ccb707fe5b92@redhat.com>

--hmNiZHtHLxTng5D3crw3X30FfVuHSnZ2D
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/2/19 5:40 PM, Thomas Huth wrote:
> On 29/08/2019 14.14, Janosch Frank wrote:
>> Testing SIGP emulation for the following order codes:
>> * start
>> * stop
>> * restart
>> * set prefix
>> * store status
>> * stop and store status
>> * reset
>> * initial reset
>> * external call
>> * emegergency call
>>
>> restart and set prefix are part of the library and needed to start
>> other cpus.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
[...]
>> +static void test_stop(void)
>> +{
>> +	int i =3D 0;
>> +
>> +	smp_cpu_stop(1);
>> +	/*
>> +	 * The smp library waits for the CPU to shut down, but let's
>> +	 * also do it here, so we don't rely on the library
>> +	 * implementation
>> +	 */
>> +	while (!smp_cpu_stopped(1)) {}
>> +	t =3D 0;
>> +	/* Let's leave some time for cpu #2 to change t */
>=20
> CPU #2 ? Where? Why?
>=20
>> +	for (; i < 0x100000; i++) {}
>=20
> I'm pretty sure the compiler optimizes empty loops away.

Yeah, I removed all of that...

>=20
>> +	report("stop", !t);
>> +}
>> +
>> +static void test_stop_store_status(void)
>> +{
>> +	struct cpu *cpu =3D smp_cpu_from_addr(1);
>> +	struct lowcore *lc =3D (void *)0x0;
>=20
> Do you want to erase the values in the save area before calling the
> "store_status"? ... just to be sure that we don't see old values there?=


Well at least resetting the prefix and gr15 to 0

>=20
>> +	smp_cpu_stop_store_status(1);
>> +	mb();
>> +	report("stop store status",
>> +	       lc->prefix_sa =3D=3D (uint32_t)(uintptr_t)cpu->lowcore);
>=20
> That confused me. Why does the prefix_sa of the lowcore of CPU 0 match
> the prefix of CPU 1 ? I'd rather expect cpu->lowcore->prefix_sa to
> contain this value?

Store status saves at absolute 0, i.e. we get the status in cpu0's lowcor=
e.

>=20
> Maybe you could also check that at least the stack pointer GPR is !=3D =
0
> in the save area?

Sure, I also fixed everything below



--hmNiZHtHLxTng5D3crw3X30FfVuHSnZ2D--

--3sXhjKLvK0fkEAFQXA1xGpPJMmpB2H03I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl1uKAUACgkQ41TmuOI4
ufgqdBAAhgFrRewTZNza9spa7KVPIPedhXIZHcgoN1/OeVQkBAlWGUsXZb0DvOe0
Byf0Fn+TCaMLAPke031dYkbZ4n52fiaY16sw8tX8bNO7aQVCnnjVn13jP6ueoJrf
StiHH7rPZnj/t2v5Y1VvYutJg0oNi6WGsyEIYxAuBRcNOR6xHZZdtHDJCt2fnSNP
b469zvhnBXdCY5Pi1fXOV0JrEtMh4rpWNSFoofAhOpyEatzeH11gIcfSJvAEn+jw
/SXHRTGzFL7zFynUkBeYHigGeN15yHLI4nUKcq2tWOytFp7sJ26HZpcn05veZQJA
QeI6O6NEFywOro8FKHVdOKX4uZRuqTNqc8OLX4LYcYNkAqMyuAOLdaHYb2+UZGeM
urCOqD1FQRB4yhxAZuD+I3DkS3wwiTriFMasQQ3Oq1L+gv/z6NHWoi5P62LDHyB6
5xEOnfSdcbDF0Kj6F27cUXFcBxar8MQlDPF/J/tC5O1GfuY7TeZZrwM9DENE5+gH
2OJseSSEmsbw1y6LIkbdOx1pWfuqf+9lDJ9B0A8EN2LUQ49VuXp+BnbF7aE/lD/o
SWmMj/l+wVZeQJDJ41aL/23Sl9eVBLwd32KRz0CKn5eJ6RyMwsD5LXPcAYWjNQFI
6FtgOyD7WD//MvMZnuVkIZiV0uc8vj8qwb+mGRoIeOnZtIbA6WU=
=up/q
-----END PGP SIGNATURE-----

--3sXhjKLvK0fkEAFQXA1xGpPJMmpB2H03I--
