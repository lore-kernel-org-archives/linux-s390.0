Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727816AbfIJLLT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Sep 2019 07:11:19 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8AB6lgR100460
        for <linux-s390@vger.kernel.org>; Tue, 10 Sep 2019 07:11:19 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uxaafgxjb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 10 Sep 2019 07:11:18 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 10 Sep 2019 12:11:16 +0100
Subject: Re: [kvm-unit-tests PATCH v2 6/6] s390x: SMP test
References: <20190905103951.36522-1-frankja@linux.ibm.com>
 <20190905103951.36522-7-frankja@linux.ibm.com>
 <28304989-f49d-850d-4ec0-98ed0d516969@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 10 Sep 2019 13:11:12 +0200
MIME-Version: 1.0
In-Reply-To: <28304989-f49d-850d-4ec0-98ed0d516969@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aVEr0SaM0rc3HjbFFFou5gxgpBmVHTok1"
Message-Id: <d3fc9cae-a3cd-27c7-b8b0-78628ae03e2f@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aVEr0SaM0rc3HjbFFFou5gxgpBmVHTok1
Content-Type: multipart/mixed; boundary="tIxdLMNWeFoif5iuld1e4XXkNZNlUViKs";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <d3fc9cae-a3cd-27c7-b8b0-78628ae03e2f@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v2 6/6] s390x: SMP test
References: <20190905103951.36522-1-frankja@linux.ibm.com>
 <20190905103951.36522-7-frankja@linux.ibm.com>
 <28304989-f49d-850d-4ec0-98ed0d516969@redhat.com>
In-Reply-To: <28304989-f49d-850d-4ec0-98ed0d516969@redhat.com>

--tIxdLMNWeFoif5iuld1e4XXkNZNlUViKs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/10/19 11:43 AM, Thomas Huth wrote:
> On 05/09/2019 12.39, Janosch Frank wrote:
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
> [...]
>> +static void test_store_status(void)
>> +{
>> +	struct cpu_status *status =3D alloc_pages(1);
>> +	uint32_t r;
>> +
>> +	report_prefix_push("store status at address");
>> +	memset(status, 0, PAGE_SIZE * 2);
>> +
>> +	report_prefix_push("running");
>> +	smp_cpu_restart(1);
>> +	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, &r);
>> +	report("incorrect state", r =3D=3D SIGP_STATUS_INCORRECT_STATE);
>> +	report("status not written", !memcmp(status, (void*)status + PAGE_SI=
ZE, PAGE_SIZE));
>> +	report_prefix_pop();
>> +
>> +	memset(status, 0, PAGE_SIZE);
>> +	report_prefix_push("stopped");
>> +	smp_cpu_stop(1);
>> +	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
>> +	while (!status->prefix) { mb(); }
>> +	report("status written", 1);
>> +	free_pages(status, PAGE_SIZE);
>=20
> Shouldn't that be PAGE_SIZE * 2 instead?

Indeed

>=20
>> +	report_prefix_pop();
>> +
>> +	report_prefix_pop();
>> +}
>=20
> The remaining part of the patch looks fine to me.

Thanks for having a look

>=20
>  Thomas
>=20



--tIxdLMNWeFoif5iuld1e4XXkNZNlUViKs--

--aVEr0SaM0rc3HjbFFFou5gxgpBmVHTok1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl13hNAACgkQ41TmuOI4
ufjjMg/7B4FlTcKdicWbsoH8msZXJKYORQ1NNKtt7MJsIM0rIGh3GE8ChdRbdrMe
KSi1OVifdhRb6Zu1x5acvHj4koRtMCk5VB2qsaLnwtdmdZaVYQ2yVx0kDwSJ4Ow9
Y0dL+Rxy6sxUt6WOXpIoViwed+UXhP28bYRrzMPS4yXypMfjMjEH725g+UQz83kH
e7up749ffx4w/LqYQFilNRD0kmdigCFfFaqgtsZKxQA8iwEPzy7zS2Biot1zPsg2
RyOObDgbICohLu8vH1guJ30peq+HvsRGBVLihxgirf21Ourmm75939tqzRymf140
vwQO9dNCKyqalu0Sqx43OTUpN+cbVJbqRLV8l02rnd9Cwwk5iVPzC5zt7/dGG1iT
I9MxQqjKn+OCeZqBDbuCk2bYa9Fv16eg7u8DNQLieUHhQQDDuXi1INWNdumtYeG9
8iB3rvcCfAu6hl04ji0E9ci1IT8J0H4UR9kxQe1csq+Vqq/k+7wRnIq0QvIj2NOy
PwFfcVbRaaN1OPbAKheJpp8wqCnXBrKiEA+9Hm6cUl9V8Xldd0rNOBTxDEw7iJoc
2Rp0c8ZXNKzcmDDmEyYKAxDMzCS+DNPs2v1IbIKhaaw7Z1mELbMZVObkAPJVJf0V
xn3p/8+3MpHU3k+0LaOkqoYmrYED1Fxj1hmtKdP61//X4OXiS1Q=
=aJaz
-----END PGP SIGNATURE-----

--aVEr0SaM0rc3HjbFFFou5gxgpBmVHTok1--
