Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729932AbfIYK0U (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Sep 2019 06:26:20 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8PANv66131282
        for <linux-s390@vger.kernel.org>; Wed, 25 Sep 2019 06:26:19 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v84v6v3sk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 25 Sep 2019 06:26:19 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 25 Sep 2019 11:26:16 +0100
Subject: Re: [kvm-unit-tests PATCH v3 6/6] s390x: SMP test
References: <20190920080356.1948-1-frankja@linux.ibm.com>
 <20190920080356.1948-7-frankja@linux.ibm.com>
 <ddb43c9c-e6d9-fbc0-b7a5-ec440756b0ec@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 25 Sep 2019 12:26:13 +0200
MIME-Version: 1.0
In-Reply-To: <ddb43c9c-e6d9-fbc0-b7a5-ec440756b0ec@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Pj9nTxLZm4mFPpyjpdWzQ3JzvSAH1wHk4"
Message-Id: <ea43c712-ca82-f7c6-08da-576fcb5857b7@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pj9nTxLZm4mFPpyjpdWzQ3JzvSAH1wHk4
Content-Type: multipart/mixed; boundary="H2XvNqqhTF6cv6d8M0E2B7oYxIZWM236W";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <ea43c712-ca82-f7c6-08da-576fcb5857b7@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v3 6/6] s390x: SMP test
References: <20190920080356.1948-1-frankja@linux.ibm.com>
 <20190920080356.1948-7-frankja@linux.ibm.com>
 <ddb43c9c-e6d9-fbc0-b7a5-ec440756b0ec@redhat.com>
In-Reply-To: <ddb43c9c-e6d9-fbc0-b7a5-ec440756b0ec@redhat.com>

--H2XvNqqhTF6cv6d8M0E2B7oYxIZWM236W
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/25/19 10:49 AM, Thomas Huth wrote:
> On 20/09/2019 10.03, Janosch Frank wrote:
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
>>  s390x/Makefile      |   1 +
>>  s390x/smp.c         | 242 +++++++++++++++++++++++++++++++++++++++++++=
+
> [...]
>> +int main(void)
>> +{
>> +	report_prefix_push("smp");
>> +
>> +	if (smp_query_num_cpus() =3D=3D 1) {
>> +		report_abort("need at least 2 cpus for this test");
>=20
> nit: report_abort() aborts immediately, so the "goto done" below is dea=
d
> code. Did you mean report_skip() instead?

That would make more sense, yes

>=20
>> +		goto done;
>> +	}
>> +
>> +	test_start();
>> +	test_stop();
>> +	test_stop_store_status();
>> +	test_store_status();
>> +	test_ecall();
>> +	test_emcall();
>> +	test_reset();
>> +	test_reset_initial();
>> +
>> +done:
>> +	report_prefix_pop();
>> +	return report_summary();
>> +}
>=20
> Apart from the nit, the patch looks fine to me. Since this is IIRC the
> only nit that is left in this series, I can also fix it up when picking=

> up the patch, if you like - just tell me whether you prefer report_skip=

> or deletion of the goto.

Well, that might depend on how much weight David's latest comment has.
:-) If you want to, you can pick and fix.

>=20
>  Thomas
>=20



--H2XvNqqhTF6cv6d8M0E2B7oYxIZWM236W--

--Pj9nTxLZm4mFPpyjpdWzQ3JzvSAH1wHk4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl2LQMUACgkQ41TmuOI4
ufjPWQ/+NieuZNgiK72dfPZdM69ZAK2RBISdcfh0Wh6hchlYvNUA1VusNdHq4EvC
88JcuqDuUwczU/Yk3ZxBi7obyxGCgWWRlhebYr0U4xWo8HtC2HfLd4p7QR2iwjHu
TgnKOOC8w47gSyvX+Yec6HnM0AMAub+cuS6Kq7fDSYPHq+G/xoOMrocS1UMELh/x
EJuibLUdsOrGMpGTQw7Txvwan7MiKzimKXH9dLouoG05pSLtnZxxZw9y5S86bsf2
HlCaIwBkkGb/JVMlEaomHbHUfv15vZfT9WyAhqBXtYUu3oR41FWdTkhfFDk/db4T
b6dmkNKsNj41/FXdm3SP+PqV5Kbgy4MqShgpqnzZDASKmCz8uo4b/7M22eduurxA
Qet8nUxVuC6eLFrWaE3YN0XEGqt+i2VsNV8TARZ/5UxXT9ZbMppVk42cq1Zwfp8H
d/V46fW37pugR9gMVuAnF+x5Ls7+eGGTpjlXxFU41dGb0D4E6Sz8lC5TI8Ano/Tj
J/ycmdGuhIinfsHIFgH2DmGx+wfexDMElGjFa/GbRx5Ric9pl66sATTfIwJ+qeQB
jKpL4uMsGb9xkkSNZwEAj6Y8sn4CTcZuJBtF0knh3SjA9IIZ5vLWXa89ekf8IEuv
gq0sbZGnS9WVj38njeItP/31O9aj3s0q6eEY0bUYVFi30ihnlNc=
=e4TN
-----END PGP SIGNATURE-----

--Pj9nTxLZm4mFPpyjpdWzQ3JzvSAH1wHk4--
